$(document).on("turbolinks:load", function(){
$(function(){

  $(".search_for-main__side-bar--button--reset").on("click", function(e){
    e.preventDefault();
    clearForm(".search_form_side");
    $(q_name_cont).val("");
    $(q_category_id).val("");
    $(q_brand_id_eq).val("");
    $(q_price_gteq).val("");
    $(q_price_lteq).val("");
    $(".category_children").remove();
    $(".category_indirects").remove();
  })

  function clearForm (form) {
    $(form)
      .find("input, select, textarea")
      .not(":button, :submit, :reset, :hidden")
      .prop("checked", false)
      .prop("selected", false)
    ;
  }
})
})
