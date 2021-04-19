$package('app.orderScanpay');
app.orderScanpay = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
                queryParams:{
                    startDate :new Date().pattern("yyyy-MM-dd 00:00:00") ,
                    endDate : new Date().pattern("yyyy-MM-dd HH:mm:ss"),
                },
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
                    	{field:'createTime',title:'日期',sortable:true,
							formatter:function(value,row,index){
                            return value.split(" ")[0];
                        }},
	 					{field:'areaName',title:'区域',sortable:true},
						{field:'parkName',title:'停车点/场名称',sortable:true},
						{field:'collectorAccount',title:'收费员账号',sortable:true},
                        {field:'subject',title:'订单标题',sortable:true},
                        {field:'source',title:'订单来源',sortable:true,formatter:sys.dicts.text('SCAN_ORDER_SOURCE')},
						{field:'palteNo',title:'车牌号',sortable:true},
						{field:'parkrecordId',title:'停车记录ID',sortable:true,
							formatter:function(value,row,index){
								if(row.source==3){
									var  valueArr = value.split(",");
									if(valueArr.length >1){
										return "<a href='javascript:void(0);' title='停车记录ID："+value+"'>批量缴费"+valueArr.length+"笔</a>";
									}
								}
								return value;
						}},
						// {field:'transOrderNo',title:'二维码或条形码码号',sortable:true},
						{field:'orderNo',title:'订单编号',sortable:true},
						{field:'payType',title:'支付方式',sortable:true,formatter:sys.dicts.text('PAY_METHOD')},
						{field:'price',title:'订单金额',sortable:true,
							formatter:function(value,row,index){
								return "<font style='color:green;font-weight:bold;'>￥"+value/100+"</font>";
							}},
                        {field:'sucRefund',title:'已退金额',sortable:true,
                        formatter:function(value,row,index){
                            return "<font style='color:dodgerblue;font-weight:bold;'>￥"+value/100+"</font>";
                        }},
						{field:'orderStatus',title:'订单状态',sortable:true,formatter:sys.dicts.text('ORDER_STATUS')},
						{field:'payTime',title:'支付时间',sortable:true},
						{field:'buyerAccount',title:'买家账号',sortable:true}
						// {field:'orderBody',title:'订单描述',sortable:true},
						// {field:'orderTime',title:'订单时间',sortable:true},
						// {field:'remark',title:'备注',sortable:true},
			 	]],
				toolbar:[
                    {id:'btnOrderScanpayRefund',text:'收费宝订单退款',btnType:'refundOrderScanpay',iconCls:"ext-icon-arrow_undo",
                        handler : function() {
                            refund();
                        }
                    },{id:'btnOrderScanpayExport',text:'导出清单报表',btnType:'exportOrderScanpay',iconCls:"ext-icon-page_excel",
                        handler : function() {
                            $('#exportOrderScanpayForm').form('reset');
                            $('#exportOrderScanpay').dialog('open');
                        }
                    },{id:'btnAchievementExport',text:'导出业绩报表',btnType:'exportAchievement',iconCls:"ext-icon-page_excel",
                        handler : function() {
                            $('#exportAchievementForm').form('reset');
                            $('#exportAchievement').dialog('open');
                        }
                    }
				]
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
		}
	}
	return _this;
}();

$(function(){
	app.orderScanpay.init();
	var date = new Date();
	$('#startDateSel').datebox('setValue',date.pattern("yyyy-MM-dd"));
	$('#endDateSel').datebox('setValue',date.pattern("yyyy-MM-dd"));
});

