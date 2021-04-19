var t1;
$(function(){
    $('.codeDiv').hide();
    // 打开充值弹窗
    $('#rechargeInfoDiv').dialog('open');
});

$('#rechargeInfoDiv').dialog({
    buttons:[
        {
            text:'充值',
            iconCls : 'ext-icon-tick',
            handler:function(){
                var phone = $('#phone').val();
                var phoneSure = $('#phoneSure').val();
                var price = $('#price').val();
                if(phone==null||phone==''||phone==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '手机号码不能为空'
                    });
                    return;
                }
                if(phoneSure==null||phoneSure==''||phoneSure==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '请填写手机号码确认一栏'
                    });
                    return;
                }
                var validPhone = /^1(3|4|5|7|8)\d{9}$/.test(phone);
                if(!validPhone){
                    $.messager.show({
                        title : '提示',
                        msg : '手机号码格式不正确'
                    });
                    return;
                }
                if(price==null||price==''||price==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '充值金额不能为空'
                    });
                    return;
                }
                if(price==0.00){
                    $.messager.show({
                        title : '提示',
                        msg : '充值金额不能为0'
                    });
                    return;
                }
                if(phone!=phoneSure){
                    $.messager.show({
                        title : '提示',
                        msg : '两次输入的手机号码不一致，请确认手机号码'
                    });
                    return;
                }
                // 元转换成分
                var priceF = price*100;
                var mes = '手机号<span style="color: #00B83F">'+phone+'</span>充值 <span style="color: #CC2222;font-weight: bold;">'+price+'</span> 元，确定吗？';
                $.messager.confirm('确认',mes , function(r) {
                    if (r) {
                        $.ajax({
                            url: 'createMembercardRechargeOrder.do',
                            type: 'post',
                            data : {
                                phone : phone,
                                price : priceF
                            },
                            success: function (result) {
                                if (result.success) {
                                    var data = result.data;
                                    if(data!=null){
                                        $('.codeDiv').show();
                                        $('#code').qrcode(data.qrCode);
                                        $('#phoneDesc').text(phone);
                                        $('#priceDesc').text(price+" 元");
                                        $('#rechargeInfoDiv').dialog('close');
                                        //每隔1分钟重复执行某个方法
                                        t1 = window.setInterval('refresh("'+data.outTradeNo+'")',2000);
                                    }else{
                                        $.messager.show({
                                            msg : "支付宝预下单异常",
                                            title : '提示'
                                        });
                                    }
                                } else {
                                    $.messager.show({
                                        msg : result.msg,
                                        title : '提示'
                                    });
                                }
                            },
                            error : function(e) {
                                $.messager.confirm('提示', '登录超时,点击确定重新登录.', function(r) {
                                    if(r){
                                        window.top.location = urls['msUrl'] + "/login.action";
                                    }
                                });
                            }
                        });
                    }
                });
            }
        },{
            text:'重置',
            iconCls:'ext-icon-arrow_undo',
            handler:function(){
                //清空表单
                $('#phone').val('');
                $('#phoneSure').val('');
                $('#price').numberbox('setValue', '');
            }
        }
    ]
});

$('#successDiv').dialog({
    buttons:[
        {
            text:'继续充值',
            iconCls:'ext-icon-arrow_undo',
            handler:function(){
                //重置页面
                reset();
            }
        }
    ]
});

function toUtf8(str) {
    var out, i, len, c;
    out = "";
    len = str.length;
    for(i = 0; i < len; i++) {
        c = str.charCodeAt(i);
        if ((c >= 0x0001) && (c <= 0x007F)) {
            out += str.charAt(i);
        } else if (c > 0x07FF) {
            out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));
            out += String.fromCharCode(0x80 | ((c >>  6) & 0x3F));
            out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));
        } else {
            out += String.fromCharCode(0xC0 | ((c >>  6) & 0x1F));
            out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));
        }
    }
    return out;
}

function refresh(tradeNo){
    //定时查询是否已支付
    $.ajax({
        url: 'queryTradeStatus.do',
        type: 'post',
        data : {
            tradeNo:tradeNo
        },
        success: function (result) {
            if (result.success) {
                var data = result.data;
                if (data != null && data.tradeStatus == "TRADE_SUCCESS"){
                    //如果已支付，跳出成功弹窗
                    success(data.totalAmount);
                }
            }
        },
        error : function(e) {
            $.messager.confirm('提示', '登录超时,点击确定重新登录.', function(r) {
                if(r){
                    window.top.location = urls['msUrl'] + "/login.action";
                }
            });
        }
    });
}

function success(price){
    //去掉定时器
    window.clearTimeout(t1);
    $("#code").empty();
    $('.codeDiv').hide();
    $('#successDiv').dialog('open');
    $("#sucAmount").text(price);
}

function reset(){
    //去掉定时器
    window.clearTimeout(t1);
    $('#successDiv').dialog('close');
    //隐藏并清空二维码
    $("#code").empty();
    $('.codeDiv').hide();
    //清空表单
    $('#phone').val('');
    $('#phoneSure').val('');
    $('#price').numberbox('setValue', '');
    //打开表单弹窗
    $('#rechargeInfoDiv').dialog('open');
}