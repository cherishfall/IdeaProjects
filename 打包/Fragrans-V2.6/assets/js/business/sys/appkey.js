$package('base.appkey');
base.appkey = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
						{field:'id',checkbox:true},
	 					{field:'appId',title:'应用编号',sortable:true},
	 					{field:'appKey',title:'应用密钥值',sortable:true},
	 					{field:'appName',title:'应用名称',sortable:true},
	 					{field:'appDesc',title:'应用描述',sortable:true},
	 					{field:'createTime',title:'创建时间',sortable:true},
	 					{field:'creator',title:'创建人',sortable:true},
	 					{field:'state',title:'状态',align:'center',sortable:true,styler:function(value,row,index){
							if(value == 1){
							  return 'color:red;';  
							}
						},
						formatter : sys.dicts.text('STATE')
						}	
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
	base.appkey.init();
});		