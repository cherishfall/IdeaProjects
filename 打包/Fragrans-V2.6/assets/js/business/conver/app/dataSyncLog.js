$package('app.dataSyncLog');
app.dataSyncLog = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'syncTitle',title:'同步标题，如停车场基础数据同步',sortable:true},
			 					{field:'syncId',title:'最后同步对象标示 ',sortable:true},
			 					{field:'result',title:'0：成功（不需要同步）1：成功（已同步）2：失败 ',sortable:true},
			 					{field:'createTime',title:'记录创建时间',sortable:true}
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
	app.dataSyncLog.init();
});		