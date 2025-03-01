FactoryBot.define do
  factory :collaborator_profile do
    user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    organization_name { 'Test Org' }
    organization_city { 'Denver' }
    organization_state { 'CO' }
    poc_name { 'POC' }
    poc_email { 'poc@example.com' }
    terms_of_service { true }
  end
end
