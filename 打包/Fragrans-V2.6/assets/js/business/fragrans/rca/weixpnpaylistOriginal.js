$package('rca.weixpnpaylistOriginal');
rca.weixpnpaylistOriginal = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			queryParams:{
	   				statdate : getYesterDayMorning(),
	   			},
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'statdate',title:'账单日期',sortable:true,
							formatter:function(value,row,index){
								return value=value.split(" ")[0];
							}
						},
			 					{field:'body',title:'商品名称',sortable:true},
			 					{field:'payTime',title:'交易时间',sortable:true},
			 					{field:'subscribeId',title:'公众账号ID',sortable:true},
			 					{field:'mchId',title:'商户号',sortable:true},
			 					{field:'transactionId',title:'微信订单号',sortable:true},
			 					{field:'outTradeNo',title:'商户订单号',sortable:true},
			 					{field:'openid',title:'用户标识',sortable:true},
			 					{field:'tradeType',title:'交易类型',sortable:true},
			 					{field:'tradeState',title:'交易状态',sortable:true},
			 					{field:'bankType',title:'付款银行',sortable:true},
			 					{field:'feeType',title:'货币种类',sortable:true},
			 					{field:'totalFee',title:'总金额',sortable:true},
			 					{field:'refundId',title:'微信退款单号',sortable:true},
			 					{field:'outRefundNo',title:'商户退款单号',sortable:true},
			 					{field:'refundAmount',title:'退款金额',sortable:true},
			 					{field:'refundType',title:'退款类型',sortable:true,formatter:sys.dicts.text('refund_type')},
			 					{field:'refundStatus',title:'退款状态',sortable:true},
			 					{field:'serviceFee',title:'手续费',sortable:true},
			 					{field:'rate',title:'费率',sortable:true},
			 					{field:'createTime',title:'创建时间',sortable:true}
			 	]],
				toolbar:[
					{id:'btnExport',text:'导出记录',btnType:'export',iconCls:"ext-icon-page_excel",
						handler : function() {
							$('#exportWeixPayListForm').form('reset');
							exportWeixPayList();
						}},
					{id:'btnOrder',text:'获取账单',btnType:'order',iconCls:"ext-icon-table_save",
							handler : function() {
								$('#orderWeixPayListForm').form('reset');
								orderWeixPayList();
							}}
				]
			}
		},
		init:function(){
			$('#statdate').datebox('setValue', getYesterDayMorning());
			_box = new YDataGrid(_this.config); 
			_box.init();
		}
	}
	return _this;
}();

$(function(){
	rca.weixpnpaylistOriginal.init();
	$('#exportWeixPayList').dialog({
		buttons : [ {
			text : '保存',
			handler : function() {
				var param = $('#exportWeixPayListForm').serializeObject();
				var startDate = param.startDate;
				var endDate = param.endDate;
				var refundType = param.refundType;
				//验证导出日报时间
				if(startDate == null || startDate == '' || startDate == undefined
						|| endDate == null || endDate == '' || endDate == undefined){
					$.messager.show({
						title : '提示',
						msg : '请选择日期'
					});
					return;
				}
				if (endDate <= startDate) {
					$.messager.show({
						title : '提示',
						msg : "开始时间必须小于结束时间"
					});
					return;
				}
				$.messager.confirm('确认', '确认导出符合查询条件的数据？', function(r) {
					if (r) {
						window.open('exportWeixPayList.do?startDate=' + startDate
								+ '&endDate=' + endDate+ '&refundType=' + refundType);
					}
				});
				$('#exportWeixPayList').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#exportWeixPayList').dialog('close');
			}
		} ]
	});
	
	$('#orderWeixPayList').dialog({
		buttons : [ {
			text : '获取',
			handler : function() {
				var param = $('#orderWeixPayListForm').serializeObject();
				var statdate = param.statdate;
				//验证导出日报时间
				if(statdate == null || statdate == '' || statdate == undefined){
					$.messager.show({
						title : '提示',
						msg : '请选择账单日期'
					});
					return;
				}
				$.messager.confirm('确认', '确认重新获取'+statdate+'微信公众号账单？', function(r) {
					if (r) {
						$.messager.progress({
				            title:'请稍后',
				            msg:'正在获取微信公众号账单...'
						});
						$.ajax({
							url : 'rebuildWeixpnpayOrder.do',
							type : 'post',
							data : {"statdate":statdate},
							success : function(result) {
								$.messager.progress('close');
								$.messager.show({
									title : '提示',
									msg : result.msg
								});
								$('#data-list').datagrid('reload');
							}
						});
					}
				});
				$('#orderWeixPayList').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#orderWeixPayList').dialog('close');
			}
		} ]
	});
});		

function exportWeixPayList() {
	$('#exportWeixPayList').dialog('open');
}

function orderWeixPayList() {
	$('#orderWeixPayList').dialog('open');
	$('#data-list').datagrid('reload');
}
