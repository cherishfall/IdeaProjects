$package('app.user');
var dataCar;
var dataPay;
var dataCaptcha;
var rowsCar;
var rowsPay;
var rowsCaptcha;
app.user = function() {
	var _box = null;
	var _this = {
		userRegerInfo:function(){
			var rows = $('#data-list').datagrid('getChecked');
			if (rows.length != 1) {
				$.messager.show({
					title : '提示',
					msg : '请选择一条记录~'
				});
				return;
			}
			$('#regerDiv').dialog('open');
			//获取当前用户邀请信息
			$.ajax({
				url : 'getRegerInfo.do',
				type : 'post',
				dataType : 'json',
				data : {
					id : rows[0].id
				},
				success : function(result) {
					if (result.success) {
						$('#regerCode').html(result.data.regerCode);
						$('#regerCount').html(result.data.regerCount);
						if(result.data.userAccount == null
								|| result.data.userAccount == ''
								|| result.data.userAccount == 'undefined'){
							$('#parentAccount').html('无');
						}else{
							$('#parentAccount').html(result.data.userAccount);
						}
					} else {
						$.messager.show({
							msg : result.msg,
							title : '提示'
						});
					}
				}
			});
			//获取当前用户邀请人列表
			$('#regerTable').datagrid(
					{
						rownumbers : true,
						fitColumns : true,
						singleSelect : true,
						url : 'getRegerDetail.do?id=' + rows[0].id,
						width : 500,
						height :280,
						onLoadSuccess: function (data) {
					            if (data.rows.length == 0) {
					                //添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
					                $(this).datagrid('appendRow', { userAccount: '<div style="text-align:center;">没有相关记录！</div>' }).datagrid('mergeCells', { index: 0, field: 'userAccount', colspan: 2 })
					            }
					    },
						columns : [[
								{
									field : 'userAccount',
									title : '用户账号',
									width : 100,
									sortable : true
								},{
									field : 'createTime',
									title : '注册时间',
									width : 150,
									sortable : true
								},{
									field : 'remark',
									title : '注册地址',
									width : 200,
									sortable : true,
									formatter: function(value,row,index){
					     				if (value!=null&&value.length > 15){
					     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
					     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'...</span>';
					     				}else{
					     					return value;
					     				}
					     		     } 
								}] ],
					});
		},
		addCollector:function(){
			$('#edit-win-collector').dialog('open');
		},
		resetPw : function() {
			var rows = $('#data-list').datagrid('getChecked');
			if (rows.length != 1) {
				$.messager.show({
					title : '提示',
					msg : '请选择一条记录重置密码！'
				});
			} else {
				$.messager.confirm('确认', '确认重置密码？', function(r) {
					if (r) {
						$.ajax({
							url : 'resetPw.do',
							type : 'post',
							data : {
								id : rows[0].id
							},
							success : function(result) {
								// var res = $.paresJSON(result);
								$.messager.show({
									title : '提示',
									msg : result.msg
								});
								if (result.success) {
									$('#data-list').datagrid('reload');
								}
							}
						});
					}
				});
			}
		},
		deblock:function(){
			var rows = $('#data-list').datagrid('getChecked');
			if (rows.length != 1) {
				$.messager.show({
					title : '提示',
					msg : '请选择一条记录解锁！'
				});
			} else {
				$.messager.confirm('确认', '确认解锁？', function(r) {
					if (r) {
						$.ajax({
							url : 'deblock.do',
							type : 'post',
							data : {
								id : rows[0].id
							},
							success : function(result) {
								// var res = $.paresJSON(result);
								$.messager.show({
									title : '提示',
									msg : result.msg
								});
								if (result.success) {
									$('#data-list').datagrid('reload');
								}
							}
						});
					}
				});
			}
		},
		appUserCar : function(rows) {
			$('#appUserCar').dialog('open');
			$('#userCar').datagrid(
							{
								rownumbers : true,
								title : '车辆信息（双击进行修改）',
								fitColumns : true,
								singleSelect : true,
								url : 'getAppUserCar.do?userId=' + rows[0].id,
								width : 500,
								height : 300,
								onDblClickRow : function(index, data) {
									$('#userCar').datagrid('beginEdit', index);
								},
								columns : [ [
										{
											field : 'id',
											hidden : true
										},
										{
											field : 'userId',
											hidden : true
										},
										{
											field : 'plateNo',
											title : '车牌号',
											width : 80,
											editor : {type:'validatebox',options:{required : true,validType:'carNo'}},
											align : 'center'
										},
										{
											field : 'plateColor',
											title : '车牌颜色',
											width : 80,
											align : 'center',
                                            formatter : sys.dicts.text('PLATE_COLOR')
										},
										{
											field : 'isDefault',
											title : '是否默认',
											width : 80,
											editor : {
												type : 'combobox',
												options : {
													valueField : 'codeValue',
													textField : 'codeText',
													method : 'get',
													url : '../tag/getDictionaryItems.do?codeType=IS_DEFAULT&isDefaultLine=0&isCommon=1',
													editable:false,
													required : true
												}
											},
											align : 'center',
											formatter : sys.dicts.text('IS_DEFAULT')
										},
										{
											field : 'note',
											title : '备注',
											width : 160,
											editor : {type:'validatebox',options:{required : false,validType:'length[1,32]'}}
										},
										{
											field : 'isIdentify',
											title : '是否认证',
											width : 80,
											formatter : sys.dicts.text('YESORNO')
										},
										{
											field : 'oper',
											title : '操作',
											width : 100,
											align : 'center',
											formatter : function(value, row, index) {
												dataCar = row;
												if (row.editing) {
													var s = '<a href="#" onclick="saveRowCar(this)">保存</a> | ';
													var c = '<a href="#" onclick="cancelRowCar(this)">取消</a>';
													return s + c;
												} else {
													var d = '<a href="#" onclick="deleteRowCar(this)">删除</a>';
													return d;
												}
											}
										}, ] ],
								onBeforeEdit : function(index, row) {
									row.editing = true;
									updateActionsCar(index);
								},
								onAfterEdit : function(index, row) {
									row.editing = false;
									updateActionsCar(index);
								},
								onCancelEdit : function(index, row) {
									row.editing = false;
									updateActionsCar(index);
								},
								toolbar : [ {
									id : 'btnadd',
									text : '添加',
									btnType : 'add',
									iconCls : 'icon-add',
									handler : function() {
										addRowCar();
									}},{
                                        id: 'btnUnauthorized',
                                        text: '取消认证',
                                        btnType: 'unauthorized',
                                        iconCls: 'ext-icon-arrow_undo',
                                        handler: function () {
                                            unauthorized();
                                        }
								} ]
							});
		},
		appUserPay : function(rows) {
			$('#appUserPay').dialog('open');
			$('#userPay').datagrid(
							{
								rownumbers : true,
								title : '支付信息（双击进行修改）',
								fitColumns : true,
								singleSelect : true,
								url : 'getAppUserPay.do?userId=' + rows[0].id,
								width : 600,
								height : 300,
								onDblClickRow : function(index, data) {
									$('#userPay').datagrid('beginEdit', index);
								},
								columns : [ [
										{
											field : 'userId',
											hidden : true
										},
										{
											field : 'payAccount',
											title : '支付账号',
											width : 180,
											editor : {type:'validatebox',options:{required : true,validType:'length[1,32]'}},
											align : 'center'
										},
										{
											field : 'payAccountType',
											title : '支付账号类型',
											width : 120,
											editor : {
												type : 'combobox',
												options : {
													valueField : 'codeValue',
													textField : 'codeText',
													method : 'get',
													url : '../tag/getDictionaryItems.do?codeType=PAY_ACCOUNT_TYPE&isDefaultLine=0&isCommon=1',
													editable:false,
													required : true
												}
											},
											align : 'center',
											formatter : sys.dicts.text('PAY_ACCOUNT_TYPE')
										},
										{
											field : 'createTime',
											title : '创建时间',
											width : 160
										},{
											field : 'updateTime',
											title : '更新时间',
											width : 160
										},
										{
											field : 'oper',
											title : '操作',
											width : 100,
											align : 'center',
											formatter : function(value, row, index) {
												dataPay=row;
												if (row.editing) {
													var s = '<a href="#" onclick="saveRowPay(this)">保存</a> | ';
													var c = '<a href="#" onclick="cancelRowPay(this)">取消</a>';
													return s + c;
												} else {
													var d = '<a href="#" onclick="deleteRowPay(this)">删除</a>';
													return d;
												}
											}
										}, ] ],
								onBeforeEdit : function(index, row) {
									row.editing = true;
									updateActionsPay(index);
								},
								onAfterEdit : function(index, row) {
									row.editing = false;
									updateActionsPay(index);
								},
								onCancelEdit : function(index, row) {
									row.editing = false;
									updateActionsPay(index);
								},
								toolbar : [ {
									id : 'btnadd',
									text : '添加',
									btnType : 'add',
									iconCls : 'icon-add',
									handler : function() {
										addRowPay();
									}
								} ]
							});
		},
		appUserCaptcha : function(rows) {
			$('#appUserCaptcha').dialog('open');
			$('#userCaptcha').datagrid(
							{
								rownumbers : true,
								title : '验证信息',
								fitColumns : true,
								singleSelect : true,
								url : 'getAppUserCaptcha.do?mobile=' + rows[0].mobile+'&email='+rows[0].email,
								width : 700,
								height : 300,
								onDblClickRow : function(index, data) {
									$('#userCaptcha').datagrid('beginEdit', index);
								},
								columns : [ [
										{
											field : 'account',
											title : '账号',
											width : 120,
											align : 'center'
										},
										{
											field : 'captcha',
											title : '验证码',
											width : 80,
											align : 'center'
										},
										{
											field : 'reason',
											title : '发送验证码原因 ',
											width : 120,
											align : 'center',
											formatter : sys.dicts
													.text('REASON')
										},
										{
											field : 'expiredTime',
											title : '过期时间',
											width : 160,
											align : 'center'
										},
										{
											field : 'lastValidTime',
											title : '最后发送有效时间',
											width : 160,
											align : 'center'
										},
										{
											field : 'count',
											title : '验证码生成次数',
											width : 120,
										},
										{
											field : 'oper',
											title : '操作',
											width : 80,
											align : 'center',
											formatter : function(value, row, index) {
												dataCaptcha=row;
//												if (row.editing) {
//													var s = '<a href="#" onclick="saveRowCaptcha(this)">保存</a> | ';
//													var c = '<a href="#" onclick="cancelRowCaptcha(this)">取消</a>';
//													return s + c;
//												} else {
													var d = '<a href="#" onclick="deleteRowCaptcha(this)">删除</a>';
													return d;
//												}
											}
										}, ] ],
								onCancelEdit : function(index, row) {
									row.editing = false;
									updateActionsCaptcha(index);
								}
							});
		},
		config : {
			event:{
                search : function() { //条件查询验证
                    var param = $("#searchForm").serializeObject();
                    if(param.userAccount == '' && param.mobile == '' && param.areaId == ''
                        && param.status == ''){
                        $.messager.show({
                            msg : '请至少选择一个查询条件',
                            title : '提示'
                        });
                        return;
                    }
                    var opts = $("#data-list").datagrid("options");
                    opts.url = "dataList.do";
                    $('#data-list').datagrid('reload',param);
                },
				save:function(){
					 var areaName = $('#areaId').combotree('getText');
					 if(areaName=="根区域"){
						 $.messager.alert('提示','不能选择根区域');  
						 return;
					 }
					 var userAccount = $('#userAccount').val();
					 var mobile = $('#mobile').val();
					 if(userAccount!=mobile){
						 $.messager.alert('提示','手机号码必须与账号一致');
						 return;
					 }
					_box.handler.save();
				}
			},
			dataGrid : {
				title : '列表',
				url : '',
				fitColumns : true,
                onLoadSuccess: function(data){
                    if(data.rows.length==0){
                        var body = $(this).data().datagrid.dc.body2;
                        body.find('table tbody').append('<tr><td width="'+body.width()+'" style="height: 25px; padding:10px;text-align: left;"  colspan='+5+'>没有任何结果数据显示！（请确认查询条件是否正确）</td></tr>');
                    }
                },
				columns : [ [ // ,formatter:sys.dicts.text('OPEN_FLAG')
				{
					field : 'id',
					checkbox : true
				}, {
					field : 'photoUrl',
					title : '头像',
					width : 60,	
					align:'center',	
					formatter : function(value, row, index) {
						var photo = value;
						if(value==null || value=='' || value=='undefind'){
							photo = basePath + '/assets/images/default_avatar.png';
						}
						var d = '<span><img style="width:50px; height:50px; border-radius:50px;" src="'+photo+'" /></span>';
						return d;
					},
					sortable : true
				}, {
					field : 'userAccount',
					title : '用户账号',
					width : 80,
					sortable : true
				}, {
					field : 'nickName',
					title : '昵称',
					width : 80,
					sortable : true
				},
				// 根据cityCode关联base_area表中的areaCode，得到areaName
				{
					field : 'areaName',
					title : '城市名称',
					width : 80,
					sortable : true
				}, {
					field : 'mobile',
					title : '手机号码',
					width : 80,
					sortable : true
				}, {
					field : 'status',
					title : '应用状态',
					width : 80,
					sortable : true,
					formatter : sys.dicts.text('USER_STATUS')
				}, {
					field : 'plateNo',
					title : '默认车牌',
					width : 80,
					sortable : true
				}, 
//				{
//					field : 'attribute2',
//					title : '用户来源',
//					width :80,
//					sortable : true,
//					formatter:sys.dicts.text('USER_RESOURCE')
//				}, 
				{
					field : 'createTime',
					title : '注册时间',
					width : 120,
					sortable : true
				},{
					field : 'remark',
					title : '注册地址',
					width : 150,
					sortable : true,
					formatter: function(value,row,index){
	     				if (value!=null&&value.length > 15){
	     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
	     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'...</span>';
	     				}else{
	     					return value;
	     				}
	     		     } 
				} ] ],
				toolbar : [{
					id : 'btnadd',
					text : '添加',
					btnType : 'add'
				},
//				{
//					id : 'btnaddCollector',
//					text : '添加收费员',
//					btnType : 'add',
//					handler : function() {
//						_this.addCollector();
//					}
//				},
				{
					id : 'btnedit',
					text : '修改',
					btnType : 'edit'
				}, 
//				{
//					id : 'btndelete',
//					text : '注销',
//					btnType : 'remove'
//				}, 
				{
					id : 'btnresetPw',
					iconCls : 'ext-icon-key',
					text : '重置密码',
					btnType : 'resetPw',
					handler : function() {
						_this.resetPw();
					}
				},  {
					id : 'btndeblock',
					iconCls : 'ext-icon-key',
					text : '解锁',
					btnType : 'deblock',
					handler : function() {
						_this.deblock();
					}
				},{
					id : 'btncar',
					iconCls : 'ext-icon-car',
					text : '用户车辆',
					btnType : 'car',
					handler : function() {
						var rows = $('#data-list').datagrid('getChecked');
						rowsCar = rows;
						if (rows.length == 1) {
							_this.appUserCar(rows);
						} else {
							$.messager.show({
								msg : '请选择一个用户',
								title : '提示'
							});
						}
					}
				}, {
					id : 'btnpay',
					iconCls : 'ext-icon-money',
					text : '用户支付',
					btnType : 'pay',
					handler : function() {
						var rows = $('#data-list').datagrid('getChecked');
						rowsPay=rows;
						if (rows.length == 1) {
							_this.appUserPay(rows);
						} else {
							$.messager.show({
								msg : '请选择一个用户',
								title : '提示'
							});
						}
					}
				}, {
					id : 'btncaptcha',
					iconCls : 'ext-icon-group_key',
					text : '用户验证',
					btnType : 'captcha',
					handler : function() {
						var rows = $('#data-list').datagrid('getChecked');
						rowsCaptcha = rows;
						if (rows.length == 1) {
							_this.appUserCaptcha(rows);
						} else {
							$.messager.show({
								msg : '请选择一个用户',
								title : '提示'
							});
						}
					}
				},
				 {
					id : 'btnreger',
					iconCls : 'ext-icon-application_view_columns',
					text : '邀请信息',
					btnType : 'reger',
					handler : function() {
						var rows = $('#data-list').datagrid('getChecked');
						if (rows.length == 1) {
							_this.userRegerInfo(rows);
						} else {
							$.messager.show({
								msg : '请选择一个用户',
								title : '提示'
							});
						}
					}
				 }]
			}
		},
		init : function() {
			_box = new YDataGrid(_this.config);
			_box.init();
            $("#data-list").datagrid('appendRow', { userAccount: '<div style="text-align:center;">请输入查询条件！</div>' }).datagrid('mergeCells', { index:0, field: 'userAccount', colspan: 8 })
		}
	}
	return _this;
}();

