$package('app.parkbusyConf');
app.parkbusyConf = function(){
	var _box = null;
	var _this = {
		config:{
			event : {
				add : function() {
					$('#editForm').form('reset');
					_box.handler.add();
				},
				edit : function() {
					$('#editForm').form('reset');
					_box.handler.edit();
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},	
	 					{field:'parkModel',title:'停车点类型',sortable:true,formatter:sys.dicts.text('PARK_LOT_MODE')},
			 					{field:'confType',title:'配置规则',sortable:true,formatter:sys.dicts.text('CONF_TYPE')},
			 					{field:'totalBerthMin',title:'泊位阈值下线数',sortable:true},
			 					{field:'totalBerthMax',title:'泊位阈值上线数',sortable:true},
			 					{field:'busyProc',title:'繁忙定义占比',sortable:true},
			 					{field:'busyCount',title:'繁忙阈值配置',sortable:true},
			 					{field:'busyDesc',title:'繁忙描述',sortable:true},
			 					{field:'freeDesc',title:'空闲描述',sortable:true}
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
	app.parkbusyConf.init();
});		