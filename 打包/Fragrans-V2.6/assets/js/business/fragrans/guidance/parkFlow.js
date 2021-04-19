$package('app.parkFlow');
app.parkFlow = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
						{field:'parkName',title:'停车点名称',sortable:true},
			 					{field:'cityName',title:'所在城市',sortable:true},
			 					{field:'totalBerthNum',title:'总泊位数',sortable:true},
			 					{field:'filingBerthNum',title:'报备总泊位数',sortable:true},
			 					{field:'availableBerthNum',title:'空余泊位数',sortable:true},
			 					{field:'bookableNum',title:'可预约泊位数',sortable:true},
			 					{field:'remainBookableNum',title:'剩余可预约泊位数',sortable:true}
			 	]]
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
	app.parkFlow.init();
});		