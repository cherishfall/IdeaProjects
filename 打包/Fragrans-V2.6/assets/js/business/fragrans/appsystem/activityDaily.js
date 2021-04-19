$package('stat.activityDaily');
stat.activityDaily = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			queryParams:{
	   				dayTime : getNowDay(),
	   			},
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'dayTime',title:'日期',sortable:true},
			 					{field:'activityCountLogin',title:'日活跃（登录用户）',sortable:true},
			 					{field:'activityCountTotal',title:'日活跃（登录/非登录）',sortable:true},
			 					{field:'newRegisterCount',title:'新增注册用户数',sortable:true},
			 					{field:'newAccessCount',title:'新增访问用户数',sortable:true},
			 					{field:'nextDayStillUseCount',title:'新增次日使用数',sortable:true},
			 					{field:'startupCount',title:'启动次数',sortable:true},
			 					{field:'downloadCountAndroid',title:'安卓下载量',sortable:true},
			 					{field:'downloadCountIos',title:'ios下载量',sortable:true},
			 					{field:'downloadCountAll',title:'总下载量',sortable:true}
			 	]],
				toolbar:[
//					{id:'btnadd',text:'添加',btnType:'add'},
//					{id:'btnedit',text:'修改',btnType:'edit'},
//					{id:'btndelete',text:'删除',btnType:'remove'}
				]
			}
		},
		init:function(){
			$('#dayTime').datebox('setValue', getNowDay());
			_box = new YDataGrid(_this.config); 
			_box.init();
		}
	}
	return _this;
}();

$(function(){
	stat.activityDaily.init();
});		