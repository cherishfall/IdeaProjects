$package('app.userCaptcha');
app.userCaptcha = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
						{field:'id',checkbox:true},
	 					{field:'account',title:'用户手机号码',sortable:true},
			 			{field:'captcha',title:'验证码',sortable:true},
			 			{field:'reason',title:'发送验证码原因',sortable:true,formatter:sys.dicts.text('REASON')},
	 					{field:'expiredTime',title:'过期时间',sortable:true},
	 					{field : 'lastValidTime',title : '最后发送有效时间',sortable:true},
						{field : 'count',title : '验证码生成次数',sortable:true}
			 	]],
				toolbar:[
//					{id:'btnadd',text:'添加',btnType:'add'},
//					{id:'btnedit',text:'修改',btnType:'edit'},
//					{id:'btndelete',text:'删除',btnType:'remove'}
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
	app.userCaptcha.init();
});		