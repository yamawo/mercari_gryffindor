$(function(){

  let get_HTML = function(){
  let html = `<select class="category_children" name="q[category_id_eq]" id="q_category_id" >`
  return html;
  };

  let get_HTML_indirects = function(){
  let html = `<select class="category_indirects" name="q[category_id_eq]" id="q_category_id">`
  return html;
  };
  
  function get_option(data){
    let html = `<option value="${data.id}">${data.name}</option>`
    return html;
  }

  $(".category_select").change(function(){
    let id = $(this).val();
    $.ajax({
      url: "/search_form_lv2",
      type: "get",
      datatype: "json",
      data: {id: id}
    })
    .done(function(datas){
        $(".category_children").remove();
        $(".search_for-main__side-bar--category").append(get_HTML)
        $(".category_children").append(`<option value>全て</option>`)
          datas.forEach(function(data){
            option = get_option(data);
            $(".category_children").append(option)
        });
    })
    .fail(function(){
    })
  });

    $(document).on("change",".category_children", function(){
    let id = $(this).val();
    $.ajax({
      url: "/search_form_lv2",
      type: "get",
      datatype: "json",
      data: {id: id}
    })
    .done(function(datas){
      $(".category_indirects").remove();
      $(".search_for-main__side-bar--category").append(get_HTML_indirects)
      $(".category_indirects").append(`<option value>全て</option>`)
      datas.forEach(function(data){
        option = get_option(data);
        $(".category_indirects").append(option)
      })
    })
    .fail(function(){
    })
  });
  
})
