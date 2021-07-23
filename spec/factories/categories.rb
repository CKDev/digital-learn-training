FactoryBot.define do

  factory :category do
    title { "Category Title" }
    description { "Category Description" }
    tag { "Software & Applications" }
  end

  factory :category2, class: Category do
    title { "Category 2 Title" }
    description { "Category Description" }
    tag { "Software & Applications" }
  end

end
