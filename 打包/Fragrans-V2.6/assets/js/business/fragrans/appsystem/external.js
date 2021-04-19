$package('app.external');
var dataExternalConf;
app.external = function(){
	var _box = null;
	var _this = {
			check : function(rows) {
				$('#check').dialog('open');
				$('#externalConf').datagrid(
								{
									rownumbers : true,
									title : '诱导服务数据权限',
									fitColumns : true,
									singleSelect : true,
									url : 'getExternalConf.do?id=' + rows[0].id,
									width : 600,
									height : 280,
									columns : [ [
											{
												field : 'id',
												hidden : true
											},
											{
												field : 'authType',
												title : '授权类型',
												width : 80,
												align : 'center',
												editor : {
													type : 'combobox',
													options : {
														valueField : 'codeValue',
														textField : 'codeText',
														method : 'get',
														url : '../tag/getDictionaryItems.do?codeType=AUTH_TYPE&isDefaultLine=0&isCommon=1',
														editable:false,
														required : true
													}
												},
												formatter : sys.dicts.text('AUTH_TYPE')
											},
											{
												field : 'authParkType',
												title : '区域停车点类型',
												width : 120,
												align : 'center',
												editor : {
													type : 'combobox',
													options : {
														valueField : 'codeValue',
														textField : 'codeText',
														method : 'get',
														url : '../tag/getDictionaryItems.do?codeType=AUTH_PARK_TYPE&isDefaultLine=0&isCommon=1',
														editable:false,
														required : false
													}
												},
												formatter : sys.dicts.text('AUTH_PARK_TYPE')
											},
											{
												field : 'areaName',
												title : '区域',
												width : 150,
												editor : {type:'combobox',
													options : {
														valueField : 'id',
														textField : 'areaName',
														method : 'get',
														url : 'getAreaTree.do',
														required : false
													}
												},
												align : 'center'
											},
											{
												field : 'parkName',
												title : '停车点',
												editor : {type:'combobox',
													options : {
														valueField : 'id',
														textField : 'name',
														method : 'get',
														url : '../park/loadPark.do',
														required : false
													}
												},
												width : 200
											},
											{
												field : 'oper',
												title : '操作',
												width : 100,
												align : 'center',
												formatter : function(value, row, index) {
													dataExternalConf = row;
													if (row.editing) {
														var s = '<a href="#" onclick="saveRowExternalConf(this)">保存</a> | ';
														var c = '<a href="#" onclick="cancelRowExternalConf(this)">取消</a>';
														return s + c;
													} else {
														var d = '<a href="#" onclick="deleteRowExternalConf(this)">删除</a>';
														return d;
													}
												}
											}, ] ],
									onBeforeEdit : function(index, row) {
										row.editing = true;
										updateActionsExternalConf(index);
									},
									onAfterEdit : function(index, row) {
										row.editing = false;
										updateActionsExternalConf(index);
									},
									onCancelEdit : function(index, row) {
										row.editing = false;        
										updateActionsExternalConf(index);
									},
									toolbar : [ {
										id : 'btnadd',
										text : '添加',
										btnType : 'add',
										iconCls : 'icon-add',
										handler : function() {
											addRowExternalConf();
										}
									} ]
								});
			},
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'appId',title:'应用ID',sortable:true},
			 					{field:'areaName',title:'数据权限区域',sortable:true},
			 					{field:'authType',title:'授权类型',sortable:true,formatter:sys.dicts.text('AUTH_TYPE')},
			 					{field:'isFreeBerth',title:'是否显示空闲泊位数',sortable:true,formatter:sys.dicts.text('YESORNO')},
			 					{field:'createUser',title:'创建人',sortable:true},
			 					{field:'createTime',title:'创建时间',sortable:true},
			 					{field:'updateUser',title:'修改人',sortable:true},
			 					{field:'updateTime',title:'修改时间',sortable:true},
			 					{field:'remark',title:'备注',sortable:true}
			 	]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add',
						iconCls : 'icon-add',
						handler : function() {
							$('#editExternalForm').form('reset');
							showArea();
							$('#edit-external').dialog('open');
						}},
					{id:'btnedit',text:'修改',btnType:'edit'},
					{id:'btndelete',text:'删除',btnType:'remove'},
					{
						id : 'btncheck',
						iconCls : 'ext-icon-group_key',
						text : '授权',
						btnType : 'check',
						handler : function() {
							var rows = $('#data-list').datagrid('getChecked');
							rowsPay=rows;
							if (rows.length == 1) {
								_this.check(rows);
							} else {
								$.messager.show({
									msg : '请选择一条记录',
									title : '提示'
								});
							}
						}
					},
				]
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
			$('#edit-external').dialog({
				buttons : [ {
					text : '保存',
					handler : function() {
						$('#editExternalForm').form('submit', {
							url : 'save.do',
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
									$('#edit-external').dialog('close');
									$('#data-list').datagrid('reload');
								}
							}
						});
					}
				}, {
					text : '关闭',
					handler : function() {
						$('#edit-external').dialog('close');
					}

				} ]
			});
		}
	}
	return _this;
}();

