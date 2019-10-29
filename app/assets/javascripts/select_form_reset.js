$(document).on("turbolinks:load", function(){
$(function(){

  $(".search_for-main__side-bar--button--reset").on("click", function(e){
    e.preventDefault();
    clearForm(".search_form_side");
    $(".category_children").remove();
    $(".category_indirects").remove();
  })

  function clearForm (form) {
    $(form)
      .find("input, select, textarea")
      .not(":button, :submit, :reset, :hidden")
      .val("")
      .prop("checked", false)
      .prop("selected", false)
    ;
  }
})
})