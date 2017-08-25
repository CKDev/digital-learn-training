class PasswordsController < Devise::PasswordsController
  layout proc { user_signed_in? ? "admin/base" : "application" }
end
