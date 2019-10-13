document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記のコードを読み込まない
      Payjp.setPublicKey("pk_test_edd04a1c5235d9380aaef299"); //公開鍵
      const btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得
      btn.addEventListener("click", (e) => { //ボタンが押された時に作動
        e.preventDefault(); //ボタンを一旦無効化する

        //クレジットカード情報を生成
        const card = {
          number: document.getElementById("user_credit_number").value,
          cvc: document.getElementById("user_cvc").value,
          exp_month: document.getElementById("user_exp_month").value,
          exp_year: document.getElementById("user_exp_year").value
        }; //入力されたデータを取得

        //トークンを生成
        Payjp.createToken(card, function(status, response) {
          if (status === 200) { //成功した場合
            $("#user_credit_number").removeAttr("name");
            $("#user_cvc").removeAttr("name");
            $("#user_exp_month").removeAttr("name");
            $("#user_exp_year").removeAttr("name"); //カード情報を自分のサーバーにpostせずに削除
            $("#user_token_submit").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            ); //トークンを送信できるように隠しタグを生成
            document.inputForm.submit();
            alert("登録が完了しました"); //確認用
          } else {
            alert("カード情報が正しくありません"); //確認用
          }
        });
      });
    }
  },
  false
);
