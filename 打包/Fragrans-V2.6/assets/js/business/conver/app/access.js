$package('app.access');
app.access = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
						{field:'id',checkbox:true},
	 					{field:'companyId',title:'接入商编号',sortable:true},
			 					{field:'accessKey',title:'接入密钥',sortable:true},
			 					{field:'accessType',title:'接入类型',sortable:true,formatter:sys.dicts.text('ACCESS_TYPE')},
			 					{field:'accessPoint',title:'接入点',sortable:true,formatter:sys.dicts.text('ACCESS_POINT')},
			 					{field:'companyName',title:'接入商名称',sortable:true},
			 					{field:'companyDesc',title:'接入商描述',sortable:true},
			 					{field:'contacts',title:'联系人姓名',sortable:true},
			 					{field:'phone',title:'联系电话',sortable:true},
			 					{field:'state',title:'状态',sortable:true,formatter:sys.dicts.text('ACCESS_STATE')},
			 					{field:'creator',title:'创建人',hidden:true},
			 					{field:'createTime',title:'创建时间',hidden:true},
			 					{field:'updateTime',title:'更新时间',sortable:true},
			 					{field:'remark',title:'备注',hidden:true}
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
	app.access.init();
});		