$package('fanc.orderSpms');
fanc.orderSpms = function(){
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
	 					{field:'cityName',title:'城市',sortable:true},
	 					{field:'parkId',title:'停车点ID',sortable:true},
			 					{field:'orderNo',title:'交易订单编号',sortable:true},
			 					{field:'parkrecordId',title:'停车记录id',sortable:true},
			 					{field:'plateNo',title:'车牌号码',sortable:true},
			 					{field:'payType',title:'支付方式',sortable:true,formatter:sys.dicts.text('payMent')},
			 					{field:'orderType',title:'订单类型',sortable:true,formatter:sys.dicts.text('ORDER_TYPE')},
			 					{field:'price',title:'支付金额(仅限APP上支付的)',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font>￥"+value/100+"</font>";
			 						}},
			 					{field:'refundNo',title:'退款编码',sortable:true},
			 					{field:'refundFee',title:'退款费用',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font>￥"+value/100+"</font>";
			 						}},
			 					{field:'berthCode',title:'泊位编号',sortable:true},
			 					{field:'parkName',title:'停车点名称',sortable:true},
			 					{field:'parkDurations',title:'停车时长',sortable:true},
			 					{field:'arriveTime',title:'驶入时间',sortable:true},
			 					{field:'departureTime',title:'驶离时间',sortable:true}
			 	]],
				toolbar:[
//					{id:'btnadd',text:'添加',btnType:'add'},
//					{id:'btnedit',text:'修改',btnType:'edit'},
//					{id:'btndelete',text:'删除',btnType:'remove'}
					{id:'btnExport',text:'导出账单',btnType:'export',iconCls:"ext-icon-page_excel",
						handler : function() {
							$('#exportOrderNomalListForm').form('reset');
							exportOrderNomalList();
						}},
					{id:'btnOrder',text:'spms账单获取',btnType:'order',iconCls:"ext-icon-table_save",
						handler : function() {
							$('#orderSpmsListForm').form('reset');
							orderSpmsList();
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
	fanc.orderSpms.init();
	
	// 导出
	$('#exportOrderNomalList').dialog({
		buttons : [ {
			text : '导出',
			handler : function() {
				var param = $('#exportOrderNomalListForm').serializeObject();
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
						window.open('exportOrderSpmsList.do?startDate=' + startDate
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
	
	// 获取账单
	$('#orderSpmsList').dialog({
		buttons : [ {
			text : '获取',
			handler : function() {
				var param = $('#orderSpmsListForm').serializeObject();
				var statdate = param.statDate;
				var cityCode = param.cityCode;
				if(statdate==''){
					$.messager.alert('提示','请选择账单日期');
					return;
				}
				if (statdate > getNowDayMorning()) {
					sys.alert('提示', '该日期账单目前无法获取');
					return;		
				}
				if(cityCode==''){
					$.messager.alert('提示','请选择城市');
					return;
				}
				$.messager.confirm('确认', '确认重新获取'+statdate+'spms账单？', function(r) {
					if (r) {
						$.messager.progress({
				            title:'请稍后',
				            msg:'正在获取spms账单...'
						});
						$.ajax({
							url : 'getOrderSpms.do',
							type : 'post',
							data : 
							{
								statDate:statdate,
								cityCode:cityCode,
							},
							success : function(result) {
								$.messager.progress('close');
								$.messager.show({
									title : '提示',
									msg : result.msg
								});
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

function exportOrderNomalList() {
	$('#exportOrderNomalList').dialog('open');
}

function orderSpmsList() {
	$('#orderSpmsList').dialog('open');
}