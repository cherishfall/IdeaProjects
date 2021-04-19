$(function() {
	// 定义按钮
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
				if (r) {
					var node = $('#data-list').treegrid('getSelected');
					/*
					 * if ((node.id).substring(0,4)=="btn_") { $.ajax({ url :
					 * 'deleteBtn.do', type : 'post', dataType : 'json', data : {
					 * btnId : node.id }, success : function(result) { if
					 * (result.success) { $('#data-list').treegrid('reload');
					 * $.messager.show({ msg : result.msg, title : '提示' }); }
					 * else { $.messager.show({ msg : result.msg, title : '提示'
					 * }); } } }); } else {
					 */
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
					// }
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

	// 构建grid
	$('#data-list').treegrid({
		title : '列表',
		url : 'dataList.do',
		idField : 'id',
		treeField : 'name',
		parentField : 'parentId',
		fit : true,
		border : false,
		columns : [ [ {
			field : 'name',
			width : 250,
			title : '模块名称'
		}, {
			field : 'id',
			width : 120,
			title : '模块ID'
		}, {
			field : 'createBy',
			width : 120,
			title : '创建人'
		}, {
			field : 'createTime',
			width : 200,
			title : '创建时间'
		} ] ],
		toolbar : toolbar
	});

	// 初始化权限按钮
	initTbar($('#data-list'), toolbar, basePath + '/appMenu/list.action');

	$('#edit-win').dialog({
		buttons : [ {
			text : '提交',
			handler : function() {

				// var rows = $('#btn-dg').datagrid('getRows');
				/*
				 * var btn = ""; var flag = true; $.each(rows, function(i, row) {
				 * if(row.editing){ $.messager.show({ title : '提示', msg :
				 * '请先保存信息在提交！' }); flag = false; }
				 */
				/*
				 * var info = row.btnName + "," + row.btnType + "," +
				 * row.actionUrls + "," + row.id; btn = btn + info + ";";
				 */
				// });
				
				$('#editForm').form('submit', {
					url : 'save.do',
					type : 'post',
					onSubmit : function(param) {
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
		}, {
			text : '关闭',
			handler : function() {
				$('#edit-win').dialog('close');
			}
		} ]

	});

});
function add() {
	$('#edit-win').dialog('open');
	$('#editForm').form('reset');
}
function edit(node) {
	if (node.moduleDesc == "按钮") {
		$.messager.show({
			title : '提示',
			msg : '修改按钮请选择对应上级模块进行修改！'
		});
		return;
	}

	$('#edit-win').dialog('open');
	$('#editForm').form('load', node);

}
