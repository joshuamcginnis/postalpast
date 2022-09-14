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

  describe 'derivations' do
    describe 'thumbnail' do
      let(:mini_magic_double) do
        instance_double(ImageProcessing::MiniMagick::Processor,
                        method_missing: nil)
      end

      before do
        allow(ImageProcessing::MiniMagick).to receive(:source)
          .and_return(mini_magic_double)

        allow(mini_magic_double).to receive(:method_missing)
      end

      it 'returns a url' do
        described_class.derivations[:thumbnail].call('file', '10', '20')

        expect(ImageProcessing::MiniMagick).to have_received(:source)
          .with('file')

        expect(mini_magic_double).to have_received(:method_missing)
          .with(:resize_to_limit!, 10, 20)
      end
    end
  end
end
