class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :course
  has_attached_file :story_line, Rails.configuration.storyline_paperclip_opts
  before_post_process :skip_for_zip

  validates :title, length: { maximum: 90 }, presence: true, uniqueness: { scope: :course }
  validates :summary, length: { maximum: 156 }, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :lesson_order, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :seo_page_title, length: { maximum: 90 }
  validates :meta_desc, length: { maximum: 156 }
  validates :pub_status, presence: true, inclusion: { in: %w(P D A) }
  validates_attachment :story_line, presence: true,
    content_type: { content_type: ['application/zip', 'application/x-zip'] }, size: { in: 0..(100.megabytes) }

  before_save :remove_other_assessments
  before_destroy :delete_associated_asl_files

  default_scope { order('lesson_order') }
  scope :published, -> { where(pub_status: 'P') }
  scope :not_archived, -> { where.not(pub_status: 'A') }

  def published?
    pub_status == 'P'
  end

  def skip_for_zip
    %w(application/zip application/x-zip).include?(story_line_content_type)
  end

  def delete_associated_asl_files
    FileUtils.remove_dir Rails.root.join("public/storylines/#{id}").to_s, true
  end

  def duration_str
    Duration.duration_str(duration)
  end

  def duration_to_int(duration_param)
    if duration_param.include?(':')
      self.duration = Duration.duration_str_to_int(duration_param)
    else
      self.duration = duration_param.to_i
    end
  end

  def remove_other_assessments
    if self.is_assessment
      self.course.lessons.where('lessons.id <> ? AND lessons.is_assessment = ?', self.id, true).update(is_assessment: false)
    else
      true
    end
  end

  def published_lesson_order
    return 0 unless self.published?

    self.course.lessons.published.map(&:id).index(self.id) + 1
  end

  def to_props
    { id: id,
      title: title,
      summary: summary,
      duration: duration,
      courseTitle: course.title,
      coursePath: Rails.application.routes.url_helpers.course_path(course.friendly_id),
      lessonPath: Rails.application.routes.url_helpers.course_lesson_path(course, id),
      storylineUrl: "/storylines/#{id}/#{story_line_file_name.chomp('.zip')}/story.html" }
  end
end
