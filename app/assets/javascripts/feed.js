$( document ).ready(function() {

  $(".filters").hide();

  $(".show_filters").click(function(){
    $(".filters").toggle();
    $(this).text(function(i, text){
      return text === "Show Filters" ? "Hide Filters" : "Show Filters";
    })
  });

});