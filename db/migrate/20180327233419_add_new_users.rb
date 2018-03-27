class AddNewUsers < ActiveRecord::Migration[5.1]
  def up
    emails.each {|email| User.create!(email: email, password: 'password')}
  end

  def down
    emails.each {|email| User.where(email: email).destroy_all}
  end

  def emails
    %w(mdombrowski@gailborden.info slopez@gailborden.info knoxid@gmail.com)
  end
end