$(function() {
	app.user.init();
	$('#close').bind('click', function(){    
	    $('#edit-win-collector').dialog('close');    
	}); 
	$('#confirm').bind('click', function(){    
		$('#editCollectorForm').form('submit', {    
		    url:'addCollector.do',    
		    type : 'post',
		    success:function(result){
			 var mes = eval('('+result+')');
			 $.messager.show({
				 title : '提示',
				 msg : mes.msg
			 });
			 if(mes.success){
				 $('#editCollectorForm').form('clear');
				 $('#edit-win-collector').dialog('close');
				 $('#data-list').datagrid('reload'); 
			 }
		  } 
		});      
	}); 
});

//userCar
function updateActionsCar(index) {
	$('#userCar').datagrid('updateRow', {
		index : index,
		row : {}
	});
}
function addCar() {
	$('#edit-win').dialog('open');
	$('#editFormCar').form('reset');
	var rows = $('#userCar').datagrid('getRows').length;
	for (var i = 0; i < rows; i++) {
		$('#userCar').datagrid('deleteRow', 0);
	}
}
function addRowCar() {
	$('#userCar').datagrid('insertRow', {
		index : 0,
		row : {}
	});
	$('#userCar').datagrid('selectRow', 0);
	$('#userCar').datagrid('beginEdit', 0);
}
function saveRowCar(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#userCar').datagrid('endEdit', index);
	var urlCar=null;
	if(dataCar.userId){
		//双击修改
		urlCar='saveCar.do';
	}else{
		//保存
		urlCar='saveCar.do?userId='+rowsCar[0].id;
	}
	if(dataCar.plateNo==null || dataCar.plateNo=='' || dataCar.plateNo=='undefined'){
		$.messager.show({ title : '提示', msg : '必填项不能为空' });
		return ;
	}
	$.ajax({
		url : urlCar,
		type : 'post',
		data : {
			id : dataCar.id,
			userId:dataCar.userId,
			plateNo:dataCar.plateNo,
			isDefault:dataCar.isDefault,
			note:dataCar.note
		},
		success : function(result) {
			// var res = $.paresJSON(result);
			$.messager.show({
				title : '提示',
				msg : result.msg
			});
			if (result.success) {
				$('#userCar').datagrid('reload');
			}
		},
		error : function(result) {
			// var res = $.paresJSON(result);
			$.messager.show({
				title : '提示',
				msg : '出现异常，请联系管理员'
			});
		}
	});
}

