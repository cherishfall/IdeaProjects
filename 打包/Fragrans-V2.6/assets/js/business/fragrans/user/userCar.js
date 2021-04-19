$package('app.userCar');
app.userCar = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
			 					{field:'plateNo',title:'车牌号',sortable:true},
			 					{field:'isDefault',title:'是否默认',sortable:true,formatter:sys.dicts.text('IS_DEFAULT')},
			 					{field:'note',title:'备注',sortable:true},
			 					{field:'createTime',title:'创建时间',sortable:true},
			 					{field:'updateTime',title:'更新时间',sortable:true}
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
	app.userCar.init();
});		