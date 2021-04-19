$package('app.userExt');
app.userExt = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'userId',title:'用户ID，关联APP_USER',sortable:true},
			 					{field:'nickName',title:'用户昵称',sortable:true},
			 					{field:'cityCode',title:'注册城市代码',sortable:true},
			 					{field:'email',title:'邮箱地址',sortable:true},
			 					{field:'isEmailActivated',title:'邮箱是否已激活 0:未激活, 1:已激活',sortable:true},
			 					{field:'photoUrl',title:'',sortable:true},
			 					{field:'address',title:'',sortable:true},
			 					{field:'remark',title:'',sortable:true},
			 					{field:'flag',title:'操作标示 ADD：增加 UPDATE:修改 DELETE:删除',sortable:true},
			 					{field:'createTime',title:'创建时间,默认SYSDATE',sortable:true},
			 					{field:'updateTime',title:'更新时间,默认SYSDATE',sortable:true},
			 					{field:'attribute1',title:'保留字段1',sortable:true},
			 					{field:'attribute2',title:'保留字段2',sortable:true},
			 					{field:'attribute3',title:'保留字段3',sortable:true},
			 					{field:'attribute4',title:'保留字段4',sortable:true},
			 					{field:'attribute5',title:'保留字段5',sortable:true}
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
	app.userExt.init();
});		