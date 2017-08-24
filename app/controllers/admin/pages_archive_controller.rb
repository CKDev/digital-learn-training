module Admin
  class PagesArchiveController < BaseController

    def index
      @pages = Page.archived.alpha_order
    end

  end
end
