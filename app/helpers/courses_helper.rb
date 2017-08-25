module CoursesHelper
  def current_topics(course, topic)
    titles = course.topics.map(&:title)
    titles.include?(topic.title)
  end

  def percent_complete_without_user(course, lesson_id)
    session[:completed_lessons] ||= []
    total_lessons = course.lessons.count
    session[:completed_lessons] << lesson_id unless session[:completed_lessons].include?(lesson_id)
    completed = session[:completed_lessons].count
    return 0 if total_lessons.zero?
    percent = (completed.to_f / total_lessons) * 100
    percent.round
  end
end
