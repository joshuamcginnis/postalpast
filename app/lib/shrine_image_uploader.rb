# frozen_string_literal: true
require 'shrine'

class ShrineImageUploader < Shrine
  plugin :derivation_endpoint,
    prefix: Rails.application.config_for(:shrine)[:derivation_endpoint]

  plugin :determine_mime_type, analyzer: :marcel
  plugin :validation_helpers
  plugin :remove_invalid

  Attacher.validate do
    validate_extension %w[png]
    validate_mime_type %w[image/png]
    validate_max_size 10*1024*1024 # 10 MB
    validate_min_size 10*1024 # 10 KB
  end

  derivation :thumbnail do |file, width, height|
    ImageProcessing::MiniMagick
      .source(file)
      .resize_to_limit!(width.to_i, height.to_i)
  end
end
