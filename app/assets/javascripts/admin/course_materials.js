$(document).ready(function() {
  $("body").on("change", "#category-id", function () {
    $.ajax({
      url: document.location.pathname,
      data: { category_id: $(this).val() },
      dataType: "json",
      type: "GET"
    }).always(function(data) {
      debugger;
      $("#js-subcategory-container").empty().html(data.responseText);
    });
  });
});
