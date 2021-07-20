FactoryBot.define do
  factory :course_material do
    title
    category
    summary { "In this course you will..." }
    description { "Description" }
    contributor { "John Doe" }
    pub_status { "D" }
    sort_order { 1 }
  end
end
