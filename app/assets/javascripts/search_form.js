$(function(){

  let get_HTML = function(){
  let html = `<select name="q[category_id]" id="q_category_id">`
                `<option value="">全て</option>`
  return html;
  };
  let get_option = function(data){
    let html = `<option value="${data.id}">全て</option>`

  }


  $("#q_category_id").change(function(){
    
    let id = $(this).val();
    $.ajax({
      url: "/search_form_lv2",
      type: "get",
      datatype: "json",
      data: { id: id }
    })
    .done(function(data){
      console.log(data)
    })
    .fail(function(){
      console.log("ng")
    })
  });
})

// $(".search_for-main__side-bar--category").append(get_HTML)