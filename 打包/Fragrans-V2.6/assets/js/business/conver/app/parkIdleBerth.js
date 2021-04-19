$package('app.parkIdleBerth');
app.parkIdleBerth = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
	   			            {field:'id',checkbox:true},
		 					{field:'accessId',title:'接入商编号',sortable:true},
		 					{field:'companyName',title:'接入商名称',sortable:true},
		 					{field:'parkCode',title:'停车点(场)编号',sortable:true},
		 					{field:'parkName',title:'停车点(场)名称',sortable:true},
		 					{field:'berthNumTotal',title:'总泊位数',sortable:true},
		 					{field:'idleBerthCount',title:'空闲泊位数',sortable:true},
		 					{field:'updateTime',title:'更新时间',sortable:true}
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
	app.parkIdleBerth.init();
});		