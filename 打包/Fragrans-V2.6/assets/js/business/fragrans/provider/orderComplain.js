$(function(){
	var _box = null;
	var _this = {
			detail : function(rows) {
				$('#detail').dialog({    
					maximizable:true,
					href: '../view/fragrans/appsystem/parkrecordDetail.jsp?parkrecordId='+rows[0].parkrecordId+'&cityCode='+rows[0].cityCode,    
				});
				$('#detail').dialog("open");
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
			handle:function(rows){
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
			viewProcess:function(rows){
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
								     				if (value.length > 10){
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
					$('#updateRefundStatus').dialog("open");
				}
			},
			init:function(){
				_box = new YDataGrid(_this.config); 
				_box.init();
			}
		}
	
	//tabs切换事件
    $('#ComplainTabs').tabs({
        border:false,
        onSelect:function(title,index){
            if(index==0){
            	 //重新载入grid
            	 $('#data-list').datagrid('reload', {
                     type:'0'
                 });
            }else{
            	 //重新载入grid
           	    $('#data-list-2').datagrid('reload', {
                    type:'1'
                });
            }
        }
    });
	
	//重新载入grid
	$('#data-list').datagrid(
			{
				title : '列表',
				url : 'getMyWork.do',
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
						{field:'cityCode',hidden:true},
						{field:'areaName',title:'区域名称',sortable:true},
						{field:'userAccount',title:'用户账号',sortable:true},
						{field:'parkrecordId',title:'停车记录ID',sortable:true},
						{field:'palteNo',title:'车牌号',sortable:true},
						{field:'complainType',title:'投诉类型',sortable:true,formatter:sys.dicts.text('COMPLAIN_TYPE')},
// 						{field:'isComplate',title:'是否完成订单',sortable:true,formatter:sys.dicts.text('IS_COMPLATE')},
						{field:'complainDesc',title:'投诉内容',sortable:true,
						 formatter: function(value,row,index){
			     				if (value.length > 15){
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
 						{field:'complainResource',title:'申诉来源',sortable:true,
 							formatter:sys.dicts.text('COMPLAIN_RESOURCE')},
 						{field:'processOverTimeFlag',title:'退款处理超时标识',hidden:true},
 						{field:'createTime',title:'创建时间',sortable:true},
//			 			{field:'updateTime',title:'更新时间',sortable:true}
 						] ],
						toolbar:[
						         	{id:'btnadd',text:'录入',btnType:'add',iconCls : 'icon-add',
						         		handler : function() {
						         			add();
						         	}},
									{id:'btnaccept',text:'受理',iconCls : 'ext-icon-accept',btnType:'accept',handler:function(){
										_this.accept();
									}},
									{id:'btnhandle',text:'处理',iconCls : 'ext-icon-arrow_undo',btnType:'handle',handler:function(){
										var rows = $('#data-list').datagrid('getChecked');
										_this.handle(rows);
									}},
									{id:'btnhandle',text:'流程处理',iconCls : 'ext-icon-arrow_refresh_small',btnType:'viewProcess',handler:function(){
										var rows = $('#data-list').datagrid('getChecked');
										_this.viewProcess(rows);
									}},
									{id:'btnaccept',text:'更改退款状态',iconCls : 'ext-icon-bin_empty',btnType:'updateRefundStatus',handler:function(){
										_this.updateRefundStatus();
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
									}}
								] 
			});
	
//	 重新载入grid
	 $('#data-list-2').datagrid({
		title : '列表',
			rownumbers : true,
			fitColumns : true,
			singleSelect : true,
			pagination:true,
			checkOnSelect:false,
			url:'getMyComplain.do',
			fit:true,
			height : 416,
			rowStyler:function(index,row){   
				if(row.processOverTimeFlag==1){
					return 'background-color:#faf2cc;';
				}else{
					if (row.refundFlag==2){   
						return 'background-color:#ebcccc;';   
					}
				}
			},  
			columns:[[ 
			        {field:'id',checkbox:true},
					{field:'cityCode',hidden:true},
					{field:'areaName',title:'区域名称',sortable:true},
					{field:'userAccount',title:'用户账号',sortable:true},
					{field:'parkrecordId',title:'停车记录ID',sortable:true},
					{field:'palteNo',title:'车牌号',sortable:true},
					{field:'complainType',title:'投诉类型',sortable:true,formatter:sys.dicts.text('COMPLAIN_TYPE')},
//					{field:'isComplate',title:'是否完成订单',sortable:true,formatter:sys.dicts.text('IS_COMPLATE')},
					{field:'complainDesc',title:'投诉内容',width:200,sortable:true,
						formatter: function(value,row,index){
		     				if (value.length > 12){
		     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
		     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,12)+'...</span>';
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
					{field:'complainResource',title:'申诉来源',sortable:true,
						formatter:sys.dicts.text('COMPLAIN_RESOURCE')},
					{field:'processOverTimeFlag',title:'退款处理超时标识',hidden:true},
					{field:'createTime',title:'创建时间',sortable:true},
//	 				{field:'updateTime',title:'更新时间',sortable:true}
		 	]],
        view: detailview,
		detailFormatter: function(index,row){
			return '<div style="padding:2px"><table class="ddv"></table></div>'
		},
	    onExpandRow: function(index,row){
	        var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
	        ddv.datagrid({
	    		fitColumns:true,  
                singleSelect:true,  
                height:'auto',
	            url:'getComplainProcessLog.do',
	            queryParams: {  
	            	complainId : row.id
	            },
	            columns:[[
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
	                    		  return 'color:#fb0;';
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
	                    		  return 'color:#06f;';
	                    	  }
	                      },
	                      {
	                    	  field : 'fromResult',
	                    	  width : 200,
	                    	  editor : {type:'validatebox',options:{required : true,validType:'length[1,200]'}},
	                    	  align : 'left',
	                    	  title : '来源用户处理意见',
	                    	  formatter: function(value,row,index){
	                    		  if (value.length > 10){
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
	                      }
	            ]],
	            onResize:function(){
	                $('#data-list-2').datagrid('fixDetailRowHeight',index);
	            },
	            onLoadSuccess:function(){
	                setTimeout(function(){
	                    $('#data-list-2').datagrid('fixDetailRowHeight',index);
	                },0);
	            }
	        });
	        $('#data-list-2').datagrid('fixDetailRowHeight',index);
	    },
		 	toolbar:[
		 	         {id:'btnExport',text:'导出申诉表',btnType:'edit',iconCls:"ext-icon-page_excel",
		 	        	 handler : function() {
		 	        		 $('#exportOrderComplainForm').form('reset');
		 	        		 exportOrderComplain();
		 	        }}
		    ]
     });
            	
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
		if(eventdesc==''){
			$.messager.alert('提示','处理意见不能为空');  
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
			$.messager.alert('提示','日志描述不能为空');  
			return;
		}
		if(rows[0].status=='2'){
			$.messager.alert('提示','该条申诉已完成');  
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
	
	$('#finish').bind('click', function(){
		var rows = $('#data-list').datagrid('getChecked');
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
							clearEditFormExceptRadio();
							$('#handle').dialog('close');
							$('#data-list').datagrid('reload');
						}
					}
				});
			}
		});
    });
});

