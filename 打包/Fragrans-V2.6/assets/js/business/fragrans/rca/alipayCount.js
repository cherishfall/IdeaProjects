$package('rca.alipayCount');
rca.alipayCount = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'statdate',title:'账单日期(YYYY-MM-DD)',sortable:true},
			 					{field:'totalOrderCount',title:'总交易单数，支付宝原始账单数量',sortable:true},
			 					{field:'totalIncomeCount',title:'总收入额',sortable:true},
			 					{field:'totalOutcomeCount',title:'总支出额',sortable:true},
			 					{field:'totalServiceFee',title:'手续费总金额',sortable:true},
			 					{field:'createTime',title:'创建时间',sortable:true}
			 	]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add'},
					{id:'btnedit',text:'修改',btnType:'edit'},
					{id:'btndelete',text:'删除',btnType:'remove'}
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
	rca.alipayCount.init();
});		