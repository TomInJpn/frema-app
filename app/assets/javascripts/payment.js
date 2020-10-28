$(function(){

  let total = Number($(".paymentAmount--price").text().replace(/,/, ''));
  let itemPrice = Number($(".paymentDetailDescription--price span:last").text().replace(/,/, ''));
  let postage = total - itemPrice

  $(".payment").on("keyup change","#quantity",
    function(){
      formatter = new Intl.NumberFormat();
      $(".paymentAmount--price").text(formatter.format(itemPrice * $("#quantity").val() + postage));
    }
  );

});
