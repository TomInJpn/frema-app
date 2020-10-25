$(function(){

  $(".itemShow").on("mouseover click",".itembox__body--thumbnail div",
    function(){
      $(".itembox__body--slider img").css("transform",`translateX(${-100 * $(this).data("index")}%)`);
    }
  );

});
