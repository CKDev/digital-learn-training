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

    if @organization&.subdomain == "att"
      # AT&T's subdomain is specific for some reason - training.att.digitallearn.org
      subdomain_components << @organization&.subdomain
    else
      subdomain_components.prepend(@organization&.subdomain)
    end

    subdomain_components.compact.join(".")
  end

  def build_learners_subdomain
    subdomain_components = []

    subdomain_components << (@organization&.subdomain || "www")
    if @environment == "staging"
      subdomain_components << "staging"
    end

    subdomain_components.join(".")
  end
end
