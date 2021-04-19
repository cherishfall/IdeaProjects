$package('app.orderParkMonthly');
app.orderParkMonthly = function(){
	var _box = null;
	var _this = {
			notify : function(rows) {
				if(rows[0].notifyStatus==0&&rows[0].orderStatus==200){
					$.messager.confirm('确认', '确定要执行此操作吗？', function(r) {
						if(r){
							$.messager.progress({
						        title:'请稍后',
						        msg:'正在发送通知...'
							});
							$.ajax({
								url : 'sendNotify.do',
								type : 'post',
								data : {
									buyerAccount : rows[0].buyerAccount,
									orderNo : rows[0].orderNo,
									payMent : rows[0].payType,
									payTime : rows[0].payTime
								},
								success : function(result){
									$.messager.progress('close');
									console.log(result);
									$.messager.show({
										msg : result.msg,
										title : '提示'
									});
									$('#data-list').datagrid('reload');
								}
							});
						}
					});
				}else if(rows[0].notifyStatus==1){
					$.messager.show({
						msg : '已通知成功，无需再通知',
						title : '提示'
					});
				}else if(rows[0].notifyStatus==0&&rows[0].notifyStatus!=200){
					$.messager.show({
						msg : '未支付成功，无需通知',
						title : '提示'
					});
				}
			},
		config:{
			event : {
				search : function() { //条件查询验证
					var startEventTime = $('#searchStartTime').datebox('getValue');
					var endEventTime = $('#searchEndTime').datebox('getValue');
					if (startEventTime > endEventTime) {
						sys.alert('警告', '起始时间大于结束时间.', 'warning');
						return;
					}
					var Grid = $('#data-list');
					var Form = {
					  search: $("#searchForm")
					};
					var param = Form.search.serializeObject();
					Grid.datagrid('reload',param);
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
						{field:'areaName',title:'区级名称',sortable:true},
	 					{field:'monthlyId',title:'包月记录ID',sortable:true},
	 					{field:'userAccount',title:'用户账号',sortable:true},
	 					{field:'orderNo',title:'交易订单编号',sortable:true},
	 					{field:'price',title:'订单金额',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
	 						}},
	 					{field:'payment',title:'支付方式',sortable:true,formatter:sys.dicts.text('PAY_METHOD')},
	 					{field:'plateNo',title:'车牌号码',sortable:true},
	 					{field:'subject',title:'订单标题',sortable:true},
	 					{field:'orderBody',title:'订单描述',sortable:true},
	 					{field:'orderStatus',title:'订单状态码',sortable:true,formatter:sys.dicts.text('ORDER_STATUS')},
	 					{field:'payTime',title:'支付时间',sortable:true},
	 					{field:'buyerAccount',title:'买家账号',sortable:true},
	 					{field:'counterFee',title:'手续费',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
	 						}},
	 					{field:'notifyStatus',title:'通知状态',sortable:true,formatter:sys.dicts.text('NOTIFY_STATUS')},
	 					{field:'notifyTime',title:'最后一次通知时间',sortable:true}
			 	]],
				toolbar:[
					{id:'btnnotify',text:'手动通知',btnType:'notify',iconCls : 'ext-icon-phone_sound',
								handler : function() {
									var rows = $('#data-list').datagrid('getChecked');
									if (rows.length == 1) {
										_this.notify(rows);
									} else {
										$.messager.show({
											msg : '请选择一条记录',
											title : '提示'
										});
									}
					}},
					{id:'btnRefundFee',text:'退款',btnType:'refundFee',iconCls : 'ext-icon-pencil_go',
						handler : function() {
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length == 1) {
								refund(rows[0].orderNo);
							} else {
								$.messager.show({
									msg : '请选择一条记录',
									title : '提示'
								});
							}
					}},
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
	app.orderParkMonthly.init();
});	

function refund(orderNo){
	$('#refund').dialog({
		buttons : [ {
			text : '确认退款',
			handler : function() {
				var rows = $('#data-list').datagrid('getChecked');
				if (rows.length == 0) {
					$.messager.show({
						title : '提示',
						msg : '至少选择一条记录~'
					});
					return;
				} 
				if(rows[0].orderStatus != 200){
					$.messager.alert('提示','订单未完成，不能退款'); 
					return;
				}
				
				if($.trim($('#realRefundFee').val())==0.00){
					$.messager.alert('提示','退款金额不能为0'); 
					return;
				}
				
				if($.trim($('#realRefundFee').val())==''){
					$.messager.alert('提示','退款金额为空！'); 
					return;
				}
				
				if($.trim($('#reason').val())==''){
					$.messager.alert('提示','退款原因不能为空！'); 
					return;
				}
				
				// 获取退款金额
				var refundFee = $('#realRefundFee').val();
				$.messager.confirm('确认', '是否确认退款  <span style="color:red;font-weight:bold;font-size:15px;">'+refundFee+'元</span>  (该操作不可逆)', function(r) {
				if (r) {
					$('#refund').dialog('close');
					$.messager.progress({
		                title:'请稍后',
		                msg:'正在为用户退款<span style="color:red;font-weight:bold;font-size:15px;">'+refundFee+'元</span>...'
					});
					$('#refundForm').form('submit', {
						url : '../orderRefund/createRefundRecord.do',
						type : "post",
						onSubmit : function() {
							return $(this).form('validate');
						},
						success : function(result) {
							$.messager.progress('close');
							var res = $.parseJSON(result);
							$.messager.show({
								title : '提示',
								msg : res.msg
							});
							if (res.success) {
								$('#data-list').datagrid('reload');
							}
						}
					});
				}
				})
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#refund').dialog('close');
			}

		} ]
	});
	$.ajax({
		url : '../orderParkMonthly/queryByOrderNo.do',
		type : 'post',
		data : {
			orderNo : orderNo
		},
		success : function(result){
			$('#refund').dialog('open');
			$('#refundForm').form('clear');
			$('#refundFee').numberbox({    
			    min:0.00,
			    max:result.price/100-result.sucRefund/100,
			    precision:2    
			}); 
			$('#refundForm').form('load',{payTime:result.payTime,orderNo:result.orderNo,price:"￥"+result.price/100,payType:sys.dicts.text('PAY_METHOD',result.payment),
				sucRefund:"￥"+result.sucRefund/100,failRefund:"￥"+result.failRefund/100,refundFee:result.price/100-result.sucRefund/100});
		}
	})
}

function toDecimal(x) { 
    var f = parseFloat(x); 
    if (isNaN(f)) { 
      return 0; 
    } 
    f = Math.round(x*100)/100/100; 
    return f; 
  }