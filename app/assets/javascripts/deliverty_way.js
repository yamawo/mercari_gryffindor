$(function(){
  $("#product_delivery_responsivility").change(function() {
    var html = `<div class="selling__main__sec__content__form__write__content__box__group" id="delivery_method">
                  <label class="selling__main__sec__content__form__write__content__box__group__label">配送の方法
                    <span class="selling__main__sec__content__form__write__content__box__group__label__need">必須</span>
                  </label>
                  <div class="selling__main__sec__content__form__write__content__box__group__select">
                    <i class="fas fa-chevron-down selling__main__sec__content__form__write__content__box__group__select__icon">
                    </i>
                    <select class="selling__main__sec__content__form__write__content__box__group__select__list" value="delivery_responsivility">
                      <option value="---">---</option>
                      <option value="未定">未定</option>
                      <option value="らくらくメルカリ便">らくらくメルカリ便</option>
                      <option value="ゆうメール">ゆうメール</option>
                      <option value="レターパック">レターパック</option>
                      <option value="普通郵便（定形、定形外）">普通郵便（定形、定形外）</option>
                      <option value="クロネコヤマト">クロネコヤマト</option>
                      <option value="ゆうパック">ゆうパック</option>
                      <option value="クリックポスト">クリックポスト</option>
                      <option value="ゆうパケット">ゆうパケット</option>
                    </select>
                  </div>
                </div>`
  const option1 = document.getElementById("product_delivery_responsivility").value;
  if(option1 == "---") {
    $("#delivery_method").remove();
  }else if(document.getElementById("delivery_method") != null){
    return
  }else{
    $(html).insertAfter("#responsivility");
  }
  })
});
