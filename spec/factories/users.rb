FactoryGirl.define do
  factory :user do
    email
    password "asdfasdf"
    confirmed_at Time.zone.now.to_s
    admin true
  end

  factory :admin, class: User do
    email
    password "asdfasdf"
    confirmed_at Time.zone.now.to_s
    admin true
  end
end
