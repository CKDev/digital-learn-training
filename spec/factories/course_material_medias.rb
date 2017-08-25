FactoryGirl.define do
  factory :course_material_media do
    course_material
    media { fixture_file_upload(Rails.root.join("spec", "fixtures", "test.png"), "image/png") }
  end
end
