$package('app.providerConnect');
app.providerConnect = function(){
	var _box = null;
	var _this = {
		config:{
			event:{
				save:function(){
					 var notifyUrl = $('#notifyUrl').val();
					 if(notifyUrl==''){
						 $.messager.alert('提示','通知地址不能为空');  
						 return;
					 }
					 var providerKey = $('#providerKey').val();
					 if(providerKey==''){
						 $.messager.alert('提示','商户密钥不能为空');  
						 return;
					 }
					 var alipayPublic = $('#alipayPublic').val();
					 if(alipayPublic==''){
						 $.messager.alert('提示','商户公钥不能为空');  
						 return;
					 }
					 var alipayPrivate = $('#alipayPrivate').val();
					 if(alipayPrivate==''){
						 $.messager.alert('提示','商户私钥不能为空');  
						 return;
					 }
					_box.handler.save();
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
								{field:'providerName',title:'商户名称',sortable:true},
			 					{field:'payment',title:'支付方式',sortable:true,formatter:sys.dicts.text('PAY_ACCOUNT_TYPE')},
			 					{field:'sellerAccount',title:'卖家收款账号',sortable:true},
			 					{field:'isUsed',title:'是否启用',sortable:true,formatter:sys.dicts.text('YESORNO')},
			 					{field:'isDefault',title:'是否系统默认',sortable:true,formatter:sys.dicts.text('IS_DEFAULT')},
			 					{field:'validityDate',title:'接入有效期',sortable:true},
			 					{field:'notifyUrl',title:'通知地址',sortable:true}
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
	app.providerConnect.init();
	$('#providerNo').combobox({
		title:'列表',
		url:'getProviderNo.do',
		panelHeight : '200',
		valueField:'providerNo',    
	    textField:'providerName'   
	});
});		