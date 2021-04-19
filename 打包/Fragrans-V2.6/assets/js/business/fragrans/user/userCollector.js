$package('user.userCollector');
user.userCollector = function() {
	var _box = null;
	var _this = {
		config : {
			dataGrid : {
				title : '收费员列表',
				url : 'dataList.do',
				fitColumns : true,
				columns : [[
					{
						field : 'id',
						checkbox : true
					}, {
						field : 'userAccount',
						title : '收费员账号',
						width : 80,
						sortable : true
					}, {
						field : 'nickName',
						title : '昵称',
						width : 80,
						sortable : true
					},
					// 根据cityCode关联base_area表中的areaCode，得到areaName
					{
						field : 'areaName',
						title : '城市',
						width : 80,
						sortable : true
					}, {
						field : 'mobile',
						title : '手机号码',
						width : 80,
						sortable : true
					}, {
						field : 'status',
						title : '状态',
						width : 80,
						sortable : true,
						formatter : sys.dicts.text('USER_STATUS')
					}, {
						field : 'regerCode',
						title : '邀请码',
						width : 80,
						sortable : true
					}, {
						field : 'regerCount',
						title : '总邀请人数',
						width : 80,
						sortable : true
					}, {
						field : 'createTime',
						title : '注册时间',
						width : 80,
						sortable : true
					},
				]],
				toolbar:[
				         {id:'btnadd',text:'添加',btnType:'add',
				        	 handler : function() {
				        		 $('#editForm').form('reset');
				        		 $('#edit-win').dialog('open');
				        	 }
				         },
				         {id:'btnedit',text:'修改',btnType:'edit'},
				         {id:'btnRemoveCollector',text:'注销收费员',btnType:'removeCollector',iconCls : 'ext-icon-cancel',
                             handler : function() {
								removeCollector();
							 }},
				         {
								id : 'btnreger',
								iconCls : 'ext-icon-comment_edit',
								text : '邀请信息',
								btnType : 'reger',
								handler : function() {
									var rows = $('#data-list').datagrid('getChecked');
									if (rows.length == 1) {
										$('#regerDiv').dialog('open');
										$('#startTime').datebox('setValue',getTheMonthFirstDay());
										$('#endTime').datebox('setValue',getNowDate());
										userRegerInfo(rows);
									} else {
										$.messager.show({
											msg : '请选择一条记录~',
											title : '提示'
										});
									}
								}
				         }
				         ,{
				        	 	id:'btnExport',
				        	 	text:'导出业绩',
				        	 	btnType:'edit',
				        	 	iconCls:"ext-icon-page_excel",
								handler : function() {
									$('#exportResultForm').form('reset');
									$('#exportRegerResult').dialog('open');
								}}
				]
			}
		},
		init : function() {
			_box = new YDataGrid(_this.config);
			_box.init();
			$('#edit-win').dialog({
				buttons:[
				         {
				        	 text:'保存',
				        	 handler:function(){
				        		 var userAccount = $('#userAccount').val();
								 var mobile = $('#mobile').val();
								 if(userAccount!=mobile){
									 $.messager.alert('提示','手机号码必须与账号一致');
									 return;
								 }
				        		 $('#editForm').form('submit',{
				        			 url:'save.do',
				        			 type : 'post',
				        			 success:function(result){
				        				 var mes = eval('('+result+')');
				        				 if(mes.success){
				        					 $.messager.show({
 												msg : mes.msg,
 												title : '提示'
 											 });
				        					 $('#edit-win').dialog('close');
					        				 $('#data-list').datagrid('reload');
				        				 }else{
				        					 var userAccount = $('#userAccount').val();
				        					 var areaId = $('#areaId').combotree('getValue');
				        					 $.messager.confirm('提示', '该账号已被注册成普通用户，点击确定将被重置成收费员', function(r) {
			        							if (r) {
			        								$.ajax({
			    				        				url : 'resetRegerCode.do',
			    				        				type : 'post',
			    				        				dataType : 'json',
			    				        				data : {
			    				        					userAccount : userAccount,
			    				        					areaId : areaId
			    				        				},
			    				        				success : function(data) {
			    				        					$.messager.show({
			    												msg : data.msg,
			    												title : '提示'
			    											});
			    				        					if(data.success){
			    				        						$('#edit-win').dialog('close');
			    						        				$('#data-list').datagrid('reload');
			    				        					}
			    				        				}
			        								});
			        							}
			        						 });
				        				 }
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
		}
	}
	return _this;
}();

function userRegerInfo(rows){
	var startTime = $('#startTime').datebox('getValue');
	var endTime = $('#endTime').datebox('getValue');
	if (endTime < startTime) {
		$.messager.show({
			title : '提示',
			msg : "开始时间必须小于结束时间"
		});
		return;
	}
	
	//获取当前用户邀请信息
	$.ajax({
		url : 'getRegerInfo.do',
		type : 'post',
		dataType : 'json',
		data : {
			id : rows[0].id,
			startTime : startTime,
			endTime : endTime
		},
		success : function(result) {
			if (result.success) {
				$('#regerCode').html(rows[0].regerCode);
				$('#regerCount').html(result.data.regerCount);
//				$('#payUserCount').html(result.data.payUserCount);
//				$('#userPayOrderCount').html(result.data.userPayOrderCount);
//				if(result.data.userAccount == null
//						|| result.data.userAccount == ''
//						|| result.data.userAccount == 'undefined'){
//					$('#parentAccount').html('无');
//				}else{
//					$('#parentAccount').html(result.data.userAccount);
//				}
			} else {
				$.messager.show({
					msg : result.msg,
					title : '提示'
				});
			}
		}
	});
	//获取当前用户邀请人列表
	$('#regerTable').datagrid(
			{
				rownumbers : true,
				fitColumns : true,
				singleSelect : true,
				url : 'getRegerDetail.do?id=' + rows[0].id+'&startTime='+startTime+'&endTime='+endTime,
				width : 500,
				height :280,
				onLoadSuccess: function (data) {
			            if (data.rows.length == 0) {
			                //添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
			                $(this).datagrid('appendRow', { userAccount: '<div style="text-align:center;">没有相关记录！</div>' }).datagrid('mergeCells', { index: 0, field: 'userAccount', colspan: 2 })
			            }
			    },
				columns : [[
						{
							field : 'userAccount',
							title : '用户账号',
							width : 200,
							sortable : true
						},
						{
							field : 'createTime',
							title : '注册时间',
							width : 300,
							sortable : true
						}] ],
			});
}

$('#exp_cityCode').combotree({    
    url: '../area/getAreaTree.do',
    fit : true,
    idField : 'id',
    treeField : 'areaName',
    parentField : 'parentId',
}); 

$(function() {
	user.userCollector.init();
	$('#exportRegerResult').dialog({
		buttons : [ {
			text : '导出',
			handler : function() {
				var param = $('#exportResultForm').serializeObject();
				var cityCode = param.cityCode;
				var startDate = param.startDate;
				var endDate = param.endDate;
				if(cityCode==''||cityCode==null||cityCode==undefined){
					$.messager.show({
						title : '提示',
						msg : '城市不能为空'
					});
					return;
				}
				if(startDate == null || startDate == '' || startDate == undefined
						|| endDate == null || endDate == '' || endDate == undefined){
					$.messager.show({
						title : '提示',
						msg : '请选择日期'
					});
					return;
				}
				if (endDate < startDate) {
					$.messager.show({
						title : '提示',
						msg : "开始时间必须小于结束时间"
					});
					return;
				}
				var dates = GetDateDiff(startDate,endDate);
				if (dates > 31) {
					$.messager.show({
						title : '提示',
						msg : "开始时间和结束时间间隔不能超过31天"
					});
					return;
				}
				//导出业绩
				$.messager.confirm('确认', '确认导出该城市及其子级城市的收费员业绩？', function(r) {
					if (r) {
						window.open('exportRegerResult.do?cityCode=' + cityCode+'&startDate=' + startDate
							+ '&endDate=' + endDate);
					}
				});
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#exportRegerResult').dialog('close');
			}
		} ]
	});
});

function GetDateDiff(startDate,endDate)  
{  
    var startTime = new Date(Date.parse(startDate.replace(/-/g,   "/"))).getTime();     
    var endTime = new Date(Date.parse(endDate.replace(/-/g,   "/"))).getTime();     
    var dates = Math.abs((startTime - endTime))/(1000*60*60*24);     
    return  dates;    
}

$('#search').bind('click', function(){ 
	var rows = $('#data-list').datagrid('getChecked');
	userRegerInfo(rows);
});

function getTheMonthFirstDay() {
	var date = new Date();
	date.setTime(date.getTime());
	return date.pattern("yyyy-MM-01");
}

function getNowDate(){
	var date = new Date();
	date.setTime(date.getTime());
	return date.pattern("yyyy-MM-dd");
}

function removeCollector(){
    var rows = $('#data-list').datagrid('getChecked');
    if (rows.length != 1) {
        $.messager.show({
            title : '提示',
            msg : '请选择一条记录~'
        });
        return;
    }
    $.messager.confirm('确认', '该操作会将'+rows[0].userAccount+'收费员置为普通用户，确定吗？', function(r) {
        if (r) {
            $.ajax({
                url: 'removeCollector.do',
                type: 'post',
                data: {
                    id: rows[0].id
                },
                success: function (result) {
                    $.messager.show({
                        title: '提示',
                        msg: result.msg
                    });
                    if (result.success) {
                        $('#edit-win').dialog('close');
                        $('#data-list').datagrid('reload');
                    }
                }
            });
        }
    });
}