function refund(){
    var rows = $('#data-list').datagrid('getChecked');
    if (rows.length != 1) {
        $.messager.show({
            title : '提示',
            msg : '请选择一条记录~'
        });
        return;
    }
    if (rows[0].source != 1) {
        $.messager.alert('提示', 'pos机订单请到停车退费管理页面申请退款','info');
        return;
    }
    if (rows[0].orderStatus != 200) {
        $.messager.alert('提示', '该条记录未支付成功，无需退款','info');
        return;
    }
    var orderNo = rows[0].orderNo;
    $('#refundOrderScanpayForm').form('reset');
    $('#refundOrderScanpay').dialog({
        buttons : [ {
            text : '确认退款',
            handler : function() {
                if($.trim($('#refundFee').val())==0.00){
                    $.messager.alert('提示','退款金额不能为0');
                    return;
                }

                if($.trim($('#refundFee').val())==''){
                    $.messager.alert('提示','退款金额为空！');
                    return;
                }

                if($.trim($('#reason').val())==''){
                    $.messager.alert('提示','退款原因不能为空！');
                    return;
                }

                // 获取退款金额
                var refundFee = $('#refundFee').val();
                $.messager.confirm('确认', '是否确认退款  <span style="color:red;font-weight:bold;font-size:15px;">'+refundFee+'元</span>  (该操作不可逆)', function(r) {
                    if (r) {
                        $.messager.progress({
                            title:'请稍后',
                            msg:'正在为用户退款<span style="color:red;font-weight:bold;font-size:15px;">'+refundFee+'元</span>...'
                        });
                        $('#refundOrderScanpayForm').form('submit', {
                            url : '../orderRefund/createScanpayRefundRecord.do',
                            type : "post",
                            onSubmit : function() {
                                return $(this).form('validate');
                            },
                            success : function(result) {
                                $.messager.progress('close');
                                var res = $.parseJSON(result);
                                if(res!=null){
                                    if (res.success) {
                                        $('#data-list').datagrid('reload');
                                        $('#refundOrderScanpay').dialog('close');
                                    }
                                    $.messager.show({
                                        title : '提示',
                                        msg : res.msg
                                    });
                                }
                            }
                        });
                    }
                })
            }
        }, {
            text : '关闭',
            handler : function() {
                $('#refundOrderScanpay').dialog('close');
            }

        } ]
    });
    $.ajax({
        url : '../orderRefund/queryAllScanpayRefundFee.do',
        type : 'post',
        data : {
            orderNo : orderNo
        },
        success : function(result){
            if(result.price==result.sucRefund){
                $.messager.alert('提示','该条记录已全额退款','info');
                return;
            }
            $('#refundOrderScanpay').dialog('open');
            $('#refundOrderScanpayForm').form('clear');
            $('#refundFee').numberbox({
                min:0.00,
                max:result.price/100-result.sucRefund/100,
                precision:2
            });
            $('#refundOrderScanpayForm').form('load',{payTime:result.payTime,orderNo:result.orderNo,price:"￥"+result.price/100,payType:sys.dicts.text('PAY_METHOD',result.payType),
                sucRefund:result.sucRefund/100});
        }
    });
}

$('#exportOrderScanpay').dialog({
    buttons : [ {
        text : '导出',
        handler : function() {
            var param = $('#exportOrderScanpayForm').serializeObject();
            var source = param.source;
            var areaCode = param.areaCode;
            var collectorAccount = param.collectorAccount;
            var parkName = param.parkName;
            var startDate = param.startDate;
            var endDate = param.endDate;
            //验证导出日报时间
            if(startDate == null || startDate == '' || startDate == undefined
                || endDate == null || endDate == '' || endDate == undefined){
                $.messager.show({
                    title : '提示',
                    msg : '请选择日期'
                });
                return;
            }
            if (endDate < startDate) {
                $.messager.show({
                    title : '提示',
                    msg : "开始时间必须小于结束时间"
                });
                return;
            }
            $.messager.progress({
                title:'请稍后',
                msg:'正在生成报表...'
            });
            $('#exportOrderScanpayForm').form('submit', {
                url : 'getExportOrderScanpay.do',
                type : "post",
                success : function(result) {
                    $.messager.progress('close');
                    var res = $.parseJSON(result);
                    if(!res.success){
                        $.messager.show({
                            title : '提示',
                            msg : res.msg
                        });
                    }else{
                        $.messager.confirm('确认', '确认导出符合条件的数据？', function(r) {
                            if (r) {
                                window.open('exportOrderScanpay.do?startDate=' + startDate
                                    + '&endDate=' + endDate +'&areaCode=' + areaCode + '&parkName=' + encodeURI(encodeURI(parkName)) + '&source=' + source + '&collectorAccount=' + collectorAccount );
                            }
                        });
                    }
                    $('#exportOrderScanpay').dialog('close');
                }
            });
        }
    }, {
        text : '重置表单',
        handler : function() {
            $('#exportOrderScanpayForm').form('clear');
        }
    } ]
});

$('#exportAchievement').dialog({
    buttons : [ {
        text : '导出',
        handler : function() {
            var param = $('#exportAchievementForm').serializeObject();
            var areaCode = param.areaCode;
            var startDate = param.startDate;
            var endDate = param.endDate;
            //验证导出日报时间
            if(startDate == null || startDate == '' || startDate == undefined
                || endDate == null || endDate == '' || endDate == undefined){
                $.messager.show({
                    title : '提示',
                    msg : '请选择日期'
                });
                return;
            }
            if (endDate < startDate) {
                $.messager.show({
                    title : '提示',
                    msg : "开始时间必须小于结束时间"
                });
                return;
            }
            $.messager.progress({
                title:'请稍后',
                msg:'正在生成报表...'
            });
            $('#exportAchievementForm').form('submit', {
                url : 'getExportAchievement.do',
                type : "post",
                success : function(result) {
                    $.messager.progress('close');
                    var res = $.parseJSON(result);
                    if(!res.success){
                        $.messager.show({
                            title : '提示',
                            msg : res.msg
                        });
                    }else{
                        $.messager.confirm('确认', '确认导出符合条件的数据？', function(r) {
                            if (r) {
                                window.open('exportAchievement.do?startDate=' + startDate
                                    + '&endDate=' + endDate +'&areaCode=' + areaCode );
                            }
                        });
                    }
                    $('#exportAchievement').dialog('close');
                }
            });
        }
    }, {
        text : '重置表单',
        handler : function() {
            $('#exportAchievementForm').form('clear');
        }
    } ]
});
