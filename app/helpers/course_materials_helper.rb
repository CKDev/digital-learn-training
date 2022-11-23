module CourseMaterialsHelper
  def category_anchor_id(category)
    category.title.parameterize(separator: '-')
  end
end
