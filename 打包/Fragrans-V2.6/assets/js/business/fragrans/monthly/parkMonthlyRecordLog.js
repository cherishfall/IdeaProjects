$package('app.parkMonthlyRecordLog');
var _areaCode = '';
app.parkMonthlyRecordLog = function(){
	var _box = null;
	var _this = {
		config:{
			event : {
				search : function() { //条件查询验证
					var startEventTime = $('#searchStartTime').datebox('getValue');
					var endEventTime = $('#searchEndTime').datebox('getValue');
					if (startEventTime > endEventTime) {
						sys.alert('警告', '起始时间大于结束时间.', 'warning');
						return;
					}
					var Grid = $('#data-list');
					var Form = {
					  search: $("#searchForm")
					};
					var param = Form.search.serializeObject();
					Grid.datagrid('reload',param);
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			rowStyler:function(index,row){   
					if(row.verifyStatus==0){
		   				return 'background-color:#faf2cc;';
		   			}else if (row.verifyStatus==1){   
		   				return 'background-color:#f1fbfc;';   
	   			    }else if (row.verifyStatus==2){   
		   				return 'background-color:#D8BFD8;';   
	   			    }else if (row.verifyStatus==3){   
		   				return 'background-color:#c7c7e2;';   
	   			    }else if (row.verifyStatus==4){   
		   				return 'background-color:#DCDCDC;';
	   			    }
		   		 },
	   			columns:[[ 
						{field:'id',checkbox:true},
	 					{field:'monthlyRecordId',title:'包月记录ID',sortable:true,hidden:true},
	 					{field:'userId',title:'用户ID',sortable:true,hidden:true},
	 					{field:'userAccount',title:'提交人',sortable:true},
	 					{field:'startTime',title:'包月开始时间',sortable:true},
	 					{field:'endTime',title:'包月结束时间',sortable:true},
	 					{field:'monthlyFee',title:'包月费用',sortable:true,
	 						formatter:function(value,row,index){
	 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
	 						}
	 					},
	 					{field:'acceptTime',title:'受理时间',sortable:true},
	 					{field:'acceptUser',title:'受理人',sortable:true},
	 					{field:'verifyUser',title:'审核人',sortable:true},
	 					{field:'verifyTime',title:'审核时间',sortable:true},
	 					{field:'verifyStatus',title:'审核状态',sortable:true,formatter:sys.dicts.text('MONTHLY_REVIEW_STATUS')},
	 					{field:'verifyInfo',title:'审核意见',sortable:true,
	 						formatter: function(value,row,index){
			     				if (value!=null&&value.length > 15){
			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'...</span>';
			     				}else{
			     					return value;
			     				}
			     		    }
	 					},
	 					{field:'adviceStartTime',title:'建议开始时间',sortable:true},
	 					{field:'adviceMonthlyDuration',title:'建议包月时长',sortable:true},
	 					{field:'createdBy',title:'创建人',sortable:true},
	 					{field:'updatedBy',title:'修改人',sortable:true},
	 					{field:'createTime',title:'创建时间',sortable:true},
	 					{field:'updateTime',title:'更新时间',sortable:true}
			 	]],
				toolbar:[
					{id:'btnAccept',text:'批量受理',btnType:'monthAccept',iconCls : 'ext-icon-accept',
						handler:function(){
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length == 0) {
								$.messager.show({
									title : '提示',
									msg : '至少选择一条记录~'
								});
								return;
							} 
							accept(rows);
						}},
					{id:'btnProcess',text:'处理',btnType:'process',iconCls : 'ext-icon-arrow_undo',
						handler:function(){
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length != 1) {
								$.messager.show({
									title : '提示',
									msg : '请选择一条记录~'
								});
								return; 
							}
							handle(rows);
					}}
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
	app.parkMonthlyRecordLog.init();
});

/**
 * 处理续包申请
 * @param rows 选择处理记录
 * @returns
 */
function handle(rows){
	var verifySatus = parseInt(rows[0].verifyStatus);
	if(verifySatus==0){
		 $.messager.alert('提示','请先受理~');  
		 return;
	}
	if(verifySatus==2||verifySatus==3){
		 $.messager.alert('提示','该条审核已处理完毕');  
		 return;
	}
	$('#verifyForm').form('clear');
	$('#handle').dialog("open");
	$.ajax({
		url : 'getParkMonthlyRecord.do',
		type : 'post',
		dataType : 'json',
		data : {
			id : rows[0].monthlyRecordId
		},
		success : function(result) {
			var data = result.data;
            var areaCode = data.areaCode;
            _areaCode = areaCode;
			$('#areaName').html(data.areaName);
			$('#parkName').html(data.parkName);
			$('#parentId').html(data.parentId);
			$('#plateNo').html(data.plateNo);
			$('#plateColor').html(sys.dicts.text("PLATE_COLOR",data.plateColor));
			$('#phone').html(data.phone);
			$('#startTime').html(data.startTime);
			$('#endTime').html(data.endTime);
			$('#note').html(data.note);

            $.ajax({
                url : 'getParentParkMonthlyRecord.do',
                type : 'post',
                dataType : 'json',
                data : {
                    id : rows[0].monthlyRecordId,
                    areaCode : areaCode
                },
                success : function(parentResult) {
                    var data = parentResult.data;
                    $('#_areaName').html(data.areaName);
                    $('#_parkName').html(data.parkName);
                    $('#_monthlyId').html(data.monthlyId);
                    $('#_phone').html(data.phone);
                    $('#_plateNo').html(data.plateNo);
                    $('#_plateColor').html(sys.dicts.text("PLATE_COLOR",data.plateColor));
                    $('#_monthlyFee').html(function(){
                        if(data.monthlyFee==null || data.monthlyFee=='' || data.monthlyFee == undefined || data.monthlyFee == 0){
                            return "<font>￥0</font>";
                        }
                        return "<font>￥"+data.monthlyFee/100+"</font>"
                    });
                    $('#_status').html(sys.dicts.text("MONTHLY_RECORD_STATUS",data.status));
                    $('#_startTime').html(data.startTime);
                    $('#_endTime').html(data.endTime);
                    $('#_note').html(data.note);
                }
            });
		}
	});
}

/**
 * 受理包月申请
 * @param rows 受理记录
 */
function accept(rows){
	var recordLogIds = [];
	for(var i=0;i<rows.length;i++){
		if(rows[i].verifyStatus != 0){
			 $.messager.alert('提示','请选择未受理的记录~');  
			 return;
		}
		recordLogIds.push(rows[i].id);
	}
	$.messager.confirm('确认', '确认受理？', function(r) {
		if (r) {
			$.ajax({
				url : 'accept.do',
				type : 'post',
				traditional: true,
				data : {
					ids : recordLogIds
				},
				success : function(result) {
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

/**
 * “通过”按钮绑定单击事件
 */
$('#passBut').bind('click',function(){
	var rows = $('#data-list').datagrid('getChecked');
	var param = $('#verifyForm').serializeObject();
	var monthlyFee = param.monthlyFee;
	if(monthlyFee == null || monthlyFee == '' || monthlyFee == undefined){
		 $.messager.alert('提示','包月金额不能为空~');  
		 return;
	}
	if(monthlyFee == 0){
		$.messager.alert('提示','包月金额不能为0~');  
		 return;
	}
	if(monthlyFee > 2000){
		$.messager.alert('提示','包月金额不能大于2000~');  
		 return;
	}
	var monthlyFeeBool = /^(0|[1-9][0-9]*)$/.test(monthlyFee);
	if(!monthlyFeeBool){
		 $.messager.alert('提示','包月金额只能为正整数~');  
		 return;
	}
	var adviceMonthlyDuration = param.adviceMonthlyDuration;
	if(adviceMonthlyDuration != null && adviceMonthlyDuration != '' && adviceMonthlyDuration != undefined){
		$.messager.alert('提示','通过审核无需设置建议包月时长~');  
		return;
	}
	var adviceStartTime = param.adviceStartTime;
	if(adviceStartTime != null && adviceStartTime != '' && adviceStartTime != undefined){
		$.messager.alert('提示','通过审核无需设置建议包月开始时间~');  
		return;
	}
	var verifyInfo = param.verifyInfo;
	if(verifyInfo != null && verifyInfo != '' && verifyInfo != undefined){
		 $.messager.alert('提示','通过审核无需设置驳回原因~');  
		 return;
	}
	//通过原因
	$.messager.confirm('提示', '您确定通过该续包申请吗？一旦通过，车主将用此金额支付！', function(r) {
		if (r) {
			$.ajax({
				url : 'submitMonthlyPass.do',
				type : 'post',
				dataType : 'json',
				data : {
					id : rows[0].id,
					monthlyFee:param.monthlyFee,
				},
				success : function(result) {
					$.messager.show({
						msg : result.msg,
						title : '提示'
					});
					if(result.success){
						$('#verifyForm').form('clear');
						$('#handle').dialog('close');
						$('#data-list').datagrid('reload');
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
	});
});

/**
 * “驳回”按钮绑定单击事件
 */
$('#rejectBut').bind('click',function(){
	var rows = $('#data-list').datagrid('getChecked');
	var param = $('#verifyForm').serializeObject();
	if(param.verifyInfo == null || param.verifyInfo == '' || param.verifyInfo == undefined){
		 $.messager.alert('提示','驳回原因不能为空~');  
		 return;
	}
	var monthlyFee = param.monthlyFee;
	var adviceMonthlyDuration = param.adviceMonthlyDuration;
	var adviceStartTime = param.adviceStartTime;
	if((adviceMonthlyDuration != null && adviceMonthlyDuration != '' && adviceMonthlyDuration != undefined 
			&& (adviceStartTime == null || adviceStartTime == '' || adviceStartTime == undefined)) ||
			((adviceMonthlyDuration == null || adviceMonthlyDuration == '' || adviceMonthlyDuration == undefined) &&
					adviceStartTime != null && adviceStartTime != '' && adviceStartTime != undefined)){
		$.messager.alert('提示','建议包月时长和建议包月开始时间必须同时不为空~');  
		return;
	}
	if((adviceMonthlyDuration == null || adviceMonthlyDuration == '' || adviceMonthlyDuration == undefined)
			&& (adviceStartTime == null || adviceStartTime == '' || adviceStartTime == undefined)
			&& (monthlyFee != null && monthlyFee != '' && monthlyFee != undefined)){
		 $.messager.alert('提示','非建议模式下无需设置包月金额~');  
		 return;
	}
	if((adviceMonthlyDuration != null && adviceMonthlyDuration != '' && adviceMonthlyDuration != undefined)
			&& (adviceStartTime != null && adviceStartTime != '' && adviceStartTime != undefined)
			&& (monthlyFee == null || monthlyFee == '' || monthlyFee == undefined)){
		 $.messager.alert('提示','建议模式下包月金额不可为空~');  
		 return;
	}
	if(monthlyFee != null && monthlyFee != '' && monthlyFee != undefined){
		if(monthlyFee == 0){
			$.messager.alert('提示','包月金额不能为0~');  
			 return;
		}
		if(monthlyFee > 2000){
			$.messager.alert('提示','包月金额不能大于2000~');  
			 return;
		}
		var bool = /^(0|[1-9][0-9]*)$/.test(monthlyFee);
		if(!bool){
			 $.messager.alert('提示','包月金额只能为正整数~');  
			 return;
		}
	}
	var adviceMonthlyDuration = param.adviceMonthlyDuration;
	if(adviceMonthlyDuration != null && adviceMonthlyDuration != '' && adviceMonthlyDuration != undefined){
		if(adviceMonthlyDuration == 0){
			$.messager.alert('提示','建议包月时长不能为0~');  
			 return;
		}
		var adviceMonthlyDurationBool = /^(0|[1-9][0-9]*)$/.test(adviceMonthlyDuration);
		if(!adviceMonthlyDurationBool){
			 $.messager.alert('提示','建议包月时长只能为正整数~');  
			 return;
		}
	}
	//驳回原因
	$.messager.confirm('提示', '您确定驳回该续包申请吗？一旦驳回，车主将重新申请或接受建议继续支付！', function(r) {
		if (r) {
			$.ajax({
				url : 'submitMonthlyReject.do',
				type : 'post',
				dataType : 'json',
				data : {
					id : rows[0].id,
					monthlyFee:param.monthlyFee,
					adviceMonthlyDuration:param.adviceMonthlyDuration,
					adviceStartTime:param.adviceStartTime,
					verifyInfo:param.verifyInfo,
					areaCode:_areaCode
				},
				success : function(result) {
					$.messager.show({
						msg : result.msg,
						title : '提示'
					});
					if(result.success){
						$('#verifyForm').form('clear');
						$('#handle').dialog('close');
						$('#data-list').datagrid('reload');
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
	});
});

/**
 * “审核规则”按钮绑定单击事件
 */
$('#verifyRule').bind('click',function(){
	$('#rule').dialog("open");
});
/**
 * “回车”键查询
 */
$(".datagrid-toolbar").keydown(function(e) {
	if (e.keyCode == 13) {
		var param = $("#searchForm").serializeObject();
		 if(param.userAccount == '' && param.phone == '' && param.plateNo == '' && param.plateColor == '' 
			 && param.verifyStatus == '' && param.startTime == '' && param.endTime == '' ){
			 $.messager.show({
					msg : '请至少选择一个查询条件',
					title : '提示'
				});
			 return;
		 }
		 var opts = $("#data-list").datagrid("options");
		 opts.url = "dataList.do";
		 $('#data-list').datagrid('reload',param); 
		 return false;
	}
});

