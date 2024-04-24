FactoryBot.define do
  factory :course_material do
    title
    category
    summary { "In this course you will..." }
    description { "Description" }
    contributor { "John Doe" }
    pub_status { "D" }
    sort_order { 1 }

    trait :with_file_archive do
      file_archive { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "BasicSearch1.zip"), "application/zip") }
    end

    trait :with_media_archive do
      media_archive { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "BasicSearch1.zip"), "application/zip") }
    end
  end
end
