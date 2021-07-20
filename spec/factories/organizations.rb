FactoryGirl.define do
  factory :att, class: "Organization" do
    title { 'AT&T' }
    subdomain { 'att' }
  end
end