# frozen_string_literal: true

require 'rails_helper'
require 'geocoder/results/nominatim'

RSpec.describe Artifact do
  subject(:artifact) do
    described_class.new(
      subject_address: {
        street: '1111 Columbia Ave',
        city: 'Franklin',
        state: 'TN',
        postcode: '37064'
      },
      postmark_address: {
        street: '239 Franklin Rd',
        city: 'Franklin',
        state: 'TN',
        postcode: '37064'
      },
      to_address: {
        street: '56 Burrow Lane',
        city: 'Nashville',
        state: 'TN',
        postcode: '37064'
      },
      from_address: {
        street: '7619 Narrow Blvd',
        city: 'Mission',
        state: 'TN',
        postcode: '38061'
      }
    )
  end

  describe '#full_subject_address' do
    it 'returns the full address of the subject' do
      expect(artifact.full_subject_address)
        .to eq('1111 Columbia Ave, Franklin, TN 37064')
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
        .to eq('56 Burrow Lane, Nashville, TN 37064')
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
end
