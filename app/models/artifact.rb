# frozen_string_literal: true

class Artifact < ApplicationRecord
  ADDRESS_FIELDS = %i[subject_address
                      postmark_address
                      to_address
                      from_address].freeze

  ADDRESS_FIELD_ATTRIBUTES = %w[business_name
                                address_line_1
                                address_line_2
                                city state postcode].freeze

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

      full_address = full_address_from(address)
      coordinates = Geocoder.search(full_address).first&.coordinates

      address['lat'], address['lon'] = coordinates if coordinates
    end
  end

  def postmarked?
    !postmarked_at.nil?
  end

  def full_subject_address
    full_address_from(subject_address)
  end

  def full_postmark_address
    full_address_from(postmark_address)
  end

  def full_to_address
    full_address_from(to_address)
  end

  def full_from_address
    full_address_from(from_address)
  end

  private

  def changed_addresses
    changed & ADDRESS_FIELDS.map(&:to_s)
  end

  def full_address_from(field)
    return if field.nil?

    full_address = "#{field['address_line_1']}, "

    if field['address_line_2'].present?
      full_address << "#{field['address_line_2']}, "
    end

    full_address << "#{field['city']}, #{field['state']} #{field['postcode']}"
  end
end
