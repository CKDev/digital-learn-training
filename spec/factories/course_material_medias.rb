FactoryBot.define do
  factory :course_material_media do
    course_material
    after(:build) do |cmf|
      cmf.media.attach(
        io: File.open(Rails.root.join("spec", "fixtures", "test.png")),
        filename: generate(:test_image_filename),
        content_type: "image/png"
      )
    end
  end
end
