

//选中全选按钮，下面的checkbox全部选中

$(function(){
    $(".ttl input").live('click',function(){
        $(this).attr("checked",true).css("background","rgba(29,121,164,1)")
        $(this).parent().parent().children().find(".ttz input").attr("checked",true).css("background","rgba(29,121,164,1)")
        $(this).parent().parent().siblings().children().find(".ppza").attr("checked",false).css("background","#fff")
        $(this).parent().parent().siblings().children().children().children(".product").attr("checked",false).css("background","#fff")
        payment();
    })
    $(".ttz input").live('click',function(){
        if(this.checked==false){
            $(this).attr("checked",false).css("background","#fff")
            $(this).parent().parent().parent().children().find(".ppza").attr("checked",false).css("background","#fff")
        }else{
            $(this).attr("checked",true).css("background","rgba(29,121,164,1)")
            $(this).parent().parent().parent().children().find(".ppza").attr("checked",true).css("background","rgba(29,121,164,1)")
            $(this).parent().parent().parent().siblings().children().find(".ppza").attr("checked",false).css("background","#fff")
            $(this).parent().parent().parent().siblings().children().find(".ttz input").attr("checked",false).css("background","#fff")
        }
        
    })

})
//商品加减及价格计算
var payment=function () {
    var product = $('.car-list .goods .product');
    var money = 0;
    if (product.length == 0) {
        $('#total').text("00.00");
    } else{
         product.each(function () {
            var me = $(this);
            var sub_total = parseFloat(me.parent().parent().find('.number').children('span').html()) * (me.parent().parent().find('.number').children().find('input').val());
            me.parent().parent().find('.number').children('em').text(sub_total.toFixed(2));
                if (me.is(':checked')) {
                money = sub_total;
            } 
           
            $('#total').text((money).toFixed(2));
        });
    }
   
}
  

  $('.jian').live('click',function () {
        var me = $(this);
        var input = me.next('input');
        var quantity = Number(input.val());
        input.val(quantity - 1);
        if (input.val() <= 0) {
            input.val(1);
        }
        
       payment();
	   
    });
    $('.jia').live('click',function () {
		
        var me = $(this);
        var input = me.prev('input');
        var quantity = Number(input.val());
        input.val(quantity + 1);
         payment();
    });
    $('.goods label input').live('change',function () {
       payment();
    });
	 
//删除商品
$(".delete").live("click",function(){
    var id=$(this).parent().parent().parent().attr("id")
    $("#desdell").show();
    $(".ttru").click(function(){
        $.ajax({
            url:commonURL+"/skl/shoppingCart/removeFromShoppingCart",
            type:"post",
            dataType:"json",
            data:{shoppingCartIds:id},
            success:function(data){
                $("div#"+id).parent().parent().parent().remove();
                payment();
                location.reload();
            }
        })
    })
    $(".ffal").click(function(){
        $("#desdell").hide();
    })
    
})

