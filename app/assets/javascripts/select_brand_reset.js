$(function(){

  $(".search_form_side").on("submit", function(){
    brand_name = $("#q_brand_id_eq").val();
    $.cookie('brand_name',brand_name);
  })

  window.onload = function(){
    var brand = $.cookie('brand_name');
    $("#q_brand_id_eq").val(brand);
   }
})
