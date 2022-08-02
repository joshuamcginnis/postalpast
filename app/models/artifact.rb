class Artifact < ApplicationRecord
  enum :kind, [:postcard], default: :postcard
  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true
end
