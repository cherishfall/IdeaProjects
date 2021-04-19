$package('app.invoiceOrder');
app.invoiceOrder = function(){
	var _box = null;
	var _this = {
		config:{
			event : {
				search : function() { //条件查询验证
					var startEventTime = $('#startTime').datetimebox('getValue');
					var endEventTime = $('#endTime').datetimebox('getValue');
					if (startEventTime > endEventTime) {
						sys.alert('警告', '起始时间大于结束时间.', 'warning');
						return;
					}
					var start  = new Date(startEventTime.replace(/-/g,"/")).getTime();
					var end = new Date(endEventTime.replace(/-/g,"/")).getTime();
					var endDate = new Date(end);
					var startLon = endDate.setMonth(endDate.getMonth()-3);
					//alert(formatDateToStr(startLon));
					if(start < startLon){
						sys.alert('警告', '起始时间和结束时间之差大于3个月.', 'warning');
						return;
					} 
					var Grid = $('#data-list');
					var Form = {
					  search: $("#searchForm")
					};
					var param = Form.search.serializeObject();
					Grid.datagrid('reload',param);
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			queryParams:{
	            	startTime :new Date().pattern("yyyy-MM-dd 00:00:00") ,
	            	endTime : new Date().pattern("yyyy-MM-dd HH:mm:ss")
	   			},
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						        {field:'id',checkbox:true},
	 					        /*{field:'cityCode',title:'城市代码',sortable:true},*/
			 					{field:'cityName',title:'城市名称',sortable:true},
			 					/*{field:'areaCode',title:'区级代码',sortable:true},*/
			 					{field:'areaName',title:'区域名称',sortable:true},
			 					{field:'plateNo',title:'车牌号',sortable:true},
			 					{field:'plateColor',title:'车牌颜色',sortable:true},
			 					{field:'userId',title:'用户ID',sortable:true},
			 					{field:'userAccount',title:'用户账号',sortable:true},
			 					{field:'buyerAccount',title:'买家账号',sortable:true},
			 					{field:'mobile',title:'手机号码',sortable:true},
			 					{field:'orderNo',title:'交易订单编号(唯一)',sortable:true},
			 					{field:'parkrecordId',title:'停车记录ID',sortable:true},
			 					{field:'payType',title:'支付方式',sortable:true,formatter:sys.dicts.text('PAY_METHOD')},
			 					{field:'payFee',title:'实际支付金额',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
			 						}
			 					},
			 					{field:'subject',title:'订单标题',sortable:true},
			 					{field:'orderBody',title:'订单描述',sortable:true},
			 					{field:'orderTime',title:'订单时间',sortable:true},
			 					{field:'payTime',title:'支付时间',sortable:true},
			 					{field:'createTime',title:'记录创建时间',sortable:true},
			 					{field:'syncTime',title:'记录同步时间',sortable:true},
			 					{field:'invoiceTime',title:'开票时间',sortable:true},
			 					{field:'invoiceState',title:'开票状态',sortable:true},
			 					{field:'orderType',title:'订单类型',sortable:true},
			 					{field:'orderSource',title:'订单来源',sortable:true}
			 					/*{field:'monthStart',title:'包月开始时间',sortable:true},
			 					{field:'monthEnd',title:'包月结束时间',sortable:true}
			 					{field:'reserve1',title:'保留字段1',sortable:true},
			 					{field:'reserve2',title:'保留字段2',sortable:true},
			 					{field:'reserve3',title:'保留字段3',sortable:true}*/
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
	app.invoiceOrder.init();
	var date = new Date();
	$('#endTime').datetimebox('setValue',date.pattern("yyyy-MM-dd HH:mm:ss"));
	$('#startTime').datetimebox('setValue',date.pattern("yyyy-MM-dd 00:00:00"));
});		