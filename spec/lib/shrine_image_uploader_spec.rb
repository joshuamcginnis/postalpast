# frozen_string_literal: true

require 'rails_helper'
require 'shrine_image_uploader'

RSpec.describe ShrineImageUploader do
  INVALID_IMAGE = 'spec/fixtures/data/black.jpg'
  VALID_IMAGE = 'spec/fixtures/data/image.png'

  describe 'validation' do
    it 'enforces valid extension' do
      photo = Photo.new
      photo.image = File.open(INVALID_IMAGE)
      expect(photo.valid?).to be false
      expect(photo.errors[:image])
        .to eq(['extension must be one of: png',
                'type must be one of: image/png',
                'size must not be less than 10.0 KB'])
    end
  end

  #describe 'derivations' do
  #  describe 'thumbnail' do
  #    it 'returns a url' do
  #      photo = Photo.new(artifact: create(:artifact),
  #                       image: File.open(VALID_IMAGE))
  #      p photo.image.derivation_url(:thumbnail, 10, 10)
  #    end
  #  end
  #end
end
