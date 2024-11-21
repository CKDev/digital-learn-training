class SubdomainBuilder
  def initialize(organization, environment = Rails.env)
    @organization = organization
    @environment = environment
  end

  def build_subdomain
    subdomain_components = []

    case @environment
    when "production"
      # training.[org_subdomain?].digitallearn.org
      subdomain_components << "training"
    when "staging"
      # staging.training.[org_subdomain?].digitallearn.org
      subdomain_components << "staging"
      subdomain_components << "training"
    end

    subdomain_components << @organization.subdomain
    subdomain_components.join(".")
  end
end
