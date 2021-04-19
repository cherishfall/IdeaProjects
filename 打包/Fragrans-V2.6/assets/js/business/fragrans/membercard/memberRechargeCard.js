$package('membercard.memberRechargeCard');
membercard.memberRechargeCard = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
//						{field:'id',checkbox:true},
	 					{field:'batchId',title:'批次ID',sortable:true,width:60},
	 					{field:'rechargeCardNo',title:'充值卡号',sortable:true,width:120},
	 					{field:'password',title:'充值卡密码',sortable:true,width:100},
	 					{field:'denomination',title:'充值卡面额',sortable:true,width:100,
	 						formatter:function(value,row,index){
	 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
	 						}},
	 					{field:'validDate',title:'到期时间',sortable:true,width:100,
 							formatter:function(value,row,index){
	 							return value.split(" ")[0]+" 23:59:59";
	 						}},
	 					{field:'isUsed',title:'是否已使用',sortable:true,width:100,
	 						formatter:sys.dicts.text('YESORNO')},
	 					{field:'isOvertime',title:'是否已过期',sortable:true,width:100,
		 						formatter:sys.dicts.text('YESORNO')},
 						{field:'producer',title:'生成人',sortable:true,width:100},
 						{field:'isRecevice',title:'是否已领取',sortable:true,width:100,
	 						formatter:sys.dicts.text('YESORNO')},
						{field:'recevicer',title:'领取人',sortable:true,width:100},
//	 					{field:'flag',title:'操作标示 ADD：增加 UPDATE:修改 DELETE:删除',sortable:true},
//	 					{field:'createdBy',title:'创建人',sortable:true},
//	 					{field:'updatedBy',title:'修改人',sortable:true},
	 					{field:'createTime',title:'创建时间',sortable:true,width:100}
//	 					{field:'updateTime',title:'更新时间',sortable:true}
			 	]],
				toolbar:[
					{id:'btncreate',text:'生成',btnType:'createMRC',iconCls : 'ext-icon-book_edit',
						handler : function() {
							create();
					}},
					{id:'btnrecevice',text:'领取',btnType:'receviceMRC',iconCls : 'ext-icon-book_go',
						handler : function() {
							recevice();
					}},
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
	membercard.memberRechargeCard.init();
});	

/**
 * 打开生成充值卡编辑框
 */
function create(){
	$.ajax({
		url : 'getBatchId.do',
		type : 'post',
		success : function(result){
			$('#batchId').numberbox('setValue', result.data.batchId);
		}
	});
	$('#denomination').combobox({    
	    url:'../tag/getDictionaryItems.do?codeType=MEMBER_REC_CARD_DENO&isDefaultLine=1&isCommon=1',    
	    valueField:'codeValue',    
	    textField:'codeText'   
	}); 
	$('#create_win').dialog('open');
}

/**
 * 打开领取编辑框
 */
function recevice(){
	$('#receviceBatchId').combobox({
		url : 'getReceviceBatchId.do',
		valueField : 'codeValue',
		textField : 'codeText',
		required: true,
		multiple : true,
		width : 200,
		formatter : function(row) {
			var s = "<span><p class='selectId' style='vertical-align: middle' id='selectId_"
					+ row.codeValue
					+ "'/>"
					+ row.codeText
					+ "<span>";
			return s;
		},
		onSelect : function(record) {
			$("#selectId_" + record.codeValue).attr(
					"checked", true);
		},
		onUnselect : function(record) {
			$("#selectId_" + record.codeValue).attr(
					"checked", false);
		}
	});
	$('#recevice_win').dialog('open');
}

/**
 * 提交生成充值卡请求
 */
$('#submit').bind('click',function(){
	var param = $('#createForm').serializeObject();
	var batchId = param.batchId;
	var denomination = param.denomination;
	var validDate = param.validDate;
	var prodeceCount = param.prodeceCount;
	if(isEmpty(batchId)){
		sys.alert('提示', '批次ID不可为空~', 'warning');
		return;
	}
	if(isEmpty(denomination)){
		sys.alert('提示', '充值卡面额不可为空~', 'warning');
		return;
	}
	if(isEmpty(validDate)){
		sys.alert('提示', '充值卡有效期不可为空~', 'warning');
		return;
	}
	if(isEmpty(prodeceCount)){
		sys.alert('提示', '充值卡生成张数不可为空~', 'warning');
		return;
	}
	if(prodeceCount <= 0){
		$.messager.alert('提示','生成张数必须大于0~');  
		 return;
	}
	if (validDate < getNowDay()) {
		sys.alert('警告', '有效期小于当前时间~', 'warning');
		return;
	}
	$.ajax({
		url : 'createMemberRechargeCard.do',
		type : 'post',
		data : {
			"batchId":batchId,
			"denomination":denomination,
			"validDate":validDate,
			"prodeceCount":prodeceCount
		},
		success : function(result){
			$.messager.show({
				title : '提示',
				msg : result.msg
			});
			if (result.success) {
				$('#createForm').form('clear');
				$('#create_win').dialog('close');
				$('#data-list').datagrid('reload');
			}  
		}
	});

});

/**
 * 关闭生成充值卡请求
 */
$('#close').bind('click',function(){
	$('#createForm').form('clear');
	$('#create_win').dialog('close');
});


/**
 * 提交领取充值卡请求
 */
$('#receviceSubmit').bind('click',function(){
	$.messager.confirm('确认', '确认领取该批次充值卡？', function(r) {
		if (r) {
			var param = $('#receviceForm').serializeObject();
			var batchId = param.batchId;
			if(isEmpty(batchId)){
				sys.alert('提示', '批次ID不可为空~', 'warning');
				return;
			}
			//导出充值卡
			window.open('exportMemberRechargeCard.do?batchId=' + tranStr(batchId));
			//更新充值卡已领取
			$.ajax({
				url : 'receviceMemberRechargeCard.do',
				type : 'post',
				data : {
					"batchId":tranStr(batchId)
				},
				success : function(result){
					$.messager.show({
						title : '提示',
						msg : result.msg
					});
					if (result.success) {
						$('#receviceForm').form('clear');
						$('#recevice_win').dialog('close');
						$('#data-list').datagrid('reload');
					}  
				}
			});
		}
	});
	
	
//	$.ajax({
//		url : 'receviceMemberRechargeCard.do',
//		type : 'post',
//		data : {
//			"batchId":tranStr(batchId)
//		},
//		success : function(result){
//			$.messager.show({
//				title : '提示',
//				msg : result.msg
//			});
//			if (result.success) {
//				$('#receviceForm').form('clear');
//				$('#recevice_win').dialog('close');
//				$('#data-list').datagrid('reload');
//			}  
//		}
//	});
	

});

function tranStr(str){
	if(str != null){
		return str.toString();
	}
	return null;
}

/**
 * 关闭生成充值卡请求
 */
$('#receviceClose').bind('click',function(){
	$('#receviceForm').form('clear');
	$('#recevice_win').dialog('close');
});
