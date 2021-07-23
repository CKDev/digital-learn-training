FactoryBot.define do
  factory :course do
    title
    summary { "In this course you will..." }
    description { "Description" }
    contributor { "John Doe" }
    pub_status { "P" }

    trait :with_lessons do
      after(:create) do |course|
        create(:lesson, course: course, lesson_order: 1)
        create(:lesson, course: course, lesson_order: 2)
        create(:lesson, course: course, lesson_order: 3)
      end
    end
  end

end
