$package('base.user');
base.user = function() {
	var _box = null;
	var _this = {
		setAuthority : function() {
			var rows = $('#data-list').datagrid('getChecked');
			if (rows.length != 1) {
				$.messager.show({
					title : '提示',
					msg : '请选中一个用户授权.'
				});
			} else {
				$('#roleIds').combobox({
									url : basePath +'/user/loadRole.do',
									valueField : 'id',
									textField : 'roleName',
//									multiple : true,
//									formatter : function(row) {
//										var s = "<span><input type='checkbox' class='selectId' style='vertical-align: middle' id='selectId_"
//												+ row.id
//												+ "'>"
//												+ row.roleName
//												+ "<span>";
//										return s;
//									},
//									onSelect : function(record) {
//										$("#selectId_" + record.id).attr(
//												"checked", true);
//									},
//									onUnselect : function(record) {
//										$("#selectId_" + record.id).attr(
//												"checked", false);
//									}
								});
				$.ajax({
					url:'getRoleLevel.do',
					success : function(data) {
						console.log("1:"+rows[0].roleLevel);
						if(data.roleLevel!=null&&rows[0].roleLevel!=null&&data.roleLevel>=rows[0].roleLevel){
							$.messager.show({
								title : '提示',
								msg : '不能给同等级的用户授权.'
							});
						}else{
								_box.handler.edit(function(result) {
									$('#edit-win').dialog('close');
									$('#authority').dialog('open');
									$('#authorityForm').form('clear');
									$('#authorityForm').form('load', result.data);
								});
						}
					}
					})
//					$('#roleIds').combobox('setValue', rows[0].roleName);
//					if (result.data.roleIds.length == 0) {
//						$('#roleIds').combobox('reload');
//					} else {
//						$.each(result.data.roleIds, function(i, roleId) {
//							$("#selectId_" + roleId).attr("checked", true);
//						});
//					}
			}
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
		config : {
			event:{
				add:function(){
					$('#departmentId').combotree({  
						title:'列表',
						url:'../department/getDeparmentTree.do',
						fit : true,
						idField : 'id',
						treeField : 'departmentName',
						parentField : 'parentId'
					});
					_box.handler.add();
				},
				edit:function(){
					$('#departmentId').combotree({  
						title:'列表',
						url:'../department/getDeparmentTree.do',
						fit : true,
						idField : 'id',
						treeField : 'departmentName',
						parentField : 'parentId'
					});
					_box.handler.edit();
				},
				save:function(){
					 var departmentName = $('#departmentId').combotree('getText');
					 if(departmentName=="机构"){
						 $.messager.alert('提示','不能选择机构');  
						 return;
					 }
					_box.handler.save();
				}
			},
			dataGrid : {
				iconCls:'ext-icon-user',
				title : '用户列表',
				url : 'dataList.do',
				fitColumns : true,
				columns : [ [ {
					field : 'id',
					checkbox : true
				}, {
					field : 'roleLevel',
					hidden : true
				},{
					field : 'account',
					title : '登录账号',
					sortable : true
				}, {
					field : 'name',
					title : '真实姓名',
					sortable : true
				}, {
					field : 'roleName',
					title : '角色',
					sortable : true
				},{
					field:'departmentName',
					title:'所属部门'
				},{
					field : 'areaName',
					title : '所属区域',
					sortable : true
				}, {
					field : 'superAdmin',
					title : '是否超级管理员',
					sortable : true,
					formatter : sys.dicts.text('YESORNO')
				},{
					field : 'gender',
					title : '性别',
					sortable : true,
					formatter : sys.dicts.text('GENDER')
				}, {
					field : 'phone',
					title : '联系方式',
					sortable : true
				}, {
					field : 'nickname',
					title : '昵称',
					sortable : true
				}, {
					field : 'email',
					title : '电子邮箱',
					sortable : true
				}, {
					field : 'state',
					title : '状态 ',
					sortable : true,
					formatter : sys.dicts.text('STATE')
				}, {
					field : 'loginCount',
					title : '登录次数',
					sortable : true
				}, {
					field : 'createdBy',
					title : '创建人',
					sortable : true
				}, {
					field : 'createTime',
					title : '创建时间',
					sortable : true
				}, {
					field : 'note',
					title : '备注'
				} ] ],
				toolbar : [ {
					id : 'btnadd',
					text : '添加',
					btnType : 'add'
				}, {
					id : 'btnedit',
					text : '修改',
					btnType : 'edit'
				}, {
					id : 'btndelete',
					text : '删除',
					btnType : 'remove'
				}, {
					id : 'btnedit',
					iconCls : 'icon-edit',
					text : '授权',
					btnType : 'authRole',
					handler : function() {
						_this.setAuthority();
					}
				}, {
					id : 'btnedit',
					iconCls : 'ext-icon-key',
					text : '重置密码',
					btnType : 'resetPw',
					handler : function() {
						_this.resetPw();
					}
				} ]
			}
		},
		init : function() {
			_box = new YDataGrid(_this.config);
			_box.init();
			$('#authority').dialog({
				buttons : [ {
					text : '保存',
					handler : function() {
						$('#authorityForm').form('submit', {
							url : '../user/saveUserRole.do',
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
									$('#authority').dialog('close');
									$('#data-list').datagrid('reload');
								}
							}
						});
					}
				}, {
					text : '关闭',
					handler : function() {
						$('#authority').dialog('close');
					}

				} ]
			});
		}
	};
	return _this;
}();

$(function() {
	base.user.init();
});