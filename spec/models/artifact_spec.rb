# frozen_string_literal: true

require 'rails_helper'
require 'geocoder/results/nominatim'

RSpec.describe Artifact do
  let(:subject) do
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
      expect(subject.full_subject_address)
        .to eq('1111 Columbia Ave, Franklin, TN 37064')
    end
  end

  describe '#full_postmark_address' do
    it 'returns the full postmark address' do
      expect(subject.full_postmark_address)
        .to eq('239 Franklin Rd, Franklin, TN 37064')
    end
  end

  describe '#full_to_address' do
    it 'returns the full postmark address' do
      expect(subject.full_to_address)
        .to eq('56 Burrow Lane, Nashville, TN 37064')
    end
  end

  describe '#full_from_address' do
    it 'returns the full postmark address' do
      expect(subject.full_from_address)
        .to eq('7619 Narrow Blvd, Mission, TN 38061')
    end
  end

  describe '#geocode_addresses' do
    context 'with a valid address' do
      let(:geocoder_result) do
        instance_double(Geocoder::Result::Nominatim, coordinates: [123, 456])
      end

      before do
        allow(Geocoder).to receive(:search)
          .with('239 Franklin Rd, Franklin, TN 37064')
          .and_return([geocoder_result])
      end

      it 'method is called after_validation' do
        subject = described_class.create(
          postmark_address: {
            street: '239 Franklin Rd',
            city: 'Franklin',
            state: 'TN',
            postcode: '37064'
          })

        expect(Geocoder).to have_received(:search)
        expect(subject.postmark_address['lat']).to eq('123')
        expect(subject.postmark_address['lon']).to eq('456')
      end
    end

    context 'address field is empty' do
      it 'does not attempt geocoding' do
        expect(Geocoder).not_to receive(:search)
        described_class.create
      end
    end
  end
end
