FactoryGirl.define do
  sequence :title do |n|
    "Title -#{n}"
  end
end

FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@training.digitallearn.org"
  end
end
