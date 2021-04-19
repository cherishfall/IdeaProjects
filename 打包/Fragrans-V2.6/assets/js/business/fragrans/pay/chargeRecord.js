$package('app.chargeRecord');
app.chargeRecord = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')	
						{field:'id',checkbox:true},
	 					{field:'cityName',title:'城市名称',sortable:true},
//			 					{field:'parkingRecordId',title:'停车记录表外键',sortable:true},
			 					{field:'userAccount',title:'用户账号',sortable:true},
			 					{field:'payAccountType',title:'支付账号类型',sortable:true,formatter:sys.dicts.text('PAY_ACCOUNT_TYPE')},
			 					{field:'payAccount',title:'支付账号',sortable:true},
			 					{field:'payFee',title:'收费金额',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font style='font-weight:bold;'>￥"+value/100+"</font>";
			 						}},
			 					{field:'parkFee',title:'停车应收费用',sortable:true,
		 							formatter:function(value,row,index){
			 							return "<font style='font-weight:bold;'>￥"+value/100+"</font>";
			 						}},
			 					{field:'unpaidFee',title:'未付金额',sortable:true,
		 							formatter:function(value,row,index){
			 							return "<font style='font-weight:bold;'>￥"+value/100+"</font>";
			 						}},
			 					{field:'discount',title:'未付金额',sortable:true,
		 							formatter:function(value,row,index){
			 							return "<font style='font-weight:bold;'>￥"+value/100+"</font>";
			 						}},
			 					{field:'discountFee',title:'折扣金额',sortable:true,
		 							formatter:function(value,row,index){
			 							return "<font style='font-weight:bold;'>￥"+value/100+"</font>";
			 						}},
			 					{field:'paidTime',title:'消费时间',sortable:true},
			 	]],
				toolbar:[
//					{id:'btnadd',text:'添加',btnType:'add'},
//					{id:'btnedit',text:'修改',btnType:'edit'},
//					{id:'btndelete',text:'删除',btnType:'remove'}
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
	app.chargeRecord.init();
});		