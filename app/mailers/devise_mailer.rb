class DeviseMailer < Devise::Mailer
  def invitation_instructions(record, token, opts = {})
    @organization = opts.delete(:organization)
    @organization_subdomain = @organization&.subdomain # Logo subdomain
    @mailer_subdomain = SubdomainBuilder.new(@organization).build_subdomain # Link subdomain
    opts[:subject] = I18n.t("devise.mailer.invitation_instructions.subject.#{@organization_subdomain || 'default'}",
      default: :"devise.mailer.invitation_instructions.subject.default")
    super(record, token, opts)
  end

  def reset_password_instructions(record, token, opts = {})
    organization = record.roles.where(name: 'organization_admin').first&.resource
    @mailer_subdomain = SubdomainBuilder.new(organization).build_subdomain
    super
  end
end
