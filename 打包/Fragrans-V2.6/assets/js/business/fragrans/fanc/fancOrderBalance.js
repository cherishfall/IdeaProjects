$package('fanc.fancOrderBalance');
fanc.orderBalance = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			queryParams:{
	   				statDate : getYesterDayMorning(),
	   			},
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'statDate',title:'账单日期',sortable:true,formatter:function(value,row,index){
								return value.split(" ")[0];
						}},
			 					{field:'cityCode',title:'城市代码',sortable:true,hidden:true},
			 					{field:'cityName',title:'城市',sortable:true},
			 					{field:'areaCode',title:'区级代码',sortable:true,hidden:true},
			 					{field:'orderNo',title:'交易订单编号',sortable:true},
			 					{field:'isBalance',title:'是否平账',sortable:true,formatter:sys.dicts.text('IS_BALANCE')},
			 					{field:'exceptionType',title:'异常类型',sortable:true,formatter:sys.dicts.text('EXCEPTION_TYPE')},
			 					{field:'parkId',title:'停车点ID',sortable:true,hidden:true},
			 					{field:'parkrecordId',title:'停车记录id',sortable:true,hidden:true},
			 					{field:'plateNo',title:'车牌号码',sortable:true},
			 					{field:'payType',title:'支付方式',sortable:true,formatter:sys.dicts.text('payMent')},
			 					{field:'orderType',title:'订单类型',sortable:true,formatter:sys.dicts.text('ORDER_TYPE')},
			 					{field:'price',title:'支付金额(单位：元)',sortable:true,formatter:function(value,row,index){
		 							return "<font>￥"+value/100+"</font>";
		 						}},
			 					{field:'refundNo',title:'退款编码',sortable:true},
			 					{field:'refundFee',title:'退款费用(单位：元)',sortable:true,formatter:function(value,row,index){
		 							return "<font>￥"+value/100+"</font>";
		 						}},
			 					{field:'berthCode',title:'泊位编号',sortable:true,hidden:true},
			 					{field:'parkName',title:'停车点名称',sortable:true},
			 					{field:'parkDurations',title:'停车时长',sortable:true},
			 					{field:'arriveTime',title:'驶入时间',sortable:true},
			 					{field:'departureTime',title:'驶离时间',sortable:true},
			 					{field:'parkType',title:'停车点类型',sortable:true,formatter:sys.dicts.text('PARK_MODEL')},
			 					{field:'subject',title:'订单标题',sortable:true},
			 					{field:'orderBody',title:'订单描述',sortable:true},
			 					{field:'exceptionDesc',title:'异常描述',sortable:true}
			 	]],
				toolbar:[
//					{id:'btnadd',text:'添加',btnType:'add'},
//					{id:'btnedit',text:'修改',btnType:'edit'},
//					{id:'btndelete',text:'删除',btnType:'remove'}
					{id:'btnExport',text:'导出账单',btnType:'export',iconCls:"ext-icon-page_excel",
						handler : function() {
							$('#exportfancOrderBalanceListForm').form('reset');
							exportfancOrderBalanceList();
						}},					
					{id:'btnOrder',text:'账单比对',btnType:'order',iconCls:"ext-icon-table_save",
						handler : function() {
							$('#orderSpmsListForm').form('reset');
							orderSpmsList();
						}}
				]
			}
		},
		init:function(){
			$('#statDate').datebox('setValue', getYesterDayMorning());
			_box = new YDataGrid(_this.config); 
			_box.init();
		}
	}
	return _this;
}();

$(function(){
	fanc.orderBalance.init();
	
	// 导出
	$('#exportfancOrderBalanceList').dialog({
		buttons : [ {
			text : '导出',
			handler : function() {
				var param = $('#exportfancOrderBalanceListForm').serializeObject();
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
						window.open('exportFancOrderSpmsList.do?startDate=' + startDate
								+ '&endDate=' + endDate + '&cityId=' + cityId);
					}
				});
				$('#exportfancOrderBalanceList').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#exportfancOrderBalanceList').dialog('close');
			}
		} ]
	});
	
	// 账单比对
	$('#orderSpmsList').dialog({
		buttons : [ {
			text : '比对',
			handler : function() {
				var param = $('#orderSpmsListForm').serializeObject();
				var statdate = param.statDate;
				//验证导出日报时间
				if(statdate == null || statdate == '' || statdate == undefined){
					$.messager.show({
						title : '提示',
						msg : '请选择账单日期'
					});
					return;
				}
				$.messager.confirm('确认', '确认重新比对'+statdate+'第三方支付、spms账单？', function(r) {
					if (r) {
						$.messager.progress({
				            title:'请稍后',
				            msg:'正在比对第三方支付、spms账单...'
						});
						$.ajax({
							url : 'getOrderBalance.do',
							type : 'post',
							data : 
							{
								statDate:statdate
							},
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
				$('#orderSpmsList').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#orderSpmsList').dialog('close');
			}
		} ]
	});
});		

function exportfancOrderBalanceList() {
	$('#exportfancOrderBalanceList').dialog('open');
}

function orderSpmsList() {
	$('#orderSpmsList').dialog('open');
}