require './spec/support/shrine_image_test_fixture'

FactoryBot.define do
  factory :photo do
    artifact
    face { :front }
    image_data { ShrineImageTestFixture.image_data }
  end
end
