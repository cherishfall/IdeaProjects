$package('app.orderNomal');
app.orderNomal = function(){
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
						{field:'cityName',title:'城市名称',sortable:true},
						{field:'areaName',title:'区级名称',sortable:true},
						{field:'parkrecordId',title:'停车记录id',sortable:true},
	 					{field:'orderNo',title:'交易订单编号',sortable:true},
	 					{field:'payType',title:'支付方式',sortable:true,formatter:sys.dicts.text('payType')},
	 					{field:'userAccount',title:'用户账号',sortable:true},
	 					{field:'orderTime',title:'订单时间',sortable:true},
						{field:'payTime',title:'支付时间',sortable:true},
	 					{field:'subject',title:'订单标题',sortable:true},
	 					{field:'orderBody',title:'订单描述',sortable:true},
	 					{field:'buyerAccount',title:'买家账号',sortable:true},
	 					{field:'orderStatus',title:'订单状态',sortable:true,formatter:sys.dicts.text('ORDER_STATUS')},
	 					{field:'notifyStatus',title:'通知状态',sortable:true,formatter:sys.dicts.text('NOTIFY_STATUS')},
	 					{field:'orderFee',title:'订单金额',sortable:true},
	 					{field:'orderFeeRate',title:'订单费率',sortable:true},
	 					{field:'serviceFee',title:'订单服务费',sortable:true},
	 					{field:'createTime',title:'创建时间',sortable:true}
			 	]],
				toolbar:[
//					{id:'btnadd',text:'添加',btnType:'add'},
//					{id:'btnedit',text:'修改',btnType:'edit'},
//					{id:'btndelete',text:'删除',btnType:'remove'}
					{id:'btnExport',text:'导出账单',btnType:'export',iconCls:"ext-icon-page_excel",
						handler : function() {
							$('#exportNomalSpmsListForm').form('reset');
							exportOrderNomalList();
						}},
					{id:'btnOrder',text:'账单比对',btnType:'order',iconCls:"ext-icon-table_save",
						handler : function() {
							$('#orderMidListForm').form('reset');
							orderMidList();
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
	app.orderNomal.init();
	
	// 导出
	$('#exportOrderNomalList').dialog({
		buttons : [ {
			text : '导出',
			handler : function() {
				var param = $('#exportNomalSpmsListForm').serializeObject();
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
						window.open('exportOrderNomalList.do?startDate=' + startDate
								+ '&endDate=' + endDate + '&cityId=' + cityId);
					}
				});
				$('#exportOrderNomalList').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#exportOrderNomalList').dialog('close');
			}
		} ]
	});
	
	// 账单比对
	$('#orderMidList').dialog({
		buttons : [ {
			text : '比对',
			handler : function() {
				var param = $('#orderMidListForm').serializeObject();
				var statdate = param.statdate;
				if(statdate==''){
					$.messager.alert('提示','请选择账单日期');
					return;
				}
				if (statdate > getNowDayMorning()) {
					sys.alert('提示', '该日期账单目前无法比对');
					return;		
				}
				$.messager.confirm('确认', '确认重新比对'+statdate+'第三方支付账单？', function(r) {
					if (r) {
						$.messager.progress({
				            title:'请稍后',
				            msg:'正在比对第三方支付账单...'
						});
						$.ajax({
							url : basePath + '/rebuildOrder.do',
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
				$('#orderMidList').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#orderMidList').dialog('close');
			}
		} ]
	});
});		

function exportOrderNomalList() {
	$('#exportOrderNomalList').dialog('open');
}

function orderMidList() {
	$('#orderMidList').dialog('open');
}