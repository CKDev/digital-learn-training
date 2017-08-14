FactoryGirl.define do

  factory :course_material do
    title
    summary "In this course material you will..."
    description "Description"
    contributor "John Doe"
  end

  # factory :course_with_lessons, class: Course do
  #   title "Course title"
  #   summary "In this course you will..."
  #   description "Description"
  #   contributor "John Doe"
  #   pub_status "P"
  #
  #   after(:create) do |course|
  #     create(:lesson, course: course, lesson_order: 1)
  #     create(:lesson, course: course, lesson_order: 2)
  #     create(:lesson, course: course, lesson_order: 3)
  #   end
  # end

end
