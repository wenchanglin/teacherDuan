$(function(){
    $('.p-detail h2 a ').click(function(){
        $(this).addClass('checked').siblings().removeClass('checked');
        $('.d-list>div:eq('+$(this).index()+')').show().siblings().hide();
    })

})//商品详情切换

// 购买 ---------------------------------------------------

 $("#sho2").click(function(){
     $("#tccl").children().remove();
     var id = getQueryString("id");
     var title ="";
     var html ="";
     // 购物属性框
     $.ajax({
             type: "POST",
             url: commonURL+"/skl/good/queryGoodInfoById",
             data: {storeGoodBaseId:id},
             dataType: 'json',
              beforeSend:function(data){
                $("#loaded").css("display","block");
            },
             success: function (data) {
                 var name=data.data.name;
                 var num=data.data.sortSellCount
                 var arry =data.data.storeGoodBaseAttrs;
                 var picz=data.data.photoCarouselList
            // 判断图片是否为null
            if (picz != "" && picz.length != 0) {
            html +="<div class='s-intro'>" +
            "<img src='"+commonURL+"/skl"+picz[0].location+"'>" +
            "<div class='shulian'>" +
            "<h4><span style='color:#333' id='mcheng'>"+name+"</span>&nbsp;&nbsp;￥<em id='pri'>0.00</em></h4>" +
            "<p><span>库存：<em class='kucun'>0</em>件</span><span>总销量："+num+"笔</span></p>" +
            "<p>请选择&nbsp;颜色分类&nbsp;商品尺码</p>" +
            "<input type='hidden' value='"+data.data.fkStoreId+"' id='stoId'>"+
            "</div>" +
            "</div>";
            $.each(arry,function(index,item){
                   var cd =item.attrValues;
                   var aa=cd.split("|");
                   var j=aa.length;
                   var li="";
                   for (var i = 0; i < j; i++) {
                   li+="<li>" + aa[i] +"</li>"
                   }
                   title=item.attrName
                   html +="<div class='fenlei'>" +
                   "<h2>" + title + "</h2>" +
                   "<ul class='fenl'>" + li + "</ul>" +
                   "</div>"
                   })
            html +="<div class='num'>" +
            "商品数量" +
            "<div class='shil'>" +
            "<div class='addnum'><span class='reduce'>-</span><input type='text' value='1' class='text_box' /><span class='add'>+</span></div>" +
            "</div>" +
            "</div>" +
            "</div>" +
            "<div class='sure'><a id='buys'><em id='detailId' style='display:none'></em>确定</a></div>";
            $("#tccl").append(html);
}else{
            html +="<div class='s-intro'>" +
            "<img src='images/null.png'>" +
            "<div class='shulian'>" +
            "<h4><span style='color:#333' id='mcheng'>"+name+"</span>&nbsp;&nbsp;￥<em id='pri'>0.00</em></h4>" +
            "<p><span>库存：<em class='kucun'>0</em>件</span><span>总销量："+num+"笔</span></p>" +
            "<p>请选择&nbsp;颜色分类&nbsp;商品尺码</p>" +
            "<input type='hidden' value='"+data.data.fkStoreId+"' id='stoId'>"+
            "</div>" +
            "</div>";
            $.each(arry,function(index,item){
                   var cd =item.attrValues;
                   var aa=cd.split("|");
                   var j=aa.length;
                   var li="";
                   for (var i = 0; i < j; i++) {
                   li+="<li>" + aa[i] +"</li>"
                   }
                   title=item.attrName
                   html +="<div class='fenlei'>" +
                   "<h2>" + title + "</h2>" +
                   "<ul class='fenl'>" + li + "</ul>" +
                   "</div>"
                   })
            html +="<div class='num'>" +
            "商品数量" +
            "<div class='shil'>" +
            "<div class='addnum'><span class='reduce'>-</span><input type='text' value='1' class='text_box' /><span class='add'>+</span></div>" +
            "</div>" +
            "</div>" +
            "</div>" +
            "<div class='sure'><a id='buys'><em id='detailId' style='display:none'></em>确定</a></div>";
            $("#tccl").append(html);
            }
            
            $('.fenlei:eq(0) li:eq(0),.fenlei:eq(1) li:eq(0)').addClass("current");
             // 默认选择的价格，库存
             $.ajax({
                 type: "POST",
                  url: commonURL+"/skl/good/queryStoreGoodDetails",
                  data: {storeGoodBaseId:id},
                  dataType: 'json',
                  success: function (data) {
                     var ln=data.data.iData
                     console.log(ln)
                     var fenlei=$(".fenlei")
                     var attrvalue="";
                      for(var z=0;z<fenlei.length;z++){
                         var aba=fenlei[z].firstChild.innerHTML
                         bab=fenlei[z].lastChild.childNodes
                         var cbc="";
                         for(var d=0;d<bab.length;d++){
                             if (bab[d].className== "current") {
                                 cbc=bab[d].innerHTML
                                 attrvalue+=aba+":"+cbc+","
                                 var ccd=attrvalue.substring(0,attrvalue.length-1)
                                 attrddd="{"+ ccd +"}"
                                 console.log(attrddd)
                             }
                         }

                      }
                         for(var i=0;i<ln.length;i++){
                         if (ln[i].attrsValue==attrddd) {
                             $("#deId").html(ln[i].id)
                             $("#mm").val(ln[i].id)
                             $("#pri").html(ln[i].price)
                             $(".kucun").html(ln[i].stock)
                             //return false;
                         }
                     }
                  }
             })
             // 确定------------------------------
             
             $("#buys").live("click",function(){
                $.ajax({
                    type: "POST",
                     url: commonURL+"/skl/good/queryStoreGoodDetails",
                     data: {storeGoodBaseId:id},
                     dataType: 'json',
                     success: function (data) {
                        var ln=data.data.iData
                        console.log(ln)
                         var fenlei=$(".fenlei")
                         var attrvalue="";
                          for(var z=0;z<fenlei.length;z++){
                             var aba=fenlei[z].firstChild.innerHTML
                             bab=fenlei[z].lastChild.childNodes
                             var cbc="";
                             for(var d=0;d<bab.length;d++){
                                 if (bab[d].className== "current") {
                                     cbc=bab[d].innerHTML
                                     attrvalue+=aba+":"+cbc+","
                                     var ccd=attrvalue.substring(0,attrvalue.length-1)
                                     attrddd="{"+ ccd +"}"
                                     console.log(attrddd)
                                 }
                             }

                          }
                            for(var i=0;i<ln.length;i++){
                            if (ln[i].attrsValue==attrddd) {
                                console.log(ln[i].id)
                                $("#deId").html(ln[i].id)
                                $("#mm").val(ln[i].id)
                                var num = $(".text_box").val();
                                window.location.href="order.html?daty="+ln[i].id+"/"+num
                            }
                        }
                     }
                })
             })
             },
             complete:function(data){
                $("#loaded").hide();
            },
         });

     $('.property').css( "display","block");
     $('#bg').css( "display","block");
     // 关闭弹窗
     
     $('.close ').click(function(){
     $('.property').css( "display","none");
     $('#bg').css( "display","none");
     })
    
     
     // 选择颜色---
 })


 // 商品数量加减---------
 $(".add").live("click",function(){
     var t=$(this).parent().find('.text_box');
     t.val(parseInt(t.val())+ 0);
     var kc=parseInt( $(".kucun").text());
     if(parseInt(t.val())> kc){
         t.val(kc);
         alert("购买数量不能大于库存");
     }
 })
 $(".reduce").live("click",function(){
     var t=$(this).parent().find('.text_box');
     t.val(parseInt(t.val())- 0);
     if(parseInt(t.val())<1){
         t.val(1);
         alert("购买数量必须大于或等于1");
     }
 })
 // 加入购物车 ----------------------------------------------------------------------

 $("#sho").click(function(){
     $("#tccl").children().remove();
     var id = getQueryString("id");
     var title ="";
     var html ="";
     var pp=""
     // 属性框
     $.ajax({
             type: "POST",
             url: commonURL+"/skl/good/queryGoodInfoById",
             data: {storeGoodBaseId:id},
             dataType: 'json',
             success: function (data) {
                console.log(data)
                var name=data.data.name
                var num=data.data.sortSellCount
                 var arry =data.data.storeGoodBaseAttrs;
                 var picz=data.data.photoCarouselList
            if (picz != "" && picz.length != 0) {
            html +="<div class='s-intro'>" +
            "<img src='"+commonURL+"/skl"+picz[0].location+"'>" +
            "<div class='shulian'>" +
            "<h4><span style='color:#333' id='mcheng'>"+name+"</span>&nbsp;&nbsp;￥<em id='pri'>0.00</em></h4>" +
            "<p><span>库存：<em class='kucun'>0</em>件</span><span>总销量："+num+"笔</span></p>" +
            "<p>请选择&nbsp;颜色分类&nbsp;商品尺码</p>" +
            "<input type='hidden' value='"+data.data.fkStoreId+"' id='stoId'>"+
            "</div>" +
            "</div>";
            $.each(arry,function(index,item){
                   var cd =item.attrValues;
                   var aa=cd.split("|");
                   var j=aa.length;
                   var li="";
                   for (var i = 0; i < j; i++) {
                   li+="<li>" + aa[i] +"</li>"
                   }
                   title=item.attrName
                   html +="<div class='fenlei'>" +
                   "<h2>" + title + "</h2>" +
                   "<ul class='fenl'>" + li + "</ul>" +
                   "</div>"
                   })
            html +="<div class='num'>" +
            "商品数量" +
            "<div class='shil'>" +
            "<div class='addnum'><span class='reduce'>-</span><input type='text' value='1' class='text_box' id='numm1'/><span class='add'>+</span></div>" +
            "</div>" +
            "</div>" +
            "</div>" +
            "<div class='sure'><a id='shopcar'>确定</a></div>";
            $("#tccl").append(html);
            
            }else{
            html +="<div class='s-intro'>" +
            "<img src='images/null.png'>" +
            "<div class='shulian'>" +
            "<h4><span style='color:#333' id='mcheng'>"+name+"</span>&nbsp;&nbsp;￥<em id='pri'>0.00</em></h4>" +
            "<p><span>库存：<em class='kucun'>0</em>件</span><span>总销量："+num+"笔</span></p>" +
            "<p>请选择&nbsp;颜色分类&nbsp;商品尺码</p>" +
            "<input type='hidden' value='"+data.data.fkStoreId+"' id='stoId'>"+
            "</div>" +
            "</div>";
            $.each(arry,function(index,item){
                   var cd =item.attrValues;
                   var aa=cd.split("|");
                   var j=aa.length;
                   var li="";
                   for (var i = 0; i < j; i++) {
                   li+="<li>" + aa[i] +"</li>"
                   }
                   title=item.attrName
                   html +="<div class='fenlei'>" +
                   "<h2>" + title + "</h2>" +
                   "<ul class='fenl'>" + li + "</ul>" +
                   "</div>"
                   })
            html +="<div class='num'>" +
            "商品数量" +
            "<div class='shil'>" +
            "<div class='addnum'><span class='reduce'>-</span><input type='text' value='1' class='text_box' id='numm1'/><span class='add'>+</span></div>" +
            "</div>" +
            "</div>" +
            "</div>" +
            "<div class='sure'><a id='shopcar'>确定</a></div>";
            $("#tccl").append(html);
            
            }
            // 默认第一个属性选中
             $('.fenlei:eq(0) li:eq(0),.fenlei:eq(1) li:eq(0)').addClass("current")
             // 默认选择的价格，库存
             $.ajax({
                 type: "POST",
                  url: commonURL+"/skl/good/queryStoreGoodDetails",
                  data: {storeGoodBaseId:id},
                  dataType: 'json',
                  success: function (data) {
                     var ln=data.data.iData
                     var fenlei=$(".fenlei")
                      var attrvalue="";
                       for(var z=0;z<fenlei.length;z++){
                          var aba=fenlei[z].firstChild.innerHTML
                          var bab=fenlei[z].lastChild.childNodes
                          var cbc="";
                          for(var d=0;d<bab.length;d++){
                              if (bab[d].className== "current") {
                                  cbc=bab[d].innerHTML
                                  attrvalue+=aba+":"+cbc+","
                                  var ccd=attrvalue.substring(0,attrvalue.length-1)
                                  attrddd="{"+ ccd +"}"
                                  console.log(attrddd)
                              }
                          }

                       }
                          for(var i=0;i<ln.length;i++){
                         if (ln[i].attrsValue==attrddd) {
                             $("#deId").html(ln[i].id)
                             $("#mm").val(ln[i].id)
                             $("#pri").html(ln[i].price)
                             $(".kucun").html(ln[i].stock)
                         }
                     }
                  }
             })
           }
         });

     $('.property').css( "display","block");
     $('#bg').css( "display","block");
     $('.close ').click(function(){
     $('.property').css( "display","none");
     $('#bg').css( "display","none");
 })

 })
  $("#shopcar").live("click",function(){
     // 加入购物车-----
     var id = getQueryString("id");
     $.ajax({
         type: "POST",
          url: commonURL+"/skl/good/queryStoreGoodDetails",
          data: {storeGoodBaseId:id},
          dataType: 'json',
          success: function (data) {
             var ln=data.data.iData
                 var fenlei=$(".fenlei")
                 var attrvalue="";
                  for(var z=0;z<fenlei.length;z++){
                     var aba=fenlei[z].firstChild.innerHTML
                     bab=fenlei[z].lastChild.childNodes
                     var cbc="";
                     for(var d=0;d<bab.length;d++){
                         if (bab[d].className== "current") {
                             cbc=bab[d].innerHTML
                             attrvalue+=aba+":"+cbc+","
                             var ccd=attrvalue.substring(0,attrvalue.length-1)
                             attrddd="{"+ ccd +"}"
                             console.log(attrddd)
                         }
                     }

                  }
                  for(var i=0;i<ln.length;i++){
                      if (ln[i].attrsValue==attrddd) {
                          $("#deId").html(ln[i].id)
                          $("#mm").val(ln[i].id)
                          $("#pri").html(ln[i].price)
                          $(".kucun").html(ln[i].stock)
                      }
                  }

            var fkUserId=$.cookie("userId");
            var storeGoodId=$("#mm").val();
            var goodCount=$("#numm1").val()
            $('.property').css( "display","none");
            $('#bg').css( "display","none");
            $.ajax({
                type: "POST",
                 url: commonURL+"/skl/shoppingCart/addGoodToShoppingCart",
                 data: {userBaseId:fkUserId,storeGoodId:storeGoodId,goodCount:goodCount},
                 dataType: 'json',
                 success: function (data) {
                    console.log(data)
                    $("#shaop").show().delay().fadeOut(1000)
                 }
            })
          }
     })
    
 })
 // 数量选择-------------------------------------
  $(".add").live("click",function(){
     var t=$(this).parent().find('.text_box');
     t.val(parseInt(t.val())+1);
     var kc=parseInt( $(".kucun").text());
     if(parseInt(t.val())> kc){
         t.val(kc);
         alert("购买数量不能大于库存");
     }
 })
 $(".reduce").live("click",function(){
     var t=$(this).parent().find('.text_box');
     t.val(parseInt(t.val())-1);
     if(parseInt(t.val())<1){
         t.val(1);
         alert("购买数量必须大于或等于1");
     }
 })
 // 颜色，尺寸  选择========--------------------------------------------
 $('.s-intro').bind('click',function(){})
      $('#tccl li').live('click',function(){
         $(this).addClass('current').siblings().removeClass('current');
         var id = getQueryString("id");
         $.ajax({
             type: "POST",
              url: commonURL+"/skl/good/queryStoreGoodDetails",
              data: {storeGoodBaseId:id},
              dataType: 'json',
              success: function (data) {
                 var ln=data.data.iData
                 console.log(ln)
                 var fenlei=$(".fenlei")
                    var attrvalue="";
                     for(var z=0;z<fenlei.length;z++){
                        var aba=fenlei[z].firstChild.innerHTML
                        bab=fenlei[z].lastChild.childNodes
                        var cbc="";
                        for(var d=0;d<bab.length;d++){
                            if (bab[d].className== "current") {
                                cbc=bab[d].innerHTML
                                attrvalue+=aba+":"+cbc+","
                                var ccd=attrvalue.substring(0,attrvalue.length-1)
                                attrddd="{"+ ccd +"}"
                                console.log(attrddd)
                            }
                        }

                     }
                     for(var i=0;i<ln.length;i++){
                     if (ln[i].attrsValue==attrddd) {
                         $("#deId").html(ln[i].id)
                         $("#mm").val(ln[i].id)
                         $("#pri").html(ln[i].price)
                         $(".kucun").html(ln[i].stock)
                         //return false;
                     }
                 }
              }
         })
     })

// 分享
$(function(){
    $(".shopcar a").on("click",function(){
        $(".share1").fadeIn();
    })
    $(".sha").on("click",function(){
        $(".share1").fadeOut();
    })
})
