$(window).on("turbolinks:load", function(){
    let dropzone = $(".selling__main__sec__content__form__write__upload__box__items");
    let dropzone2 = $(".selling__main__sec__content__form__write__upload__box2__items2");
    let appendzone = $(".selling__main__sec__content__form__write__upload__box2");
    let input_area = $(".selling__main__sec__content__form__write__upload__box__items__input-area");
    let preview = $("#preview");
    let preview2 = $("#preview2");

    // 登録済み画像と新規追加画像を全て格納する配列（ビュー表示用）、削除編集で使用する
    let images = [];
    // 登録済み画像データのみが格納される配列（DB送る用）
    let registered_images_ids = [];
    // 新規追加画像データのみが格納される配列（DB送る用）
    let new_image_files = [];

    // TODO すでに登録されている画像を表示する処理追記する


    // 新規画像投稿の場合の処理
    $(".selling__main__sec__content__form__write__upload__box, .selling__main__sec__content__form__write__upload__box2").on("change", 'input[type="file"].selling__main__sec__content__form__write__upload__box__items__input-area__field', function(){
        // dropされたファイルデータをpropで取って変数fileに入れ込む
        let file = $(this).prop("files")[0];
        // 配列に格納
        new_image_files.push(file)
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
        images.push(img);

        // 画像が４枚以下の場合の処理
        if (images.length <= 4){
            // 一度空にする
            $("#preview").empty();
            // eachでそれぞれ追加する画像を処理
            $.each(images, function(index, image){
                // カスタムデータ属性を付与する
                image.data("image", index);
                preview.append(image);
            })
            // dropエリアの大きさを可変
            dropzone.css({
                "width": `calc(100% - (20% * ${images.length}))`
            })
        // 画像が５枚の場合、１段目のdropエリアを削除して、２段目を出させる
        } else if (images.length == 5){
            // ４枚以下の時と同じ
            $("preview").empty();
            $.each(images, function(index, image){
                image.data("image", index);
                preview.append(image);
            });
            // 2段目のdropエリア
            appendzone.css({
                "display": "block"
            });
            // 1段目のdropエリアを削除
            dropzone.css({
                "display": "none"
            });
            // 画像は５枚なので２段目の画像は何もない状態を確認
            preview2.empty();
        // 画像が６枚以上の場合
        } else if (images.length >= 6){
            // 配列から０〜４枚目を抜き取って５枚目から抽出
            let pickup_images = images.slice(5);
            $.each(pickup_images, function(index, image){
                // indexは何枚目かの番号を数えてる
                image.data("image", index + 5);
                preview2.append(image);
                dropzone2.css({
                    "width": `calc(100% - (20% * ${images.length - 5}))`
                });
            });
            // 画像が１０枚になったら２段目のdropエリアを削除
            if (images.length == 10) {
                dropzone2.css({
                    "display": "none"
                });
            }
        }
        // 複数画像を投稿するためにinputタグを複数設置
        let new_image = $(
            `<input multiple="multiple" name="product_images[image][]" class="selling__main__sec__content__form__write__upload__box__items__input-area__field" data-image=${images.length} type="file" id="selling__main__sec__content__form__write__upload__box__items__input-area__field">`
        );
        input_area.append(new_image);
    });
    // 削除ボタン
    $(".selling__main__sec__content__form__write__upload__box, .selling__main__sec__content__form__write__upload__box2").on("click", ".btn_delete", function(){
        // 削除ボタンを押した画像を取得する
        let target_image = $(this).parent().parent(); // #FIX_ME 削除できないときはここの要素で取得する階層間違ってるかも
        //削除画像のカスタムデータ属性data-image番号を取得
        let target_image_num =target_image.data("image");
        // 対象画像をビュー上で削除する処理
        target_image.remove();

        // 対象画像を削除したあとの新たな配列を生成(start番号, 個数)
        images.splice(target_image_num, 1);

        // target_image_numが登録済み画像の数以下の場合は登録済み画像データの配列から削除させる。それよりも大きい値の場合は新規登録画像データの配列から削除させる
        if (target_image_num < registered_images_ids.length){
            registered_images_ids.splice(target_image_num, 1);
        } else {
            // 登録済み画像の数を引いた値 = 新規登録画像データの配列のみ になるのでそこから値を指定して削除
            new_image_files.splice((target_image_num - registered_images_ids.length), 1);
        }

        if (images.length == 0){
            $('input[type="file"].selling__main__sec__content__form__write__upload__box__items__input-area__field').attr({
                "data-image": 0
            })
        }
        // 削除した後の中身の数でCSSの処理を分岐
        // 画像が４枚以下の場合
        if (images.length <= 4){
            $("#preview"),empty();
            $.each(images, function(index, image){
                image.data("image", index);
                preview.append(image);
            })
            dropzone.css({
                "width": `calc(100% - (20% * ${images.length}))`,
                "display": "block"
            })
            appendzone.css({
                "display": "none"
            })
        // 画像が５枚の場合は１段目のdropエリアを消して２段目のdropエリアを出す
        } else if (images.length == 5){
            $("#preview").empty();
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
            dropzone.css({
                "display": "none"
            })
            preview2.empty();
        // 画像が６枚以上の場合
        } else {
            // １〜５枚目の画像を抽出する
            let pickup_images1 = images.slice(0, 5);
            // １〜５枚目を１段目に表示させる
            $("#preview").empty();
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
    $(".selling__main__sec__content__form__write__upload__box__items__input-area__field").on("submit", function(e){
        // 場合分け等してsubmitしたい為、通常のsubmitイベントを止める
        e.preventDefault();
        // images以外のform情報をformDataに入れる。 get() = getElementById()
        let formData = new FormData($(this).get(0));
        // 登録済み画像が残っていない場合は便宜的に０を入れる
        if (registered_images_ids.length == 0){
            formData.append("registered_images_ids[ids][]", 0)
        // 登録済み画像で、まだ残っているものがあればidをformDataに追加していく
        } else {
            registered_images_ids.forEach(function(registered_image){
                formData.append("registered_images_ids[ids][]", registered_image)
            });
        }
        // 新しく追加したimagesがない場合は便宜的に空の文字列を入れる
        if (new_image_files.length == 0){
            formData.append("new_images[images][]", "")
        // 新しく追加したimagesがある場合はformDataに追加する
        } else {
            new_image_files.forEach(function(file){
                formData.append("new_images[images][]", file)
            });
        }
        // ajax
        $.ajax({
            url: "/products",
            type: "POST",
            data: formData,
            contentType: false,
            processData: false,
        })
    });
});