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
end
