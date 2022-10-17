$(document).ready(function () {
  $("#course_title").change(function () {
    var value = $(this).val();
    $("#course_seo_page_title").val(value);
  });
});
