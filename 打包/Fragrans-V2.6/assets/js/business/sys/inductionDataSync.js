$package('sys.inductionDataSync');
sys.inductionDataSync = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'诱导数据同步',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
						{field:'id',checkbox:true},
						{field:'areaCode',title:'区域编码',width:80,sortable:true},
						{field:'areaName',title:'区域名称',width:80,sortable:true},
						{field:'appId',title:'设备ID',width:80,sortable:true},
						{field:'appKey',title:'设备密钥',width:80,sortable:true},
						{field:'appName',title:'设备名称',width:80,sortable:true},
						{field:'expiredTime',title:'失效时间',width:80,sortable:true},
						{field:'appStatus',title:'设备状态',width:100,sortable:true,
							formatter : function(value, row, index) {
							if (value == 0) {
								return "正常";
							}
							if (value == 1) {
								return "停用";
							}
							}	
						},
						{field:'appDesc',title:'设备描述',width:80,sortable:true},
						{field:'authIp',title:'授权IP地址',width:80,sortable:true},
						{field:'syncLastUpdateTime',title:'最后同步更新时间',width:120,sortable:true},
						{field:'createBy',title:'创建人',width:80,sortable:true},
						{field:'updateBy',title:'更新人',width:100,sortable:true},
						{field:'createTime',title:'创建时间',width:100,sortable:true},
						{field:'updateTime',title:'更新时间',width:100,sortable:true},
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
/*$(function(){
	$('#serviceAdd').combobox({
		mode:'remote',
		url:'getServiceName.do',
		valueField:'id',
		textField:'text'
	});
});*/
function add(){
	$('#edit-win').dialog('open');
	$('#editForm').form('clear');
}

$(function(){
	sys.inductionDataSync.init();
});	
