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
		viewProcess:function(){
			var rows = $('#data-list').datagrid('getChecked');
			if (rows.length != 1) {
				$.messager.show({
					title : '提示',
					msg : '请选择一条记录~'
				});
			} else {
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
							if(result.data.roleFlag == 'REGION_CS_ID' && result.data.status == '0'){
								$("#processEditForm").show();//显示
								$('#processEditForm').form('clear');
								$("#processEditForm2").hide();//隐藏
							} else {
								$("#processEditForm2").show();//显示
								$('#processEditForm2').form('clear');
								$("#processEditForm").hide();//隐藏
								$('#refundFeeP').html("￥"+result.data.refundFee/100);
								$('#refundFeeHidden').val(result.data.refundFee/100);
								$('#processResultP').html(result.data.complainDesc);
								$('#questionTypeP').html(sys.dicts.text('QUESTION_TYPE',result.data.questionType));
								if(result.data.questionType == '1'){
									if(result.data.maintenanceFlag == "1"){
										$("#maintenanceFlagP1").show();
										$("#maintenanceFlagP2").show();
										$('#maintenanceFlagP').html("已确认");
									}else{
										$('#maintenanceFlagP').html("未确认");
									}
								} else {
									$("#maintenanceFlagP1").hide();
									$("#maintenanceFlagP2").hide();
								}
								if(result.data.roleFlag == 'REGION_CUSTOM_SERVICE_MANAGER'){//区域经理
									$("#agreeConfirm").show();
									$("#doRefundConfirm").hide();
									$("#finishConfirm").hide();
								} else if(result.data.roleFlag == 'HQ_CUSTOM_SERVICE_MANAGER'){//总部客服
									if(result.data.refundFee > result.data.amountFlag) {
										$("#agreeConfirm").show();
										$("#doRefundConfirm").hide();
										$("#finishConfirm").hide();
									} else {
										$("#agreeConfirm").hide();
										$("#doRefundConfirm").show();
										$("#finishConfirm").hide();
									}
									
								} else if(result.data.roleFlag == 'HQ_FINANCE'){//总部财务
									$("#agreeConfirm").hide();
									$("#doRefundConfirm").show();
									$("#finishConfirm").hide();
								} else if(result.data.roleFlag == 'REGION_CS_ID'){//区域客服
									$("#agreeConfirm").hide();
									$("#doRefundConfirm").hide();
									$("#finishConfirm").show();
									$("#remarkResultTr").hide();
									$("#backConfirm").hide();
								}
							}
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
							            	 field : 'fromRoleName',
							            	 title : '处理角色',
							            	 width:100,
							            	 formatter: function(value,row,index){
								     				if (value!=null){
								     					return value;
								     				}else{
								     					return '车主';
								     				}
								     		    }
							             },
							             {
							            	 field : 'fromUserName',
							            	 title : '处理人',
							            	 width:100,
							            	 formatter: function(value,row,index){
							            		 if (value!=null){
								     					return value;
								     				}else{
								     					return row.fromUser;
								     				}
								     		    }
							             },
							             {
							            	 field : 'fromResult',
							            	 width : 200,
							            	 editor : {type:'validatebox',options:{required : true,validType:'length[1,200]'}},
							            	 align : 'left',
							            	 title : '处理意见',
							     		     formatter: function(value,row,index){
							     				if (value!=null&&value.length > 30){
							     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
							     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,30)+'...</span>';
							     				}else{
							     					return value;
							     				}
							     		    }  
							             },
							             {
							            	 field : 'status',
							            	 title : '处理状态',
							            	 width:150,formatter:sys.dicts.text('PROCESS_STATUS')
							             },
							             {
							            	 field : 'fromTime',
							            	 title : '处理时间',
							            	 width:150
							             }
							            ] ],
						});
				$('#orderInfo').datagrid(
						{
							rownumbers : true,
							fitColumns : true,
							singleSelect : true,
							url : 'getOrderInfo.do?complainId=' + rows[0].id,
							width : 1020,
							height : 150,
							columns : [ [
							             {
							            	 field : 'id',
							            	 hidden : true
							             },
							             {
							            	 field : 'orderNo',
							            	 title : '订单编号',
							            	 width:200
							             },
							             {
							            	 field : 'price',
							            	 title : '订单金额',
							            	 width:100,
							            	 formatter: function(value,row,index){
							            		 return "<font font-weight:bold;'>￥"+value/100+"</font>";
							     			}
							             },
							             {
							            	 field : 'refundFee',
							            	 title : '已退款金额',
							            	 width:100,
							            	 formatter: function(value,row,index){
							            		 return "<font font-weight:bold;'>￥"+value/100+"</font>";
								     			}
							             },
							             {
							            	 field : 'buyerAccount',
							            	 width : 200,
							            	 editor : {type:'validatebox',options:{required : true,validType:'length[1,200]'}},
							            	 align : 'left',
							            	 title : '支付账号',
							     		     formatter: function(value,row,index){
							     				return value;
							     		    }  
							             },
							             {
							            	 field : 'payTime',
							            	 title : '更新时间',
							            	 width:150
							             },
							             {
							            	 field : 'orderStatus',
							            	 width : 200,
							            	 editor : {type:'validatebox',options:{required : true,validType:'length[1,200]'}},
							            	 align : 'left',
							            	 title : '可退状态',
							            	 formatter: function(value,row,index){
						            			if (row.refundFee >= row.price){
							     					return '<span class="easyui-tooltip">交易完成</span>';
							     				}else{
							     					return '<span class="easyui-tooltip">可退款</span>';
							     				} 
								     		},
								     		styler: function(value,row,index){
								     			if (row.refundFee >= row.price){
							    					return 'color:#FF0000;';
								     			} else {
								     				return 'color:#1ABDE6;';
							    				}
							    			}  
							             }
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
				url : 'getMyWorkNew.do',
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
									{id:'btnprocessHandle',text:'流程处理',iconCls : 'ext-icon-arrow_refresh_small',btnType:'viewProcessNew',handler:function(){
										_this.viewProcess();
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
$('#processClose2').bind('click',function(){
	$('#viewProcess').dialog('close');
});
$('#directFinishConfirm').bind('click',function(){
	submitProcessSuggestionNew(1);
});
$('#processConfirm').bind('click',function(){
	submitProcessSuggestionNew(2);
});
function submitProcessSuggestionNew(type){
	$.messager.progress({
        title:'请稍后',
        msg:'正在处理申诉...'
	});
	var rows = $('#data-list').datagrid('getChecked');
	var refundFee = $('#refundFee').val();
	var processResult = $('#processResult').val();
	var maintenanceFlag = getRadioValue("maintenanceFlag");;
	var questionType =  $('#questionType').combobox('getValue');
	if(refundFee == '' || isNaN(refundFee)){
		$.messager.alert('提示','退款金额不能为空，且只能为数字');  
		$.messager.progress('close');
		return;
	}
	if(processResult==''){
		$.messager.alert('提示','处理意见不能为空');  
		$.messager.progress('close');
		return;
	}
	if(questionType==''){
		$.messager.alert('提示','问题类型不能为空'); 
		$.messager.progress('close');
		return;
	}
	if(questionType == '1' && maintenanceFlag == ''){
		$.messager.alert('提示','请选择维保确认！'); 
		$.messager.progress('close');
		return;
	}
	 $.ajax({
			url : 'submitProcessSuggestionNew.do',
			type : 'post',
			data : {
				complainId : rows[0].id,
				processId : rows[0].processId,
				processResult: processResult,
				maintenanceFlag:maintenanceFlag,
				refundFee:refundFee,
				questionType:questionType,
				buttonType:type
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
					$('#orderInfo').datagrid('reload');
					$('#viewProcess').dialog('close');
					$('#data-list').datagrid('reload');
				}
			}
		});
}
$('#questionType').combobox({
	onChange:function(newValue,oldValue){
		//地磁故障时，显示维保确认
		if(newValue==1){
    		$("#maintenanceTd1").show();
    		$("#maintenanceTd2").show();
		}else{
			$("#maintenanceTd1").hide();
    		$("#maintenanceTd2").hide();
		}
    }
});
$('#confirm').bind('click', function(){ 
	$.messager.progress({
        title:'请稍后',
        msg:'正在处理申诉...'
	});
	var rows = $('#data-list').datagrid('getChecked');
	var eventdesc = $('#eventdesc').val();
	var reverseRole =  $('#reverseRole').combobox('getValue')
	var radioDiv = getRadioValue("handleRedio");
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
//同意退款
$('#agreeConfirm').bind('click', function(){ 
	$.messager.progress({
        title:'请稍后',
        msg:'正在处理申诉...'
	});
	var rows = $('#data-list').datagrid('getChecked');
	var remarkResult = $('#remarkResult').val();
	if(remarkResult==''){
		$.messager.alert('提示','处理意见不能为空');  
		$.messager.progress('close');
		return;
	}
	 $.ajax({
			url : 'submitAgree.do',
			type : 'post',
			data : {
				complainId : rows[0].id,
				remarkResult: remarkResult
			},
			success : function(result) {
				$.messager.progress('close');
				$.messager.show({
					title : '提示',
					msg : result.msg
				});
				if (result.success) {
					$('#viewProcess').dialog('close');
					$('#processEditForm2').form('clear');
					$('#data-list').datagrid('reload');
				}
			}
		});
});
//退款
$('#doRefundConfirm').bind('click', function(){
	var refundFee = $('#refundFeeHidden').val();
	$.messager.confirm('确认', '是否确认退款  <span style="color:red;font-weight:bold;font-size:15px;">'+refundFee+'元</span>  (该操作不可逆)', function(r) {
	if (r) {
		$.messager.progress({
	        title:'请稍后',
	        msg:'正在处理申诉...'
		});
		var rows = $('#data-list').datagrid('getChecked');
		var remarkResult = $('#remarkResult').val();
		 $.ajax({
				url : 'submitRefund.do',
				type : 'post',
				data : {
					complainId : rows[0].id,
					remarkResult: remarkResult
				},
				success : function(result) {
					$.messager.progress('close');
					$.messager.show({
						title : '提示',
						msg : result.msg
					});
					if (result.success) {
						$('#viewProcess').dialog('close');
						$('#processEditForm2').form('clear');
						$('#data-list').datagrid('reload');
					}
				},
				error:function(result){
					$.messager.progress('close');
					$.messager.show({
						title : '提示',
						msg : "处理异常，请联系开发人员！"
					});
				}
			});
		}
	})
});
//申诉完成
$('#finishConfirm').bind('click', function(){ 
	$.messager.progress({
        title:'请稍后',
        msg:'正在处理申诉...'
	});
	var rows = $('#data-list').datagrid('getChecked');
	 $.ajax({
			url : 'submitFinish.do',
			type : 'post',
			data : {
				complainId : rows[0].id
			},
			success : function(result) {
				$.messager.progress('close');
				$.messager.show({
					title : '提示',
					msg : result.msg
				});
				if (result.success) {
					$('#viewProcess').dialog('close');
					$('#processEditForm2').form('clear');
					$('#data-list').datagrid('reload');
				}
			}
		});
});
//驳回
$('#backConfirm').bind('click', function(){ 
	$.messager.progress({
        title:'请稍后',
        msg:'正在处理申诉...'
	});
	var rows = $('#data-list').datagrid('getChecked');
	var remarkResult = $('#remarkResult').val();
	if(remarkResult==''){
		$.messager.alert('提示','处理意见不能为空');  
		$.messager.progress('close');
		return;
	}
	 $.ajax({
			url : 'submitBack.do',
			type : 'post',
			data : {
				complainId : rows[0].id,
				remarkResult: remarkResult
			},
			success : function(result) {
				$.messager.progress('close');
				$.messager.show({
					title : '提示',
					msg : result.msg
				});
				if (result.success) {
					$('#viewProcess').dialog('close');
					$('#processEditForm2').form('clear');
					$('#data-list').datagrid('reload');
				}
			}
		});
});

function getRadioValue(name){
	var value="";
	var radio=document.getElementsByName(name);
	for(var i=0;i<radio.length;i++){
		if(radio[i].checked==true){
			value=radio[i].value;
			break;
		}
	}
	return value;
} 

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
