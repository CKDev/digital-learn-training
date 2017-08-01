if Rails.env.development?
  User.create(email: "alex@commercekitchen.com", password: "asdfasdf", confirmed_at: Time.zone.now, admin: true)
end

["About", "Bibliography", "Privacy Policy"].each do |page|
  Page.create(title: page, body: "#{page} ...", pub_status: "draft", author: "Admin")
end
