class Artifact < ApplicationRecord
  enum :kind, [:postcard], default: :postcard

  has_many :photos, dependent: :destroy
  has_one :publisher
  has_one :stamp

  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :stamp, :publisher

  def postmarked?
    postmarked_at.nil? ? false : true
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

  def format_full_address(address_field)
    "#{address_field['street']}, #{address_field['city']}, " \
    "#{address_field['state']} #{address_field['postcode']}"
  end
end