function cancelRowCar(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#userCar').datagrid('cancelEdit', index);
	$('#userCar').datagrid('reload');
}

function deleteRowCar(target) {
	$.messager.confirm('提示', '您确定要删除吗?', function(r){
        if (r){
        	var tr = $(target).closest('tr.datagrid-row');
        	var index = parseInt(tr.attr('datagrid-row-index'));
        	var rows = $('#userCar').datagrid('getSelected');
    		$.ajax({
    			url : 'deleteCar.do?id='+rows.id,
    			type : 'post',
    	//		data : {
    	//			id : row.id,
    	//		},
    			success : function(result) {
    				// var res = $.paresJSON(result);
    				$.messager.show({
    					title : '提示',
    					msg : result.msg
    				});
    				if (result.success) {
    					$('#userCar').datagrid('reload');
    				}
    			}
    		});
        }
	});
}
//userPay
function updateActionsPay(index) {
	$('#userPay').datagrid('updateRow', {
		index : index,
		row : {}
	});
}
function addPay() {
	$('#edit-win').dialog('open');
	$('#editFormPay').form('reset');
	var rows = $('#userPay').datagrid('getRows').length;
	for (var i = 0; i < rows; i++) {
		$('#userPay').datagrid('deleteRow', 0);
	}
}
function addRowPay() {
	$('#userPay').datagrid('insertRow', {
		index : 0,
		row : {}
	});
	$('#userPay').datagrid('selectRow', 0);
	$('#userPay').datagrid('beginEdit', 0);
}
function saveRowPay(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#userPay').datagrid('endEdit', index);
	var urlPay=null;
	if(dataPay.userId){
		urlPay='savePay.do';
	}else{
		urlPay='savePay.do?userId='+rowsPay[0].id;
	}
	if(dataPay.payAccount==null || dataPay.payAccount=='' || dataPay.payAccount=='undefined'){
		$.messager.show({ title : '提示', msg : '必填项不能为空' });
		return ;
	}
	$.ajax({
		url : urlPay,
		type : 'post',
		data : {
			id : dataPay.id,
			userId : dataPay.userId,
			payAccount : dataPay.payAccount,
			payAccountType : dataPay.payAccountType
		},
		success : function(result) {
			// var res = $.paresJSON(result);
			$.messager.show({
				title : '提示',
				msg : result.msg
			});
			if (result.success) {
				$('#userPay').datagrid('reload');
			}
		},
		error : function(result) {
			// var res = $.paresJSON(result);
			$.messager.show({
				title : '提示',
				msg : '出现异常，请联系管理员'
			});
		}
	});
}

