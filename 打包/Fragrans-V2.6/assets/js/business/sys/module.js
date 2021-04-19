$(function() {
	//定义按钮
	var toolbar = [ {
		id : 'btnadd',
		text : '添加',
		btnType : 'add',
		iconCls : 'icon-add',
		handler : function() {
			add();
		}
	}, {
		id : 'btnedit',
		text : '修改',
		btnType : 'edit',
		iconCls : 'icon-edit',
		handler : function() {
			var node = $('#data-list').treegrid('getSelected');
			if (node) {
				edit(node);
			} else {
				$.messager.show({
					msg : '请选择一个菜单修改！',
					title : '提示'
				});
			}
		}
	}, {
		id : 'btndelete',
		text : '删除',
		btnType : 'remove',
		iconCls : 'icon-remove',
		handler : function() {
			$.messager.confirm('确认', '确认删除所选菜单？', function(r) {
			if(r){
			var node = $('#data-list').treegrid('getSelected');
			if ((node.id).substring(0,4)=="btn_") {
				$.ajax({
					url : 'deleteBtn.do',
					type : 'post',
					dataType : 'json',
					data : {
						btnId : node.id
					},
					success : function(result) {
						if (result.success) {
							$('#data-list').treegrid('reload');
							$.messager.show({
								msg : result.msg,
								title : '提示'
							});
						} else {
							$.messager.show({
								msg : result.msg,
								title : '提示'
							});
						}
					}
				});
			} else {
				$.ajax({
					url : 'delete.do',
					type : 'post',
					dataType : 'json',
					data : {
						id : node.id
					},
					success : function(result) {
						if (result.success) {
							$('#data-list').treegrid('reload');
							$.messager.show({
								msg : result.msg,
								title : '提示'
							});
						} else {
							$.messager.show({
								msg : result.msg,
								title : '提示'
							});
						}
					}
				});
			}
			}
			});
		}
	}, {
		text : '展开',
		iconCls : 'icon-redo',
		handler : function() {
			var node = $('#data-list').treegrid('getSelected');
			if (node) {
				$('#data-list').treegrid('expandAll', node.cid);
			} else {
				$('#data-list').treegrid('expandAll');
			}
		}
	}, {
		text : '折叠',
		iconCls : 'icon-undo',
		handler : function() {
			var node = $('#data-list').treegrid('getSelected');
			if (node) {
				$('#data-list').treegrid('collapseAll', node.cid);
			} else {
				$('#data-list').treegrid('collapseAll');
			}
		}
	} ];
	
	//构建grid
	$('#data-list').treegrid({
		title : '列表',
		url : 'getModuleTree.do',
		idField : 'id',
		treeField : 'moduleName',
		parentField : 'parentId',
		fit : true,
		border : false,
		columns : [ [ {
			field : 'moduleName',
			width : 140,
			title : '模块名称'
		}, {
			field : 'iconCls',
			width : 100,
			title : '图标名称'
		}, {
			field : 'moduleUrl',
			width : 100,
			title : '模块URL'
		}, {
			field : 'actions',
			width : 200,
			title : '操作动作'
		}, {
			field : 'superAdmin',
			width : 200,
			title : '是否超级权限',
			formatter:sys.dicts.text('YESORNO')
		},{
			field : 'moduleDesc',
			width : 100,
			title : '模块描述'
		} , {
			field : 'orderNum',
			width : 100,
			title : '排序号'
		} ] ],
		toolbar : toolbar
	});
	
	//初始化权限按钮
	initTbar($('#data-list'),toolbar,basePath+'/module/list.action');
	
	$('#edit-win').dialog(
			{
				buttons : [
						{
							text : '提交',
							handler : function() {
								var id = $('#id').val();
								var superAdmin = $("#superAdmin").combobox("getText");
								console.log("s:"+superAdmin);
								var rows = $('#btn-dg').datagrid('getRows');
								var btn = "";
								var flag = true;
								$.each(rows, function(i, row) {
									if(row.editing){
										$.messager.show({
											title : '提示',
											msg : '请先保存信息在提交！'
										});
										flag = false;
									}
									var info = row.btnName + "," + row.btnType
											+ "," + row.actionUrls + ","
											+ row.id;
									btn = btn + info + ";";
								});
								$.ajax({
									url : 'getSuperAdmin.do',
									type : 'post',
									data : {
										id : id
									},
									success : function(result) {
										if(result!=''&&result[0].superAdmin==0&superAdmin=='是'){
											$.messager.confirm('确认', '该菜单已分配给角色，若授予超级权限，该菜单只有超级管理员可用', function(r) {
												if (r) {
													if(flag){
														$('#editForm').form('submit', {
															url : 'save.do',
															type : 'post',
															onSubmit : function(param) {
																param.childBtns = btn;
																return $(this).form('validate');
															},
															success : function(result) {
																var mes = eval('(' + result + ')');
																$.messager.show({
																	title : '提示',
																	msg : mes.msg
																});
																$('#edit-win').dialog('close');
																$('#data-list').treegrid('reload');
															}
														});
													}
												}
											});
										}else{
											console.log("flag:"+flag);
											if(flag){
												$('#editForm').form('submit', {
													url : 'save.do',
													type : 'post',
													onSubmit : function(param) {
														param.childBtns = btn;
														return $(this).form('validate');
													},
													success : function(result) {
														var mes = eval('(' + result + ')');
														$.messager.show({
															title : '提示',
															msg : mes.msg
														});
														$('#edit-win').dialog('close');
														$('#data-list').treegrid('reload');
													}
												});
											}
										}
									}
								});
								}
						}, {
							text : '关闭',
							handler : function() {
								$('#edit-win').dialog('close');
							}
						} ]
			});
	$('#btn-dg').datagrid({
		rownumbers:true,
		title : '菜单按钮（双击进行修改）',
		fitColumns : true,
		singleSelect:true,
		url : 'getBtnByModuleId.do',
		width : 320,
		onDblClickRow:function(index,data){
			$('#btn-dg').datagrid('beginEdit', index);
		},
		columns : [ [ {
			field : 'id',
			hidden : true
		}, {
			field : 'btnName',
			title : '按钮名称',
			width : 80,
			editor : 'text',
			align : 'center'
		}, {
			field : 'btnType',
			title : '按钮类型',
			width : 80,
			editor : 'text',
			align : 'center'
		}, {
			field : 'actionUrls',
			title : '请求(用"|"分隔)',
			width : 140,
			editor : 'text'
		}, {
			field : 'oper',
			title : '操作',
			width : 100,
			align : 'center',
			formatter : function(value, row, index) {
				if (row.editing) {
					var s = '<a href="#" onclick="saveRow(this)">保存</a> | ';
					var c = '<a href="#" onclick="cancelRow(this)">取消</a>';
					return s + c;
				} else {
					var d = '<a href="#" onclick="deleteRow(this)">删除</a>';
					return d;
				}
			}
		}, ] ],
		onBeforeEdit : function(index, row) {
			row.editing = true;
			updateActions(index);
		},
		onAfterEdit : function(index, row) {
			row.editing = false;
			updateActions(index);
		},
		onCancelEdit : function(index, row) {
			row.editing = false;
			updateActions(index);
		},
		toolbar : [ {
			id : 'btnadd',
			text : '添加',
			btnType : 'add',
			iconCls : 'icon-add',
			handler : function() {
				addRow();
			}
		} ]
	});
});
function updateActions(index) {
	$('#btn-dg').datagrid('updateRow', {
		index : index,
		row : {}
	});
}
function add() {
	$('#edit-win').dialog('open');
	$('#editForm').form('reset');
	//获取 datagrid 当前选择的行
	var node = $('#data-list').treegrid('getSelected');
	var rows = $('#btn-dg').datagrid('getRows').length;
	for (var i = 0; i < rows; i++) {
		$('#btn-dg').datagrid('deleteRow', 0);
	}
	$('#btn-dg').datagrid('insertRow', {
		index : 0,
		row : {
			btnName : '增加',
			btnType : 'add',
			actionUrls : 'save.do'
		}
	});
	$('#btn-dg').datagrid('insertRow', {
		index : 0,
		row : {
			btnName : '删除',
			btnType : 'remove',
			actionUrls : 'delete.do'
		}
	});
	$('#btn-dg').datagrid('insertRow', {
		index : 0,
		row : {
			btnName : '修改',
			btnType : 'edit',
			actionUrls : 'save.do|getId.do'
		}
	});
	if(node!=null){
		 //默认选择gridtree
		$('#parentId').combotree('setValue', node.id);
	}
}
function edit(node) {
	if(node.moduleDesc=="按钮"){
		$.messager.show({
			title:'提示',
			msg:'修改按钮请选择对应上级模块进行修改！'
		});
		return;
	}
	$('#edit-win').dialog('open');
	$('#editForm').form('load', node);
	$('#btn-dg').datagrid('load', {
		moduleId : node.id
	});
}

function addRow() {
	$('#btn-dg').datagrid('insertRow', {
		index : 0,
		row : {}
	});
	$('#btn-dg').datagrid('selectRow', 0);
	$('#btn-dg').datagrid('beginEdit', 0);
}

function saveRow(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg').datagrid('endEdit', index);
}

function cancelRow(target){
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg').datagrid('cancelEdit', index);
}

function deleteRow(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg').datagrid('deleteRow', index);
}

function showIcons() {
	var dialog = parent.sy.modalDialog({
		title : '浏览小图标',
		url : basePath + '/view/sys/icons.jsp',
		buttons : [ {
			text : '确定',
			handler : function() {
				dialog.find('iframe').get(0).contentWindow.selectIcon(dialog, $('#iconCls'));
			}
		} ]
	});
}

