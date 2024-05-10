FactoryBot.define do
  factory :user do
    email
    password { "asdfasdf" }
    confirmed_at { Time.zone.now.to_s }
    admin { false }

    factory :admin do
      admin { true }
    end

    trait :with_collaborator_profile do
      collaborator_profile
    end
  end
end
