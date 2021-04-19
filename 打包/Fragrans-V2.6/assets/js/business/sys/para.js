$package('sys.para');
sys.para = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
						{field:'id',checkbox:true},
	 					{field:'paraName',title:'参数关键字',width:120,sortable:true},
	 					{field:'paraValue',title:'参数值',width:120,sortable:true},
	 					{field:'paraDesc',title:'参数描述',width:170,sortable:true,
	 						formatter: function(value,row,index){
  			     				if (value!=null&&value.length > 12){
  			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
  			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,12)+'...</span>';
  			     				}else{
  			     					return value;
  			     				}
  			     		    }},
	 					{field:'paraType',title:'参数类别',width:120,sortable:true,formatter : sys.dicts.text('PARA_TYPE')},
	 					{field:'state',title:'参数状态',width:50,align:'center',sortable:true,styler:function(value,row,index){
							if(value == 1){
							  return 'color:red;';  
							}
						},
						formatter : sys.dicts.text('STATE')
						},
						{field:'createdBy',title:'创建人',width:80,sortable:true},
						{field:'updatedBy',title:'修改人',width:80,sortable:true},
						{field:'createTime',title:'创建时间',width:100,sortable:true}
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
	sys.para.init();
});		