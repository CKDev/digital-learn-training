FactoryBot.define do

  factory :attachment do
    course
    document { fixture_file_upload(Rails.root.join("spec", "fixtures", "test_upload.pdf"), "application/pdf") }
    doc_type { "supplemental" }
  end

  factory :docx_attachment, class: 'Attachment' do
    course
    document { fixture_file_upload(Rails.root.join("spec", "fixtures", "test_document.docx"), "application/vnd.openxmlformats-officedocument.wordprocessingml.document") }
    document_content_type { "application/vnd.openxmlformats-officedocument.wordprocessingml.document" }
    doc_type { "supplemental" }
  end

end
