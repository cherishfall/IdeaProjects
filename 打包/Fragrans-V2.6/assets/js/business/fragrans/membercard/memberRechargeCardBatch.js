$package('membercard.memberRechargeCardBatch');
membercard.memberRechargeCardBatch = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'batchId',title:'批次号码',sortable:true,width:60},
	 					{field:'denomination',title:'充值卡面额',sortable:true,width:120,
	 						formatter:function(value,row,index){
	 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
	 						}},
	 					{field:'prodeceCount',title:'生成张数',sortable:true,width:60},
	 					{field:'validDate',title:'到期时间',sortable:true,width:120,
 							formatter:function(value,row,index){
	 							return value.split(" ")[0]+" 23:59:59";
	 						}},
	 					{field:'isRecevice',title:'是否已领取',sortable:true,width:60,
		 						formatter:sys.dicts.text('YESORNO')},
	 					{field:'producer',title:'生成人',sortable:true,width:60},
	 					{field:'prodeceTime',title:'生成时间',sortable:true,width:120},
	 					{field:'recevicer',title:'领取人',sortable:true,width:60},
	 					{field:'receiveTime',title:'领取时间',sortable:true,width:120},
	 					{field:'downloadUrl',title:'下载地址',hidden:true},
	 					{
							field : 'oper',
							title : '下载',
							width : 100,
							align : 'center',
							formatter : function(value, row, index) {
								var isRecevice = row.isRecevice;
								if(isRecevice == 0){
									var s = '<a href="#" style="color:gray">未领取</a> ';
									return s;
								}
								var is_download = row.isDownload;
								if(is_download == 1){
									var s = '<a href="#" style="color:gray">已下载</a> ';
									return s;
								}
								var id = row.id;
//								var downloadUrl = row.downloadUrl;
								var s = '<a href="#" id="oper_down" onclick="file_download(\''+id+'\',\''+is_download+'\')">下载</a>';
//								var s = '<a href="#" onclick="file_download(\''+id+'\')">下载</a>';
								return s;
							}
						},
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
					{
						id : 'btnRecord',
						iconCls : 'ext-icon-application_form_magnify',
						text : '充值卡列表',
						btnType : 'memberRechargeCard',
						handler : function() {
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length == 1) {
								rechargeCard(rows);
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

function rechargeCard(rows){
	$('#recordSearchForm').form('clear');
	$('#recordDialog').dialog('open');
	$('#record-data').datagrid({
			fitColumns:true,  
    		singleSelect:true,  
    		height:'auto',
    		pagination:true,
			rownumbers:true,
			fit:true,
            url:'getMemberRechargeCard.do',
            queryParams: {  
            	batchId : rows[0].batchId,
            },
            columns:[[
//	                        {field:'id',checkbox:true},
						{field:'batchId',title:'批次ID',sortable:true,width:60},
	 					{field:'rechargeCardNo',title:'充值卡号',sortable:true,width:120},
//	 					{field:'password',title:'充值卡密码',sortable:true,width:80},
	 					{field:'denomination',title:'充值卡面额',sortable:true,width:80,
	 						formatter:function(value,row,index){
	 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
	 						}},
	 					{field:'validDate',title:'到期时间',sortable:true,width:120,
 							formatter:function(value,row,index){
	 							return value.split(" ")[0]+" 23:59:59";
	 						}},
	 					{field:'isUsed',title:'是否已使用',sortable:true,width:80,
	 						formatter:sys.dicts.text('YESORNO')},
	 					{field:'isOvertime',title:'是否已过期',sortable:true,width:80,
		 						formatter:sys.dicts.text('YESORNO')},
 						{field:'isRecevice',title:'是否已领取',sortable:true,width:80,
	 						formatter:sys.dicts.text('YESORNO')},
	 					{field:'createTime',title:'创建时间',sortable:true,width:120}
				]],
			});
}

function file_download(id,is_download){
	if(is_download == 1){
		sys.alert('提示', '该批次充值卡已下载~', 'warning');
		return;
	}
	$.messager.confirm('确认', '确认下载？', function(r) {
		if (r) {
			$('#oper_down').html('<a href="#" style="color:gray">下载中</a>');
			$('#oper_down').removeAttr('onclick');
			//下载文件
			window.open('downloadXlsFile.do?id=' + id);
		}
		$('#data-list').datagrid('reload');
	});
	
}

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
	if(prodeceCount > 5000){
		$.messager.alert('提示','一次性生成张数不可大于5000~');  
		 return;
	}
	if (validDate < getNowDay()) {
		sys.alert('警告', '有效期小于当前时间~', 'warning');
		return;
	}
	$.messager.progress({
        title:'请稍后',
        msg:'正在生成充值卡...'
	});
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
			$.messager.progress('close');
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
 * 打开领取编辑框
 */
function recevice(){
	var rows = $('#data-list').datagrid('getChecked');
	if (rows.length < 1) {
		$.messager.show({
			title : '提示',
			msg : '请选择一条记录~'
		});
		return; 
	}
	var batchIds = [];
	for(var i=0;i<rows.length;i++){
		 if(rows[i].isRecevice == 1){
			 $.messager.alert('提示','您选中的记录中有已领取批次，请重新选择~');  
			 return; 
		 }
		 batchIds.push(rows[i].batchId);
	}
	if(isEmpty(batchIds)){
		sys.alert('提示', '批次ID不可为空~', 'warning');
		return;
	}
	$.messager.confirm('确认', '确认领取该批次充值卡？', function(r) {
		if (r) {
			//更新充值卡已领取
			$.ajax({
				url : 'receviceMemberRechargeCard.do',
				type : 'post',
				data : {
					"batchId":tranStr(batchIds)
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
}

/**
 * 关闭生成充值卡请求
 */
$('#close').bind('click',function(){
	$('#createForm').form('clear');
	$('#create_win').dialog('close');
});

function tranStr(str){
	if(str != null){
		return str.toString();
	}
	return null;
}

/**
 * “余额变动记录”查询
 */
$('#btn-search-card').bind('click',function(){
	var rows = $('#data-list').datagrid('getChecked');
	var batchId = rows[0].batchId;
	var param = $('#recordSearchForm').serializeObject();
	var rechargeCardNo = param.rechargeCardNo;
	var isUsed = param.isUsed;
	var isOvertime = param.isOvertime;
	var isRecevice = param.isRecevice;
	var changeStatus = param.changeStatus;
	$('#record-data').datagrid('load', {    
	    name: 'easyui',    
	    batchId:batchId,
	    rechargeCardNo: rechargeCardNo,isUsed:isUsed,isOvertime:isOvertime,
	    isRecevice:isRecevice,changeStatus:changeStatus});
});

$(function(){
	membercard.memberRechargeCardBatch.init();
});		