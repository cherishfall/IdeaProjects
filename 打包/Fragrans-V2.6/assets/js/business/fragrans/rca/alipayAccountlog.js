$package('rca.alipayAccountlog');
rca.alipayAccountlog = function(){
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
								return value.split(" ")[0];
						}},
						{field:'merchantOutOrderNo',title:'商户订单号',sortable:true},
			 					{field:'balance',title:'余额',sortable:true},
			 					{field:'income',title:'收入金额',sortable:true},
			 					{field:'outcome',title:'支出金额',sortable:true},
			 					{field:'transDate',title:'订单付款时间',sortable:true},
			 					{field:'subTransCodeMsg',title:'子业务类型',sortable:true},
			 					{field:'transCodeMsg',title:'业务类型',sortable:true},
			 					{field:'buyerAccount',title:'买家支付宝人民币资金账号',sortable:true},
			 					{field:'sellerAccount',title:'卖家支付宝人民币资金账号',sortable:true},
			 					{field:'sellerFullname',title:'卖家姓名',sortable:true},
			 					{field:'currency',title:'货币代码',sortable:true},
			 					{field:'depositBankNo',title:'充值流水号',sortable:true},
			 					{field:'goodsTitle',title:'商品名称',sortable:true},
			 					{field:'iwAccountLogId',title:'账务序列号',sortable:true},
			 					{field:'partnerId',title:'合作者身份ID',sortable:true},
			 					{field:'serviceFee',title:'交易服务费',sortable:true},
			 					{field:'serviceFeeRatio',title:'交易服务费率',sortable:true},
			 					{field:'totalFee',title:'交易总金额',sortable:true},
			 					{field:'tradeNo',title:'支付宝交易号',sortable:true},
			 					{field:'tradeRefundAmount',title:'累积退款金额',sortable:true},
			 					{field:'signProductName',title:'签约产品',sortable:true},
			 					{field:'rate',title:'费率',sortable:true},
			 					{field:'transOutOrderNo',title:'订单号',sortable:true},
			 					{field:'transAccount',title:'账务本方支付宝人民币资金账号',sortable:true},
			 					{field:'otherAccountEmail',title:'账务对方邮箱',sortable:true},
			 					{field:'otherAccountFullname',title:'账务对方全称',sortable:true},
			 					{field:'otherUserId',title:'账务对方支付宝用户号',sortable:true},
			 					{field:'bankName',title:'银行名称',sortable:true},
			 					{field:'bankAccountNo',title:'银行账号',sortable:true},
			 					{field:'bankAccountName',title:'银行账户名字',sortable:true},
			 					{field:'memo',title:'备注',sortable:true}
			 	]],
				toolbar:[
					{id:'btnExport',text:'导出记录',btnType:'export',iconCls:"ext-icon-page_excel",
						handler : function() {
							$('#exportAliPayListForm').form('reset');
							exportAliPayList();
					}},
					{id:'btnOrder',text:'获取账单',btnType:'order',iconCls:"ext-icon-table_save",
						handler : function() {
							$('#orderAliPayListForm').form('reset');
							orderAliPayList();
						}}
				]
			}
		},
		init:function(){
			$('#statdate').datebox('setValue', getYesterDay());
			_box = new YDataGrid(_this.config); 
			_box.init();
		}
	}
	return _this;
}();

$(function(){
	rca.alipayAccountlog.init();
	$('#exportAliPayList').dialog({
		buttons : [ {
			text : '保存',
			handler : function() {
				var param = $('#exportAliPayListForm').serializeObject();
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
				if (endDate < startDate) {
					$.messager.show({
						title : '提示',
						msg : "开始时间必须小于结束时间"
					});
					return;
				}
				$.messager.confirm('确认', '确认导出符合查询条件的数据？', function(r) {
					if (r) {
						window.open('exportAliPayList.do?startDate=' + startDate
								+ '&endDate=' + endDate);
					}
				});
				$('#exportAliPayList').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#exportAliPayList').dialog('close');
			}
		} ]
	});
	
	$('#orderAliPayList').dialog({
		buttons : [ {
			text : '获取',
			handler : function() {
				var param = $('#orderAliPayListForm').serializeObject();
				var statdate = param.statdate;
				//验证导出日报时间
				if(statdate == null || statdate == '' || statdate == undefined){
					$.messager.show({
						title : '提示',
						msg : '请选择账单日期'
					});
					return;
				}
				$.messager.confirm('确认', '确认重新获取'+statdate+'支付宝账单？', function(r) {
					if (r) {
						$.messager.progress({
				            title:'请稍后',
				            msg:'正在获取支付宝账单...'
						});
						$.ajax({
							url : 'rebuildAlipayOrder.do',
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
				$('#orderAliPayList').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#orderAliPayList').dialog('close');
			}
		} ]
	});
});		

function exportAliPayList() {
	$('#exportAliPayList').dialog('open');
}

function orderAliPayList() {
	$('#orderAliPayList').dialog('open');
}