$(document).ready(function(){
  sortableTable.set_positions();
  sortableTable.init_sortables();
});

var sortableTable =  (function(){
  return {
    set_positions: function(){
      // Loop through and give each task a data-pos attribute that holds its DOM position
      $(".panel.panel-default").each(function(i){
        $(this).attr("data-pos",i + 1);
      });
    },

    init_sortables: function(){
      $(".sortable").sortable();
      $(".sortable").bind("sortupdate", function(e, ui) {
        var updated_order = [];
        var url = $("#sort_url").val();
        sortableTable.set_positions();

        // Populate the updated_order array with the new task positions.
        $(".sortable-item").each(function(i) {
          updated_order.push({ id: $(this).data("id"), position: i + 1 });
        });

        $(".no_drag").attr("draggable", false);


        $.ajax({
          type: "PUT",
          url: url,
          data: { order: updated_order }
        });
      });
    }
  }
})();
