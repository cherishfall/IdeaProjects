$package('sys.serviceHandle');
sys.serviceHandle = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				idField : 'id',
  				title:'接口列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
						{field:'id',checkbox:true},
						{field:'name',title:'接口名称',width:100,sortable:true},
						{field:'service',title:'接口服务名称',width:100,sortable:true},	
						{field:'data',title:'接口数据',width:100,sortable:true},
						{field:'dataDesc',title:'数据描述',width:100,sortable:true}
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
	sys.serviceHandle.init();
	
});	

function add(){
	var combos = $("#editForm .easyui-combobox");
	$.each(combos,function(i,combo){
		var id = '#'+combo.id;
		$(id).combobox('reset');
	})
	$('#edit-win').dialog('open');
	
	$('#editForm').form('clear');
}


