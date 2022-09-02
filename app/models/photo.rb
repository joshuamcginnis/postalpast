# frozen_string_literal: true

require 'shrine_image_uploader'

class Photo < ApplicationRecord
  include ShrineImageUploader::Attachment(:image)

  belongs_to :artifact

  enum :face, %i[front back], default: :front
end
