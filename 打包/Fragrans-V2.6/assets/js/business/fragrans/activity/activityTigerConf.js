$package('app.activityTigerConf');
var dataOrderLimit;
var dataTicketRel;
var dataTicketRelByRandom;
var rowsDeploy;
app.activityTigerConf = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'activityName',title:'活动',sortable:true},
			 					{field:'tigerType',title:'触发类型',sortable:true,formatter:sys.dicts.text('TIGER_TYPE')},	
			 					{field:'ticketCount',title:'触发生成总张数',sortable:true},
			 	]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add',
						handler:function(){
							$.ajax({
								url : 'getActivityForTiger.do',
								type : 'post',
								success : function(result) {
									if(result==0){
										sys.alert('提示','每个活动都已配置一个触发规则','info');
									}else{
										$('#editTigerForm').form('reset');
										//下拉框加载的数据为未配置的活动
										$('#activityId').combobox({
											title:'列表',
											url:'getActivityForTiger.do',
											fit : true,
											valueField : 'id',
											textField:'text',
										});
										$('#ticketCountAdd').numberbox('setValue', '');
										show();
										$('#edit-Tiger').dialog('open');
									}
								}
							});
						}
					},
					{id:'btnedit',text:'修改',btnType:'edit',
						handler:function(){
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length == 1) {
								$('#activityName').html(rows[0].activityName);
								if(rows[0].tigerType==1){
									show();
								}else{
									hid();
								}
								_box.handler.edit();
							} else {
								$.messager.show({
									msg : '请选择一条记录',
									title : '提示'
								});
							}
						}},
					{id:'btndelete',text:'删除',btnType:'remove'},
					{id:'btndeploy',text:'配置',btnType:'deploy',iconCls : 'ext-icon-cog',
						handler:function(){
							var rows = $('#data-list').datagrid('getChecked');
							rowsDeploy = rows;
							if (rows.length == 1) {
								$('#edit-deploy').dialog('open');
								if(rows[0].tigerType==1){
									//触发类型为1，即随机策略时，展示的table
									showTicketRelEdit(rows);
								}else{
									//触发类型为2，即订单限制策略时，展示的table
									showOrderLimitEdit(rows);
								}
							} else {
								$.messager.show({
									msg : '请选择一条记录',
									title : '提示'
								});
							}
						}}
				]
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
			$('#edit-Tiger').dialog({
				buttons : [ {
					text : '保存',
					handler : function() {
						$('#editTigerForm').form('submit', {
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
									$('#edit-Tiger').dialog('close');
									$('#data-list').datagrid('reload');
								}
							}
						});
					}
				}, {
					text : '关闭',
					handler : function() {
						$('#edit-Tiger').dialog('close');
					}

				} ]
			});
			
			$('#edit-win').dialog({
				buttons : [ {
					text : '保存',
					handler : function() {
						$.messager.confirm('提示', '修改触发类型后，配置的条件将会被删除，确认修改吗？', function(r) {
							if(r){
								$('#editForm').form('submit', {
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
											$('#edit-win').dialog('close');
											$('#data-list').datagrid('reload');
										}
									}
								});
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
		}
	}
	return _this;
}();

function show(){
	//显示生成总张数
	$('#ticketCountAdd').numberbox('setValue', '');
	$("#tickAdd").show();
	$("#ticketCountDivAdd").show();
	$("#tickEdit").show();
	$("#ticketCountDivEdit").show();
}

function hid(){
	//隐藏生成总张数
	$("#tickAdd").hide();
	$("#ticketCountDivAdd").hide();
	$("#tickEdit").hide();
	$("#ticketCountDivEdit").hide();
}

function showTicketRelEdit(rows){
	var tigerConfId = rows[0].id;
	showTicket(tigerConfId);
	$("#orderLimitDiv").hide();
	$("#tigerTicketRelDiv").show();
}

function showOrderLimitEdit(rows){
	var tigerConfId = rows[0].id;
	orderLimit(tigerConfId);
	$("#orderLimitDiv").show();
	$("#tigerTicketRelDiv").hide();
}

//订单限制策略配置
function orderLimit(id){
	$('#orderLimit').datagrid(
			{
				rownumbers : true,
				title : '订单触发条件限制（双击进行修改）',
				fitColumns : true,
				singleSelect : true,
				url : 'getOrderLimit.do?tigerConfId=' + id,
				width : 1050,
				height : 300,
				onDblClickRow : function(index, data) {
					$('#orderLimit').datagrid('beginEdit', index);
				},
				columns : [ [
						{
							field : 'id',
							hidden : true
						},
						{
							field : 'tigerConfId',
							hidden : true
						},
						{
							field : 'limitType',
							title : '限制条件类型',
							width : 150,
							editor : {type:'combobox',
							options : {
								valueField : 'codeValue',
								textField : 'codeText',
								method : 'get',
								url : '../tag/getDictionaryItems.do?codeType=LIMIT_TYPE&isDefaultLine=0&isCommon=1',
								editable:false,
								required : true
							}},
							align : 'center',
							formatter : sys.dicts.text('LIMIT_TYPE')
						},
						{
							field : 'ticketCount',
							title : '券张数',
							width : 80,
							editor : {
								type : 'validatebox',
								options:{required : true,validType:'length[1,4]'}
							},
							align : 'center',
						},
						{
							field : 'limitPayFeeMin',
							title : '限制支付金额区间下限',
							width : 180,
							editor : {type:'validatebox',options:{required : false,validType:'length[1,10]'}},
							formatter : function(value,row,index){
								if(value!=null){
									return "<font>￥"+value/100+"</font>";
								}
	 						}
						},
						{
							field : 'limitPayFeeMax',
							title : '限制支付金额区间上限',
							width : 180,
							editor : {type:'validatebox',options:{required : false,validType:'length[1,10]'}},
							formatter : function(value,row,index){
								if(value!=null){
									return "<font>￥"+value/100+"</font>";
								}
	 						}
						},
						{
							field : 'limitOnepayFeeMin',
							title : '限制单笔支付金额区间下限',
							width : 200,
							editor : {type:'validatebox',options:{required : false,validType:'length[1,10]'}},
							formatter : function(value,row,index){
								if(value!=null){
									return "<font>￥"+value/100+"</font>";
								}
	 						}
						},
						{
							field : 'limitOnepayFeeMax',
							title : '限制单笔支付金额区间上限',
							width : 200,
							editor : {type:'validatebox',options:{required : false,validType:'length[1,10]'}},
							formatter : function(value,row,index){
								if(value!=null){
									return "<font>￥"+value/100+"</font>";
								}
	 						}
						},
						{
							field : 'limitPayCountMin',
							title : '限制支付笔数下限',
							width : 150,
							editor : {type:'validatebox',options:{required : false,validType:'length[1,10]'}}
						},
						{
							field : 'limitPayCountMax',
							title : '限制支付笔数上限',
							width : 150,
							editor : {type:'validatebox',options:{required : false,validType:'length[1,10]'}}
						},
						{
							field : 'oper',
							title : '操作',
							width : 150,
							align : 'center',
							formatter : function(value, row, index) {
								dataOrderLimit = row;
								console.log(dataOrderLimit);
								var id = row.id;
								var tigerConfId = row.tigerConfId;
								if (row.editing) {
									var s = '<a href="#" style="color:green" onclick="saveRowOrderLimit(this)">保存</a> | ';
									var c = '<a href="#" style="color:green" onclick="cancelRowOrderLimit(this)">取消</a>';
									return s + c;
								} else {
									var a = '<a href="#" style="color:green" onclick="issueTicket(\''+id+'\',\''+tigerConfId+'\')">配置停车券</a> | ';
									var d = '<a href="#" style="color:green" onclick="deleteRowOrderLimit(this)">删除</a>';
									return a+d;
								}
							}
						}, ] ],
				onBeforeEdit : function(index, row) {
					row.editing = true;
					updateActionsOrderLimit(index);
				},
				onAfterEdit : function(index, row) {
					row.editing = false;
					updateActionsOrderLimit(index);
				},
				onCancelEdit : function(index, row) {
					row.editing = false;
					updateActionsOrderLimit(index);
				},
				toolbar : [ {
					id : 'btnadd',
					text : '添加',
					btnType : 'add',
					iconCls : 'icon-add',
					handler : function() {
						addRowOrderLimit();
					}
				} ]
			});
}

//orderLimit
function updateActionsOrderLimit(index) {
	$('#orderLimit').datagrid('updateRow', {
		index : index,
		row : {}
	});
}
function addRowOrderLimit() {
	$('#orderLimit').datagrid('insertRow', {
		index : 0,
		row : {}
	});
	$('#orderLimit').datagrid('selectRow', 0);
	$('#orderLimit').datagrid('beginEdit', 0);
}
function saveRowOrderLimit(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#orderLimit').datagrid('endEdit', index);
	var urlOrderLimit=null;
	if(dataOrderLimit.tigerConfId){
		//双击修改
		urlOrderLimit='saveOrderLimit.do';
	}else{
		//保存
		urlOrderLimit='saveOrderLimit.do?tigerConfId='+rowsDeploy[0].id;
	}
	if(dataOrderLimit.limitType==null || dataOrderLimit.limitType=='' || dataOrderLimit.limitType=='undefined'){
		$.messager.show({ title : '提示', msg : '必填项不能为空' });
		return ;
	}
	if(dataOrderLimit.ticketCount==null || dataOrderLimit.ticketCount=='' || dataOrderLimit.ticketCount=='undefined'){
		$.messager.show({ title : '提示', msg : '必填项不能为空' });
		return ;
	}
	if(isNaN(dataOrderLimit.ticketCount)){
		$.messager.show({ title : '提示', msg : '券张数必须是数字' });
		$('#orderLimit').datagrid('reload');
		return ;
	}
	if(isNaN(dataOrderLimit.limitPayFeeMin)||isNaN(dataOrderLimit.limitPayFeeMax)||
			isNaN(dataOrderLimit.limitOnepayFeeMin)||isNaN(dataOrderLimit.limitOnepayFeeMax)||
			isNaN(dataOrderLimit.limitPayCountMin)||isNaN(dataOrderLimit.limitPayCountMax)){
		$.messager.show({ title : '提示', msg : '上下限必须是数字' });
		$('#orderLimit').datagrid('reload');
		return ;
	}
	if(dataOrderLimit.limitPayFeeMin>dataOrderLimit.limitPayFeeMax||
			dataOrderLimit.limitOnepayFeeMin>dataOrderLimit.limitOnepayFeeMax||
			dataOrderLimit.limitPayCountMin>dataOrderLimit.limitPayCountMax){
		$.messager.show({ title : '提示', msg : '下限不能大于上限' });
		$('#orderLimit').datagrid('reload');
		return ;
	}
	$.ajax({
		url : urlOrderLimit,
		type : 'post',
		data : {
			id:dataOrderLimit.id,
			limitType : dataOrderLimit.limitType,
			ticketCount : dataOrderLimit.ticketCount,
			limitPayFeeMin : dataOrderLimit.limitPayFeeMin,
			limitPayFeeMax : dataOrderLimit.limitPayFeeMax,
			limitOnepayFeeMin : dataOrderLimit.limitOnepayFeeMin,
			limitOnepayFeeMax : dataOrderLimit.limitOnepayFeeMax,
			limitPayCountMin : dataOrderLimit.limitPayCountMin,
			limitPayCountMax : dataOrderLimit.limitPayCountMax,
		},
		success : function(result) {
			$.messager.show({
				title : '提示',
				msg : result.msg
			});
			if (result.success) {
				$('#orderLimit').datagrid('reload');
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

function cancelRowOrderLimit(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#orderLimit').datagrid('cancelEdit', index);
	$('#orderLimit').datagrid('reload');
}

function deleteRowOrderLimit(target) {
	$.messager.confirm('提示', '您确定要删除吗?', function(r){
        if (r){
        	var tr = $(target).closest('tr.datagrid-row');
        	var index = parseInt(tr.attr('datagrid-row-index'));
        	var rows = $('#orderLimit').datagrid('getSelected');
    		$.ajax({
    			url : 'deleteOrderLimit.do?id='+rows.id,
    			type : 'post',
    			success : function(result) {
    				$.messager.show({
    					title : '提示',
    					msg : result.msg
    				});
    				if (result.success) {
    					$('#orderLimit').datagrid('reload');
    				}
    			}
    		});
        }
	});
}

//订单策略中的停车券配置
function issueTicket(tigerConfLimitId,tigerConfId){
	$('#ticketRel').dialog('open');
	$('#tigerTicketRel').datagrid(
			{
				rownumbers : true,
				title : '触发配置停车券（双击进行修改）',
				fitColumns : true,
				singleSelect : true,
				url : 'getTicketRelByLimit.do?tigerConfLimitId=' + tigerConfLimitId,
				width : 850,
				height : 300,
				onDblClickRow : function(index, data) {
					$('#tigerTicketRel').datagrid('beginEdit', index);
				},
				columns : [ [
						{
							field : 'id',
							hidden : true
						},
						{
							field : 'tigerConfId',
							hidden : true
						},
						{
							field : 'tigerConfLimitId',
							hidden : true
						},
						{
							field : 'ticketConfId',
							hidden : true
						},
						{
							field : 'ticketName',
							title : '券名称',
							width : 150,
							editor : {type:'combobox',
								options : {
									valueField : 'id',
									textField : 'text',
									method : 'get',
									url : 'getTicketName.do?tigerConfId='+tigerConfId,
									editable:false,
									required : true
								}
							},
							align : 'center',
						},
						{
							field : 'weight',
							title : '权重（指定策略为100）',
							width : 80,
							editor : {type:'validatebox',
								options:{required : true,validType:'length[1,4]'}
							},
							align : 'center',
						},
						{
							field : 'oper',
							title : '操作',
							width : 100,
							align : 'center',
							formatter : function(value, row, index) {
								dataTicketRel = row;
								if (row.editing) {
									var s = '<a href="#" style="color:green" onclick="saveRowTicketRel(this)">保存</a> | ';
									var c = '<a href="#" style="color:green" onclick="cancelRowTicketRel(this)">取消</a>';
									return s + c;
								} else {
									var d = '<a href="#" style="color:green" onclick="deleteRowTicketRel(this)">删除</a>';
									return d;
								}
							}
						}, ] ],
				onBeforeEdit : function(index, row) {
					row.editing = true;
					updateActionsTicketRel(index);
				},
				onAfterEdit : function(index, row) {
					row.editing = false;
					updateActionsTicketRel(index);
				},
				onCancelEdit : function(index, row) {
					row.editing = false;
					updateActionsTicketRel(index);
				},
				toolbar : [ {
					id : 'btnadd',
					text : '添加',
					btnType : 'add',
					iconCls : 'icon-add',
					handler : function() {
						addRowTicketRel();
					}
				} ]
			});
}

//TicketRel表格
function updateActionsTicketRel(index) {
	$('#tigerTicketRel').datagrid('updateRow', {
		index : index,
		row : {}
	});
}
function addRowTicketRel() {
	$('#tigerTicketRel').datagrid('insertRow', {
		index : 0,
		row : {}
	});
	$('#tigerTicketRel').datagrid('selectRow', 0);
	$('#tigerTicketRel').datagrid('beginEdit', 0);
}
function saveRowTicketRel(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#tigerTicketRel').datagrid('endEdit', index);
	var urlTicketRel=null;
	if(dataTicketRel.tigerConfLimitId){
		//双击修改
		urlTicketRel='saveTicketRel.do';
	}else{
		//保存
		urlTicketRel='saveTicketRel.do?tigerConfLimitId='+dataOrderLimit.id;
	}
	if(dataTicketRel.ticketName==null || dataTicketRel.ticketName=='' || dataTicketRel.ticketName=='undefined'){
		$.messager.show({ title : '提示', msg : '必填项不能为空' });
		return ;
	}
	if(dataTicketRel.weight==null || dataTicketRel.weight=='' || dataTicketRel.weight=='undefined'){
		$.messager.show({ title : '提示', msg : '必填项不能为空' });
		return ;
	}
	if(isNaN(dataTicketRel.weight)){
		$.messager.show({ title : '提示', msg : '权重必须是数字' });
		$('#tigerTicketRel').datagrid('reload');
		return ;
	}
	$.ajax({
		url : urlTicketRel,
		type : 'post',
		data : {
			id:dataTicketRel.id,
			tigerConfId : dataTicketRel.tigerConfId,
			tigerConfLimitId : dataTicketRel.tigerConfLimitId,
			ticketConfId : dataTicketRel.ticketConfId,
			ticketName : dataTicketRel.ticketName,
			weight:dataTicketRel.weight
		},
		success : function(result) {
			$.messager.show({
				title : '提示',
				msg : result.msg
			});
			if (result.success) {
				$('#tigerTicketRel').datagrid('reload');
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

function cancelRowTicketRel(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#tigerTicketRel').datagrid('cancelEdit', index);
	$('#tigerTicketRel').datagrid('reload');
}

function deleteRowTicketRel(target) {
	$.messager.confirm('提示', '您确定要删除吗?', function(r){
        if (r){
        	var tr = $(target).closest('tr.datagrid-row');
        	var index = parseInt(tr.attr('datagrid-row-index'));
        	var rows = $('#tigerTicketRel').datagrid('getSelected');
    		$.ajax({
    			url : 'deleteTicketRel.do?id='+rows.id,
    			type : 'post',
    			success : function(result) {
    				$.messager.show({
    					title : '提示',
    					msg : result.msg
    				});
    				if (result.success) {
    					$('#tigerTicketRel').datagrid('reload');
    				}
    			}
    		});
        }
	});
}

function showTicket(tigerConfId){
	$('#tigerTicketRelByRandom').datagrid(
			{
				rownumbers : true,
				title : '触发配置停车券（双击进行修改）',
				fitColumns : true,
				singleSelect : true,
				url : 'getTicketRelByTiger.do?tigerConfId=' + tigerConfId,
				width : 1050,
				height : 300,
				onDblClickRow : function(index, data) {
					$('#tigerTicketRelByRandom').datagrid('beginEdit', index);
				},
				columns : [ [
						{
							field : 'id',
							hidden : true
						},
						{
							field : 'tigerConfId',
							hidden : true
						},
						{
							field : 'tigerConfLimitId',
							hidden : true
						},
						{
							field : 'ticketConfId',
							hidden : true
						},
						{
							field : 'ticketName',
							title : '券名称',
							width : 150,
							editor : {type:'combobox',
								options : {
									valueField : 'id',
									textField : 'text',
									method : 'get',
									url : 'getTicketName.do?tigerConfId='+tigerConfId,
									editable:false,
									required : true
								}
							},
							align : 'center',
						},
						{
							field : 'weight',
							title : '权重（指定策略为100）',
							width : 80,
							editor : {type:'validatebox',
								options:{required : true,validType:'length[1,4]'}
							},
							align : 'center',
						},
						{
							field : 'oper',
							title : '操作',
							width : 100,
							align : 'center',
							formatter : function(value, row, index) {
								dataTicketRelByRandom = row;
								if (row.editing) {
									var s = '<a href="#" style="color:green" onclick="saveRowTicketRelByRandom(this)">保存</a> | ';
									var c = '<a href="#" style="color:green" onclick="cancelRowTicketRelByRandom(this)">取消</a>';
									return s + c;
								} else {
									var d = '<a href="#" style="color:green" onclick="deleteRowTicketRelByRandom(this)">删除</a>';
									return d;
								}
							}
						}, ] ],
				onBeforeEdit : function(index, row) {
					row.editing = true;
					updateActionsTicketRelByRandom(index);
				},
				onAfterEdit : function(index, row) {
					row.editing = false;
					updateActionsTicketRelByRandom(index);
				},
				onCancelEdit : function(index, row) {
					row.editing = false;
					updateActionsTicketRelByRandom(index);
				},
				toolbar : [ {
					id : 'btnadd',
					text : '添加',
					btnType : 'add',
					iconCls : 'icon-add',
					handler : function() {
						addRowTicketRelByRandom();
					}
				} ]
			});
}


//TicketRel表格
function updateActionsTicketRelByRandom(index) {
	$('#tigerTicketRelByRandom').datagrid('updateRow', {
		index : index,
		row : {}
	});
}
function addRowTicketRelByRandom() {
	$('#tigerTicketRelByRandom').datagrid('insertRow', {
		index : 0,
		row : {}
	});
	$('#tigerTicketRelByRandom').datagrid('selectRow', 0);
	$('#tigerTicketRelByRandom').datagrid('beginEdit', 0);
}

//随机策略配置停车券
function saveRowTicketRelByRandom(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#tigerTicketRelByRandom').datagrid('endEdit', index);
	var urlTicketRelByRandom=null;
	if(dataTicketRelByRandom.tigerConfId){
		//双击修改
		urlTicketRelByRandom='saveTicketRelByRandom.do';
	}else{
		console.log("1:"+rowsDeploy[0].id);
		console.log("2:"+dataTicketRelByRandom.tigerConfId);
		//保存
		urlTicketRelByRandom='saveTicketRelByRandom.do?tigerConfId='+rowsDeploy[0].id;
	}
	if(dataTicketRelByRandom.ticketName==null || dataTicketRelByRandom.ticketName=='' || dataTicketRelByRandom.ticketName=='undefined'){
		$.messager.show({ title : '提示', msg : '必填项不能为空' });
		return ;
	}
	if(dataTicketRelByRandom.weight==null || dataTicketRelByRandom.weight=='' || dataTicketRelByRandom.weight=='undefined'){
		$.messager.show({ title : '提示', msg : '必填项不能为空' });
		return ;
	}
	if(isNaN(dataTicketRelByRandom.weight)){
		$.messager.show({ title : '提示', msg : '权重必须是数字' });
		$('#tigerTicketRelByRandom').datagrid('reload');
		return ;
	}
	$.ajax({
		url : urlTicketRelByRandom,
		type : 'post',
		data : {
			id:dataTicketRelByRandom.id,
			tigerConfId : dataTicketRelByRandom.tigerConfId,
			tigerConfLimitId : dataTicketRelByRandom.tigerConfLimitId,
			ticketConfId : dataTicketRelByRandom.ticketConfId,
			ticketName : dataTicketRelByRandom.ticketName,
			weight:dataTicketRelByRandom.weight
		},
		success : function(result) {
			$.messager.show({
				title : '提示',
				msg : result.msg
			});
			if (result.success) {
				$('#tigerTicketRelByRandom').datagrid('reload');
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

function cancelRowTicketRelByRandom(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#tigerTicketRelByRandom').datagrid('cancelEdit', index);
	$('#tigerTicketRelByRandom').datagrid('reload');
}

function deleteRowTicketRelByRandom(target) {
	$.messager.confirm('提示', '您确定要删除吗?', function(r){
      if (r){
      	var tr = $(target).closest('tr.datagrid-row');
      	var index = parseInt(tr.attr('datagrid-row-index'));
      	var rows = $('#tigerTicketRelByRandom').datagrid('getSelected');
  		$.ajax({
  			url : 'deleteTicketRel.do?id='+rows.id,
  			type : 'post',
  			success : function(result) {
  				$.messager.show({
  					title : '提示',
  					msg : result.msg
  				});
  				if (result.success) {
  					$('#tigerTicketRelByRandom').datagrid('reload');
  				}
  			}
  		});
      }
	});
}
$(function(){
	app.activityTigerConf.init();
});	
