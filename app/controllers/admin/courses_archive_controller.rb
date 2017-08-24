module Admin
  class CoursesArchiveController < BaseController

    def index
      @courses = Course.archived
    end

  end
end
