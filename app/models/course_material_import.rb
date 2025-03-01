class CourseMaterialImport < ApplicationRecord
  belongs_to :organization
  belongs_to :course_material
end
