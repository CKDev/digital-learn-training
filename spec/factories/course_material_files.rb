FactoryBot.define do
  factory :course_material_file do
    course_material
    after(:build) do |cmf|
      cmf.file.attach(
        io: File.open(Rails.root.join("spec", "fixtures", "test_upload.pdf")),
        filename: generate(:test_pdf_filename),
        content_type: "application/pdf"
      )
    end
  end
end
