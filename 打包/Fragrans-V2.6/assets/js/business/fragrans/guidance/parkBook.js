$package('app.parkBook');
app.parkBook = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
						{field:'name',title:'停车点名称',sortable:true},
			 					{field:'cityName',title:'城市编码',sortable:true},
			 					{field:'parkCode',title:'停车点编码',sortable:true},
			 					{field:'bookRate',title:'预约费(单位：分)',sortable:true},
			 					{field:'dataFrom',title:'数据来源',sortable:true},
			 					{field:'remark',title:'备注',sortable:true}
			 	]],
				toolbar:[
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
	app.parkBook.init();
});		