class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :lessons
  has_many :attachments, dependent: :destroy

  validates :description, presence: true
  validates :contributor, presence: true # TODO: length ?
  validates :title, length: { maximum: 90 }, presence: true, uniqueness: { message: "must be unique" }
  validates :summary, length: { maximum: 156 }, presence: true
  validates :seo_page_title, length: { maximum: 90 }
  validates :meta_desc, length: { maximum: 156 }
  validates :pub_status, presence: true,
    inclusion: { in: %w(P D A), message: "%{value} is not a valid status" }

  accepts_nested_attributes_for :attachments, reject_if: proc { |a| a[:document].blank? }, allow_destroy: true

  before_save :update_pub_date

  default_scope { order("course_order") }
  scope :with_category, ->(category_id) { where(category_id: category_id) }
  scope :archived, -> { where(pub_status: "A") }
  scope :not_archived, -> { where.not(pub_status: "A") }
  scope :published, -> { where(pub_status: "P") }
  scope :alpha_order, -> { order(:title) }

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

  def update_pub_date
    pub_status == "P" ? self.pub_date = Time.zone.now : self.pub_date = nil
    true # Since this is used from a callback.
  end

  def pub_date_str
    if pub_status == "P" && pub_date.present?
      pub_date.strftime(DateFormats.month_day_year)
    else
      "N/A"
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
