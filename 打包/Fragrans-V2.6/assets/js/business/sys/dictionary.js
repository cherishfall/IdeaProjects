$package('sys.dictionary');
sys.dictionary = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				idField : 'id',
  				title:'数据字典列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
						{field:'id',checkbox:true},
						{field:'codeTypeDesc',title:'信息名称',width:100,sortable:true},
						{field:'codeType',title:'信息类型',width:100,sortable:true},
						{field:'codeValue',title:'信息值',width:50,sortable:true},
						{field:'codeText',title:'信息描述',width:100,sortable:true},
						{field:'orderNum',title:'排序号',width:50,sortable:true},
						{field:'isDefault',title:'是否默认',width:50,sortable:true,formatter : sys.dicts.text('IS_DEFAULT')},
						{field:'state',title:'状态',width:80,align:'center',sortable:true,styler:function(value,row,index){
							if(value == 1){
							  return 'color:red;';  
							}
						},
						formatter : sys.dicts.text('STATE')
						}						
				]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add',handler : function() { add(); }},
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
	sys.dictionary.init();
	
});	

function add(){
 
	var combos = $("#editForm .easyui-combobox");
	$.each(combos,function(i,combo){
		var id = '#'+combo.id;
		$(id).combobox('reset');
	})
	$('#edit-win').dialog('open');
	$('#editForm').form('clear');
	//设置下啦默认值
	$('#state').combobox('setValue',0);
	$('#isCommon').combobox('setValue',1);
	 
	
}


