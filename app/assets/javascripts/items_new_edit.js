$(function(){

  let displayTime=300;
  let click_place;

  function upload_box_width(){
    let box_class=".item__image--upload>.item__image--uploadBox";
    let box_length=$(box_class).length;
    if(box_length<6){
      $(`${box_class}:nth-of-type(-n+5)`).css("width",`${100/(box_length)}%`);
    }else if(box_length<11){
      $(`${box_class}:nth-of-type(-n+5)`).css("width","20%");
      $(`${box_class}:nth-of-type(n+6)`).css("width",`${100/(box_length-5)}%`);
    }else{
      $(`${box_class}`).css("width","20%");
    }
  }

  function add_after_box(current_box,image_number){
    after_box=current_box.clone();
    after_box.find("label").attr("for",`item_images_attributes_${image_number}_image`);
    after_box.find("input").attr({
      "data-index":`${image_number}`,
      id:`item_images_attributes_${image_number}_image`,
      name:`item[images_attributes][${image_number}][image]`,
      required:false
    });
    after_box.find("input")[0].value="";
    current_box.parent().append(after_box);
  }

  function disappear_box(){
    $.each($('[name^="item[images_attributes]"][name$="[_destroy]"]:checked'),function(){
      $(this).parent().wrap('<span class="item__image--uploadBox_none"></span>');
    });
  }





  disappear_box();

  upload_box_width();

  $(".itemNew,.itemEdit").on("click",".item__image--uploadBox *",
    function(e){
      e.stopPropagation();
    }
  );

  $(".itemNew,.itemEdit").on("click",".item__image--uploadBox label,.item__image--uploadBox span",
    function(){
      click_place=$(this).attr("class");
      if(click_place=="item_image--change"){
        $(this).siblings("label").find("input").trigger("click");
      }else if(click_place=="item_image--delete"){
        if($(this).siblings('[id$="__destroy"]').length){
          $(this).parent().wrap('<span class="item__image--uploadBox_none"></span>');
          $(this).siblings('[type="checkbox"]').prop("checked",true);
        }else{
          $(this).closest(".item__image--uploadBox").remove();
        }
        if($(".item__image--upload>.item__image--uploadBox").length==1){
          $(".item__image--upload>.item__image--uploadBox").find('input[type="file"]').attr("required",true);
        }
        upload_box_width();
      }
    }
  );

  $(".itemNew,.itemEdit").on("change",'[id^="item_images_attributes"][id$="_image"]',
    function(){
      let datas = this.files;
      let image_number=$(this).data("index");
      let box_length=$(".item__image--upload>.item__image--uploadBox").length;
      let delete_box_num=0
      let data_max;
      if(datas.length+box_length<12){
        data_max=datas.length;
      }else if(click_place=="item_image--change"){
        data_max=1
      }else{
        data_max=11-box_length;
      }
      for(i=0;i<data_max;i++){
        let parent_label;
        let file = new DataTransfer();
        let reader = new FileReader();
        file.items.add(datas[i]);
        if(click_place=="click_label"){
          if($(".item__image--uploadBox_none").length){
            parent_label = $(`label[for="${$(".item__image--uploadBox_none:first label").attr("for")}"]`);
            $(".item__image--uploadBox_none:first>div").unwrap();
            parent_label.find('[id^="item_images_attributes_"][id$="_image"]')[0].files=file.files;
            parent_label.siblings('[type="checkbox"]').prop("checked",false);
            $(`#item_images_attributes_${image_number+i}_image`).removeAttr("required");
            delete_box_num+=1;
          }else{
            parent_label=$(`label[for="item_images_attributes_${image_number+i-delete_box_num}_image"]`);
            add_after_box(parent_label.closest(".item__image--uploadBox"),image_number+i+1-delete_box_num);
            $(`#item_images_attributes_${image_number+i-delete_box_num}_image`).removeAttr("multiple required");
            $(`#item_images_attributes_${image_number+i-delete_box_num}_image`)[0].files=file.files;
          }
          upload_box_width();
        }else if(click_place=="item_image--change"){
          parent_label=$(`label[for="item_images_attributes_${image_number+i}_image"]`);
          $(this).closest(".click_label").siblings('input[id$="_cache"]').remove();
          $(`#item_images_attributes_${image_number+i}_image`)[0].files=file.files;
        }
        reader.readAsDataURL(file.files[0]);
        reader.onload = function(){
          let img_src = $("<img>").attr("src",reader.result);
          parent_label.children("img").remove();
          parent_label.prepend(img_src);
        }
      }
      $('[id^="item_images_attributes"][id$="_image"]').last().val("");
    }
  );

  $(".itemNew,.itemEdit").on("dragover",".item__image--uploadBox label",
    function(e){
      e.preventDefault();
    }
  );

  $(".itemNew,.itemEdit").on("drop",".item__image--uploadBox label",
    function(e){
      e.preventDefault();
      let datas=e.originalEvent.dataTransfer.files;
      let image_number=$(this).children("input").data("index");
      let box_length=$(".item__image--upload>.item__image--uploadBox").length;
      let delete_box_num=0
      let data_max;
      if(datas.length+box_length<12){
        data_max=datas.length;
      }else if(click_place=="item_image--change"){
        data_max=1
      }else{
        data_max=11-box_length;
      }
      for(i=0;i<data_max;i++){
        let parent_label;
        let file = new DataTransfer();
        let reader = new FileReader();
        file.items.add(datas[i]);
        if($(".item__image--uploadBox_none").length){
          parent_label = $(`label[for="${$(".item__image--uploadBox_none:first label").attr("for")}"]`);
          $(".item__image--uploadBox_none:first>div").unwrap();
          parent_label.find('[id^="item_images_attributes_"][id$="_image"]')[0].files=file.files;
          parent_label.siblings('[type="checkbox"]').prop("checked",false);
          $(`#item_images_attributes_${image_number+i}_image`).removeAttr("required");
          delete_box_num+=1;
        }else{
          parent_label=$(`label[for="item_images_attributes_${image_number+i-delete_box_num}_image"]`);
          add_after_box(parent_label.closest(".item__image--uploadBox"),image_number+i+1-delete_box_num);
          $(`#item_images_attributes_${image_number+i-delete_box_num}_image`).removeAttr("multiple required");
          $(`#item_images_attributes_${image_number+i-delete_box_num}_image`)[0].files=file.files;
        }
        upload_box_width();
        reader.readAsDataURL(file.files[0]);
        reader.onload = function(){
          let img_src = $("<img>").attr("src",reader.result);
          parent_label.children("img").remove();
          parent_label.prepend(img_src);
        }
      }
      $('[id^="item_images_attributes"][id$="_image"]').last().val("");
    }
  );



  $(".itemNew,.itemEdit").on("change",'select[id^="item_category"]',
    function(){
      if($(this).val()&&$(this).attr("id")!="item_category"){
        let data=$(this).val();
        let child_category="item_category_parent";
        if($(this).attr("id")=="item_category_parent"){
          child_category=$(this).attr("id").replace("_parent","");
        }
        $.ajax({
          type: "get",
          url: "/categories/ajax",
          data: {parent_id:`${data}`},
          dataType: "json",
          context: this
        })
        .done(function(categories){
          $(this).nextAll().each(function(){$(this).addClass("cateclose")});
          setTimeout($.proxy(function(){$(this).nextAll().remove();},this),displayTime);
          let stg='<option value="">選択してください</option>';
          if(categories.length>0){
            for(let category of categories){
              stg+=`<option value="${category.id}">${category.name}</option>`;
            }
            stg=`<select id=${child_category} class="item__detail_category--select" required="required" name="item[category_id]">${stg}</select>`;
            setTimeout($.proxy(function(){$(this).after(stg);},this),displayTime);
          }
        })
        .fail(function(){
          alert("カテゴリの送信に失敗しました");
        });
      }else{
        $(this).nextAll().each(function(){$(this).addClass("cateclose")});
        setTimeout($.proxy(function(){$(this).nextAll().remove();},this),displayTime);
      }
    }
  );



  $(".itemNew,.itemEdit").on("keyup","#item_description",
    function(){
      let denominator=$(".item__detail_textarea--count").text().match(/\/.+/);
      $(".item__detail_textarea--count").text(`${$(this).val().length}${denominator}`);
    }
  );



  $(".itemNew,.itemEdit").on("keyup","#item_price",
    function(){
      formatter = new Intl.NumberFormat();
      $(".item__price--price>span").text(formatter.format($(this).val()));
      $(".item__price--tax>span").text(formatter.format(Math.round($(this).val()*0.1)));
      $(".item__price--profit>span").text(formatter.format($(this).val()-Math.round($(this).val()*0.1)));
    }
  );

});
