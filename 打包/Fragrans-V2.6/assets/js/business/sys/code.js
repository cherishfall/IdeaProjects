$package('base.code');
base.code = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
						{field:'id',checkbox:true},
//	 					{field:'cityCode',title:'城市编码',sortable:true},
			 					{field:'codeType',title:'编码类型',sortable:true},
			 					{field:'prefix',title:'前缀',sortable:true},
			 					{field:'maxCode',title:'最大编号',sortable:true},
			 					{field:'maxLen',title:'最大长度',sortable:true}
			 	]],
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
	base.code.init();
});		