$(function(){
	app.external.init();
	$('#appIdAdd').combobox({
		url:'getAppId.do',
		fit : true,
		panelHeight : '200',
		valueField:'id',    
	    textField:'text'
	});
	$('#appIdEdit').combobox({
		url:'getAppId.do',
		fit : true,
		panelHeight : '200',
		valueField:'id',    
	    textField:'text'
	});
});	

function showArea(){
	$("#parkType").show();
	$("#authParkTypeDiv").show();
	$('#name').html('选择区域：');
	$('#data').combobox({
		title:'列表',
		url:'getAreaTree.do',
		valueField : 'id',
		textField : 'areaName',
		multiple : true,
		width : 200,
		formatter : function(row) {
			var s = "<span><input type='checkbox' class='selectId' style='vertical-align: middle' id='selectId_"
					+ row.id
					+ "'>"
					+ row.areaName
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

function showPark(){
	$("#parkType").hide();
	$("#authParkTypeDiv").hide();
	$("#authParkType").combobox('clear');
	$('#name').html('选择停车点：');
	$('#data').combobox({
			url : '../park/loadPark.do',
			valueField : 'id',
			textField : 'name',
			multiple : true,
			width : 200,
			formatter : function(row) {
				var s = "<span><input type='checkbox' class='selectId' style='vertical-align: middle' id='selectId_"
						+ row.id
						+ "'>"
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

function saveRowExternalConf(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#externalConf').datagrid('endEdit', index);
	var rows = $('#data-list').datagrid('getChecked');
	if(dataExternalConf.authType==null || dataExternalConf.authType=='' || dataExternalConf.authType=='undefined'){
		$.messager.show({ title : '提示', msg : '授权类型不能为空' });
		return ;
	}
	$.ajax({
		url : 'saveExternalConf.do',
		type : 'post',
		data : {
			externalId:rows[0].id,
			authType:dataExternalConf.authType,
			authParkType:dataExternalConf.authParkType,
			areaName:dataExternalConf.areaName,
			parkId:dataExternalConf.parkName
		},
		success : function(result) {
			// var res = $.paresJSON(result);
			$.messager.show({
				title : '提示',
				msg : result.msg
			});
			if (result.success) {
				$('#externalConf').datagrid('reload');
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

function cancelRowExternalConf(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#externalConf').datagrid('cancelEdit', index);
	$('#externalConf').datagrid('reload');
}

function updateActionsExternalConf(index) {
	$('#externalConf').datagrid('updateRow', {
		index : index,
		row : {}
	});
}

function addRowExternalConf() {
	$('#externalConf').datagrid('insertRow', {
		index : 0,
		row : {}
	});
	$('#externalConf').datagrid('selectRow', 0);
	$('#externalConf').datagrid('beginEdit', 0);
}
function deleteRowExternalConf(target) {
	$.messager.confirm('提示', '您确定要删除吗?', function(r){
        if (r){
        	var tr = $(target).closest('tr.datagrid-row');
        	var index = parseInt(tr.attr('datagrid-row-index'));
        	var rows = $('#externalConf').datagrid('getSelected');
    		$.ajax({
    			url : 'deleteExternalConf.do?id='+rows.id,
    			type : 'post',
    			success : function(result) {
    				$.messager.show({
    					title : '提示',
    					msg : result.msg
    				});
    				if (result.success) {
    					$('#externalConf').datagrid('reload');
    				}
    			}
    		});
        }
	});
}
