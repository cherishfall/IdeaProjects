$package('app.memberCardOrder');
app.memberCardOrder = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'cityCode',title:'城市代码',sortable:true,hidden:true},
	 					{field:'areaCode',title:'区级代码',sortable:true,hidden:true},
	 					{field:'areaName',title:'区域名称',sortable:true,width:60},
	 					{field:'userId',title:'用户ID',sortable:true,hidden:true},
	 					{field:'userAccount',title:'用户账号',sortable:true,width:90},
	 					{field:'orderNo',title:'充值订单编号',sortable:true,width:160},
	 					{field:'rechargeCardNo',title:'充值卡编码',sortable:true,width:110},
	 					{field:'payType',title:'支付方式',sortable:true,width:80,
	 						formatter:sys.dicts.text('MEMBER_RECHARGE_TYPE')},
	 					{field:'price',title:'充值金额',sortable:true,width:60,
	 						formatter:function(value,row,index){
	 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
	 						}},
	 					// {field:'counterFee',title:'手续费',sortable:true,width:60,
	 					// 	formatter:function(value,row,index){
	 					// 		return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
	 					// 	}},
	 					{field:'orderStatus',title:'订单状态码',sortable:true,width:80,
	 							formatter:sys.dicts.text('ORDER_STATUS')},
	 					{field:'buyerAccount',title:'买家账号',sortable:true,width:120},
	 					{field:'createTime',title:'订单生成时间',sortable:true,width:110},
			 	]],
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
	app.memberCardOrder.init();
});		