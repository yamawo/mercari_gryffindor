$(function(){

  let get_HTML = function(){
  let html = `<select name="q[category_id]" id="q_category_id" class="category_children">`
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
      if ($("select").hasClass("category_children")){
        $(".category_children").remove();
        $(".search_for-main__side-bar--category").append(get_HTML)
          datas.forEach(function(data){
            option = get_option(data);
            $(".category_children").append(option)
        });
      }
      else{
        $(".search_for-main__side-bar--category").append(get_HTML)
          datas.forEach(function(data){
            option = get_option(data);
            $(".category_children").append(option)
        });
      }
    })
    .fail(function(){
      console.log("ng")
    })
  });

  // $(".category_children").change(function(){
  //   console.log("ok")
  //   let id = $(this).val();
  //   $.ajax({
  //     url: "/search_form_lv2",
  //     type: "get",
  //     datatype: "json",
  //     data: {id: id}
  //   })
  //   .done(function(datas){
  //     if ($("select").hasClass("category_children")){
  //       console.log("ok")
  //     }
  //     else{
  //       $(".search_for-main__side-bar--category").append(get_HTML)
  //         datas.forEach(function(data){
  //           option = get_option(data);
  //           $(".category_children").append(option)
  //       });
  //     }
  //   })
  //   .fail(function(){
  //     console.log("ng")
  //   })
  // });










})
