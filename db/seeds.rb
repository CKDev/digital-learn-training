if Rails.env.development?
  User.create(email: "alex@commercekitchen.com", password: "asdfasdf", confirmed_at: Time.zone.now, admin: true)
end

["About", "Bibliography", "Privacy Policy | Terms"].each do |page|
  Page.create(title: page, body: "#{page} ...", pub_status: "draft", author: "Admin")
end

category = Category.create(title: "Hardware")
SubCategory.create(title: "Computer Basics", category: category)
SubCategory.create(title: "Tablet Basics", category: category)

category = Category.create(title: "Software & Applications")
SubCategory.create(title: "Microsoft Tools", category: category)
SubCategory.create(title: "Google Tools", category: category)
SubCategory.create(title: "Social Media", category: category)
SubCategory.create(title: "More Websites & Apps", category: category)

category = Category.create(title: "Job & Career")
SubCategory.create(title: "Resume Series", category: category)
SubCategory.create(title: "LinkedIn", category: category)
