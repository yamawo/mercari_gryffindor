$(function() {
  $("brand").change(function(){
    var input = $("#brand").val();
    if (input.length !== 0){
      $.ajax({
        url: "/producs/search",
        data: { keyword: input },
        dataType: "json"
      })
    }
  })
})