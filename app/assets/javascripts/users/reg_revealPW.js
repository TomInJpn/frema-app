$(function(){
  if($('.registration').length){

    function revealPassword(){
      if(reveal_password.checked){
        $('.revealedPassword').removeClass('revealedPassword__close');
        $('.revealedPassword').addClass('revealedPassword__open');
        $('.revealedPassword').text($('#user_password').val());
      }else if($('.revealedPassword').hasClass('revealedPassword__open')){
        $('.revealedPassword').removeClass('revealedPassword__open');
        $('.revealedPassword').addClass('revealedPassword__close');
      }
    }

    $('#reveal_password').change(function(){
      revealPassword();
    });

    $('#user_password').keyup(function(){
      revealPassword();
    });

  }
});
