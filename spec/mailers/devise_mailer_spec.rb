require 'rails_helper'

describe DeviseMailer do
  describe '#reset_password_instructions' do
    let(:mail) { described_class.reset_password_instructions(user, 'token123') }

    context 'collaborator with an organization role' do
      let(:user) { create(:user, :with_collaborator_profile) }

      before { user.add_role(:collaborator, create(:att)) }

      it 'links to the organization subdomain' do
        expect(mail.body.encoded).to include('att.')
      end
    end

    context 'collaborator who requested access through an organization' do
      let(:user) { create(:user, :with_collaborator_profile) }

      before { create(:access_request, email: user.email.upcase) }

      it 'links to the organization subdomain' do
        expect(mail.body.encoded).to include('att.')
      end
    end

    context 'organization admin' do
      let(:organization) { create(:organization) }
      let(:user) { create(:user) }

      before { user.add_role(:organization_admin, organization) }

      it 'links to the organization subdomain' do
        expect(mail.body.encoded).to include('chipublib.')
      end
    end

    context 'user without an organization' do
      let(:user) { create(:user) }

      it 'links to the default site' do
        expect(mail.body.encoded).not_to include('att.')
        expect(mail.body.encoded).not_to include('chipublib.')
      end
    end
  end
end
