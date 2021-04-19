$package('stat.userActionDaily');
stat.userActionDaily = function(){
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
	 					{field:'dayTime',title:'统计日期',sortable:true,
							formatter:function(value,row,index){
								return value=value.split(" ")[0];
							}},
			 					{field:'deviceNo',title:'设备号',sortable:true},
			 					{field:'userAccount',title:'用户账号',sortable:true},
			 					{field:'personalInfoCount',title:'个人信息功能使用次数',sortable:true},
			 					{field:'walletCount',title:'电子钱包功能使用次数',sortable:true},
			 					{field:'bookCount',title:'预约功能使用次数',sortable:true},
			 					{field:'messageCount',title:'消息功能使用次数',sortable:true},
			 					{field:'setCount',title:'设置功能使用次数',sortable:true},
			 					{field:'searchCount',title:'搜索功能使用次数',sortable:true},
			 					{field:'payCount',title:'缴费次数',sortable:true},
			 					{field:'createTime',title:'创建时间',sortable:true}
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
	stat.userActionDaily.init();
});		