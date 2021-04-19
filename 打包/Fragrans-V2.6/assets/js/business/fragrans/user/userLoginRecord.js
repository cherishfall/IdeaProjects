$package('app.userLoginRecord');
app.userLoginRecord = function(){
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
			 					{field:'deviceModel',title:'手机型号',sortable:true},
			 					{field:'deviceOsVersion',title:'OS版本',sortable:true},
			 					{field:'longitudeGD',title:'高德经度',sortable:true},
			 					{field:'latitudeGD',title:'高德纬度',sortable:true},
			 					{field:'type',title:'操作类型',sortable:true,formatter:sys.dicts.text('USER_LOGIN_TYPE')},
			 					{field:'status',title:'结果状态 ',sortable:true,formatter:sys.dicts.text('USER_LOGIN_RECORD_STATUS')},
			 					{field:'description',title:'登录退出结果',sortable:true},
			 					{field:'createTime',title:'创建时间',sortable:true}
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
	app.userLoginRecord.init();
});		