$package('app.myWork');
var orderPrice;
app.myWork = function(){
	var _box = null;
	var _this = {
		detail : function(rows) {
			$('#detail').dialog({    
				maximizable:true,
				href: '../view/fragrans/appsystem/parkrecordDetail.jsp?parkrecordId='+rows[0].parkrecordId+'&cityCode='+rows[0].cityCode,    
			});
			$('#detail').dialog("open");
		},
		input:function(){
			$('#input').dialog('open');
			$('#inputForm').form('reset');
		},
		accept:function(){
			var rows = $('#data-list').datagrid('getChecked');
			if (rows.length != 1) {
				$.messager.show({
					title : '提示',
					msg : '请选择一条记录~'
				});
			} else {
				$.messager.confirm('确认', '确认受理？', function(r) {
				if (r) {
					$.ajax({
						url : 'accept.do',
						type : 'post',
						data : {
							id : rows[0].id
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
		},
		handle:function(){
			var rows = $('#data-list').datagrid('getChecked');
			if (rows.length != 1) {
				$.messager.show({
					title : '提示',
					msg : '请选择一条记录~'
				});
			} else {
				if(rows[0].status=='0'){
					 $.messager.alert('提示','请先受理该条申诉');  
					 return;
				 }
				$('#reverseRole').combobox({    
				    url: 'getReverseRole.do',
				    fit : true,
				    valueField:'id',    
				    textField:'text',
				    onBeforeLoad: function(param){
						param.complainId = rows[0].id;
					}
				}); 
				$('#handle').dialog("open");
				//清除除单选按钮之外的所有组件值
				clearEditFormExceptRadio();
				
				var row = rows[0];
				var id = row.id;
				$.ajax({
					url : 'getId.do',
					type : 'post',
					dataType : 'json',
					data : {
						id : id
					},
					success : function(result) {
						if (result.success) {
							$('#complainDesc').html(result.data.complainDesc);
						} else {
							$.messager.show({
								msg : result.msg,
								title : '提示'
							});
						}
					}
				});
				$('#log').datagrid(
						{
							rownumbers : true,
							fitColumns : true,
							singleSelect : true,
							url : 'getLog.do?complainId=' + rows[0].id,
							width : 500,
							height : 130,
							columns : [ [
									{
										field : 'id',
										hidden : true
									},
									{
										field : 'complainId',
										hidden : true
									},
									{
										field : 'eventdesc',
										title : '日志描述',
										width : 200,
										editor : {type:'validatebox',options:{required : true,validType:'length[1,200]'}},
										align : 'left'
									},
									{
										field : 'createBy',
										title : '创建人',
										width : 50
									},
									{
										field : 'oper',
										title : '操作',
										width : 50,
										align : 'center',
										formatter : function(value, row, index) {
											dataLog = row;
											if (row.editing) {
												var s = '<a href="#" onclick="saveLog(this)">保存</a> | ';
												var c = '<a href="#" onclick="cancelLog(this)">取消</a>';
												return s + c;
											} else {
												var d = '<a href="#" onclick="deleteLog(this)">删除</a>';
												return d;
											}
										}
									}, ] ],
									onDblClickRow : function(index, data) {
										$('#log').datagrid('beginEdit', index);
									},
									onBeforeEdit : function(index, row) {
										row.editing = true;
										updateActionsLog(index);
									},
									onAfterEdit : function(index, row) {
										row.editing = false;
										updateActionsLog(index);
									},
									onCancelEdit : function(index, row) {
										row.editing = false;
										updateActionsLog(index);
									}
						});
			}
		},
		viewProcess:function(){
			var rows = $('#data-list').datagrid('getChecked');
			if (rows.length != 1) {
				$.messager.show({
					title : '提示',
					msg : '请选择一条记录~'
				});
			} else {
				if(rows[0].status=='0'){
					$.messager.alert('提示','请先受理该条申诉');  
					return;
				}
				$('#processReverseRole').combobox({    
				    url: 'getReverseRole.do',
				    fit : true,
				    valueField:'id',    
				    textField:'text',
				    onBeforeLoad: function(param){
						param.complainId = rows[0].id;
					}
				});
				$('#viewProcess').dialog("open");
				var row = rows[0];
				var id = row.id;
				$.ajax({
					url : 'getId.do',
					type : 'post',
					dataType : 'json',
					data : {
						id : id
					},
					success : function(result) {
						if (result.success) {
							$('#processComplainDesc').html(result.data.complainDesc);
						} else {
							$.messager.show({
								msg : result.msg,
								title : '提示'
							});
						}
					}
				});
				$('#processLog').datagrid(
						{
							rownumbers : true,
							fitColumns : true,
							singleSelect : true,
							url : 'getProcessLog.do?complainId=' + rows[0].id,
							width : 1020,
							height : 150,
							columns : [ [
							             {
							            	 field : 'id',
							            	 hidden : true
							             },
							             {
							            	 field : 'busiId',
							            	 hidden : true
							             },
							             {
							            	 field : 'areaName',
							            	 hidden : true,
							            	 title : '区域名称',
							            	 width:50
							             },
							             {
							            	 field : 'fromUser',
							            	 title : '来源用户',
							            	 width:100,
							            	 formatter: function(value,row,index){
							     				if (row.fromUserName && row.fromRoleName){
							     					return row.fromRoleName+'-'+row.fromUserName;
							     				} else {
							     					return value;
							     				}
							     			},
							     			styler: function(value,row,index){
							    					return 'color:#FFCC00;';
							    			}
							             },
							             {
							            	 field : 'toUser',
							            	 title : '处理用户',
							            	 width:100,
							            	 formatter: function(value,row,index){
								     				if (row.toUserName && row.toRoleName){
								     					return row.toRoleName+'-'+row.toUserName;
								     				} else {
								     					return value;
								     				}
								     			},
								     		styler: function(value,row,index){
							    					return 'color:#1ABDE6;';
							    			}
							             },
							             {
							            	 field : 'fromResult',
							            	 width : 200,
							            	 editor : {type:'validatebox',options:{required : true,validType:'length[1,200]'}},
							            	 align : 'left',
							            	 title : '来源用户处理意见',
							     		     formatter: function(value,row,index){
							     				if (value!=null&&value.length > 10){
							     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
							     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,10)+'...</span>';
							     				}else{
							     					return value;
							     				}
							     		    }  
							             },
							             {
							            	 field : 'fromTime',
							            	 title : '来源用户处理时间',
							            	 width:150
							             },
							             {
							            	 field : 'toResult',
							            	 width : 200,
							            	 editor : {type:'validatebox',options:{required : true,validType:'length[1,200]'}},
							            	 align : 'left',
							            	 title : '处理用户处理意见',
							            	 formatter: function(value,row,index){
							            		 if(value != null){
							            			 if (value.length > 10){
									     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
									     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,10)+'...</span>';
									     				}else{
									     					return value;
									     				} 
							            		 }else{
							            			 return null;
							            		 }
								     		    }  
							             },
							             {
							            	 field : 'toTime',
							            	 title : '处理用户处理时间',
							            	 width:150
							             },
							             {
							            	 field : 'status',
							            	 title : '流程处理状态',
							            	 width:150,
							            	 formatter:sys.dicts.text('PROCESS_ID')
							             },
							            ] ],
						});
			}
		},
		updateRefundStatus:function(){
			var rows = $('#data-list').datagrid('getChecked');
			if (rows.length != 1) {
				$.messager.show({
					title : '提示',
					msg : '请选择一条记录~'
				});
			} else {
				$('#refundFee').numberbox('clear');
				$('#updateRefundStatus').dialog("open");
			}
		},
		finish:function(){
			var rows = $('#data-list').datagrid('getChecked');
			if (rows.length != 1) {
				$.messager.show({
					title : '提示',
					msg : '请选择一条记录~'
				});
			} else {
				if(rows[0].status=='2'){
					 $.messager.alert('提示','该条申诉已完成');  
					 return;
				 }
				$.messager.confirm('确认', '确认完成申诉？', function(r) {
					if (r) {
						$.ajax({
							url : 'handle.do',
							type : 'post',
							data : {
								id : rows[0].id
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
		},
		ticket:function(){
			var rows = $('#data-list').datagrid('getChecked');
			if (rows.length == 0) {
				$.messager.show({
					title : '提示',
					msg : '请选择一条记录~'
				});
			}else if (rows.length > 1) {
				$.messager.show({
					title : '提示',
					msg : '只能选择一条记录~'
				});
			}else {
				$('#sendTicket').dialog('open');
				$('#sendTicketForm').form('reset');
				$('#userAccountForTicket').val(rows[0].userAccount);
			}
		},
		config:{
  			dataGrid:{
  				title : '列表',
				url : 'getMyWork.do',
				fitColumns : true,
				rowStyler:function(index,row){   
					if(row.processOverTimeFlag==1){
		   					return 'background-color:#faf2cc;';
		   				}else{
		   					if (row.refundFlag==2){   
		   						return 'background-color:#ebcccc;';   
		   					}
		   			    }
		   		 }, 
				columns : [ [
						{field:'id',checkbox:true},
						{field:'userId',hidden:true},
						{field:'cityCode',hidden:true},
						{field:'areaName',title:'区域名称',sortable:true},
						{field:'userAccount',title:'用户账号',sortable:true},
						{field:'parkrecordId',title:'停车记录ID',sortable:true},
						{field:'palteNo',title:'车牌号',sortable:true},
						{field:'complainType',title:'投诉类型',sortable:true,formatter:sys.dicts.text('COMPLAIN_TYPE')},
// 						{field:'isComplate',title:'是否完成订单',sortable:true,formatter:sys.dicts.text('IS_COMPLATE')},
						{field:'complainDesc',title:'投诉内容',width:200,sortable:true,
						 formatter: function(value,row,index){
			     				if (value!=null&&value.length > 15){
			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'...</span>';
			     				}else{
			     					return value;
			     				}
			     		    }  
						},
 						{field:'status',title:'处理状态',sortable:true,formatter:sys.dicts.text('COMPLAIN_STATUS')},
 						{field:'handleUser',title:'受理人',sortable:true},
 						{field:'processId',title:'投诉处理进度',sortable:true,
 							formatter:sys.dicts.text('PROCESS_ID')},
 						{field:'refundFlag',title:'退款处理状态',sortable:true,
 							formatter:sys.dicts.text('REFUND_STATUS')},
 						{field:'refundFee',title:'退款金额',sortable:true,
 								formatter:function(value,row,index){
		 							return "<font font-weight:bold;'>￥"+value/100+"</font>";
		 						}},
 						{field:'complainResource',title:'申诉来源',sortable:true,
 							formatter:sys.dicts.text('COMPLAIN_RESOURCE')},
 						{field:'processOverTimeFlag',title:'退款处理超时标识',hidden:true},
 						{field:'createTime',title:'创建时间',sortable:true},
//			 			{field:'updateTime',title:'更新时间',sortable:true}
 						] ],
						toolbar:[
						         	{id:'btnadd',text:'录入',btnType:'input',iconCls : 'icon-add',handler:function(){
						         		_this.input();
						         	}},
									{id:'btnaccept',text:'受理',iconCls : 'ext-icon-accept',btnType:'complainAccept',handler:function(){
										_this.accept();
									}},
									{id:'btnhandle',text:'处理',iconCls : 'ext-icon-arrow_undo',btnType:'complainHandle',handler:function(){
										_this.handle();
									}},
									{id:'btnprocessHandle',text:'流程处理',iconCls : 'ext-icon-arrow_refresh_small',btnType:'viewProcess',handler:function(){
										_this.viewProcess();
									}},
									{id:'btnrefund',text:'更改退款状态',iconCls : 'ext-icon-bin_empty',btnType:'updateRefundStatus',handler:function(){
										_this.updateRefundStatus();
									}},
									{id:'btnfinish',text:'完成处理',iconCls : 'ext-icon-tick',btnType:'finish',handler:function(){
										_this.finish();
									}},
									{id:'btndetail',text:'停车记录详情',btnType:'detail',iconCls : 'ext-icon-report_add',
										handler : function() {
											var rows = $('#data-list').datagrid('getChecked');
											if (rows.length == 1) {
												_this.detail(rows);
											} else {
												$.messager.show({
													msg : '请选择一条记录',
													title : '提示'
												});
											}
									}},
									{id:'btnticket',text:'补偿券',iconCls : 'ext-icon-rss',btnType:'ticket',handler:function(){
										_this.ticket();
									}}
								] 
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
			$('#input').dialog({
				buttons:[
					{
						text:'保存',
						handler:function(){
							$('#inputForm').form('submit',{
								url:'save.do',
								type:'post',
								success:function(result){
									var mes = eval('('+result+')');
									$.messager.show({
										title : '提示',
										msg : mes.msg
									});
									$('#input').dialog('close');
									$('#data-list').datagrid('reload');
								}
							});
						}
					},{
						text:'关闭',
						handler:function(){
							$('#input').dialog('close');
						}
					}
				]
			});
			
			$('#sendTicket').dialog({
				buttons:[
				         {
				        	 text:'发券',
				        	 handler:function(){
				        		 var activityId = $('#activityId').combobox('getValue');
				        		 if(activityId==''){
									 $.messager.alert('提示','请先选择补偿券');  
									 return;
								 }
				 				 $.messager.confirm('确认', '确认发券？', function(r) {
									if (r) {
						        		 $('#sendTicketForm').form('submit',{
						        			 url:'sendTicket.do',
						        			 type : 'post',
						        			 success:function(result){
						        				 var mes = eval('('+result+')');
						        				 $.messager.show({
						        					 title : '提示',
						        					 msg : mes.msg
						        				 });
						        				 $('#sendTicket').dialog('close');
						        				 $('#data-list').datagrid('reload');
						        			 }
						        		 });
									}
				 				});	
				        	 }
				         },{
				        	 text:'关闭',
				        	 handler:function(){
				        		 $('#sendTicket').dialog('close');
				        	 }
				         }
				      ]
			});
		}
	}
	return _this;
}();

$(function(){
	app.myWork.init();
});	

function clearEditFormExceptRadio(){
	$('#eventdesc').val('');
	$('#reverseRole').combobox('clear');
	//设置值为0的单选按钮为选中状态
	setCheckdWithOne();
}

function setCheckdWithOne(){
	var radio=document.getElementsByName("handleRedio");//获取id为radioDiv下的所有name为handleRedio的值的集合
	for(var i=0;i<radio.length;i++){//循环值得集合
		value = radio[i].value//将被选择的radio的值赋给变量userid
		if(value == '0'){
			radio[i].checked=true;//设置为选中状态
		}else{
			radio[i].checked=false; //清空选中状态
			hiddenReverse();
		}
	}
}

function hiddenReverse(){
	document.getElementById("reverseDiv").style.visibility="hidden";//隐藏
}

function showReverse(){
	document.getElementById("reverseDiv").style.visibility="visible";//显示
}

function saveLog(target) {
	$.messager.progress({
        title:'请稍后',
        msg:'正在保存日志...'
	});
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#log').datagrid('endEdit', index);
	$.ajax({
		url : 'updateLog.do',
		type : 'post',
		data:{
			eventdesc:dataLog.eventdesc,
			id:dataLog.id
		},
		dataType:'json',
		success : function(result) {
			$.messager.progress('close');
			$.messager.show({
				title : '提示',
				msg : result.msg
			});
			if (result.success) {
				$('#log').datagrid('reload');
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

function cancelLog(target) {
	var tr = $(target).closest('tr.datagrid-row');
	var index = parseInt(tr.attr('datagrid-row-index'));
	$('#log').datagrid('cancelEdit', index);
}
function deleteLog(target) {
	$.messager.confirm('提示', '您确定要删除吗?', function(r){
        if (r){
        	var tr = $(target).closest('tr.datagrid-row');
        	var index = parseInt(tr.attr('datagrid-row-index'));
        	var rows = $('#log').datagrid('getSelected');
    		$.ajax({
    			url : 'deleteLog.do?id='+rows.id,
    			type : 'post',
    			success : function(result) {
    				$.messager.show({
    					title : '提示',
    					msg : result.msg
    				});
    				if (result.success) {
    					$('#log').datagrid('reload');
    				}
    			}
    		});
        }
	});
}

function updateActionsLog(index) {
	$('#log').datagrid('updateRow', {
		index : index,
		row : {}
	});
}

$('#processClose').bind('click',function(){
	$('#viewProcess').dialog('close');
});
$('#processConfirm').bind('click',function(){
	$.messager.progress({
        title:'请稍后',
        msg:'正在处理申诉...'
	});
	var rows = $('#data-list').datagrid('getChecked');
	var processResult = $('#processResult').val();
	var processReverseRole =  $('#processReverseRole').combobox('getValue')
	if(processResult==''){
		$.messager.alert('提示','处理意见不能为空');  
		$.messager.progress('close');
		return;
	}
	if(processReverseRole==''){
		$.messager.alert('提示','扭转角色不能为空'); 
		$.messager.progress('close');
		return;
	}
	 $.ajax({
			url : 'submitProcessSuggestion.do',
			type : 'post',
			data : {
				complainId : rows[0].id,
				processId : rows[0].processId,
				processResult: processResult,
				processReverseRole:processReverseRole
			},
			success : function(result) {
				$.messager.progress('close');
				$.messager.show({
					title : '提示',
					msg : result.msg
				});
				if (result.success) {
					$('#processEditForm').form('clear');
					$('#processLog').datagrid('reload');
					$('#viewProcess').dialog('close');
					$('#data-list').datagrid('reload');
				}
			}
		});
});
$('#confirm').bind('click', function(){ 
	$.messager.progress({
        title:'请稍后',
        msg:'正在处理申诉...'
	});
	var rows = $('#data-list').datagrid('getChecked');
	var eventdesc = $('#eventdesc').val();
	var reverseRole =  $('#reverseRole').combobox('getValue')
	var radioDiv = getRadioValue();
	if(eventdesc==''){
		$.messager.alert('提示','处理意见不能为空');  
		$.messager.progress('close');
		return;
	}
	if(radioDiv == '1'&&reverseRole==''){
		$.messager.alert('提示','扭转角色不能为空'); 
		$.messager.progress('close');
		return;
	}
	if(rows[0].status=='2'){
		$.messager.alert('提示','该条申诉已完成');  
		$.messager.progress('close');
		return;
	}
	 $.ajax({
			url : 'submitConverse.do',
			type : 'post',
			data : {
				complainId : rows[0].id,
				processId : rows[0].processId,
				eventdesc: eventdesc,
				reverseRole:reverseRole,
				radioDiv:radioDiv
			},
			success : function(result) {
				$.messager.progress('close');
				$.messager.show({
					title : '提示',
					msg : result.msg
				});
				if (result.success) {
					$('#log').datagrid('reload');
					if(radioDiv == '1'){
						//清除除单选按钮之外的所有组件值
						clearEditFormExceptRadio();
						$('#handle').dialog('close');
						$('#data-list').datagrid('reload');
					}
				}
			}
		});
});

function getRadioValue(){
	var value="";
	var radio=document.getElementsByName("handleRedio");
	for(var i=0;i<radio.length;i++){
		if(radio[i].checked==true){
			value=radio[i].value;
			break;
		}
	}
	return value;
} 

//$('#finish').bind('click', function(){
//	var rows = $('#data-list').datagrid('getChecked');
//	if(rows[0].status=='2'){
//		 $.messager.alert('提示','该条申诉已完成');  
//		 return;
//	 }
//	$.messager.confirm('确认', '确认完成申诉？', function(r) {
//		if (r) {
//			$.ajax({
//				url : 'handle.do',
//				type : 'post',
//				data : {
//					id : rows[0].id
//				},
//				success : function(result) {
//					$.messager.show({
//						title : '提示',
//						msg : result.msg
//					});
//					if (result.success) {
//						clearEditFormExceptRadio();
//						$('#handle').dialog('close');
//						$('#data-list').datagrid('reload');
//					}
//				}
//			});
//		}
//	});
//});

$('#refundClose').bind('click',function(){
	$('#updateRefundStatus').dialog('close');
});

$('#refundConfirm').bind('click', function(){
	var rows = $('#data-list').datagrid('getChecked');
	if(rows[0].status=='0'){
		 $.messager.alert('提示','请先受理该条申诉');  
		 return;
	 }
	if(rows[0].status=='2'){
		$.messager.alert('提示','该条申诉已完成');  
		return;
	}
	var param = $('#updateRefundStatusForm').serializeObject();
	var refundFlag = param.refundFlag;
	var refundFee = param.refundFee;
	if(refundFlag == 1 && refundFee > 0.00){
		$.messager.alert('提示','请先修改退款状态'); 
		return;
	}
	if($.trim($('#refundFee').val())==0.00){
		$.messager.alert('提示','退款金额不能为0'); 
		return;
	}
	if($.trim($('#refundFee').val())==''){
		$.messager.alert('提示','退款金额为空！'); 
		return;
	}
	var parkrecordId = rows[0].parkrecordId;
    var cityCode = rows[0].cityCode;
	if(parkrecordId != null && parkrecordId != '' && parkrecordId != 'undefined'
	&& cityCode != null && cityCode != '' && cityCode != 'undefined'){
		$.ajax({
			url : 'getOrderPrice.do',
			type : 'post',
			dataType : 'json',
			async:false,
			data : {
				parkrecordId : parkrecordId,
                cityCode : cityCode
			},
			success : function(result) {
				orderPrice = result.orderPrice;
			}
		});
		var fee = refundFee * 100;
		if(parseInt(fee) > orderPrice){
			$.messager.alert('提示','退款金额不能大于订单实付金额'); 
			return;
		}
	}
	
	$.messager.progress({
        title:'请稍后',
        msg:'正在更新退款信息...'
	});
	$.ajax({
		url : 'updateRefundStatus.do',
		type : 'post',
		dataType : 'json',
		data : {
			complainId : rows[0].id,
			refundFlag:refundFlag,
			refundFee:refundFee
		},
		success : function(result) {
			$.messager.show({
				title : '提示',
				msg : result.msg
			});
			if(result.success){
				$.messager.progress('close');
				$('#updateRefundStatus').dialog('close');
				$('#data-list').datagrid('reload');
			}
		}
	});
});

//获取补偿券
$('#activityId').combobox({
	title:'列表',
	url:'getTicket.do',
	fit : true,
	editable:false,
	valueField : 'id',
	textField : 'text',
});
