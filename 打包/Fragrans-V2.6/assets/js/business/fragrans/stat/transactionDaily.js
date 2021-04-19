$package('stat.transactionDaily');
stat.transactionDaily = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			keepChoice : true,
	   			queryParams:{
	   				dayTime : getNowDay(),
	   			},
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
						{field:'dayTime',title:'日期',sortable:true},
			 					{field:'cityName',title:'城市名称',sortable:true},
			 					{field:'areaName',title:'区域名称',sortable:true},
			 					{field:'tranSuccessCount',title:'交易成功笔数',sortable:true,formatter:function(value,row,index){
		 							return "<font style='color:green;font-weight:bold;'>"+value+"</font>";
		 						}},
			 					{field:'aliPaySuccessAmount',title:'支付宝成功金额',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font style='color:green;font-weight:bold;'>￥"+value/100+"</font>";
			 						}},
		 						{field:'wxSuccessAmount',title:'微信成功金额',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font style='color:green;font-weight:bold;'>￥"+value/100+"</font>";
			 						}},
			 					{field:'tranSuccessAmount',title:'交易成功金额',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font style='color:green;font-weight:bold;'>￥"+value/100+"</font>";
			 						}},
			 					{field:'tranFaultCount',title:'交易失败笔数',sortable:true,formatter:function(value,row,index){
		 							return "<font style='color:#ccc;font-weight:bold;'>"+value+"</font>";
		 						}},
			 					{field:'tranFaultAmount',title:'交易失败金额',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font style='color:#ccc;font-weight:bold;'>￥"+value/100+"</font>";
			 						}},
			 					{field:'bookCount',title:'预约数',sortable:true},
			 					{field:'bookAmount',title:'预约金额',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font >￥"+value/100+"</font>";
			 						}},
//			 					{field:'shouldPaidAmount',title:'应缴金额',sortable:true,
//			 							formatter:function(value,row,index){
//				 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
//				 						}},
//			 					{field:'actuallyPaidAmount',title:'实缴金额',sortable:true,
//				 							formatter:function(value,row,index){
//					 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
//					 						}},
		 						{field:'cmbPayCount',title:'一网通支付笔数',sortable:true,formatter:function(value,row,index){
		 							return "<font style='color:green;font-weight:bold;'>"+value+"</font>";
		 						}},
			 					{field:'cmbPayAmount',title:'一网通支付金额 ',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font style='color:green;font-weight:bold;'>￥"+value/100+"</font>";
			 					}},
			 					{field:'alipayCounterFee',title:'支付宝手续费 ',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font style='color:green;font-weight:bold;'>￥"+value/100+"</font>";
		 						}},
		 						{field:'wxpayCounterFee',title:'微信手续费',sortable:true,
		 							formatter:function(value,row,index){
		 								return "<font style='color:green;font-weight:bold;'>￥"+value/100+"</font>";
	 							}},
	 							{field:'cmbpayCounterFee',title:'一网通手续费 ',sortable:true,
	 								formatter:function(value,row,index){
	 									return "<font style='color:green;font-weight:bold;'>￥"+value/100+"</font>";
 								}},
 								{field:'ticketDiscountCount',title:'停车券抵扣笔数',sortable:true,formatter:function(value,row,index){
		 							return "<font style='color:green;font-weight:bold;'>"+value+"</font>";
		 						}},
			 					{field:'ticketDiscountAmount',title:'停车券抵扣金额 ',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font style='color:green;font-weight:bold;'>￥"+value/100+"</font>";
			 					}},
			 	]],
				toolbar:[
//					{id:'btnadd',text:'添加',btnType:'add'},
//					{id:'btnedit',text:'修改',btnType:'edit'},
//					{id:'btndelete',text:'删除',btnType:'remove'}
				]
			}
		},
		init:function(){
			$('#dayTime').datebox('setValue', getNowDay());
			_box = new YDataGrid(_this.config); 
			_box.init();
		}
	}
	return _this;
}();

$(function(){
	stat.transactionDaily.init();
});