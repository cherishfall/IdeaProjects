$package('app.intfVersion');
app.intfVersion = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'areaCode',title:'城市',sortable:true},
			 					{field:'intfType',title:'接口类型（1APP接口；2spms接口）',sortable:true},
			 					{field:'intfServiceName',title:'接口服务名',sortable:true},
			 					{field:'intfVersion',title:'接口版本',sortable:true},
			 					{field:'intfVersionName',title:'版本接口名称',sortable:true},
			 					{field:'remark',title:'备注',sortable:true},
			 					{field:'createBy',title:'',sortable:true},
			 					{field:'updateBy',title:'',sortable:true},
			 					{field:'flag',title:'',sortable:true},
			 					{field:'updateTime',title:'',sortable:true},
			 					{field:'createTime',title:'',sortable:true}
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
	app.intfVersion.init();
});		