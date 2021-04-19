$package('app.flowData');
app.flowData = function(){
	var _box = null;
	var _this = {
		config:{
			event : {
				search : function() { //条件查询验证
					var startEventTime = $('#startEventTime').datebox('getValue');
					var endEventTime = $('#endEventTime').datebox('getValue');
					if (startEventTime > endEventTime) {
						sys.alert('警告', '起始时间大于结束时间.', 'warning');
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
	   			columns:[[
						{field:'id',checkbox:true},
	 					{field:'parkCode',title:'停车点编码',sortable:true},
	 					{field:'parkName',title:'停车点名称',sortable:true},
	 					{field:'accessId',title:'接入商ID',hidden:true},
	 					{field:'companyName',title:'接入商',sortable:true},
	 					{field:'berthNumTotal',title:'总泊位数',sortable:true},
	 					{field:'berthNumIdle',title:'空闲泊位数 ',sortable:true},
	 					{field:'inOutFlag',title:'车辆进出标识',sortable:true,formatter:sys.dicts.text('VEHICLE_STATISTICS')},
	 					{field:'plateNo',title:'车牌号',sortable:true},
	 					{field:'passageNo',title:'通道号',sortable:true},
	 					{field:'eventTime',title:'事件发生时间',sortable:true},
	 					{field:'createTime',title:'记录创建时间',sortable:true}
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
	app.flowData.init();
	
	//时间格式 化
	$('#startEventTime').datebox().datebox('calendar').calendar({
		validator: function(date){
			var now = new Date();
			var c_date = new Date(now.getFullYear(), now.getMonth(), now.getDate());
			return c_date>=date;
		}
	});
	
	$('#endEventTime').datebox().datebox('calendar').calendar({
		validator: function(date){
			var now = new Date();
			var c_date = new Date(now.getFullYear(), now.getMonth(), now.getDate());
			return c_date>=date;
		}
	});
	// 默认时间
	formatterDate = function(date) {
		var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
		var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
		+ (date.getMonth() + 1);
		return date.getFullYear() + '-' + month + '-' + day;
	};
	$('#startEventTime').datebox('setValue', formatterDate(new Date()));
	$('#endEventTime').datebox('setValue', formatterDate(new Date()));
	
});		