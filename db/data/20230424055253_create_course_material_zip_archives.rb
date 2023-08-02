# frozen_string_literal: true

class CreateCourseMaterialZipArchives < ActiveRecord::Migration[5.2]
  def up
    CourseMaterialFile.all.each do |cmf|
      CourseMaterialArchiveJob.perform_later cmf.course_material_id, 'course_material_files', 'file'
    end

    CourseMaterialMedia.all.each do |cmm|
      CourseMaterialArchiveJob.perform_later cmm.course_material_id, 'course_material_medias', 'media'
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
