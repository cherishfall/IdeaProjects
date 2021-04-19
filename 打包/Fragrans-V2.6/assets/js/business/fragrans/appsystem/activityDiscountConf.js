$package('appsystem.activityDiscountConf');
appsystem.activityDiscountConf = function(){
	var _box = null;
	var _this = {
		config:{
			event : {
				add : function() {
					$('#editForm').form('reset');
					_box.handler.add();
				},
				save:function(){
					var param = $('#editForm').serializeObject();
					var discountStartTimeEdit = param.discountStartTime;
					var discountEndTimeEdit = param.discountEndTime;
					if (discountEndTimeEdit < discountStartTimeEdit) {
						$.messager.show({
							title : '提示',
							msg : "开始时间不能大于结束时间"
						});
						return;
					}
					_box.handler.save();
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('PAY_METHOD')
						{field:'id',checkbox:true},
	 					{field:'activityName',title:'关联活动名称',sortable:true},
	 					{field:'areaCodes',title:'活动城市',sortable:true,
	 						formatter: function(value,row,index){
			     				if (value!=null&&value.length > 15){
			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'....</span>';
			     				}else{
			     					return value;
			     				}
			     		    }},
			 					{field:'discountName',title:'折扣名称',sortable:true},
			 					{field:'payment',title:'支付方式',sortable:true,
			 						formatter : sys.dicts.text('PAY_METHOD')},
			 					{field:'fulluse',title:'满额使用条件',sortable:true,
			 							formatter:function(value,row,index){
				 							return "<font>￥"+value/100+"</font>";
				 						}},
			 					{field:'discount',title:'折扣比例',sortable:true,
				 							formatter:function(value,row,index){
					 							return "<font>"+value/10+"折</font>";
					 						}},
			 					{field:'maxdiscountFee',title:'最大折扣封顶金额',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font>￥"+value/100+"</font>";
			 						}},
			 					{field:'isOverly',title:'是否可叠加其他活动',sortable:true,
			 						formatter : sys.dicts.text('YESORNO')},
			 					{field:'discountStartTime',title:'折扣有效期开始时间',sortable:true,
			 							formatter:function(value,row,index){
											return value.split(" ")[0];
										}},
			 					{field:'discountEndTime',title:'折扣有效期结束时间',sortable:true,
											formatter:function(value,row,index){
												return value.split(" ")[0];
											}},
			 					{field:'discountDesc',title:'折扣使用描述',sortable:true},
			 					{field:'userDayCount',title:'单个用户每日打折次数',sortable:true},
			 					{field:'dayCount',title:'每日打折总次数',sortable:true},
			 					{field:'allCount',title:'总配置次数',sortable:true}
			 	]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add',
						iconCls : 'icon-add',
						handler : function() {
							$('#editDiscountForm').form('reset');
							$('#edit-discount').dialog('open');
						}},
					{id:'btnedit',text:'修改',btnType:'edit',
							handler:function(){
								var rows = $('#data-list').datagrid('getChecked');
								$('#editForm').form('reset');
								if (rows.length == 1) {
									$.ajax({
										url : '../excheck/getActivityStatus.do',
										type : 'post',
										data : {
											activityId : rows[0].activityId
										},
										success : function(result) {
											$('#ztree').dialog({    
												maximizable:true,
											    href: '../view/fragrans/appsystem/excheck.jsp?param='+rows[0].activityId+'&objId='+rows[0].id,    
											});
											//判断活动是否在线，活动在线则不能修改关联活动和活动城市
											if(result!=null&&result.status==1){
												$("#activityName").hide();
												$("#activityNameDiv").hide();
												$("#areaName").hide();
												$("#areaNameDiv").hide();
											}else if(result!=null&&result.status==0){
												$("#activityName").show();
												$("#activityNameDiv").show();
												$("#areaName").show();
												$("#areaNameDiv").show();
											}
											_box.handler.edit();
										}
									});
								} else {
									$.messager.show({
										msg : '请选择一条记录',
										title : '提示'
									});
								}
							}},
					{id:'btndelete',text:'删除',btnType:'remove'}
				]
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
			$('#edit-discount').dialog({
				buttons : [ {
					text : '保存',
					handler : function() {
						var param = $('#editActivityForm').serializeObject();
						var discountStartTimeAdd = param.discountStartTime;
						var discountEndTimeAdd = param.discountEndTime;
						if (discountEndTimeAdd <= discountStartTimeAdd) {
							$.messager.show({
								title : '提示',
								msg : "开始时间必须小于结束时间"
							});
							return;
						}
						$('#editDiscountForm').form('submit', {
							url : 'save.do',
							type : "post",
							onSubmit : function() {
								return $(this).form('validate');
							},
							success : function(result) {
								var res = $.parseJSON(result);
								$.messager.show({
									title : '提示',
									msg : res.msg
								});
								if (res.success) {
									$('#edit-discount').dialog('close');
									$('#data-list').datagrid('reload');
								}
							}
						});
					}
				}, {
					text : '关闭',
					handler : function() {
						$('#edit-discount').dialog('close');
					}

				} ]
			});
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

$('#fulluse').tooltip({    
	position: 'right',    
	content: '<span style="color:black">单位:分，如满500分使用则填500</span>',    
	onShow: function(){       
		$(this).tooltip('tip').css({            
			backgroundColor: '#ffc',           
			borderColor: '#c93'       
				});    
		}
});

$('#discount').tooltip({    
	position: 'right',    
	content: '<span style="color:black">请输入折扣比例(如8折 填写80)</span>',    
	onShow: function(){       
		$(this).tooltip('tip').css({            
			backgroundColor: '#ffc',           
			borderColor: '#c93'       
				});    
		}
});

$('#maxdiscountFee').tooltip({    
	position: 'right',    
	content: '<span style="color:black">单位:分，如满500分使用则填500</span>',    
	onShow: function(){       
		$(this).tooltip('tip').css({            
			backgroundColor: '#ffc',           
			borderColor: '#c93'       
				});    
		}
});

$(function(){
	appsystem.activityDiscountConf.init();
});		

$('#activityNameAdd').combobox({
	title:'列表',
	url:'getActivityName.do',
	fit : true,
	valueField : 'id',
	textField:'text',
	onChange:function(newValue, oldValue){
		$('#ztree').dialog({    
			maximizable:true,
		    href: '../view/fragrans/appsystem/excheck.jsp?param='+newValue+'&objId=""',    
		});
	}
});

$('#activityNameEdit').combobox({
	title:'列表',
	url:'getActivityName.do',
	fit : true,
	valueField : 'id',
	textField:'text',
	onChange:function(newValue, oldValue){
		$('#ztree').dialog({    
			maximizable:true,
		    href: '../view/fragrans/appsystem/excheck.jsp?param='+newValue,    
		});
	}
});

function ztreeAdd(){
	var activityNameAdd = $('#activityNameAdd').combobox('getValue');
	if(activityNameAdd==''||activityNameAdd==null){
		 $.messager.alert('提示','请先选择关联活动');  
		 return;
	}
	$('#ztree').dialog("open");
}

function ztreeEdit(){
	$('#ztree').dialog("open");
}