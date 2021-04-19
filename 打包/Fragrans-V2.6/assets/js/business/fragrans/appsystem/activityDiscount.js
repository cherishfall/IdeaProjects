$package('sys.activityDiscount');
sys.activityDiscount = function(){
	var _box = null;
	var _this = {
		selectadd : function(){
			setBusiType();
			setDiscountStrat();
		},
		selectedit : function(){
			setBusiType();
			_box.handler.edit(function(result) {
				$('#editForm').form('clear');
				$('#editForm').form('load', result.data);
				if (result.data.busiTypeCode.length == 0) {
					$('#busiType').combobox('reload');
				} else {
					$.each(result.data.busiTypeCode, function(i, _busiType) {
						$("#selectId_" + _busiType).attr("checked", true);
					});
				}
			});
			setDiscountStrat();
			_box.handler.edit(function(result) {
				$('#editForm').form('clear');
				$('#editForm').form('load', result.data);
				if (result.data.discountStratCode.length == 0) {
					$('#discountStrat').combobox('reload');
				} else {
					$.each(result.data.discountStratCode, function(i, _busiType) {
						$("#selectId_" + _busiType).attr("checked", true);
					});
				}
			});
		},
		config:{
  			dataGrid:{
  				idField : 'id',
  				title:'活动列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
						{field:'id',checkbox:true},
						{field:'activityTopicName',title:'主题活动',width:100,sortable:true},
						{field:'discountName',title:'活动名称',width:100,sortable:true},
						{field:'areaCodes',title:'活动地区',width:100,sortable:true},
						{field:'startTime',title:'折扣开始时间',width:100,sortable:true,
							formatter:function(value,row,index){
								return value.split(" ")[0];
							}},
						{field:'endTime',title:'折扣结束时间',width:100,sortable:true,
								formatter:function(value,row,index){
									return value.split(" ")[0];
								}},
						{field:'fulluse',title:'满折金额',width:100,sortable:true},
						{field:'maxdiscountFee',title:'最高折扣',width:100,sortable:true},
//						{field:'displayNum',title:'优先级',width:100,sortable:true},
						{field:'isCoverly',title:'是否可叠加停车券',width:100,sortable:true,formatter : sys.dicts.text('YESORNO')},
						{field:'isValid',title:'是否有效',width:100,sortable:true,formatter : sys.dicts.text('YESORNO')}
				]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add',handler : function() {
						_this.selectadd();
//						_box.handler.add();
						add(); 
						}},
					{id:'btnedit',text:'修改',btnType:'edit',handler : function() { 
						var rows = $('#data-list').datagrid('getChecked');
						if(rows.length==1){
							_this.selectedit();
							_box.handler.edit();
							edit();
						}else{
							sys.alert('警告','请选择一行.','warning');  
						}
						 }},
				    {id:'btndelete',text:'删除',btnType:'remove',iconCls : 'icon-remove',
						handler : function() {
							var rows = $('#data-list').datagrid('getChecked');
							$.messager.confirm('确认', '确认删除？', function(r) {
								if(r){
									var ids = '';
							    	$.each(rows,function(i,row){
							    		ids+=row.id+','
							    	});
								$.ajax({
									url:'delete.do',
									type:'post',
									dataType:'json',
									data:{
										ids : ids
									},
									success:function(result){
										$('#data-list').datagrid('clearChecked');
										$('#data-list').datagrid('reload');
										$.messager.show({
											msg : result.msg,
											title : '提示'
										});
									}
								});
							}
						});
					}},
				]
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
			$('#ztree').dialog({
				buttons : [ {
					text : '确定',
					handler : function() {
						$('#ztree').dialog('close');
					}
				}
				]
			});
		}
	}
	return _this;
}();

$(function(){
    sys.activityDiscount.init();   
});	

