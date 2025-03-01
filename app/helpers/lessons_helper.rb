module LessonsHelper
  def asl_iframe(lesson)
    if lesson.story_line_file_name.present?
      directory = lesson.story_line_file_name.chomp('.zip')
      story_line_url = "/storylines/#{lesson.id}/#{directory}/story.html"
      content_tag(:iframe, nil, src: story_line_url, class: 'story_line', title: lesson.summary, id: 'asl-iframe')
    else
      content_tag(:p, 'There are no available lessons.', class: 'note')
    end
  end
end
