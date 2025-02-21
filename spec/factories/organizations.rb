FactoryBot.define do
  factory :organization do
    title { "Chicago Public Library" }
    subdomain { "chipublib" }
  end

  factory :att, class: "Organization" do
    title { "AT&T" }
    subdomain { "att" }
    settings { { access_requests_enabled: true } }
  end
end
