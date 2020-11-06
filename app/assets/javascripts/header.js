$(function(){

  $(".parents").on("mouseover","li",function(e){
    e.stopPropagation();
  });

  $(".parents").on("mouseover","li>a",
    function(){
      if(!$(this).next("ul").length&&!$(this).parents(".grandchild").length){
        let parent_data= {parent_id:$(this).attr("id")};
        let family="child";
        if(!$(this).parent(".parent").length){
          family="grandchild";
        }
        $.ajax({
          type: "get",
          url: "/categories/ajax",
          data: parent_data,
          dataType: "json",
          context:this
        })
        .done(function(categories){
          let stg="";
          for(let category of categories){
            stg+=`<li><a id="${category.id}" href="/categories/${category.id}">${category.name}</a></li>`;
          }
          stg=`<ul class="${family}">${stg}</ul>`;
          $(this).parent().append(stg);
          $(this).next("ul").css("min-height",`${$(this).closest("ul").height()}px`);
        })
        .fail(function(){
          alert("カテゴリ送信に失敗しました");
        });
      }
    }
  );

  $(".mainNaviRight").on("click", function(){
    if($(this).hasClass("close")){
      $(this).removeClass("close");
    }else{
      let height=window.innerHeight;
      document.documentElement.style.setProperty( "--vh", height/100 + "px");
      $(this).addClass("close");
    }
  });

  $(".mainNaviLeft").on("click", function(){
    if($(this).children("span").hasClass("close")){
      $(this).children("span").removeClass("close");
    }else{
      let height=window.innerHeight;
      document.documentElement.style.setProperty( "--vh", height/100 + "px");
      $(this).children("span").addClass("close");
    }
  });

  $(".mainHeader__search").on("click",'input[type="submit"]',function(e){
    e.preventDefault();
    $(".mainHeader__result").empty();
    let data = {search:$('input[type="text"]').val()};
    if(data.search != ""){
      $.ajax({
        type: "get",
        url: "/search",
        data: data,
        dataType: "json",
      })
      .done(function(searches){
        if (searches.length>0){
          let result = ""
          for(let search of searches){
            result+=`<li><a href="/items/${search.id}">${search.name}</a></li>`;
          }
          $(".mainHeader__result").append(result);
        }else{
          result = "<li>該当する商品はありません</li>"
          $(".mainHeader__result").append(result);
        }
      })
      .fail(function(){
        alert("送信に失敗しました");
      });
    }
  });

  $(document).on("click",function(e){
    if(!$(e.target).parents(".mainHeader__result").length){
      $(".mainHeader__result").empty();
    }
  });

});
