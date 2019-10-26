if (window.location.href.match(/\/products\/\d+\/edit/)){
    $(window).on("turbolinks:load", function(){
        let dropzone = $(".js-items");
        let new_dropzone = $(".js-new_items");
        let dropzone2 = $(".js-items2");
        let appendzone = $(".js-box2");
        let input_area = $(".selling__main__sec__content__form__write__upload__box__items__input-area");
        let new_input_area = $(".selling__main__sec__content__form__write__upload__box__new_items__input-area");
        let preview = $("#preview");
        let preview2 = $("#preview2");

        // まずnewページで使ってたdropzoneは消す（画像分出るので）
        dropzone.css({
            "display": "none"
        })

        // ビューで使う全ての画像が入った配列（dropzone可変で使用）
        let images = gon.edit_product_images
        // 新しい画像のみが入った配列（DBに保存させる用）
        let new_images = []
        // 画像が４枚以下の場合
        if (images.length <= 4){
            new_dropzone.css({
                "width": `calc(100% - (20% * ${images.length}))`
            });
            // 画像が５枚のとき１段目の枠を消し、２段目の枠を出す
        } else if (images.length == 5){
            // TODO ２段目実装時にコメントアウト外すこと
            // appendzone.css({
            //     "display": "block"
            // });
            new_dropzone.css({
                "display": "none"
            });
        } //else if (images.length >= 6){
        //     // １〜５枚目の画像を抽出
        // }
        
        // 新規画像投稿の場合の処理
        $(".js-box, .js-box2").on("change", 'input[type="file"].selling__main__sec__content__form__write__upload__box__new_items__input-area__field', function(){
            // ビューに表示するために、一時的に画像を入れる配列
            let temporary_images = [];
            // 2回目以降前のが残ってるので初期化
            temporary_images.length = 0
            // dropされたファイルデータをpropで取って変数fileに入れ込む
            let file = $(this).prop("files")[0];

            // 新規追加画像を保存
            // ファイル読み取りを行えるようにするようにFileReaderに格納
            let reader = new FileReader();
            let img = $(`<div class="add_img"><div class="img_area"><img class="image"></div></div>`);
            
            reader.onload = function(e){
                let btn_wrapper = $('<div class="btn_wrapper"><a class="btn_edit">編集</a><a class="btn_delete">削除</a></div>');
                // 画像に削除・編集ボタン付与
                img.append(btn_wrapper);
                // src取りたいのでattr
                img.find("img").attr({
                    src: e.target.result
                });
            };
            // FileReaderに使うオブジェクト。fileオブジェクトを読み込んでresultにdataをキーとするURL文字列が格納される
            reader.readAsDataURL(file);
            // ビュー用に格納
            temporary_images.push(img)
            // DBに送るための配列（ajaxでjs定義の配列を送れるかどうか謎）
            new_images.push(img)
            // 条件分岐, dropzone可変に使用
            images.push(img);

            // 画像が４枚以下の場合の処理
            if (images.length <= 4){
                // eachでそれぞれ追加する画像を処理
                $.each(temporary_images, function(index, image){
                    preview.append(image);
                })
                // dropエリアの大きさを可変
                new_dropzone.css({
                    "width": `calc(100% - (20% * ${images.length}))`
                });
            // 画像が５枚の場合、１段目のdropエリアを削除して、２段目を出させる
            } else if (images.length == 5){
                $.each(temporary_images, function(index, image){
                    preview.append(image);
                });
                // 2段目のdropエリア
                appendzone.css({
                    "display": "block"
                });
                // 1段目のdropエリアを削除
                new_dropzone.css({
                    "display": "none"
                });
            // 画像が６枚以上の場合
            } // else if (images.length >= 6){
            //     // 配列から０〜４枚目を抜き取って５枚目から抽出
            //     let pickup_images = images.slice(5);
            //     $.each(pickup_images, function(index, image){
            //         // indexは何枚目かの番号を数えてる
            //         image.data("image", index + 5);
            //         preview2.append(image);
            //         dropzone2.css({
            //             "width": `calc(100% - (20% * ${images.length - 5}))`
            //         });
            //     });
            //     // 画像が１０枚になったら２段目のdropエリアを削除
            //     if (images.length == 10) {
            //         dropzone2.css({
            //             "display": "none"
            //         });
            //     }
            // }
            // 複数画像を投稿するためにinputタグを複数設置  // #FIXME ２段目は分岐させて２段目だけにlabelをつけるようにさせる（IDとかでつける）
            let new_image = $(
                `<input id="product_product_images_attributes_${images.length}_image" class="selling__main__sec__content__form__write__upload__box__items__input-area__field" data-image="${images.length}" type="file" name="product[product_images_attributes][${images.length}][image]">`
            );
            input_area.append(new_image);
            $(`label.selling__main__sec__content__form__write__upload__box__items__input-area`).attr("for", `product_product_images_attributes_${images.length}_image`)
        });
        // 削除ボタン
        $(".selling__main__sec__content__form__write__upload__box, .selling__main__sec__content__form__write__upload__box2").on("click", ".btn_delete", function(){
            // 削除ボタンを押した画像を取得する
            let target_image = $(this).parent().parent();
            //削除画像のカスタムデータ属性data-image番号を取得
            let target_image_num =target_image.data("image");
            // 対象画像をビュー上で削除する処理
            target_image.remove();

            // 対象画像を削除したあとの新たな配列を生成(start番号, 個数)
            images.splice(target_image_num, 1);

            if (images.length == 0){
                $('input[type="file"].selling__main__sec__content__form__write__upload__box__items__input-area__field').attr({
                    "data-image": 0
                })
            }
            // 削除した後の中身の数でCSSの処理を分岐
            // 画像が４枚以下の場合
            if (images.length <= 4){
                $.each(images, function(index, image){
                    image.data("image", index);
                    preview.append(image);
                })
                new_dropzone.css({
                    "width": `calc(100% - (20% * ${images.length}))`,
                    "display": "block"
                })
                appendzone.css({
                    "display": "none"
                })
            // 画像が５枚の場合は１段目のdropエリアを消して２段目のdropエリアを出す
            } else if (images.length == 5){
                $.each(images, function(index, image){
                    image.data("image", index);
                    preview.append(image);
                })
                appendzone.css({
                    "display": "block"
                })
                dropzone2.css({
                    "width": "100%"
                })
                new_dropzone.css({
                    "display": "none"
                })
            // 画像が６枚以上の場合
            } else {
                // １〜５枚目の画像を抽出する
                let pickup_images1 = images.slice(0, 5);
                $.each(pickup_images1, function(index, image){
                    image.data("image", index);
                    preview.append(image);
                })
                // ６枚目以降の画像を抽出する
                let pickup_images2 = images.slice(5);
                // ６枚目以降の画像を２段目に表示
                $.each(pickup_images2, function(index, image){
                    image.data("image", index + 5);
                    preview2.append(image);
                    dropzone2.css({
                        "display": "block",
                        "width": `calc(100% - (20% * ${images.length - 5}))`
                    })
                })
            }
        })
        // $(".selling__main__sec__content__form__write").on("submit", function(e){
            // 場合分け等してsubmitしたい為、通常のsubmitイベントを止める
            // e.preventDefault();
            // images以外のform情報をformDataに入れる。 get() = getElementById()
            // let formData = new FormData(this);

            // TODO Edit実装時にいるかどうか実装者が判断すること

            // 登録済み画像が残っていない場合は便宜的に０を入れる
            // if (registered_images_ids.length == 0){
            //     formData.append("registered_images_ids[ids][]", 0)
            // // 登録済み画像で、まだ残っているものがあればidをformDataに追加していく
            // } else {
            //     registered_images_ids.forEach(function(registered_image){
            //         formData.append("registered_images_ids[ids][]", registered_image)
            //     });
            // }
            // 新しく追加したimagesがない場合は便宜的に空の文字列を入れる
            // if (new_image_files.length == 0){
            //     formData.append("new_images[images][]", "")
            // // 新しく追加したimagesがある場合はformDataに追加する
            // } else {
            //     new_image_files.forEach(function(file){
            //         formData.append("new_images[images][]", file)
            //     });
            // }
            // ajax
            // $.ajax({
            //     url: "/products",
            //     type: "POST",
            //     data: formData,
            //     dataType: 'json',
            //     contentType: false,
            //     processData: false,
            // })
        // });
    });
};