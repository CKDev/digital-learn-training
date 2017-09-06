$(document).delegate(".remove_child","click", function() {
  $(this).parent().children(".removable")[0].value = 1;
  $(this).prev().slideUp();
  $(this).parent().slideUp();
  $(this).slideUp();
  return false;
});

// Add attachment fields in Course form.
function add_fields(association, content, prefix) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $("#add-attachment-" + prefix).before(content.replace(regexp, new_id));
};
