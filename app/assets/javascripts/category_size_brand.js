$(function(){
  $("#product_name:first").change(function(){
    var input = $("#product_name").val;
    if (input !== "---")
    
      $ajax({
        url: "post/new",
        type: "GET",
        
      })
  })
})

// var html = `<div class="selling__main__sec__content__form__write__content__box__group__select" id="category2">
// <i class="fas fa-chevron-down selling__main__sec__content__form__write__content__box__group__select__icon">
// </i>
// <select value="name" class="selling__main__sec__content__form__write__content__box__group__select__list" id="category2-2">
//   <option value="---">---</option>
//   <option value="トップス">トップス</option>
//   <option value="ジャケット/アウター">ジャケット/アウター</option>
//   <option value="パンツ">パンツ</option>
//   <option value="スカート">スカート</option>
//   <option value="ワンピース">ワンピース</option>
//   <option value="靴">靴</option>
//   <option value="ルームウェア/パジャマ">ルームウェア/パジャマ</option>
//   <option value="レッグウェア">レッグウェア</option>
//   <option value="帽子">帽子</option>
//   <option value="バッグ">バッグ</option>
//   <option value="アクセサリー">アクセサリー</option>
//   <option value="ヘアアクセサリー">ヘアアクセサリー</option>
//   <option value="小物">小物</option>
//   <option value="時計">時計</option>
//   <option value="ウィッグ/エクステ">ウィッグ/エクステ</option>
//   <option value="浴衣/水着">浴衣/水着</option>
//   <option value="スーツ/フォーマル/ドレス">スーツ/フォーマル/ドレス</option>
//   <option value="マタニティ">マタニティ</option>
//   <option value="その他">その他</option>
// </select>
// </div>`
// $(html).insertAfter("#category");
// $("#category2-2").change(function(){
// var html = `<div class="selling__main__sec__content__form__write__content__box__group__select" id="category3">
//   <i class="fas fa-chevron-down selling__main__sec__content__form__write__content__box__group__select__icon">
//   </i>
//   <select value="name" class="selling__main__sec__content__form__write__content__box__group__select__list" id="category3-2">
//     <option value="---">---</option>
//     <option value="テーラードジャケット">テーラードジャケット</option>
//     <option value="ノーカラージャケット">ノーカラージャケット</option>
//     <option value="Gジャン/デニムジャケット">Gジャン/デニムジャケット</option>
//     <option value="レザージャケット">レザージャケット</option>
//     <option value="ダウンジャケット">ダウンジャケット</option>
//     <option value="ライダースジャケット">ライダースジャケット</option>
//     <option value="ミリタリージャケット">ミリタリージャケット</option>
//     <option value="ダウンベスト">ダウンベスト</option>
//     <option value="ジャンパー/ブルゾン">ジャンパー/ブルゾン</option>
//     <option value="ポンチョ">ポンチョ</option>
//     <option value="ロングコート">ロングコート</option>
//     <option value="トレンチコート">トレンチコート</option>
//     <option value="ダッフルコート">ダッフルコート</option>
//     <option value="ピーコート">ピーコート</option>
//     <option value="チェスターコート">チェスターコート</option>
//     <option value="モッズコート">モッズコート</option>
//     <option value="スタジャン">スタジャン</option>
//     <option value="毛皮/ファーコート">毛皮/ファーコート</option>
//     <option value="スプリングコート">スプリングコート</option>
//     <option value="スカジャン">スカジャン</option>
//     <option value="その他">その他</option>
//   </select>
// </div>`
// $(html).insertAfter("#category2");
// $("#category3-2").change(function(){
// var html = `<div class="selling__main__sec__content__form__write__content__box__group">
//     <label class="selling__main__sec__content__form__write__content__box__group__label">サイズ
//       <span class="selling__main__sec__content__form__write__content__box__group__label__need">必須</span>
//     </label>
//     <div class="selling__main__sec__content__form__write__content__box__group__select">
//       <i class="fas fa-chevron-down selling__main__sec__content__form__write__content__box__group__select__icon">
//       </i>
//       <select value="status" class="selling__main__sec__content__form__write__content__box__group__select__list">
//         <option value="---">---</option>
//         <option value="XXS以下">XSS以下</option>
//         <option value="XS(SS)">XS(SS)</option>
//         <option value="S">S</option>
//         <option value="M">M</option>
//         <option value="L">L</option>
//         <option value="XL(LL)">XL(LL)</option>
//         <option value="2XL(3L)">2XL(3L)</option>
//         <option value="3XL(4L)">3XL(4L)</option>
//         <option value="4XL(5L)以上">4XL(5L)以上</option>
//         <option value="FREE SIZE">FREE SIZE</option>
//       </select>
//     </div>
//   </div>


  
//   <div class="selling__main__sec__content__form__write__content__box__group">
//     <label class="selling__main__sec__content__form__write__content__box__group__label">ブランド
//       <span class="selling__main__sec__content__form__write__content__box__group__label__free">任意</span>
//     </label>
//     <div class="selling__main__sec__content__form__write__content__box__group__select">
//       <input class="selling__main__sec__content__form__write__content__box__group__select__input" placeholder="例）シャネル">
//       </input>
//     </div>
//   </div>`
// $(html).insertAfter("#group1");
// })
// })
// });

// })
