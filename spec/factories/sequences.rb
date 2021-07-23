FactoryBot.define do
  sequence :title do |n|
    "Title -#{n}"
  end
end

FactoryBot.define do
  sequence :email do |n|
    "user#{n}@training.digitallearn.org"
  end
end
