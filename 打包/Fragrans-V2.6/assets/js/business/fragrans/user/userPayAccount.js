$package('app.userPayAccount');
app.userPayAccount = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
			 					{field:'payAccount',title:'支付账号',sortable:true},
			 					{field:'payAccountType',title:'支付账号类型',sortable:true,formatter:sys.dicts.text('PAY_ACCOUNT_TYPE')},
			 					{field:'createTime',title:'创建时间,默认SYSDATE',sortable:true},
			 					{field:'updateTime',title:'更新时间,默认SYSDATE',sortable:true}
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
	app.userPayAccount.init();
});		