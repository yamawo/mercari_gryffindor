$(document).on("turbolinks:load", function(){
  
  function appendBrand(brand) {
    var search_result = $(".selling__main__sec__content__form__write__content__box__group__select__search");
    var html = `<li class="selling__main__sec__content__form__write__content__box__group__select__search__ele" data-id="${brand.id}">${brand.name}</li>`
    search_result.append(html);
  }
  $(document).on('input', "#brand_list", function(){//動的に追加した要素はdocumentで
    var input = $('#brand_list').val();
    if (input.length !== 0){
      $.ajax({
      url: "/products/search",
      data: { keyword: input },
      dataType: "json"
      })
      .done(function(brands){
      $(".selling__main__sec__content__form__write__content__box__group__select__search").empty();
      if(brands.length !== 0){
        brands.forEach(function(brand){
          appendBrand(brand);
        })
      }
      })
    }
  })
  $(document).on("click", ".selling__main__sec__content__form__write__content__box__group__select__search__ele", function() {
    var brand_name = $(this).text().replace(/\r?\n/g, '');
    var brand_id = $(this).data("id")
    console.log(brand_id)
    $("#brand_list").val(brand_name)
    $(".selling__main__sec__content__form__write__content__box__group__select__search__ele").remove();
    $(".brand_hidden").val(brand_id)
  })
})