$package('app.orderOther');
app.orderOther = function(){
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
			 					{field:'orderType',title:'订单种类',sortable:true,formatter:sys.dicts.text('PAY_ACCOUNT_TYPE')},
			 					{field:'orderNo',title:'交易订单编号',sortable:true},
			 					{field:'transactionNo',title:'第三方订单号',sortable:true},
			 					{field:'orderTitle',title:'订单标题',sortable:true},
			 					{field:'orderFee',title:'订单金额',sortable:true},
			 					{field:'orderFeeRate',title:'订单费率',sortable:true},
			 					{field:'serviceFee',title:'订单服务费',sortable:true},
			 					{field:'payTime',title:'支付时间',sortable:true},
			 					{field:'buyerAccount',title:'买家账号',sortable:true},
			 					{field:'createTime',title:'创建时间',sortable:true}
			 	]],
				toolbar:[
//					{id:'btnadd',text:'添加',btnType:'add'},
//					{id:'btnedit',text:'修改',btnType:'edit'},
//					{id:'btndelete',text:'删除',btnType:'remove'}
					{id:'btnExport',text:'导出账单',btnType:'export',iconCls:"ext-icon-page_excel",
						handler : function() {
							$('#exportOrderOtherListForm').form('reset');
							exportOrderOtherList();
						}},
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
	app.orderOther.init();
	
	// 导出
	$('#exportOrderOtherList').dialog({
		buttons : [ {
			text : '导出',
			handler : function() {
				var param = $('#exportOrderOtherListForm').serializeObject();
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
				$.messager.confirm('确认', '确认导出符合查询条件的数据？', function(r) {
					if (r) {
						window.open('exportOrderOtherList.do?startDate=' + startDate
								+ '&endDate=' + endDate);
					}
				});
				$('#exportOrderOtherList').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#exportOrderOtherList').dialog('close');
			}
		} ]
	});
});		

function exportOrderOtherList() {
	$('#exportOrderOtherList').dialog('open');
}