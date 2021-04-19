$package('fanc.fancOrderSpms');
fanc.fancOrderSpms = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'summaryDataList.do',
	   			fitColumns:true,
	   			queryParams:{
	   				summaryMonthStart:getMonthFirstDay(),
	   				summaryMonthEnd:getNowDay()
	   			},
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
	 					{field:'summaryMonth',title:'汇总月份',sortable:true},
	 					{field:'cityName',title:'城市',sortable:true},
	 					{field:'amount',title:'收入金额',sortable:true,formatter:function(value,row,index){
 							return "<font>￥"+value/100+"</font>";
 						}},
	 					{field:'amountDiscount',title:'折扣金额',sortable:true,formatter:function(value,row,index){
 							return "<font>￥"+value/100+"</font>";
 						}},
	 					{field:'amountSpms',title:'SPMS金额',sortable:true,formatter:function(value,row,index){
 							return "<font>￥"+value/100+"</font>";
 						}},
	 					{field:'amountAlipay',title:'支付宝支付金额',sortable:true,formatter:function(value,row,index){
 							return "<font>￥"+value/100+"</font>";
 						}},
	 					{field:'amountWeixpay',title:'微信支付金额',sortable:true,formatter:function(value,row,index){
 							return "<font>￥"+value/100+"</font>";
 						}},
	 					{field:'amountWeixpnpay',title:'微信公众号支付金额',sortable:true,formatter:function(value,row,index){
 							return "<font>￥"+value/100+"</font>";
 						}},
	 					{field:'amountRefund',title:'退款金额',sortable:true,formatter:function(value,row,index){
 							return "<font>￥"+value/100+"</font>";
 						}},
	 					{field:'amountException',title:'异常金额',sortable:true,formatter:function(value,row,index){
 							return "<font>￥"+value/100+"</font>";
 						}}
			 	]],
				toolbar:[
					{id:'btnExport',text:'导出汇总',btnType:'export',iconCls:"ext-icon-page_excel",
						handler : function() {
							$('#exportOrderSpmsListForm').form('reset');
							exportOrderSpmsList();
						}}
				]
			}
		},
		init:function(){
			$('#summaryMonthStart').datebox('setValue', getMonthFirstDay());
			$('#summaryMonthEnd').datebox('setValue', getNowDay());
			_box = new YDataGrid(_this.config); 
			_box.init();
		}
	}
	return _this;
}();

$(function(){
	fanc.fancOrderSpms.init();
	// 导出
	$('#exportOrderSpmsList').dialog({
		buttons : [ {
			text : '导出',
			handler : function() {
				var param = $('#exportOrderSpmsListForm').serializeObject();
				var startDate = param.summaryMonthStart;
				var endDate = param.summaryMonthEnd;
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
				window.open('exportSummaryDataList.do?summaryMonthStart=' + startDate
					+ '&summaryMonthEnd=' + endDate+'&cityCode='+param.cityCode);
				$('#exportOrderSpmsList').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#exportOrderSpmsList').dialog('close');
			}
		} ]
	});
	
});		

function reset() {
	$('#searchForm').form('clear');
	$('#summaryMonthStart').datebox('setValue', getMonthFirstDay());
	$('#summaryMonthEnd').datebox('setValue', getNowDay());
}
function exportOrderSpmsList() {
	$('#exportOrderSpmsList').dialog('open');
}

function orderSpmsList() {
	$('#orderSpmsList').dialog('open');
}