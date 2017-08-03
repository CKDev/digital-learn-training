require "zip"

class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :course
  has_attached_file :story_line, url: "/system/lessons/story_lines/:id/:style/:basename.:extension"
  before_post_process :skip_for_zip

  # TODO: We need to make lesson titles unique per course, but not site-wide.
  validates :title, length: { maximum: 90 }, presence: true # , uniqueness: true
  validates :summary, length: { maximum: 156 }, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :lesson_order, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :seo_page_title, length: { maximum: 90 }
  validates :meta_desc, length: { maximum: 156 }
  validates :pub_status, presence: true, inclusion: { in: %w(P D A), message: "%{value} is not a valid status" }
  validates_attachment :story_line, presence: true,
    content_type: { content_type: ["application/zip", "application/x-zip"] }, size: { in: 0..100.megabytes }

  before_destroy :delete_associated_asl_files

  default_scope { order("lesson_order") }
  scope :published, -> { where(pub_status: "P") }

  def skip_for_zip
    %w(application/zip application/x-zip).include?(story_line_content_type)
  end

  def delete_associated_asl_files
    FileUtils.remove_dir "#{Rails.root}/public/storylines/#{id}", true
  end

  def duration_str
    Duration.duration_str(duration)
  end

  def duration_to_int(duration_param)
    if duration_param.include?(":")
      self.duration = Duration.duration_str_to_int(duration_param)
    else
      self.duration = duration_param.to_i
    end
  end
end
