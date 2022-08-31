require 'rails_helper'

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
end
