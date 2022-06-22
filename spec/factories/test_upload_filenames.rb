FactoryBot.define do
  sequence :test_pdf_filename do |n|
    "test_upload#{n}.pdf"
  end

  sequence :test_image_filename do |n|
    "test_image#{n}.png"
  end
end