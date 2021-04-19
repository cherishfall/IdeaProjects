$package('app.key');
var dataRequestAuthConf;
app.key = function(){
	var _box = null;
	var _this = {
		config:{
			event : {
				add : function() {
					$.ajax({
						url : 'getIdAndKey.do',
						type : 'post',
						success : function(result){
							$('#editForm').form('clear');
							$('#editForm').form('load',{appId:result[0].appId,appKey:result[0].appKey});
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
			 					{field:'appName',title:'应用名称',sortable:true},
			 					{field:'appStatus',title:'应用状态',sortable:true,formatter:sys.dicts.text('APP_STATUS')},
			 					{field:'expiredDay',title:'有效期',sortable:true},
			 					{field:'appDesc',title:'应用描述',sortable:true},
			 					{field:'isSuper',title:'是否超级权限',sortable:true,formatter:sys.dicts.text('YESORNO')}
			 	]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add'},
					{id:'btnedit',text:'修改',btnType:'edit'},
					{id:'btndelete',text:'删除',btnType:'remove'},
                    {
                        id : 'btncheck',
                        iconCls : 'ext-icon-group_key',
                        text : '授权接口',
                        btnType : 'check',
                        handler : function() {
                            var rows = $('#data-list').datagrid('getChecked');
                            if (rows.length == 1) {
                            	if(rows[0].isSuper==1){
                                    $.messager.show({
                                        msg : '已是超级权限，无需授权',
                                        title : '提示'
                                    });
                            		return;
								}
                                requestAuthConfig(rows[0]);
                            } else {
                                $.messager.show({
                                    msg : '请选择一条记录',
                                    title : '提示'
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
	app.key.init();
});

function requestAuthConfig(row) {
    $('#requestAuthConfDiv').dialog('open');
    $('#requestAuthConf').datagrid(
        {
            rownumbers : true,
            title : '权限配置（双击进行修改）',
            fitColumns : true,
            singleSelect : true,
            url : 'getRequestAuthConfig.do?appId=' + row.appId,
            width : 600,
            height : 280,
            onDblClickRow : function(index, data) {
                $('#requestAuthConf').datagrid('beginEdit', index);
            },
            columns : [ [
                {
                    field : 'id',
                    hidden : true
                },
                {
                    field : 'appName',
                    title : '应用名称',
                    width : 100,
                    align : 'center'
                },
                {
                    field : 'appId',
                    title : '应用ID',
                    width : 120,
                    align : 'center'
                },
                {
                    field : 'serviceName',
                    title : '接口名称',
                    width : 180,
                    align : 'center',
                    editor : {type:'validatebox',options:{required : true,validType:'length[1,256]'}}
                },
                {
                    field : 'oper',
                    title : '操作',
                    width : 100,
                    align : 'center',
                    formatter : function(value, row, index) {
                        dataRequestAuthConf = row;
                        if (row.editing) {
                            var s = '<a href="#" onclick="saveRowRequestAuthConf(this)">保存</a> | ';
                            var c = '<a href="#" onclick="cancelRowRequestAuthConf(this)">取消</a>';
                            return s + c;
                        } else {
                            var d = '<a href="#" onclick="deleteRowRequestAuthConf(this)">删除</a>';
                            return d;
                        }
                    }
                }, ] ],
            onBeforeEdit : function(index, row) {
                row.editing = true;
                updateActionsRequestAuthConf(index);
            },
            onAfterEdit : function(index, row) {
                row.editing = false;
                updateActionsRequestAuthConf(index);
            },
            onCancelEdit : function(index, row) {
                row.editing = false;
                updateActionsRequestAuthConf(index);
            },
            toolbar : [ {
                id : 'btnadd',
                text : '添加',
                btnType : 'add',
                iconCls : 'icon-add',
                handler : function() {
                    var rows = $('#data-list').datagrid('getChecked');
                    addRowRequestAuthConf(rows[0]);
                }
            } ]
        });
}

function saveRowRequestAuthConf(target) {
    var tr = $(target).closest('tr.datagrid-row');
    var index = parseInt(tr.attr('datagrid-row-index'));
    $('#requestAuthConf').datagrid('endEdit', index);
    if(dataRequestAuthConf.serviceName==null || dataRequestAuthConf.serviceName=='' || dataRequestAuthConf.serviceName=='undefined'){
        $.messager.show({ title : '提示', msg : '接口名称不能为空' });
        return ;
    }
    $.ajax({
        url : 'saveRequestAuthConfig.do',
        type : 'post',
        data : {
            id:dataRequestAuthConf.id,
            appId:dataRequestAuthConf.appId,
            serviceName:dataRequestAuthConf.serviceName
        },
        success : function(result) {
            $.messager.show({
                title : '提示',
                msg : result.msg
            });
            if (result.success) {
                $('#requestAuthConf').datagrid('reload');
            }
        },
        error : function(result) {
            $.messager.show({
                title : '提示',
                msg : '出现异常，请联系管理员'
            });
        }
    });
}

function cancelRowRequestAuthConf(target) {
    var tr = $(target).closest('tr.datagrid-row');
    var index = parseInt(tr.attr('datagrid-row-index'));
    $('#requestAuthConf').datagrid('cancelEdit', index);
    $('#requestAuthConf').datagrid('reload');
}

function updateActionsRequestAuthConf(index) {
    $('#requestAuthConf').datagrid('updateRow', {
        index : index,
        row : {}
    });
}

function addRowRequestAuthConf(row) {
    $('#requestAuthConf').datagrid('insertRow', {
        index : 0,
        row : {appId:row.appId,appName:row.appName}
    });
    $('#requestAuthConf').datagrid('selectRow', 0);
    $('#requestAuthConf').datagrid('beginEdit', 0);
}
function deleteRowRequestAuthConf(target) {
    $.messager.confirm('提示', '您确定要删除吗?', function(r){
        if (r){
            var tr = $(target).closest('tr.datagrid-row');
            var index = parseInt(tr.attr('datagrid-row-index'));
            var rows = $('#requestAuthConf').datagrid('getSelected');
            $.ajax({
                url : 'deleteRequestAuthConfig.do?id='+rows.id,
                type : 'post',
                success : function(result) {
                    $.messager.show({
                        title : '提示',
                        msg : result.msg
                    });
                    if (result.success) {
                        $('#requestAuthConf').datagrid('reload');
                    }
                }
            });
        }
    });
}