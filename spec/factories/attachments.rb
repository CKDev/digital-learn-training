FactoryBot.define do

  factory :attachment do
    course
    document { fixture_file_upload(Rails.root.join("spec", "fixtures", "test_upload.pdf"), "application/pdf") }
    doc_type { "supplemental" }
  end

end
