$(document).on('turbolinks:load',function() {
$(function(){

  // $(".search_form_side").on("submit", function(){
  //   let brand_name = $("#q_brand_id_eq").val();
  //   $.ajax({
  //     type: "get",
  //     datatype: "json",
  //     url: "/select_brand"
  //   })
  //   .done(function(){
  //     console.log("ok")
  //   })
  //   .fail(function(){

  //   })
  // })
  let brand_id = "あああ"
  

  $(".search_form_side").on("submit", function(brand_id){
    let brand_name = $("#q_brand_id_eq").val();
    console.log(brand_id);
    return brand_name
  })

  // function get_brand_name()


  // let brand_id = brand_name

  window.onload = function(brand_id){
    $("#q_brand_id_eq").val("シャネル");
   }

  })
})