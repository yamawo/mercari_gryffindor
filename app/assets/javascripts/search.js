$(function() {
  $("#brand").on("input",(){
    var input = $("#brand").val();
    console.log(input)
    if (input.length !== 0){

      $.ajax({
        url: "/producs/search",
        data: { keyword: input },
        dataType: "json"
      })
      .done
    }
  })
})