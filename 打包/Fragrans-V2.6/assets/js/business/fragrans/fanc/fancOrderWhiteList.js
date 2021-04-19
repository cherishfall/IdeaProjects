$package('fanc.fancOrderWhiteList');
fanc.orderWhiteList = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'whiteType',title:'白名单类型',sortable:true,formatter:sys.dicts.text('WHITE_TYPE')},
	 					{field:'whiteValue',title:'白名单值',sortable:true},
	 					{field:'isEnabled',title:'是否有效',sortable:true,formatter:sys.dicts.text('IS_VALID')}
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
	fanc.orderWhiteList.init();
});		