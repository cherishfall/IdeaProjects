$package('activity.shareGetUser');
activity.shareGetUser = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
	   			        {field:'id',checkbox:true},
	 					{field:'userAccount',title:'中奖用户账号',sortable:true},
	 					{field:'regUserCounts',title:'推荐注册用户数',sortable:true},
	 					{field:'payUserCounts',title:'缴费用户数',sortable:true}
			 	]],
			 	toolbar:[
						{id:'btnsendSms',text:'发送短信',btnType:'send',iconCls:'ext-icon-comment_edit',
								handler:function(){
									var rows = $('#data-list').datagrid('getChecked');
									if (rows.length == 0) {
										$.messager.show({
											title : '提示',
											msg : '请选择一条记录~'
										});
									}else {
										$('#sms-win').dialog('open');
									}
								}},
						{id:'btntestSendSms',text:'测试发送短信',btnType:'testsend',iconCls:'ext-icon-pencil_go',
							handler:function(){
								$('#test-sms-win').dialog('open');
							}}
						]
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
			$('#sms-win').dialog({
				buttons:[
				         {
				        	 text:'发送短信',
				        	 handler:function(){
				        		 var rows = $('#data-list').datagrid('getChecked');
				        		 var shareGetUsers = [];
				        		 for(var i=0;i<rows.length;i++){
				        			shareGetUsers.push(rows[i].userAccount);
				        		 }
				        		 var content = $('#content').val();
				        		 if(content==null||content==''||content==undefined){
				        			 $.messager.show({
	        							 msg : '短信内容不能为空',
	        							 title : '提示'
	        						 });
				        			 return;
				        		 }
				        		 $.messager.confirm('提示', '确定发送短信？', function(r) {
		 							if (r) {
						        		 $.ajax({
						        				url : 'sendSms.do',
						        				type : 'post',
						        				dataType : 'json',
						        				traditional: true,
						        				data : {
						        					shareGetUsers : shareGetUsers,
						        					content : content
						        				},
						        				success : function(result) {
						        					if(result.success){
						        						$.messager.alert('提示',result.msg,'info');
						        					}else{
						        						$.messager.show({
						        							msg : result.msg,
						        							title : '提示'
						        						});
						        					}
						        					$('#sms-win').dialog('close');
						        				}
						        			});
		 								}
				        		 });
				        	 }
				         },{
				        	 text:'关闭',
				        	 handler:function(){
				        		 $('#sms-win').dialog('close');
				        	 }
				         }
				      ]
			});
			
			$('#test-sms-win').dialog({
				buttons:[
				         {
				        	 text:'发送短信',
				        	 handler:function(){
				        		 var shareGetUsers = [];
				        		 shareGetUsers.push($('#shareGetUsers').val());
				        		 var content = $('#testContent').val();
				        		 if(content==null||content==''||content==undefined){
				        			 $.messager.show({
	        							 msg : '短信内容不能为空',
	        							 title : '提示'
	        						 });
				        			 return;
				        		 }
				        		 $.messager.confirm('提示', '确定发送短信？', function(r) {
		 							if (r) {
						        		 $.ajax({
						        				url : 'sendSms.do',
						        				type : 'post',
						        				dataType : 'json',
						        				traditional: true,
						        				data : {
						        					shareGetUsers : shareGetUsers,
						        					content : content
						        				},
						        				success : function(result) {
						        					if(result.success){
						        						$.messager.alert('提示',result.msg,'info');
						        					}else{
						        						$.messager.show({
						        							msg : result.msg,
						        							title : '提示'
						        						});
						        					}
					        						$('#test-sms-win').dialog('close');
						        				}
						        			});
		 								}
				        		 });
				        	 }
				         },{
				        	 text:'关闭',
				        	 handler:function(){
				        		 $('#test-sms-win').dialog('close');
				        	 }
				         }
				      ]
			});
		}
	}
	return _this;
}();

$(function(){
	activity.shareGetUser.init();
});		