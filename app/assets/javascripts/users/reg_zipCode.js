$(function(){
  if($('.address').length){

    function addZipcode(thisZipcode){
      if(thisZipcode.val()==thisZipcode.val().match(/\d{3}\-\d{4}/)){
        let zipcode=Number(thisZipcode.val().replace('-',''));
        $.get('/zipcode.csv',function(data){
          let zipArray=data.split('\n');
          let searchZip=new RegExp('^' + zipcode + ',');
          $.each(zipArray,function(i,val){
            if(val.match(searchZip)){
              addressData=val.split(',');
              $('#address_prefecture_id option').each(function(i,elm){
                if(elm.text==addressData[1]){
                  $(elm).prop('selected',true);
                  $('#address_prefecture_id').blur();
                }
              });
              $('#address_city').val(addressData[2]+addressData[3]);
              $('#address_city').blur();
            }
          });
        });
      }
    }




    $('#address_post_number').keyup(function(){
      addZipcode($(this));
    });

    $('#address_post_number').focusout(function(){
      addZipcode($(this));
    });

  }
});
