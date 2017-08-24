module Admin
  class CoursesArchiveController < BaseController

    def index
      @pages = Course.archived
    end

  end
end
