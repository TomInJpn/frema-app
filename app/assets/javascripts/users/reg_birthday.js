$(function(){
  if($('.registration').length){

    let now = new Date();
    let thisYear=now.getFullYear();

    function firstOption(ymd){$(ymd).append($('<option>').attr({value:''}).text('--'));}
    function daysInMonth(year,month,day,dayValue){
      if(year!=''&&month!=''){
        $('#day').empty();
        days=new Date(year,month,0).getDate();
        for(let i=0;i<days+1;i++){
          if(i==0){
            firstOption('#day');
          }else{
            $('#day').append($('<option>').attr({value:('00'+i).slice(-2)}).text(i));
          }
        }
        if($('#day')[0].length-1>=Number(day)){
          $('#day').val(day);
          firstOptionDisabled($($('#day')[0].firstChild));
          return day
        }else{
          $('#day').val('');
          if(dayValue!=''){
            $('#day').addClass('errBorder');
            $('#user_birthday').after('<div class="errMessage">生年月日を入力してください</div>');
            $('#day').parents().children('.errMessage').addClass('errHeight');
          }
          return day=''
        }
      }else{
        return day
      }
    }
    function firstOptionDisabled(ymd){ymd.prop('disabled',true);}
    function birthdayValue(year,month,day){$('#user_birthday').val(year+month+day);}





    for(let i=thisYear;i>=thisYear-100;i--){
      if(i===thisYear){
        firstOption('#year');
      }else{
        $('#year').append($('<option>').attr({value:i+1}).text(i+1));
      }
    }
    for(let i=0;i<13;i++){
      if(i===0){
        firstOption('#month');
      }else{
        $('#month').append($('<option>').attr({value:('00'+i).slice(-2)}).text(i));
      }
    }
    firstOption('#day');





    let dayValue;

    $("#year,#month").focusin(function(){
      dayValue=$('#day').val();
    });

    $('#year').change(function(){
      let year=$(this).val();
      let month=$('#month').val();
      let day=$('#day').val();
      day=daysInMonth(year,month,day,dayValue);
      firstOptionDisabled($(this.firstChild));
      birthdayValue(year,month,day);
    });

    $('#month').change(function(){
      let year=$('#year').val();
      let month=$(this).val();
      let day=$('#day').val();
      day=daysInMonth(year,month,day,dayValue);
      firstOptionDisabled($(this.firstChild));
      birthdayValue(year,month,day);
    });

    $('#day').change(function(){
      let year=$('#year').val();
      let month=$('#month').val();
      let day=$(this).val();
      firstOptionDisabled($(this.firstChild));
      birthdayValue(year,month,day);
    });

  }
});
