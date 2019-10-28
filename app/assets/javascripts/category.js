$(document).on("turbolinks:load", function(){
  var buildchildrenHTML = function(children){
    var html = `<div class="selling__main__sec__content__form__write__content__box__group__select" id="category2">
                  <i class="fas fa-chevron-down selling__main__sec__content__form__write__content__box__group__select__icon">
                  </i>
                  <select value="category_id" class="selling__main__sec__content__form__write__content__box__group__select__list" id="children">
                    <option value="---">---</option>
                  </select>
                </div>`
    return html;
  };
  var buildgrandchildrenHTML = function(grandchildren){
    var html = `<div class="selling__main__sec__content__form__write__content__box__group__select" id="category3">
                  <i class="fas fa-chevron-down selling__main__sec__content__form__write__content__box__group__select__icon">
                  </i>
                  <select value="category_id" class="selling__main__sec__content__form__write__content__box__group__select__list" name="product[category_id]" id="grandchildren">
                  </select>
                </div>`
    return html;
  };
  var buildsize_brandHTML = function(sizes){
    var html =  `<div class="selling__main__sec__content__form__write__content__box__group" id="sizes">
                  <label class="selling__main__sec__content__form__write__content__box__group__label">サイズ
                    <span class="selling__main__sec__content__form__write__content__box__group__label__need">必須</span>
                  </label>
                  <div class="selling__main__sec__content__form__write__content__box__group__select">
                    <i class="fas fa-chevron-down selling__main__sec__content__form__write__content__box__group__select__icon">
                    </i>
                    <select class="selling__main__sec__content__form__write__content__box__group__select__list" name="product[size_id]" id="size">
                      <option value="---">---</option>
                    </select>
                  </div>
                </div>`
      return html;
    }
    var build_brandHTML = function(brands){
      var html = `<div class="selling__main__sec__content__form__write__content__box__group">
                    <label class="selling__main__sec__content__form__write__content__box__group__label">ブランド
                      <span class="selling__main__sec__content__form__write__content__box__group__label__free">任意</span>
                    </label>
                    <div class="selling__main__sec__content__form__write__content__box__group__select">
                      <input class="selling__main__sec__content__form__write__content__box__group__select__input" placeholder="例）シャネル" name="product[brand_id]" id="brand_list">
                      </input>
                        <div>
                          <ul class="selling__main__sec__content__form__write__content__box__group__select__search">
                          </ul>
                        </div>
                    </div>
                  </div>`
      return html;
    }
  $("#product_category_id").change(function(){
    var input = $('#product_category_id').val();
    if(input == "---"){
      $("#category2").remove();
      $("#category3").remove();
    }else if(document.getElementById("category2") != null){
      $("#children").empty();
      $("#category3").remove();
      $.ajax({
        url: "/products/create_category_children",
        data: { value: input },
        dataType: "json"
      })
      .done(function(children){
        var option = document.createElement("option");
        option.value = "---";
        option.text = "---";
        document.getElementById("children").appendChild(option);
        for(var i=0; i<children.length; i++) {
          var option = document.createElement("option");
          option.value = children[i].id
          option.text = children[i].name
          document.getElementById("children").appendChild(option);
        }
        $("#children").change(function(){
          var input2 = $('#children').val();
          var val = `${input}/${input2}`
          if (input2 == "---"){
            $("#category3").remove();
          }else if(document.getElementById("category3") != null){
            $("#grandchildren").empty();
            $.ajax({
              url: "/products/create_category_grandchildren",
              data: { value: val },
              dataType: "json"
            })
            .done(function(grandchildren){
              var option = document.createElement("option");
              option.value = "---";
              option.text = "---";
              for(var i=0; i<grandchildren.length; i++) {
                var option = document.createElement("option");
                option.value = grandchildren[i].id;
                option.text = grandchildren[i].name;
                document.getElementById("grandchildren").appendChild(option);
              }
            })
          }else if(input2 == 1325){
            return;
          }else if(input2 == 1234){
            $.ajax({
              url: "/products/search_size",
              data: { value: input2 },
              dataType: "json",
            })
            .done(function(sizes){
              var html = buildsize_brandHTML(sizes);
              if(document.getElementById("sizes") != null){
                return;
              }else{
                $(html).insertAfter("#group1");
                for(var i=0; i<sizes.length; i++) {
                  var option = document.createElement("option");
                  option.value = sizes[i].id;
                  option.text = sizes[i].name;
                  document.getElementById("size").appendChild(option);
                  return false
                }
              }
            })
          }
          else{
            $.ajax({
              url: "/products/create_category_grandchildren",
              data: { value: val },
              dataType: "json"
            })
            .done(function(grandchildren){
              // var html = buildgrandchildrenHTML(grandchildren);
              // $(html).insertAfter("#category2");
              var option = document.createElement("option");
              // option.value = "---";
              // option.text = "---";
              // document.getElementById("grandchildren").appendChild(option);
              for(var i=0; i<grandchildren.length; i++) {
                var option = document.createElement("option");
                option.value = grandchildren[i].id;
                option.text = grandchildren[i].name;
                document.getElementById("grandchildren").appendChild(option);
              }
              $("#grandchildren").change(function(){
                var input3 = $("#grandchildren").val();
                if (input3 != "---")
                  $.ajax({
                    url: "/products/search_size",
                    data: { value: input3 },
                    dataType: "json"
                  })
                  .done(function(sizes){
                    var html = buildsize_brandHTML(sizes);
                    if(document.getElementById("sizes") != null){
                      return;
                    }else{
                    $(html).insertAfter("#group1");
                    for(var i=0; i<sizes.length; i++) {
                      var option = document.createElement("option");
                      option.value = sizes[i].id;
                      option.text = sizes[i].name;
                      document.getElementById("size").appendChild(option);
                    }
                    }
                  })
              })
            })
          }
        })
      })
     
    }else if(document.getElementById("category2") == null){
      $.ajax({
        url: "/products/create_category_children",
        data: { value: input },
        dataType: "json"
      })
      .done(function(children){
        var html = buildchildrenHTML(children);
        $(html).insertAfter("#category");
        for(var i=0; i<children.length; i++) {
          var option = document.createElement("option");
          option.value = children[i].id
          option.text = children[i].name;
          document.getElementById("children").appendChild(option);
        };
          $("#children").change(function(){
            var input2 = $('#children').val();
            var val = `${input}/${input2}`
            if (input2 == "---"){
              $("#category3").remove();
            }else if(document.getElementById("category3") != null){
              $("#grandchildren").empty();
              $.ajax({
                url: "/products/create_category_grandchildren",
                data: { value: val },
                dataType: "json"
              })
              .done(function(grandchildren){
                var option = document.createElement("option");
                option.value = "---";
                option.text = "---";
                document.getElementById("grandchildren").appendChild(option);
                for(var i=0; i<grandchildren.length; i++) {
                  var option = document.createElement("option");
                  option.value = grandchildren[i].id;
                  option.text = grandchildren[i].name;
                  document.getElementById("grandchildren").appendChild(option);
                }
              })
            }else if(input2 == 1325){
              return;
            }else if(input2 == 1234){
              $.ajax({
                url: "/products/search_size",
                data: { value: input2 },
                dataType: "json",
              })
              .done(function(sizes){
                var html = buildsize_brandHTML(sizes);
                if(document.getElementById("sizes") != null){
                  return;
                }else{
                  $(html).insertAfter("#group1");
                  for(var i=0; i<sizes.length; i++) {
                    var option = document.createElement("option");
                    option.value = sizes[i].id;
                    option.text = sizes[i].name;
                    document.getElementById("size").appendChild(option);
                  }
                }
              })
            }
            else{
              $.ajax({
                url: "/products/create_category_grandchildren",
                data: { value: val },
                dataType: "json"
              })
              .done(function(grandchildren){
                var html = buildgrandchildrenHTML(grandchildren);
                $(html).insertAfter("#category2");
                var option = document.createElement("option");
                option.value = "---";
                option.text = "---";
                document.getElementById("grandchildren").appendChild(option);
                for(var i=0; i<grandchildren.length; i++) {
                  var option = document.createElement("option");
                  option.value = grandchildren[i].id;
                  option.text = grandchildren[i].name;
                  document.getElementById("grandchildren").appendChild(option);
                }
                $("#grandchildren").change(function(){
                  var input3 = $("#grandchildren").val();
                  if (input3 != "---")
                    $.ajax({
                      url: "/products/search_size",
                      data: { value: input3 },
                      dataType: "json"
                    })
                    .done(function(sizes){
                      var html = buildsize_brandHTML(sizes);
                      var brand_html = build_brandHTML(sizes);
                      $(brand_html).insertAfter("#group1")
                      if(sizes.length == 0 ){
                      }else{
                        if(document.getElementById("sizes") != null){
                          return;
                        }else{
                        $(html).insertAfter("#group1");
                        for(var i=0; i<sizes.length; i++) {
                          var option = document.createElement("option");
                          option.value = sizes[i].id;
                          option.text = sizes[i].name;
                          document.getElementById("size").appendChild(option);
                          }
                        }
                      }
                      
                    })
                })
              })
            }
          })
      });
    }   
  })
})

$(window).on("load", function(){
  if(document.URL.match(/\/products\/\d+\/edit/))
    id = $(".hidden_id").val();
    $.ajax({
      url: `/products/${id}/edit`,
      data: "",
      data: "",
      data: "",
      type: "GET",
      dataType: "json"
    })
    .done(function(product){
      $("#grandchildren").val(product.grandchild_id);
      $("#children").val(product.child_id);
      $("#product_category_id").val(product.parent_id);
      $("#size").val(product.size_id);
      $("#product_brand_id").val(product.brand_name);
      $(".brand").val(product.brand_id);
    })
})
