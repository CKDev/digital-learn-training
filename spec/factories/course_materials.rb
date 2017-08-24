FactoryGirl.define do

  factory :course_material do
    title
    summary "In this course you will..."
    description "Description"
    contributor "John Doe"
    pub_status "D"
    category
  end

end
