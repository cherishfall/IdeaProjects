$package('app.complain');
app.complain = function(){
	var _box = null;
	var _this = {
		detail : function(rows) {
			$('#detail').dialog({    
				maximizable:true,
				href: '../view/fragrans/appsystem/parkrecordDetail.jsp?parkrecordId='+rows[0].parkrecordId+'&cityCode='+rows[0].cityCode,    
			});
			$('#detail').dialog("open");
		},
		config:{
  			dataGrid:{
  				title : '列表',
  				url:'getMyComplain.do',
  				fit:true,
  				height : 416,
//  				rowStyler:function(index,row){   
//  					if(row.processOverTimeFlag==1){
//  						return 'background-color:#faf2cc;';
//  					}else{
//  						if (row.refundFlag==2){   
//  							return 'background-color:#ebcccc;';   
//  						}
//  					}
//  				},  
  				columns:[[ 
  				        {field:'id',checkbox:true},
  						{field:'cityCode',hidden:true},
  						{field:'areaName',title:'区域名称',sortable:true},
  						{field:'userAccount',title:'用户账号',sortable:true},
  						{field:'parkrecordId',title:'停车记录ID',sortable:true},
  						{field:'palteNo',title:'车牌号',sortable:true},
  						{field:'complainType',title:'投诉类型',sortable:true,formatter:sys.dicts.text('COMPLAIN_TYPE')},
//  						{field:'isComplate',title:'是否完成订单',sortable:true,formatter:sys.dicts.text('IS_COMPLATE')},
  						{field:'complainDesc',title:'投诉内容',width:200,sortable:true,
  							formatter: function(value,row,index){
  			     				if (value!=null&&value.length > 12){
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
  						{field:'refundFee',title:'退款金额',sortable:true,
 							formatter:function(value,row,index){
		 						return "<font font-weight:bold;'>￥"+value/100+"</font>";
		 					}},
  						{field:'complainResource',title:'申诉来源',sortable:true,
  							formatter:sys.dicts.text('COMPLAIN_RESOURCE')},
  						{field:'processOverTimeFlag',title:'退款处理超时标识',hidden:true},
  						{field:'createTime',title:'创建时间',sortable:true},
//  		 				{field:'updateTime',title:'更新时间',sortable:true}
  			 	]],
  			 	toolbar:[
  			 	         {id:'btnExport',text:'导出申诉表',btnType:'export',iconCls:"ext-icon-page_excel",
  			 	        	 handler : function() {
  			 	        		 $('#exportOrderComplainForm').form('reset');
  			 	        		 exportOrderComplain();
  			 	        }},{id:'btndetail',text:'停车记录详情',btnType:'detail',iconCls : 'ext-icon-report_add',
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
	app.complain.init();
	$('#data-list').datagrid({
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
//	                    	  title : '来源用户',
	                    	  title : '处理人',
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
	                    	  hidden : true,
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
//	                    	  title : '来源用户处理意见',
	                    	  title : '处理意见',
	                    	  formatter: function(value,row,index){
	                    		  if (value!=null&&value.length > 50){
	                    			  var aa = value.replace(/(\n)+|(\r\n)+/g, "");
	                    			  return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,50)+'...</span>';
	                    		  }else{
	                    			  return value;
	                    		  }
	                    	  }  
	                      },
	                      {
	                    	  field : 'fromTime',
//	                    	  title : '来源用户处理时间',
	                    	  title : '处理时间',
	                    	  width:150
	                      },
	                      {
	                    	  field : 'toResult',
	                    	  width : 200,
	                    	  hidden : true,
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
	                    	  hidden : true,
	                    	  width:150
	                      },
	                      {
	                    	  field : 'status',
	                    	  title : '流程处理状态',
	                    	  width:150,
	                    	  formatter:sys.dicts.text('PROCESS_STATUS')
	                      }
	            ]],
	            onResize:function(){
	                $('#data-list').datagrid('fixDetailRowHeight',index);
	            },
	            onLoadSuccess:function(){
	                setTimeout(function(){
	                    $('#data-list').datagrid('fixDetailRowHeight',index);
	                },0);
	            }
	        });
	        $('#data-list').datagrid('fixDetailRowHeight',index);
	    }
	});	
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
					$.ajax({
						url : 'findOrderComplain.do?startDate=' + startDate
						+ '&endDate=' + endDate+ '&cityCode=' + cityCode+ '&status=' + status,
						type : 'post',
						success : function(result) {
							if(result!=null&&result.length!=0){
								window.open('exportOrderComplain.do?startDate=' + startDate
								+ '&endDate=' + endDate+ '&cityCode=' + cityCode+ '&status=' + status);
							}else{
								$.messager.show({
									title : '提示',
									msg : '没有符合该条件的数据~'
								});
							}
						}
					});
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

$('#cityCode').combotree({
	title:'列表',
	url:'../area/getAreaTree.do',
	fit : true,
	idField : 'id',
	panelHeight : '200',
	treeField : 'areaName',
	parentField : 'parentId',
});
