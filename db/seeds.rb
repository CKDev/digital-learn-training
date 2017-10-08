if Rails.env.development?
  User.create(email: "alex@commercekitchen.com", password: "asdfasdf", confirmed_at: Time.zone.now, admin: true)
end

["About", "Bibliography", "Privacy Policy | Terms", "Contribute to DigitalLearn"].each do |page|
  Page.create(title: page, body: "#{page} ...", pub_status: "draft", author: "Admin")
end

Category.create(title: "Computer Basics", tag: "Getting Started")
Category.create(title: "Tablet Basics", tag: "Getting Started")

category = Category.create(title: "Hardware", tag: "Hardware")
SubCategory.create(title: "PC Hardware", category: category)

category = Category.create(title: "Microsoft Tools", tag: "Software & Applications")
SubCategory.create(title: "Microsoft Office 2013", category: category)
SubCategory.create(title: "Microsoft Office 2010", category: category)

Category.create(title: "Google Tools", tag: "Software & Applications")
Category.create(title: "Social Media", tag: "Software & Applications")
Category.create(title: "More Websites & Apps", tag: "Software & Applications")
Category.create(title: "Resume Series", tag: "Job & Career")
Category.create(title: "LinkedIn", tag: "Job & Career")
category = Category.create(title: "Other", tag: "Other")

CourseMaterial.create(
  title: "Course Templates",
  contributor: "Admin",
  summary: "Use our templates to design your own classroom materials!",
  category: category,
  pub_status: "P"
)
