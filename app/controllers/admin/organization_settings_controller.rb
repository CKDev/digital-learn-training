module Admin
  class OrganizationSettingsController < BaseController
    def show
      @organization = current_organization
    end

    def update
      @organization = current_organization

      respond_to do |format|
        format.json do
          if @organization.update(organization_settings_params)
            render json: { message: 'Organization settings updated successfully' }
          else
            render json: { error: @organization.errors.full_messages.join(', ') }, status: :unprocessable_entity
          end
        end
      end
    end

    private

    def organization_settings_params
      result = {}

      permitted = params.require(:organization).permit(:header_logo, :footer_logo)
      result.merge!(permitted.to_h)

      if params.dig(:organization, :palette).present?
        result['palette'] = extract_palette(params[:organization][:palette])
      end

      result
    end

    def extract_palette(raw)
      {
        'primary' => {
          'main' => raw.dig(:primary, :main),
          'light' => raw.dig(:primary, :light),
        }.compact,
        'info' => {
          'main' => raw.dig(:info, :main),
          'dark' => raw.dig(:info, :dark),
          'contrastText' => raw.dig(:info, :contrastText),
        }.compact,
        'iconColor' => raw[:iconColor],
      }.compact
    end
  end
end
