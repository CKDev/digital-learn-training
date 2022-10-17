$(document).ready(function () {
  $("#lesson_title").change(function () {
    var value = $(this).val();
    $("#lesson_seo_page_title").val(value);
  });
});
