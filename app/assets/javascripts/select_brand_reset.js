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


  $(".search_form_side").on("submit", function(){
    brand_name = $("#q_brand_id_eq").val();
    $.cookie('brand_name',brand_name);
  })

  // function get_brand_name()


  // let brand_id = brand_name

  window.onload = function(){
    // console.log(brand_id);
    var brand = $.cookie('brand_name');
    $("#q_brand_id_eq").val(brand);
   }
  
  })
})