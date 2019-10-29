$(document).on("turbolinks:load", function(){
  var $input = $("#product_price");
  var $fee = $("#fee");
  var $profit = $("#profit");
  $input.keyup("#product_price", function(event) {
    var value = $input.val();
    if(value >= 300){
      var fee = Math.floor(value * 0.1);
    $fee.html('¥' + fee)
    var profit = Math.floor(value * 0.9);
    $profit.text('¥' + profit);
    }else{
      $fee.text("−")
      $profit.text("−")
    }

  })
  if (window.location.href.match(/\/products\/\d+\/edit/)){
    var value = $input.val();
    if(value >= 300){
      var fee = Math.floor(value * 0.1);
    $fee.html('¥' + fee)
    var profit = Math.floor(value * 0.9);
    $profit.text('¥' + profit);
    }else{
      $fee.text("−")
      $profit.text("−")
    }

  }
})