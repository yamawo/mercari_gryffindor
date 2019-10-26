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
  
  var brand_id = "aaa"

  $(".search_form_side").on("submit", function(){
    brand_name = $("#q_brand_id_eq").val();
    console.log(brand_id);
    brand_id = brand_name
    console.log(brand_id);
    $.cookie('brand_name',brand_id);
  })

  // function get_brand_name()


  // let brand_id = brand_name

  window.onload = function(){
    // console.log(brand_id);
    var brand_id = $.cookie('brand_name');
    $("#q_brand_id_eq").val(brand_id);
   }
  
  })
})