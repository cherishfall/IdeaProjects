$package('app.flowData');
app.flowData = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'nonedataList.do',
	   			fitColumns:true,
	   			columns:[[
	 					{field:'accessId',title:'接入商ID',sortable:true},
	 					{field:'companyName',title:'接入商',sortable:true},
	 					{field:'parkCode',title:'停车点编码',sortable:true},
	 					{field:'parkName',title:'停车点名称',sortable:true},
	 					{field:'countFd',title:'记录数',sortable:true}
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
	app.flowData.init();
});		