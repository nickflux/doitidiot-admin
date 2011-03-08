$(document).ready(function() { 
  // Add Sorting Function
  $(function() {
    $("#todo_sort").sortable({
      containment: '#todo_wrapper', 
      update : function () { 
        var order = $('#todo_sort').sortable('serialize');
        $.ajax({
          url:"/todos/order_update?"+order,
          type:'POST',
          beforeSend: function() {
            $('#todos_updating').html("<img src='/images/ajax-loader.gif' />");
          },
          success: function() {
            $('#todos_updating').html("ORDER UPDATED");
          }
        });
      }});
  });
  
  // Add Deleting Functions
  $(".todo_delete").live('click', function() {
    id  = this.id
    id  = id.replace("todo_delete_", "");
    $.ajax({
      url:"/todos/"+id+"/delete",
      type:'POST',
      beforeSend: function() {
        $('#todos_updating').html("<img src='/images/ajax-loader.gif' />");
      },
      success: function(data) {
        $('#todos_updating').html("To Do deleted");
        $('#todo_'+id).remove();
      }
    });
    return false;
  })

  // Add Edit Functions
  $(".todo_edit").live('click', function() {
    id  = this.id
    id  = id.replace("todo_edit_", "");
    $.ajax({
      url:"/todos/"+id+"/edit",
      type:'GET',
      beforeSend: function() {
        $('#todos_updating').html("<img src='/images/ajax-loader.gif' />");
      },
      success: function(data) {
        $('#todos_updating').html("");
        $('#todo_'+id).html(data);
        jQuery("input.what_to_do_input").attr('readonly', false); 
      }
    });
    return false;
  })

  // Add Update Functions
  $(".todo_update").live('click', function() {
    id          = this.id
    id          = id.replace("todo_update_", "");
    what_to_do  = $("input#what_to_do_"+id).val();
    $.ajax({
      url:"/todos/"+id,
      data:{"what_to_do":what_to_do},
      type:'POST',
      beforeSend: function() {
        $('#todos_updating').html("<img src='/images/ajax-loader.gif' />");
      },
      success: function(return_data) {
        $('#todos_updating').html("To Do updated");
        $('#todo_'+id).html(return_data);
      }
    });
    return false;
  })
  
  // Add Completing Functions
  $(".todo_complete").live('click', function() {
    id  = this.id
    id  = id.replace("todo_complete_", "");
    $.ajax({
      url:"/todos/"+id+"/complete",
      type:'POST',
      beforeSend: function() {
        $('#todos_updating').html("<img src='/images/ajax-loader.gif' />");
      },
      success: function(data) {
        $('#todos_updating').html("To Do completed");
        $('#todo_'+id).remove();
      }
    });
    return false;
  })

  // Add Hover Functions
  $("#todo_sort li").live('mouseover mouseout', function(event) {
      if (event.type == 'mouseover') {
        $(this).find("p").show();
      } else {
        $(this).find("p").hide();
      }
  })

});

$(function() {
  $("#create_todo").click(function() {
    var what_to_do  = $("input#new_todo").val();
    $.ajax({
      url:"/todos/",
      data:{"what_to_do":what_to_do},
      type:'POST',
      beforeSend: function() {
        $('#todos_updating').html("<img src='/images/ajax-loader.gif' />");
      },
      success: function(data) {
        $('#todos_updating').html("To Do added");
        $(data).appendTo('#todo_sort');
        $("input#new_todo").val("");
      }
    });
    return false;
  });
});
