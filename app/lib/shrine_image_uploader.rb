require 'shrine'

class ShrineImageUploader < Shrine
  plugin :derivation_endpoint,
    prefix: Rails.application.config_for(:shrine)[:derivation_endpoint]

  derivation :thumbnail do |file, width, height|
    ImageProcessing::MiniMagick
      .source(file)
      .resize_to_limit!(width.to_i, height.to_i)
  end
end
