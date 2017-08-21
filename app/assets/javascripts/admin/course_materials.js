$(document).ready(function() {
  var subCategories = $("#course_material_sub_category_id").html();
  showHideSubCategoryOptions();
  $("body").on("change", "#course_material_category_id", function () {
    showHideSubCategoryOptions();
  });

  function showHideSubCategoryOptions() {
    var category = $("#course_material_category_id :selected").text();
    var options = $(subCategories).filter("optgroup[label='" + category + "']").html();
    if (options) {
      var defaultOption = "<option value=''>Select ...</option>";
      options = defaultOption + options;
      $("#course_material_sub_category_id").html(options);
      $("#course_material_sub_category_id").parent().show();
    }
    else {
      $("#course_material_sub_category_id").empty();
      $("#course_material_sub_category_id").parent().hide();
    }
  }
});
