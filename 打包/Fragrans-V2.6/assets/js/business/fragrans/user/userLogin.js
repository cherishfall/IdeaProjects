$package('app.userLogin');
app.userLogin = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
	   			           		{field:'id',checkbox:true},
			 					{field:'userAccount',title:'用户账号',sortable:true},
			 					{field:'deviceNo',title:'客户端设备号',sortable:true},
			 					{field:'clientVersion',title:'客户端版本',sortable:true},
			 					{field:'status',title:'应用状态',sortable:true,formatter:sys.dicts.text('USER_LOGIN_STATUS')},
			 					{field:'errCount',title:'密码错误次数',sortable:true},
			 					{field:'loginCount',title:'登录次数',sortable:true},
			 					{field:'lastLoginTime',title:'最后登录时间',sortable:true},
			 					{field:'lastErrTime',title:'最后一次错误时间',sortable:true}
			 	]],
				toolbar:[
//					{id:'btnadd',text:'添加',btnType:'add'},
//					{id:'btnedit',text:'修改',btnType:'edit'},
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
	app.userLogin.init();
});		