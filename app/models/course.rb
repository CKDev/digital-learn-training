class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  # has_one :course_progress
  has_many :lessons
  has_many :attachments, dependent: :destroy

  validates :description, :contributor, presence: true
  validates :title, length: { maximum: 40 }, presence: true
  validates :seo_page_title, length: { maximum: 90 }
  validates :summary, length: { maximum: 74 }, presence: true
  validates :meta_desc, length: { maximum: 156 }
  validates :pub_status, presence: true,
    inclusion: { in: %w(P D A), message: "%{value} is not a valid status" }

  accepts_nested_attributes_for :attachments, reject_if: proc { |a| a[:document].blank? }, allow_destroy: true

  default_scope { order("course_order ASC") }

  scope :with_category, ->(category_id) { where(category_id: category_id) }

  def validate_has_unique_title
    # TODO: this should go away, or be moved as part of a validation
    if Course.where(title: title).where_exists(:organization_course, organization_id: org_id).count > 0
      errors.add(:title, "must be unique. There is already a course with that title, please select a different title and try again.")
    end
  end

  def current_pub_status
    case pub_status
    when "D" then "Draft"
    when "P" then "Published"
    when "T" then "Trashed"
    end
  end

  def next_lesson_id(current_lesson_id = 0)
    raise StandardError, "There are no available lessons for this course." if lessons.count.zero?

    begin
      current_lesson = lessons.find(current_lesson_id)
      order = current_lesson.lesson_order
      order += 1
      return lessons.order("lesson_order").last.id if order >= last_lesson_order
      next_lesson = lessons.find_by(lesson_order: order)
      next_lesson.id
    rescue
      lessons.order("lesson_order").first.id
    end
  end

  def last_lesson_order
    raise StandardError, "There are no available lessons for this course." if lessons.count.zero?
    lessons.maximum("lesson_order")
  end

  def duration(format = "mins")
    total = 0
    lessons.each { |l| total += l.duration }
    Duration.minutes_str(total, format)
  end

  def set_pub_date
    self.pub_date = Time.zone.now unless pub_status != "P"
  end

  def update_pub_date(new_pub_status)
    if new_pub_status == "P"
      self.pub_date = Time.zone.now
    else
      self.pub_date = nil
    end
  end

  def update_lesson_pub_stats(new_pub_status)
    lessons.each do |l|
      l.pub_status = new_pub_status
      l.save
    end
  end

  def post_course_attachments
    self.attachments.where(doc_type: "post-course")
  end

  def supplemental_attachments
    self.attachments.where(doc_type: "supplemental")
  end
end
