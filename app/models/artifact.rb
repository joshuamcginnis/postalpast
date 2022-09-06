# frozen_string_literal: true

class Artifact < ApplicationRecord
  ADDRESS_FIELDS = %i[subject_address
                      postmark_address
                      to_address
                      from_address].freeze

  ADDRESS_FIELD_ATTRIBUTES = %w[street city state postcode].freeze

  enum :kind, [:postcard], default: :postcard

  has_many :photos, dependent: :destroy
  has_one :publisher, dependent: nil
  has_one :stamp, dependent: nil

  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :stamp, :publisher

  after_validation :geocode_addresses, unless: -> { changed_addresses.empty? }

  def next
    self.class.where(self.class.arel_table[:id].gt(id)).limit(1).first
  end

  def geocode_addresses
    self.class::ADDRESS_FIELDS.each do |field|
      address = self[field]
      next if address.nil?

      full_address = full_address_for(address)
      coordinates = Geocoder.search(full_address).first&.coordinates

      address['lat'], address['lon'] = coordinates if coordinates
    end
  end

  def postmarked?
    !postmarked_at.nil?
  end

  def full_subject_address
    full_address_for(subject_address)
  end

  def full_postmark_address
    full_address_for(postmark_address)
  end

  def full_to_address
    full_address_for(to_address)
  end

  def full_from_address
    full_address_for(from_address)
  end

  private

  def changed_addresses
    changed & ADDRESS_FIELDS.map(&:to_s)
  end

  def full_address_for(address_field)
    "#{address_field['street']}, #{address_field['city']}, " \
      "#{address_field['state']} #{address_field['postcode']}"
  end
end
