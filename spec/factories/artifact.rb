# frozen_string_literal: true

FactoryBot.define do
  factory :artifact do
    transient do
      address do
        {
          'street'   => Faker::Address.street_address,
          'city'     => Faker::Address.city,
          'state'    => Faker::Address.state_abbr,
          'postcode' => Faker::Address.postcode
        }
      end
    end

    kind                 { :postcard }
    addressed_to_name    { Faker::Name.unique.name }
    addressed_from_name  { Faker::Name.unique.name }
    addressed_to_message { Faker::Quote.yoda }
    color                { true }
    subject              { Faker::Book.title }
    subject_address      { address }

    trait :with_addresses do
      postmark_address     { address }
      to_address           { address }
      from_address         { address }
    end

    trait :with_photos do
      photos do
        [create(:photo, face: :front), create(:photo, face: :back)]
      end
    end
  end
end
