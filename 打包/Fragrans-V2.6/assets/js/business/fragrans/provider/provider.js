$package('app.provider');
app.provider = function(){
	var _box = null;
	var _this = {
			allot : function() {
				var rows = $('#data-list').datagrid('getChecked');
				if (rows.length != 1) {
					$.messager.show({
						title : '提示',
						msg : '请选择一个商户.'
					});
				} else {
					$('#parkIds').combobox({
										url : '../park/loadPark.do',
										valueField : 'id',
										textField : 'name',
										multiple : true,
										width : 200,
										formatter : function(row) {
											var s = "<span><p class='selectId' style='vertical-align: middle' id='selectId_"
													+ row.id
													+ "'/>"
													+ row.name
													+ "<span>";
											return s;
										},
										onSelect : function(record) {
											$("#selectId_" + record.id).attr(
													"checked", true);
										},
										onUnselect : function(record) {
											$("#selectId_" + record.id).attr(
													"checked", false);
										}
									});
				}
			},
			area : function() {
				var rows = $('#data-list').datagrid('getChecked');
				if (rows.length != 1) {
					$.messager.show({
						title : '提示',
						msg : '请选择一个商户.'
					});
				} else {
					$('#areaCodes').combobox({
										url : '../area/loadArea.do',
										valueField : 'areaCode',
										textField : 'areaName',
										multiple : true,
										width : 200,
										formatter : function(row) {
											var s = "<span><p class='selectId' style='vertical-align: middle' id='selectId_"
													+ row.areaCode
													+ "'/>"
													+ row.areaName
													+ "<span>";
											return s;
										},
										onSelect : function(record) {
											$("#selectId_" + record.areaCode).attr(
													"checked", true);
										},
										onUnselect : function(record) {
											$("#selectId_" + record.areaCode).attr(
													"checked", false);
										}
									});
				}
			},
//			allot : function() {
//				var rows = $('#data-list').datagrid('getChecked');
//				if (rows.length != 1) {
//					$.messager.show({
//						title : '提示',
//						msg : '请选择一个商户.'
//					});
//				} else {
//					_box.handler.edit(function(result) {
//						$('#edit-win').dialog('close');
//						$('#allot').dialog('open');
//						$('#park-list').datagrid({
//			  				title:'列表',
//				   			url:'../park/dataList.do',
//				   			fitColumns:true,
//				   			pagination:true,
//				   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
//									{field:'id',checkbox:true},
//						 			{field:'name',title:'停车场名称',sortable:true}
//						 	]],
//						});
//						$('#allotForm').form('clear');
//						$('#allotForm').form('load', result.data);
//						if (result.data.parkIds.length == 0) {
//							$('#parkIds').combobox('reload');
//						} else {
//							$.each(result.data.parkIds, function(i, parkId) {
//								$("#selectId_" + parkId).attr("checked", true);
//							});
//						}
//					});
//				}
//			},
		config:{
			event : {
				add : function() {
					$.ajax({
						url : 'getProviderNo.do',
						type : 'post',
						success : function(result){
							$('#editForm').form('clear');
							$('#editForm').form('load',{providerNo:result[0].providerNo});
						}
					})
					_box.handler.add();
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
			 					{field:'providerName',title:'商户名称',sortable:true},
			 					{field:'companyName',title:'公司名称',sortable:true},
			 					{field:'contact',title:'联系人',sortable:true},
			 					{field:'phone',title:'联系电话',sortable:true},
			 					{field:'address',title:'公司地址',sortable:true},
			 					{field:'email',title:'Email',sortable:true},
			 					{field:'deleted',title:'是否有效',sortable:true,formatter:sys.dicts.text('YESORNO')},
			 					{field:'validityDate',title:'接入有效期',sortable:true}
			 	]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add'},
					{id:'btnedit',text:'修改',btnType:'edit'},
					{id:'btndelete',text:'删除',btnType:'remove'},
					{id:'btnedit',iconCls:'ext-icon-car',text : '配置',btnType : 'allot',
						handler : function() {
							var rows = $('#data-list').datagrid('getChecked');
							if(rows.length != 1){
								sys.alert('警告','请选择一行.','warning');  
							}else{
								_this.allot();
								_this.area();
								_box.handler.edit(function(result) {
									$('#edit-win').dialog('close');
									$('#allot').dialog('open');
									$('#allotForm').form('clear');
									$('#allotForm').form('load', result.data);
									if(result.data.authType == 1){
										if (result.data.parkIds.length == 0) {
											$('#parkIds').combobox('reload');
										} else {
											$('#area').hide();
											$('#park').show();
											$.each(result.data.parkIds, function(i, parkId) {
												$("#selectId_" + parkId).attr("checked", true);
											});
										}
									}else if(result.data.authType == 2){
										if (result.data.areaCodes.length == 0) {
											$('#areaCodes').combobox('reload');
										} else {
											$('#park').hide();
											$('#area').show();
											$.each(result.data.areaCodes, function(i, areaCode) {
												$("#selectId_" + areaCode).attr("checked", true);
											});
										}
									}
									
								
								});
							}
							
						}
					}
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
	app.provider.init();
	edit();
});

$('#authType').combobox({  
    onChange: function (newValue, oldValue) {
    	if(newValue == 1){
    		$('#area').hide();
    		$('#park').show();
    	}else if(newValue == 2){
    		$('#park').hide();
    		$('#area').show();
    	}
    }  
}); 

function edit(){
	$('#allot').dialog({
		buttons : [ {
			text : '保存',
			handler : function() {
				$('#allotForm').form('submit', {
					url : '../park/savePark.do',
					type : "post",
					onSubmit : function() {
						return $(this).form('validate');
					},
					success : function(result) {
						var res = $.parseJSON(result);
						$.messager.show({
							title : '提示',
							msg : res.msg
						});
						if (res.success) {
							$('#allotForm').form('reset');
							$('#allot').dialog('close');
							$('#data-list').datagrid('reload');
						}
					}
				});
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#allot').dialog('close');
			}

		} ]
	});
}


