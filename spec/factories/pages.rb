FactoryGirl.define do
  sequence :title do |n|
    "Page Title -#{n}"
  end
end

FactoryGirl.define do
  factory :page do
    title
    body "<b>Some text here</p>"
    author "Admin"
    pub_status "published"
  end
end