$('#refundClose').bind('click',function(){
	$('#updateRefundStatus').dialog('close');
});

$('#refundConfirm').bind('click', function(){
	var rows = $('#data-list').datagrid('getChecked');
	if(rows[0].status=='2'){
		$.messager.alert('提示','该条申诉已完成');  
		return;
	}
	var param = $('#updateRefundStatusForm').serializeObject();
	var refundFlag = param.refundFlag;
	$.ajax({
		url : 'updateRefundStatus.do',
		type : 'post',
		dataType : 'json',
		data : {
			complainId : rows[0].id,
			refundFlag:refundFlag
		},
		success : function(result) {
			$.messager.show({
				title : '提示',
				msg : result.msg
			});
			if(result.success){
				$('#updateRefundStatus').dialog('close');
				$('#data-list').datagrid('reload');
			}
		}
	});
});

function updateActionsLog(index) {
	$('#log').datagrid('updateRow', {
		index : index,
		row : {}
	});
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

function hiddenReverse(){
	document.getElementById("reverseDiv").style.visibility="hidden";//隐藏
}

function showReverse(){
	document.getElementById("reverseDiv").style.visibility="visible";//显示
}

$('#reverseRole').combobox({    
    url: 'getReverseRole.do',
    fit : true,
    valueField:'id',    
    textField:'text'   
}); 

$('#processReverseRole').combobox({    
    url: 'getReverseRole.do',
    fit : true,
    valueField:'id',    
    textField:'text'   
});

function submitForm(from){
	var param = $('#searchForm').serializeObject();
	var areaId = param.cityCode;
	var userAccount = param.userAccount;
	var palteNo = param.palteNo;
	var status = param.status;
	var refundFlag = param.refundFlag;
	//获取选项卡index
	var tabId = $('#ComplainTabs').tabs('getTabIndex',$('#ComplainTabs').tabs('getSelected'));
    var url = '';
    if(tabId==0){
    	url = 'getMyWork.do';
    }else{
    	url = 'getMyComplain.do';
    }
	$.ajax({
		url : url,
		type : 'post',
		data : {
			areaId:areaId,userAccount:userAccount,palteNo:palteNo,status:status,refundFlag:refundFlag
		},
		success : function(result) {
				var data=new Object();
				data.total = result.total;
				data.rows = result.rows;
				if(tabId==0){
					$("#data-list").datagrid("loadData",data);
				}else{
					$("#data-list-2").datagrid("loadData",data);
				}
		}
	});
}

$('#edit-win').dialog({
	buttons:[
		{
			text:'保存',
			handler:function(){
				 var areaName = $('#areaName').combotree('getText');
				 if(areaName=="根区域"){
					 $.messager.alert('提示','不能选择根区域');  
					 return;
				 }
				 var param = $('#editForm').serializeObject();
				 var areaId = param.areaName;
				 var userAccount = param.userAccount;
				 var parkrecordId = param.parkrecordId;
				 var palteNo = param.palteNo;
				 var isComplate = param.isComplate;
				 var complainResource = param.complainResource;
				 var complainType = param.complainType;
				 var complainDesc = param.addComplainDesc;
				 $.ajax({
						url : 'save.do',
						type : 'post',
						dataType : 'json',
						data : {
							areaId:areaId,userAccount:userAccount,palteNo:palteNo,
							parkrecordId:parkrecordId,isComplate:isComplate,complainResource:complainResource,
							complainType:complainType,complainDesc:complainDesc
						},
						success : function(result) {
							$.messager.show({
								title : '提示',
								msg : result.msg
							});
							$('#edit-win').dialog('close');
							$('#data-list').datagrid('reload');
							$('#data-list-2').datagrid('reload');
						}
					});
			}
		},{
			text:'关闭',
			handler:function(){
				$('#edit-win').dialog('close');
			}
		}
	]
});

function add(){
	$('#edit-win').dialog('open');
	$('#editForm').form('clear');
	$("#complainResource option[value='2']").attr("selected", "selected");
}

$('#areaName').combotree({
	title:'列表',
	url:'../area/getAreaTree.do',
	fit : true,
	idField : 'id',
	panelHeight : '200',
	treeField : 'areaName',
	parentField : 'parentId',
});

$('#exportOrderComplain').dialog({
	buttons : [ {
		text : '保存',
		handler : function() {
			var param = $('#exportOrderComplainForm').serializeObject();
			var startDate = param.startDate;
			var endDate = param.endDate;
			var cityCode = param.cityCode;
			var status = param.status;
			//验证导出申诉表时间
			if(startDate == null || startDate == '' || startDate == undefined
					|| endDate == null || endDate == '' || endDate == undefined){
				$.messager.show({
					title : '提示',
					msg : '请选择日期'
				});
				return;
			}
			if (endDate <= startDate) {
				$.messager.show({
					title : '提示',
					msg : "开始时间必须小于结束时间"
				});
				return;
			}
			$.messager.confirm('确认', '确认导出符合查询条件的数据？', function(r) {
				if (r) {
					window.open('exportOrderComplain.do?startDate=' + startDate
							+ '&endDate=' + endDate+ '&cityCode=' + cityCode+ '&status=' + status);
				}
			});
			$('#exportOrderComplain').dialog('close');
		}
	}, {
		text : '关闭',
		handler : function() {
			$('#exportOrderComplain').dialog('close');
		}
	} ]
});

function exportOrderComplain() {
	$('#exportOrderComplain').dialog('open');
}


	


