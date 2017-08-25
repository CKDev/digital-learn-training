class RegistrationsController < Devise::RegistrationsController
  layout proc { user_signed_in? ? "admin/base" : "application" }
end
