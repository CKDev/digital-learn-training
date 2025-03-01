require 'rails_helper'

describe 'pages/show.html.erb' do
  let(:page) { create(:page, meta_desc: 'Meta description.', seo_title: 'SEO Title') }

  before do
    # Stub `current_organization` method
    view.stubs(:current_organization).returns(nil)
    assign(:page, page)
    assign(:footer_links, [])
    view.expects(:admin_signed_in?).returns(false)
    view.lookup_context.prefixes << 'application' # To find appropriate partials.
  end

  context 'when logged out (or a bot)' do
    it 'uses the meta_desc field as a meta description tag' do
      render template: 'pages/show', layout: 'layouts/application'
      expect(rendered).to have_selector("meta[name='description'][content='Meta description.']", visible: false)
    end

    it 'uses the page summary field as the meta description tag if the seo_page_title is blank' do
      page.update(meta_desc: '')
      render template: 'pages/show', layout: 'layouts/application'
      expect(rendered).to have_selector("meta[name='description']", visible: false)
    end

    it 'uses the seo title if available' do
      render template: 'pages/show', layout: 'layouts/application'
      expect(rendered).to have_selector('title', text: 'SEO Title', visible: false)
    end

    it 'uses the page title if seo title is not available' do
      page.update(seo_title: '')
      render template: 'pages/show', layout: 'layouts/application'
      expect(rendered).to have_selector('title', text: page.title, visible: false)
    end
  end
end
