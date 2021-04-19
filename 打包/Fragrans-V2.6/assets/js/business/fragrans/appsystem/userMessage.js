$package('app.userMessage');
app.userMessage = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'id',title:'主键ID',sortable:true},
			 					{field:'messageId',title:'消息ID',sortable:true},
			 					{field:'isRead',title:'已读标识（默认0）',sortable:true},
			 					{field:'messageType',title:'消息类型（1活动 2公告 3规则）',sortable:true},
			 					{field:'flag',title:'操作标示 ADD：增加 UPDATE:修改 DELETE:删除',sortable:true},
			 					{field:'createdBy',title:'创建人',sortable:true},
			 					{field:'updatedBy',title:'修改人',sortable:true},
			 					{field:'createTime',title:'创建时间',sortable:true},
			 					{field:'updateTime',title:'更新时间,默认SYSDATE',sortable:true}
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
	app.userMessage.init();
});		