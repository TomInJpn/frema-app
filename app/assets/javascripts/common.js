$(function(){

  $('.parents').on('mouseover','li',
    function(e){
      e.stopPropagation();
    }
  )

  $('.parents').on('mouseover','li>a',
    function(){
      if(!$(this).next('ul').length&&!$(this).parents('.grandchild').length){
        let sendData= {parent_id:$(this).attr('id')};
        let family='child';
        if(!$(this).parent('.parent').length){
          family='grandchild';
        }
        $.ajax({
          type: 'get',
          url: '/categories/ajax',
          data: sendData,
          dataType: 'json',
          context:this
        })
        .done(function(categories){
          let stg="";
          for(let category of categories){
            stg+=`<li><a id="${category.id}" href="/categories/${category.id}">${category.name}</a></li>`;
          }
          stg=`<ul class="${family}">${stg}</ul>`;
          $(this).parent().append(stg);
          $(this).next("ul").css('min-height',`${$(this).closest('ul').height()}px`);
        })
        .fail(function(){
          alert('カテゴリ送信に失敗しました');
        });
      }
    }
  );

  $('.mainNaviRight').on('click', function(){
    if($(this).hasClass('close')){
      $(this).removeClass('close');
    }else{
      let height=window.innerHeight;
      document.documentElement.style.setProperty( '--vh', height/100 + 'px');
      $(this).addClass('close');
    }
  });

  $('.mainNaviLeft').on('click', function(){
    if($(this).children('span').hasClass('close')){
      $(this).children('span').removeClass('close');
    }else{
      let height=window.innerHeight;
      document.documentElement.style.setProperty( '--vh', height/100 + 'px');
      $(this).children('span').addClass('close');
    }
  });

});
