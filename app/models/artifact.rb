class Artifact < ApplicationRecord
  enum :kind, [:postcard], default: :postcard
end
