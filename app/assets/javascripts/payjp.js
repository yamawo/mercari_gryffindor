$(document).on('turbolinks:load', function() {
  var form = $('#charge-form');
  Payjp.setPublicKey('pk_test_edd04a1c5235d9380aaef299');
  $(document).on("click", "submit-button", function(e) {
    
    e.preventDefault();
    form.find("input[type=submit]").prop("disabled", true);

    var credit = {
      number: $("#credit_number").val(),
      cvc: $("#cvc").val(),
      exp_month: $("#exp_month").val(),
      exp_year: $("exp_year").val()
    };
    Payjp.createToken(credit, function(status, response) {
      if (response.error) {
        alert('トークン作成エラー発生');
      }
      else {
        $("#credit_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
        var token = response.id;

        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        form.get(0).submit();
      }
    });
  });
});