function cancelRowPay(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#userPay').datagrid('cancelEdit', index);
	$('#userPay').datagrid('reload');
}

function deleteRowPay(target) {
	$.messager.confirm('提示', '您确定要删除吗?', function(r){
        if (r){
        	var tr = $(target).closest('tr.datagrid-row');
        	var index = parseInt(tr.attr('datagrid-row-index'));
        	var rows = $('#userPay').datagrid('getSelected');
    		$.ajax({
    			url : 'deletePay.do?id='+rows.id,
    			type : 'post',
    	//		data : {
    	//			id : row.id,
    	//		},
    			success : function(result) {
    				// var res = $.paresJSON(result);
    				$.messager.show({
    					title : '提示',
    					msg : result.msg
    				});
    				if (result.success) {
    					$('#userPay').datagrid('reload');
    				}
    			}
    		});
        }
	});
}
//userCaptcha
function updateActionsCaptcha(index) {
	$('#userCaptcha').datagrid('updateRow', {
		index : index,
		row : {}
	});
}
function addCaptcha() {
	$('#edit-win').dialog('open');
	$('#editFormCaptcha').form('reset');
	var rows = $('#userCaptcha').datagrid('getRows').length;
	for (var i = 0; i < rows; i++) {
		$('#userCaptcha').datagrid('deleteRow', 0);
	}
}
function addRowCaptcha() {
	$('#userCaptcha').datagrid('insertRow', {
		index : 0,
		row : {}
	});
	$('#userCaptcha').datagrid('selectRow', 0);
	$('#userCaptcha').datagrid('beginEdit', 0);
}
function saveRowCaptcha(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#userCaptcha').datagrid('endEdit', index);
}

