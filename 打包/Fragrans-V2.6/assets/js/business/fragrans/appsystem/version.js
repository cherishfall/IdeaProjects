$package('app.version');
app.version = function(){
	var _box = null;
	var _this = {
		config:{
			event : {
				save:function(){
					 var versionDesc = $('#versionDesc').val();
					 if(versionDesc==''){
						 $.messager.alert('提示','版本描述不能为空');  
						 return;
					 }
					_box.handler.save();
				},
				add : function() {
					$('#editForm').form('reset');
					_box.handler.add();
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
						{field:'versionCode',title:'版本号',width:80,sortable:true},
	 					{field:'versionName',title:'版本名称',width:100,sortable:true},
			 					{field:'versionValue',title:'版本值',width:50,sortable:true},
			 					{field:'appType',title:'应用类型',width:160,sortable:true,formatter:sys.dicts.text('APP_TYPE')},
			 					{field:'status',title:'版本状态',width:80,sortable:true,formatter:sys.dicts.text('VERSION_TYPE')},
			 					{field:'isForce',title:'是否是强制版本',width:90,sortable:true,formatter:sys.dicts.text('YESORNO')},
			 					{field:'versionDesc',title:'版本描述',width:100,sortable:true},
			 					{field:'downloadUrl',title:'版本下载地址',width:180,sortable:true},
			 					{field:'resourceDownloadUrl',title:'资源包下载地址',width:180,sortable:true}
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
	app.version.init();
});		