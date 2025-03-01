FactoryBot.define do
  factory :page do
    title
    body { '<b>Some text here</p>' }
    author { 'Admin' }
    pub_status { 'P' }
  end
end
