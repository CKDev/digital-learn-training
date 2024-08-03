FactoryBot.define do
  factory :att, class: "Organization" do
    title { 'AT&T' }
    subdomain { 'att' }
    settings { { access_requests_enabled: true } }
  end
end