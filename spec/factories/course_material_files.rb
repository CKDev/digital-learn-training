FactoryBot.define do
  factory :course_material_file do
    course_material
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_upload.pdf'), 'application/pdf') }
  end
end
