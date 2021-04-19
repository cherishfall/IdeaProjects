$package('sys.appIntfVersion');
sys.appIntfVersion = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'接口版本信息表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
						{field:'id',checkbox:true},
						{field:'areaName',title:'城市',width:80,sortable:true},
						{field:'intfType',title:'接口类型',width:100,sortable:true,
							formatter : function(value, row, index) {
							if (value == 1) {
								return "APP接口";
							}
							if (value == 2) {
								return "spms接口";
							}
							}	
						},
						{field:'intfServiceName',title:'接口服务名',width:220,sortable:true},
						{field:'intfVersion',title:'接口版本',width:80,sortable:true},
						{field:'intfVersionName',title:'接口版本名称',width:250,sortable:true},
						{field:'remark',title:'备注',width:100,sortable:true},
						{field:'createBy',title:'创建人',width:100,sortable:true},
						{field:'updateBy',title:'更新人',width:100,sortable:true}
						/*{field:'flag',title:'标识',width:100,sortable:true},
						{field:'updateTime',title:'更新时间',width:200,sortable:true},
						{field:'createTime',title:'创建时间',width:200,sortable:true}*/
				]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add',handler : function() { add(); }},
					{id:'btnedit',text:'修改',btnType:'edit'},
					{id:'btndelete',text:'删除',btnType:'remove',}
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
	sys.appIntfVersion.init();
	//加载城市复选框数据
	$('#areaAdd').combotree({
		url:'getCity.do',
		fit : true,
		idField : 'id',
		panelHeight : '200',
		treeField : 'text',
		parentField : 'parentId',
		multiple : false
	});
});
/*$(function(){
	$('#serviceAdd').combobox({
		mode:'remote',
		url:'getServiceName.do',
		valueField:'id',
		textField:'text'
	});
});*/
function add(){
 
	var combos = $("#editForm .easyui-combobox");
	$.each(combos,function(i,combo){
		var id = '#'+combo.id;
		$(id).combobox('reset');
	})
	$('#edit-win').dialog('open');
	$('#editForm').form('clear');
	
}


