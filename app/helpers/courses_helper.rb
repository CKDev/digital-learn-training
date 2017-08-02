module CoursesHelper
  def current_topics(course, topic)
    titles = course.topics.map(&:title)
    titles.include?(topic.title)
  end

  def pub_status_str(course)
    case course.pub_status
    when "D" then "Draft"
    when "P" then "Published"
    when "T" then "Trashed"
    end
  end

  def percent_complete(course)
    if user_signed_in?
      course_progress = current_user.course_progresses.find_by_course_id(course.id)
      if course_progress.present?
        return "#{course_progress.percent_complete}#{I18n.t 'lesson_page.percent_complete'}"
      else
        return "0#{I18n.t 'lesson_page.percent_complete'}"
      end
    end
    ""
  end

  def percent_complete_without_user(course, lesson_id)
    session[:completed_lessons] ||= []
    total_lessons = course.lessons.count
    session[:completed_lessons] << lesson_id unless session[:completed_lessons].include?(lesson_id)
    completed = session[:completed_lessons].count
    return 0 if total_lessons == 0
    percent = (completed.to_f / total_lessons) * 100
    percent.round
  end
end
