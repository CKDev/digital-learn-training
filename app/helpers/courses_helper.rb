module CoursesHelper

  def current_topics(course, topic)
    titles = course.topics.map(&:title)
    titles.include?(topic.title)
  end

  def percent_complete(course, lesson_id)
    course_id = course.id.to_s
    session[:completed_lessons] ||= {}

    if session[:completed_lessons][course_id].present?
      session[:completed_lessons][course_id] << lesson_id unless session[:completed_lessons][course_id].include?(lesson_id)
    else
      session[:completed_lessons][course_id] = [lesson_id]
    end

    completed = session[:completed_lessons][course_id].reject(&:blank?).size
    total_lessons = course.lessons.count
    return 0 if total_lessons.zero?
    percent = (completed.to_f / total_lessons) * 100
    percent = 100 if percent > 100
    percent.round
  end

end
