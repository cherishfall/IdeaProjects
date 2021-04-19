$package('app.orderMiddleware');
app.orderMiddleware = function(){
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
							}},
 						{field:'orderNo',title:'交易订单编号',sortable:true},
			 					{field:'cityName',title:'城市名称',sortable:true},
			 					{field:'areaName',title:'区级名称',sortable:true},
			 					{field:'payType',title:'支付方式',sortable:true,formatter:sys.dicts.text('payType')},
			 					{field:'userAccount',title:'用户账号',sortable:true},
			 					{field:'parkrecordId',title:'停车记录id',sortable:true},
			 					{field:'price',title:'订单金额',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font>￥"+value/100+"</font>";
			 						}},
		 						{field:'orderTime',title:'订单时间',sortable:true},
								{field:'payTime',title:'支付时间',sortable:true},
			 					{field:'subject',title:'订单标题',sortable:true},
			 					{field:'orderBody',title:'订单描述',sortable:true},
			 					{field:'buyerAccount',title:'买家账号',sortable:true},
			 					{field:'orderStatus',title:'订单状态码',sortable:true,formatter:sys.dicts.text('ORDER_STATUS')},
			 					{field:'notifyStatus',title:'通知状态',sortable:true,formatter:sys.dicts.text('NOTIFY_STATUS')},
			 					{field:'notifyTime',title:'最后一次通知时间',sortable:true},
			 	]],
				toolbar:[
//					{id:'btnadd',text:'添加',btnType:'add'},
//					{id:'btnedit',text:'修改',btnType:'edit'},
//					{id:'btndelete',text:'删除',btnType:'remove'}
					{id:'btnExport',text:'导出账单',btnType:'export',iconCls:"ext-icon-page_excel",
						handler : function() {
							$('#exportOrderMiddlewareListForm').form('reset');
							exportOrderMiddlewareList();
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
	app.orderMiddleware.init();
	
	// 导出
	$('#exportOrderMiddlewareList').dialog({
		buttons : [ {
			text : '导出',
			handler : function() {
				var param = $('#exportOrderMiddlewareListForm').serializeObject();
				var startDate = param.startDate;
				var endDate = param.endDate;
				var cityId = param.cityId;
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
						window.open('exportOrderMiddlewareList.do?startDate=' + startDate
								+ '&endDate=' + endDate + '&cityId=' + cityId);
					}
				});
				$('#exportOrderMiddlewareList').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#exportOrderMiddlewareList').dialog('close');
			}
		} ]
	});
});	

function exportOrderMiddlewareList() {
	$('#exportOrderMiddlewareList').dialog('open');
}