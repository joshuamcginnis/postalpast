# frozen_string_literal: true

class Artifact < ApplicationRecord
  ADDRESS_FIELDS = %i[subject_address
                      postmark_address
                      to_address
                      from_address].freeze

  enum :kind, [:postcard], default: :postcard

  has_many :photos, dependent: :destroy
  has_one :publisher, dependent: nil
  has_one :stamp, dependent: nil

  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :stamp, :publisher

  after_validation :geocode_addresses

  def geocode_addresses
    self.class::ADDRESS_FIELDS.each do |field|
      next unless field_geocodable?(self[field])

      full_address = send("full_#{field}")
      coordinates = Geocoder.search(full_address).first&.coordinates

      self[field]['lat'], self[field]['lon'] = coordinates if coordinates.any?
    end
  end

  def postmarked?
    !postmarked_at.nil?
  end

  def full_subject_address
    format_full_address(subject_address)
  end

  def full_postmark_address
    format_full_address(postmark_address)
  end

  def full_to_address
    format_full_address(to_address)
  end

  def full_from_address
    format_full_address(from_address)
  end

  private

  def field_geocodable?(address)
    return false if address.nil?

    address['lat'].nil? || address['lon'].nil?
  end

  def format_full_address(address_field)
    "#{address_field['street']}, #{address_field['city']}, " \
      "#{address_field['state']} #{address_field['postcode']}"
  end
end
