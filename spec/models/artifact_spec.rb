# frozen_string_literal: true

require 'rails_helper'
require 'geocoder/results/nominatim'

RSpec.describe Artifact do
  subject(:artifact) do
    described_class.new(
      subject_address: {
        business_name: 'Columbia Apartments',
        address_line_1: '1111 Columbia Ave',
        address_line_2: 'APT 10',
        city: 'Franklin',
        state: 'TN',
        postcode: '37064'
      },
      postmark_address: {
        address_line_1: '239 Franklin Rd',
        city: 'Franklin',
        state: 'TN',
        postcode: '37064'
      },
      to_address: {
        address_line_1: '56 Burrow St.',
        address_line_2: '#4',
        city: 'Nashville',
        state: 'TN',
        postcode: '37064'
      },
      from_address: {
        business_name: 'Century Cleaners',
        address_line_1: '7619 Narrow Blvd',
        city: 'Mission',
        state: 'TN',
        postcode: '38061'
      }
    )
  end

  context 'when address is nil' do
    it 'returns nil' do
      artifact = create(:artifact, subject_address: nil)
      expect(artifact.full_subject_address).to be_nil
    end
  end

  describe '#full_subject_address' do
    it 'returns the full address of the subject' do
      expect(artifact.full_subject_address)
        .to eq('1111 Columbia Ave, APT 10, Franklin, TN 37064')
    end
  end

  describe '#full_postmark_address' do
    it 'returns the full postmark address' do
      expect(artifact.full_postmark_address)
        .to eq('239 Franklin Rd, Franklin, TN 37064')
    end
  end

  describe '#full_to_address' do
    it 'returns the full postmark address' do
      expect(artifact.full_to_address)
        .to eq('56 Burrow St., #4, Nashville, TN 37064')
    end
  end

  describe '#full_from_address' do
    it 'returns the full postmark address' do
      expect(artifact.full_from_address)
        .to eq('7619 Narrow Blvd, Mission, TN 38061')
    end
  end

  describe '#geocode_addresses' do
    let(:geocoder_result) do
      instance_double(Geocoder::Result::Nominatim, coordinates: [123, 456])
    end

    before do
      allow(Geocoder).to receive(:search)
        .with(anything)
        .and_return([geocoder_result])
    end

    context 'with a valid address' do
      it 'method is called after_validation' do
        artifact.save
        expect(Geocoder).to have_received(:search).exactly(4).times
        expect(artifact.postmark_address['lat']).to eq('123')
        expect(artifact.postmark_address['lon']).to eq('456')
      end
    end

    context 'when address field is empty' do
      it 'does not attempt geocoding' do
        described_class.create
        expect(Geocoder).not_to have_received(:search)
      end
    end

    context 'when there are no results' do
      before { allow(Geocoder).to receive(:search).and_return([]) }

      it 'does not update lat, lon' do
        artifact.save
        expect(artifact.subject_address['lat']).to be_nil
        expect(artifact.subject_address['lon']).to be_nil
      end
    end
  end

  describe '#next' do
    before do
      described_class.create(id: 1)
      described_class.create(id: 2)
      described_class.create(id: 5)
    end

    it 'returns the next record by id' do
      a = described_class.find(1)
      expect(a.next.id).to eq(2)
      expect(a.next.next.id).to eq(5)
    end
  end

  describe '#postmarked?' do
    context 'when there is a postmark' do
      it 'returns true' do
        expect(described_class.new(postmarked_at: Date.new).postmarked?)
          .to be true
      end
    end

    context 'when there is no postmark' do
      it 'returns false' do
        expect(described_class.new.postmarked?).to be false
      end
    end
  end
end