function cancelRowCaptcha(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#userCaptcha').datagrid('cancelEdit', index);
	$('#userCaptcha').datagrid('reload');
}

function deleteRowCaptcha(target) {
	$.messager.confirm('提示', '您确定要删除吗?', function(r){
        if (r){
        	var tr = $(target).closest('tr.datagrid-row');
    		var index = parseInt(tr.attr('datagrid-row-index'));
    		var rows = $('#userCaptcha').datagrid('getSelected');
    		$.ajax({
    			url : 'deleteCaptcha.do?id='+rows.id,
    			type : 'post',
    	//		data : {
    	//			id : row.id,
    	//		},
    			success : function(result) {
    				// var res = $.paresJSON(result);
    				$.messager.show({
    					title : '提示',
    					msg : result.msg
    				});
    				if (result.success) {
    					$('#userCaptcha').datagrid('reload');
    				}
    			}
    		});
        }
	});
}

function unauthorized(){
    var dataRow = $('#data-list').datagrid('getChecked');
    var row = $('#userCar').datagrid('getSelected');
    if(row==null){
        $.messager.show({
            title : '提示',
            msg : '请选择一条记录~'
        });
        return;
    }
    if(row.isIdentify==0){
        $.messager.show({
            title : '提示',
            msg : '该车牌未认证，无需取消认证'
        });
        return;
    }
    $.messager.confirm('确认', '解除认证成功会发送一条短信告知用户，确定解除认证吗？', function(r) {
        if (r) {
            $.ajax({
                url: 'canclePlateNoIdentify.do',
                type: 'post',
                data: {
                    id: row.id,
                    plateNo: row.plateNo,
                    userAccount: dataRow[0].userAccount
                },
                success: function (result) {
                    $.messager.show({
                        title: '提示',
                        msg: result.msg
                    });
                    if (result.success) {
                        $('#userCar').datagrid('reload');
                    }
                },
                error: function (result) {
                    $.messager.show({
                        title: '提示',
                        msg: '出现异常，请联系管理员'
                    });
                }
            });
        }
    });
}