function setBusiType(){
	$('#busiType').combobox({
		url : 'getBusiType.do',
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

function setDiscountStrat(){
	$('#discountStrat').combobox({
		url : 'getDiscountStrat.do',
		valueField : 'id',
		textField : 'name',
		multiple : true,
		width : 180,
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

function add(){
	addBaseStrat();
    addPayTimeStrat();
    addPhotoStrat();
    addBatchpayStrat();
	var combos = $("#editForm .easyui-combobox");
	$.each(combos,function(i,combo){
		var id = '#'+combo.id;
		$(id).combobox('reset');
	});
	$('#editForm').form('clear');
	$('#edit-win').dialog({
				buttons : [
						   {
							text : '提交',
							handler : function() {
								var baseRows = $('#btn-dg-base').datagrid('getRows');
								var base = "";
								$.each(baseRows, function(i, row) {
									var info = row.discountDesc + "," + row.discount ;
									base = base + info + ";";
								});
								var payTimeRows = $('#btn-dg-paytime').datagrid('getRows');
								var payTime = "";
								$.each(payTimeRows, function(i, row) {
									var info = row.discountDesc + "," + row.discount + ","+row.stratType+ ","+ row.value;
									payTime = payTime + info + ";";
								});
								var PhotoRows = $('#btn-dg-photo').datagrid('getRows');
								var photo = "";
								$.each(PhotoRows, function(i, row) {
									var info = row.discountDesc + "," + row.discount + ","+row.stratType+ ","+ row.value;
									photo = photo + info + ";";
								});
								var batchpayRows = $('#btn-dg-batchpay').datagrid('getRows');
								var batchpay = "";
								$.each(batchpayRows, function(i, row) {
									var info = row.discountDesc + "," + row.discount ;
									batchpay = batchpay + info + ";";
								});
								var param = $('#editForm').serializeObject();
								var id = param.id;
								var busiType = tranStr(param.busiTypeCode);
							    var discountStrat = tranStr(param.discountStratCode);
								var discountName = param.discountName;
								var startTime = param.startTime;
								var endTime = param.endTime;
								var fulluse = param.fulluse;
								var maxdiscountFee = param.maxdiscountFee;
								var isCoverly = param.isCoverly;
								var isValid = param.isValid;
								var displayNum = param.displayNum;
								var activityTopicId = param.activityTopicId;
								var areaCodes = param.areaCode;
								var displayNum = param.displayNum;
								if (endTime < startTime) {
									$.messager.show({
										title : '提示',
										msg : "开始时间不能大于结束时间"
									});
									return;
								}
								$.ajax({
									url : 'save.do',
									type : 'post',
									data : {
										"id":id,   
										"base" : base,
										"payTime":payTime,
										"photo":photo,
										"batchpay":batchpay,
										"discountName":discountName,
										"startTime":startTime,
										"endTime":endTime,
										"fulluse":fulluse,
										"maxdiscountFee":maxdiscountFee,
										"isCoverly":isCoverly,
										"displayNum":displayNum,
										"activityTopicId":activityTopicId,
									    "areaCodes":areaCodes,
									    "busiType":busiType,
									    "discountStrat":discountStrat,
									    "isValid":isValid,
									    "displayNum":displayNum,
									},
									success : function(result) {
										$.messager.show({
											title : '提示',
											msg : result.msg
										});
										if (result.success) {
//											$('#btn-dg-base').datagrid('loadData', { total: 0, rows: [] });
//											$('#btn-dg-photo').datagrid('loadData', { total: 0, rows: [] });
//											$('#btn-dg-paytime').datagrid('loadData', { total: 0, rows: [] });
											$('#edit-win').dialog("close");
											$('#data-list').datagrid('reload');
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
	$('#edit-win').dialog('open');	
}
function edit(){
	editBaseStrat();
    editPayTimeStrat();
    editPhotoStrat();
    editBatchpayStrat();
	$('#edit-win').dialog('open');	
	$('#edit-win').dialog({
				buttons : [
						   {
							text : '提交',
							handler : function() {
								var baseRows = $('#btn-dg-base').datagrid('getRows');
								var base = "";
								$.each(baseRows, function(i, row) {
									var info = row.discountDesc + "," + row.discount ;
									base = base + info + ";";
								});
								var payTimeRows = $('#btn-dg-paytime').datagrid('getRows');
								var payTime = "";
								$.each(payTimeRows, function(i, row) {
									var info = row.discountDesc + "," + row.discount + ","+row.stratType+ ","+ row.value;
									payTime = payTime + info + ";";
								});
								var PhotoRows = $('#btn-dg-photo').datagrid('getRows');
								var photo = "";
								$.each(PhotoRows, function(i, row) {
									var info = row.discountDesc + "," + row.discount + ","+row.stratType+ ","+ row.value;
									photo = photo + info + ";";
								});	
								var batchpayRows = $('#btn-dg-batchpay').datagrid('getRows');
								var batchpay = "";
								$.each(batchpayRows, function(i, row) {
									var info = row.discountDesc + "," + row.discount ;
									batchpay = batchpay + info + ";";
								});
								var param = $('#editForm').serializeObject();
								var id = param.id;
								var busiType = tranStr(param.busiTypeCode);
							    var discountStrat = tranStr(param.discountStratCode);
								var discountName = param.discountName;
								var startTime = param.startTime;
								var endTime = param.endTime;
								var fulluse = param.fulluse;
								var maxdiscountFee = param.maxdiscountFee;
								var isCoverly = param.isCoverly;
								var displayNum = param.displayNum;
								var activityTopicId = param.activityTopicId;
								var areaCodes = param.areaCode;
								var isValid = param.isValid;
								var displayNum = param.displayNum;
								if (endTime < startTime) {
									$.messager.show({
										title : '提示',
										msg : "开始时间不能大于结束时间"
									});
									return;
								}
								$.ajax({
									url : 'save.do',
									type : 'post',
									data : {
										"id":id,   
										"base" : base,
										"payTime":payTime,
										"photo":photo,
										"batchpay":batchpay,
										"discountName":discountName,
										"startTime":startTime,
										"endTime":endTime,
										"fulluse":fulluse,
										"maxdiscountFee":maxdiscountFee,
										"isCoverly":isCoverly,
										"displayNum":displayNum,
										"activityTopicId":activityTopicId,
//										activityTopicName:activityTopicName,
									    "areaCodes":areaCodes,
									    "busiType":busiType,
									    "discountStrat":discountStrat,
									    "isValid":isValid,
									    "displayNum":displayNum,
									},
									success : function(result) {
										$.messager.show({
											title : '提示',
											msg : result.msg
										});
										if (result.success) {
//											$('#btn-dg-base').datagrid('loadData', { total: 0, rows: [] });
//											$('#btn-dg-photo').datagrid('loadData', { total: 0, rows: [] });
//											$('#btn-dg-paytime').datagrid('loadData', { total: 0, rows: [] });
											$('#edit-win').dialog("close");
											$('#data-list').datagrid('reload');
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
	$('#edit-win').dialog('open');	
}

$('#activityTopicName').combobox({
	title:'列表',
	url:'getActivityDiscountTopic.do',
	fit : true,
	valueField : 'activityTopicId',
	textField : 'activityTopicName',
});
function updateActionsBase(index) {
	$('#btn-dg-base').datagrid('updateRow', {
		index : index,
		row : {}
	});
}

function updateActionsBathchpay(index) {
	$('#btn-dg-batchpay').datagrid('updateRow', {
		index : index,
		row : {}
	});
}

function tranStr(busiTypeCode){
	if(busiTypeCode != null){
		return busiTypeCode.toString();
	}
	return null;
}

function updateActionsPhoto(index) {
	$('#btn-dg-photo').datagrid('updateRow', {
		index : index,
		row : {}
	});
}
function updateActionsPayTime(index) {
	$('#btn-dg-paytime').datagrid('updateRow', {
		index : index,
		row : {}
	});
}
function updateActionsBatchpay(index) {
	$('#btn-dg-batchpay').datagrid('updateRow', {
		index : index,
		row : {}
	});
}
function ztreeAdd(){
	var id = 'all';
	var objId = '';
	var rows = $('#data-list').datagrid('getChecked');
	if(rows.length == 1){
		objId = rows[0].id;
	}
	$('#ztree').dialog({    
		maximizable:true,
		href: '../view/fragrans/appsystem/excheck.jsp?param='+id+'&objId='+objId,    
	});
	$('#ztree').dialog("open");
}
function addRow(str) {
	$(str).datagrid('insertRow', {
		index : 0,
		row : {}
	});
	$(str).datagrid('selectRow', 0);
	$(str).datagrid('beginEdit', 0);
}
function editBatchpayStrat(){
	var param = $('#editForm').serializeObject();
	var discountId = param.id;
	$('#btn-dg-batchpay').datagrid({
		rownumbers:true,
		title : '批量缴费策略（双击进行修改）',
		url : 'getStratBatchpay.do?id='+discountId,
		fitColumns : true,
		singleSelect:true,
		width : 400,
		onDblClickRow:function(index,data){
			$('#btn-dg-batchpay').datagrid('beginEdit', index);
		},
		columns : [ [ {
			field : 'id',
			hidden : true
		}, {
			field : 'discountDesc',
			title : '折扣描述',
			width : 80,
			editor : 'text',
			align : 'center'
		}, {
			field : 'discount',
			title : '折扣比例',
			width : 80,
			editor : 'text',
			align : 'center'
		}, {
			field : 'oper',
			title : '操作',
			width : 100,
			align : 'center',
			formatter : function(value, row, index) {
				if (row.editing) {
					var s = '<a href="#" onclick="saveRowBatchpay(this)">确定</a>';
					return s ;
				} else {
					var d = '<a href="#" onclick="deleteRowBatchpay(this)">删除</a>';
					return d;
				}
			}
		},
		] ],
		onBeforeEdit : function(index, row) {
			row.editing = true;
			updateActionsBathchpay(index);
		},
		onAfterEdit : function(index, row) {
			row.editing = false;
			updateActionsBathchpay(index);
		},
		onCancelEdit : function(index, row) {
			row.editing = false;
			updateActionsBathchpay(index);
		},
		toolbar : [ {
			id : 'btnadd',
			text : '添加',
			btnType : 'add',
			iconCls : 'icon-add',
			handler : function() {
				addRow('#btn-dg-batchpay');
			}
		} ]
	});
}

function editBaseStrat(){
	var param = $('#editForm').serializeObject();
	var discountId = param.id;
	$('#btn-dg-base').datagrid({
		rownumbers:true,
		title : '基本策略（双击进行修改）',
		url : 'getStratBasic.do?id='+discountId,
		fitColumns : true,
		singleSelect:true,
		width : 400,
		onDblClickRow:function(index,data){
			$('#btn-dg-base').datagrid('beginEdit', index);
		},
		columns : [ [ {
			field : 'id',
			hidden : true
		}, {
			field : 'discountDesc',
			title : '折扣描述',
			width : 80,
			editor : 'text',
			align : 'center'
		}, {
			field : 'discount',
			title : '折扣比例',
			width : 80,
			editor : 'text',
			align : 'center'
		}, {
			field : 'oper',
			title : '操作',
			width : 100,
			align : 'center',
			formatter : function(value, row, index) {
				if (row.editing) {
					var s = '<a href="#" onclick="saveRowBase(this)">确定</a>';
					return s ;
				} else {
					var d = '<a href="#" onclick="deleteRowBase(this)">删除</a>';
					return d;
				}
			}
		},
		] ],
		onBeforeEdit : function(index, row) {
			row.editing = true;
			updateActionsBase(index);
		},
		onAfterEdit : function(index, row) {
			row.editing = false;
			updateActionsBase(index);
		},
		onCancelEdit : function(index, row) {
			row.editing = false;
			updateActionsBase(index);
		},
		toolbar : [ {
			id : 'btnadd',
			text : '添加',
			btnType : 'add',
			iconCls : 'icon-add',
			handler : function() {
				addRow('#btn-dg-base');
			}
		} ]
	});
}
function editPayTimeStrat(){
	var param = $('#editForm').serializeObject();
	var discountId = param.id;
	$('#btn-dg-paytime').datagrid({
		rownumbers:true,
		title : '付款策略（双击进行修改）',
		fitColumns : true,
		url : 'getStratPayTime.do?id='+discountId,
		singleSelect:true,
		width : 400,
		onDblClickRow:function(index,data){
			$('#btn-dg-paytime').datagrid('beginEdit', index);
		},
		columns : [ [ {
			field : 'id',
			hidden : true
		}, {
			field : 'discountDesc',
			title : '折扣描述',
			width : 80,
			editor : 'text',
			align : 'center'
		}, {
			field : 'discount',
			title : '折扣比例',
			width : 80,
			editor : 'text',
			align : 'center'
		}, { field: 'stratType', title: '策略类型', width: 120, align: 'center',
			formatter : function(value, row, index) {
				if (value==1) {
					return "当日付" ;
				} else {
					return "滞纳时长";
				}
			},
			editor: {
				type: 'combobox',
				options:{
				valueField: 'id',
				textField: 'stratName',
				url: 'getPayTimeStrat.do',}
				}
			 }, {
					field : 'value',
					title : '值',
					width : 80,
					editor : 'text',
					align : 'center'
				}, {
			field : 'oper',
			title : '操作',
			width : 100,
			align : 'center',
			formatter : function(value, row, index) {
				if (row.editing) {
					var s = '<a href="#" onclick="saveRowPayTime(this)">确定</a>';
					return s ;
				} else {
					var d = '<a href="#" onclick="deleteRowPayTime(this)">删除</a>';
					return d;
				}
			}
		},
		] ],
		onBeforeEdit : function(index, row) {
			row.editing = true;
			updateActionsPayTime(index);
		},
		onAfterEdit : function(index, row) {
			row.editing = false;
			updateActionsPayTime(index);
		},
		onCancelEdit : function(index, row) {
			row.editing = false;
			updateActionsPayTime(index);
		},
		toolbar : [ {
			id : 'btnadd',
			text : '添加',
			btnType : 'add',
			iconCls : 'icon-add',
			handler : function() {
				addRow('#btn-dg-paytime');
			}
		} ]
	});
}
function editPhotoStrat(){
	var param = $('#editForm').serializeObject();
	var discountId = param.id;
	$('#btn-dg-photo').datagrid({
		rownumbers:true,
		title : '拍照策略（双击进行修改）',
		fitColumns : true,
		url : 'getStratPhoto.do?id='+discountId,
		singleSelect:true,
		width : 400,
		onDblClickRow:function(index,data){
			$('#btn-dg-photo').datagrid('beginEdit', index);
		},
		columns : [ [ {
			field : 'id',
			hidden : true
		}, {
			field : 'discountDesc',
			title : '折扣描述',
			width : 80,
			editor : 'text',
			align : 'center'
		}, {
			field : 'discount',
			title : '折扣比例',
			width : 80,
			editor : 'text',
			align : 'center'
		},    { field: 'stratType', title: '策略类型', width: 120, align: 'center',
			formatter : function(value, row, index) {
				if (value==1) {
					return "有效率" ;
				} else {
					return "照片数";
				}
			},
			editor: {
			type: 'combobox',
			options:{
			valueField: 'id',
			textField: 'stratName',
			url: 'getPhotoStrat.do',}
			}
		 },{
				field : 'value',
				title : '值',
				width : 80,
				editor : 'text',
				align : 'center'
			}, 
		{
			field : 'oper',
			title : '操作',
			width : 100,
			align : 'center',
			formatter : function(value, row, index) {
				if (row.editing) {
					var s = '<a href="#" onclick="saveRowPhoto(this)">确定</a>';
					return s ;
				} else {
					var d = '<a href="#" onclick="deleteRowPhoto(this)">删除</a>';
					return d;
				}
			}
		},
		] ],
		onBeforeEdit : function(index, row) {
			row.editing = true;
			updateActionsPhoto(index);
		},
		onAfterEdit : function(index, row) {
			row.editing = false;
			updateActionsPhoto(index);
		},
		onCancelEdit : function(index, row) {
			row.editing = false;
			updateActionsPhoto(index);
		},
		toolbar : [ {
			id : 'btnadd',
			text : '添加',
			btnType : 'add',
			iconCls : 'icon-add',
			handler : function() {
				addRow('#btn-dg-photo');
			}
		} ]
	});
}

function saveRowBase(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg-base').datagrid('endEdit', index);
}
function deleteRowBase(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg-base').datagrid('deleteRow', index);
}
function cancelRowBase(target){
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg-base').datagrid('cancelEdit', index);
}

function saveRowBatchpay(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg-batchpay').datagrid('endEdit', index);
}
function deleteRowBatchpay(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg-batchpay').datagrid('deleteRow', index);
}
function cancelRowBatchpay(target){
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg-batchpay').datagrid('cancelEdit', index);
}


function saveRowPhoto(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg-photo').datagrid('endEdit', index);
}
function deleteRowPhoto(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg-photo').datagrid('deleteRow', index);
}
function cancelRowPhoto(target){
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg-photo').datagrid('cancelEdit', index);
}


function saveRowPayTime(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg-paytime').datagrid('endEdit', index);
}
function deleteRowPayTime(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg-paytime').datagrid('deleteRow', index);
}
function cancelRowPayTime(target){
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#btn-dg-paytime').datagrid('cancelEdit', index);
}

function addBaseStrat(){
	$('#btn-dg-base').datagrid({
		rownumbers:true,
		title : '基本策略（双击进行修改）',
		fitColumns : true,
		singleSelect:true,
		width : 400,
		onDblClickRow:function(index,data){
			$('#btn-dg-base').datagrid('beginEdit', index);
		},
		columns : [ [ {
			field : 'id',
			hidden : true
		}, {
			field : 'discountDesc',
			title : '折扣描述',
			width : 80,
			editor : 'text',
			align : 'center'
		}, {
			field : 'discount',
			title : '折扣比例',
			width : 80,
			editor : 'text',
			align : 'center'
		}, {
			field : 'oper',
			title : '操作',
			width : 100,
			align : 'center',
			formatter : function(value, row, index) {
				if (row.editing) {
					var s = '<a href="#" onclick="saveRowBase(this)">确定</a>';
					return s ;
				} else {
					var d = '<a href="#" onclick="deleteRowBase(this)">删除</a>';
					return d;
				}
			}
		},
		] ],
		onBeforeEdit : function(index, row) {
			row.editing = true;
			updateActionsBase(index);
		},
		onAfterEdit : function(index, row) {
			row.editing = false;
			updateActionsBase(index);
		},
		onCancelEdit : function(index, row) {
			row.editing = false;
			updateActionsBase(index);
		},
		toolbar : [ {
			id : 'btnadd',
			text : '添加',
			btnType : 'add',
			iconCls : 'icon-add',
			handler : function() {
				addRow('#btn-dg-base');
			}
		} ]
	});
}

function addBatchpayStrat(){
	$('#btn-dg-batchpay').datagrid({
		rownumbers:true,
		title : '批量缴费策略（双击进行修改）',
		fitColumns : true,
		singleSelect:true,
		width : 400,
		onDblClickRow:function(index,data){
			$('#btn-dg-batchpay').datagrid('beginEdit', index);
		},
		columns : [ [ {
			field : 'id',
			hidden : true
		}, {
			field : 'discountDesc',
			title : '折扣描述',
			width : 80,
			editor : 'text',
			align : 'center'
		}, {
			field : 'discount',
			title : '折扣比例',
			width : 80,
			editor : 'text',
			align : 'center'
		}, {
			field : 'oper',
			title : '操作',
			width : 100,
			align : 'center',
			formatter : function(value, row, index) {
				if (row.editing) {
					var s = '<a href="#" onclick="saveRowBatchpay(this)">确定</a>';
					return s ;
				} else {
					var d = '<a href="#" onclick="deleteRowBatchpay(this)">删除</a>';
					return d;
				}
			}
		},
		] ],
		onBeforeEdit : function(index, row) {
			row.editing = true;
			updateActionsBatchpay(index);
		},
		onAfterEdit : function(index, row) {
			row.editing = false;
			updateActionsBatchpay(index);
		},
		onCancelEdit : function(index, row) {
			row.editing = false;
			updateActionsBatchpay(index);
		},
		toolbar : [ {
			id : 'btnadd',
			text : '添加',
			btnType : 'add',
			iconCls : 'icon-add',
			handler : function() {
				addRow('#btn-dg-batchpay');
			}
		} ]
	});
}

function addPayTimeStrat(){
	$('#btn-dg-paytime').datagrid({
		rownumbers:true,
		title : '付款策略（双击进行修改）',
		fitColumns : true,
		singleSelect:true,
		width : 400,
		onDblClickRow:function(index,data){
			$('#btn-dg-paytime').datagrid('beginEdit', index);
		},
		columns : [ [ {
			field : 'id',
			hidden : true
		}, {
			field : 'discountDesc',
			title : '折扣描述',
			width : 80,
			editor : 'text',
			align : 'center'
		}, {
			field : 'discount',
			title : '折扣比例',
			width : 80,
			editor : 'text',
			align : 'center'
		}, { field: 'stratType', title: '策略类型', width: 120, align: 'center',
			formatter : function(value, row, index) {
				if (value==1) {
					return "当日付" ;
				} else {
					return "滞纳时长";
				}
			},
			editor: {
				type: 'combobox',
				options:{
				valueField: 'id',
				textField: 'stratName',
				url: 'getPayTimeStrat.do',}
				}
			 }, {
					field : 'value',
					title : '值',
					width : 80,
					editor : 'text',
					align : 'center'
				}, {
			field : 'oper',
			title : '操作',
			width : 100,
			align : 'center',
			formatter : function(value, row, index) {
				if (row.editing) {
					var s = '<a href="#" onclick="saveRowPayTime(this)">确定</a>';
					return s ;
				} else {
					var d = '<a href="#" onclick="deleteRowPayTime(this)">删除</a>';
					return d;
				}
			}
		},
		] ],
		onBeforeEdit : function(index, row) {
			row.editing = true;
			updateActionsPayTime(index);
		},
		onAfterEdit : function(index, row) {
			row.editing = false;
			updateActionsPayTime(index);
		},
		onCancelEdit : function(index, row) {
			row.editing = false;
			updateActionsPayTime(index);
		},
		toolbar : [ {
			id : 'btnadd',
			text : '添加',
			btnType : 'add',
			iconCls : 'icon-add',
			handler : function() {
				addRow('#btn-dg-paytime');
			}
		} ]
	});
}
function addPhotoStrat(){
	$('#btn-dg-photo').datagrid({
		rownumbers:true,
		title : '拍照策略（双击进行修改）',
		fitColumns : true,
		singleSelect:true,
		width : 400,
		onDblClickRow:function(index,data){
			$('#btn-dg-photo').datagrid('beginEdit', index);
		},
		columns : [ [ {
			field : 'id',
			hidden : true
		}, {
			field : 'discountDesc',
			title : '折扣描述',
			width : 80,
			editor : 'text',
			align : 'center'
		}, {
			field : 'discount',
			title : '折扣比例',
			width : 80,
			editor : 'text',
			align : 'center'
		},    { field: 'stratType', title: '策略类型', width: 120, align: 'center',
			formatter : function(value, row, index) {
				if (value==1) {
					return "有效率" ;
				} else {
					return "照片数";
				}
			},
			editor: {
			type: 'combobox',
			options:{
			valueField: 'id',
			textField: 'stratName',
			url: 'getPhotoStrat.do',}
			}
		 },{
				field : 'value',
				title : '值',
				width : 80,
				editor : 'text',
				align : 'center'
			}, 
		{
			field : 'oper',
			title : '操作',
			width : 100,
			align : 'center',
			formatter : function(value, row, index) {
				if (row.editing) {
					var s = '<a href="#" onclick="saveRowPhoto(this)">确定</a>';
					return s ;
				} else {
					var d = '<a href="#" onclick="deleteRowPhoto(this)">删除</a>';
					return d;
				}
			}
		},
		] ],
		onBeforeEdit : function(index, row) {
			row.editing = true;
			updateActionsPhoto(index);
		},
		onAfterEdit : function(index, row) {
			row.editing = false;
			updateActionsPhoto(index);
		},
		onCancelEdit : function(index, row) {
			row.editing = false;
			updateActionsPhoto(index);
		},
		toolbar : [ {
			id : 'btnadd',
			text : '添加',
			btnType : 'add',
			iconCls : 'icon-add',
			handler : function() {
				addRow('#btn-dg-photo');
			}
		} ]
	});
}

