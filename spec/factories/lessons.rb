FactoryBot.define do
  factory :lesson do
    title
    summary { "Lesson summary" }
    duration { 90 }
    lesson_order { 1 }
    pub_status { "P" }
    story_line { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "BasicSearch1.zip"), "application/zip") }
  end
end
