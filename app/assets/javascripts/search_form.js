$(function(){

  let select_main = function(){
  let html = `<select class="category_children" name="q[category_id_eq]" id="q_category_id" >`
  return html;
  };

  let get_HTML_indirects = function(){
  let html = `<select class="category_indirects" name="q[category_id_eq]" id="q_category_id">`
  return html;
  };

  function defoult_option(id){
    let html = `<option value="${id}" class="d_option">全て</option>`
    return html;
  }

  function get_option(data){
    let html = `<option value="${data.id}">${data.name}</option>`
    return html;
  }
  
  $(".category_select").change(function(){
    let id = $(this).val();

    if (id[0] == undefined){
      $(".category_children").remove();
      $(".category_indirects").remove();
    }
    $.ajax({
      url: "/search_form_lv2",
      type: "get",
      datatype: "json",
      data: {id: id}
    })
    .done(function(datas){
      $(".category_children").remove();
      $(".category_indirects").remove();
      $(".search_for-main__side-bar--category").append(select_main)
      d_option = defoult_option(id)
      $(".category_children").append(d_option)
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
    let ids = $(this).children(':selected').text();
    if (ids == "全て"){
      $(".category_indirects").remove();
    }
    $.ajax({
      url: "/search_form_lv2",
      type: "get",
      datatype: "json",
      data: {id: id}
    })
    .done(function(datas){
      if (ids == "全て"){
      $(".category_indirects").remove();
      }
      else{
      $(".category_indirects").remove();
      $(".search_for-main__side-bar--category").append(get_HTML_indirects)
      d_option = defoult_option(id)
      $(".category_indirects").append(d_option)
      datas.forEach(function(data){
        option = get_option(data);
        $(".category_indirects").append(option)
      })}
    })
    .fail(function(){
    })
  });
  
})
