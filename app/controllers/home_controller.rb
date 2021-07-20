class HomeController < ApplicationController
  prepend_before_action :redirect_unauthenticated_subdomain_user

  def index
    @courses = Course.published.limit(2)
    @categories = Category.includes(sub_categories: :course_materials).all
    @getting_started = @categories.where(tag: "Getting Started")
    @hardware = @categories.where(tag: "Hardware")
    @software_and_applications = @categories.where(tag: "Software & Applications")
    @job_and_career = @categories.where(tag: "Job & Career")
  end

  private

  def redirect_unauthenticated_subdomain_user
    if !current_user && current_organization
      redirect_to "/#{current_organization.subdomain}/login"
    end
  end

end
