$(function(){
  var $input = $("#product_price");
  var $output1 = $("#fee");
  var $output2 = $("#profit");
  $input.keyup("#product_price", function(event) {
    var value = $input.val();
    var fee = Math.floor(value * 0.1);
    $output1.html('¥' + fee)
    var profit = Math.floor(value * 0.9);
    $output2.text('¥' + profit);
  })
  if (window.location.href.match(/\/products\/\d+\/edit/)){
      var value = $input.val();
      var fee = Math.floor(value * 0.1);
      $output1.html('¥' + fee)
      var profit = Math.floor(value * 0.9);
      $output2.text('¥' + profit);

  }
})