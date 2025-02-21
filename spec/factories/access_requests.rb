FactoryBot.define do
  factory :access_request do
    organization { FactoryBot.create(:att) } # Only organization for now
    full_name { Faker::Name.name }
    organization_name { Faker::Company.name }
    email { Faker::Internet.email }
    phone { "%010d" % rand(10**10) }
    request_reason { Faker::Lorem.paragraph }
  end
end
