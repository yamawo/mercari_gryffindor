$(document).on('turbolinks:load',function() {
  $('img.products-show__product-details__main__item-photo__list__one__inner__img').mouseover(function(){
  // "_thumb"を削った画像ファイル名を取得
  var selectedSrc = $(this).attr('src').replace(/^(.+)_thumb(\.gif|\.jpg|\.png+)$/, "$1"+"$2");
  
  // 画像入れ替え
  $('img.products-show__product-details__main__item-photo__outer__top').stop().fadeOut(50,
  function(){
  $('img.products-show__product-details__main__item-photo__outer__top').attr('src', selectedSrc);
  $('img.products-show__product-details__main__item-photo__outer__top').stop().fadeIn(200);
  }
  );
  // サムネイルの枠を変更
  $(this).css({"opacity": "1"});
  });
  
  // マウスアウトでサムネイル枠もとに戻す
  $('img.products-show__product-details__main__item-photo__list__one__inner__img').mouseout(function(){
  $(this).css({"opacity":"0.50"});
  });
 });