$(function(){

  $(".itemShow").on("mouseover click",".itembox__body--thumbnail div",
    function(){
      $(".itembox__body--slider__img").css("transform",`translateX(${-100 * $(this).data("index")}%)`);
    }
  );

});
