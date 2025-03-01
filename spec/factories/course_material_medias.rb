FactoryBot.define do
  factory :course_material_media do
    course_material
    media { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.png'), 'image/png') }
  end
end
