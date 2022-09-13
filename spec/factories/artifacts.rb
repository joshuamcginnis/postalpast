# frozen_string_literal: true

FactoryBot.define do
  factory :artifact do
    kind                 { :postcard }
    addressed_to_name    { Faker::Name.unique.name }
    addressed_from_name  { Faker::Name.unique.name }
    addressed_to_message { Faker::Quote.yoda }
    color                { true }
    subject              { Faker::Book.title }
    subject_address      {}
    postmark_address     {}
    to_address           {}
    from_address         {}

    trait :with_photos do
      photos { [create(:photo, face: :front),
                create(:photo, face: :back)] }
    end
  end
end
