$package('app.activityTicketConf');
app.activityTicketConf = function(){
	var _box = null;
	var _this = {
		config:{
			event : {
				save : function(){
					 var ticketDescEdit = $('#ticketDescEdit').val();
					 if($.trim(ticketDescEdit)==''){
						 $.messager.alert('提示','券使用描述不能为空');  
						 return;
					 }
					 _box.handler.save();
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
						{field:'activityName',title:'关联活动名称',sortable:true},
						{field:'areaCodes',title:'活动区域',sortable:true,
							formatter: function(value,row,index){
			     				if (value!=null&&value.length > 15){
			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'....</span>';
			     				}else{
			     					return value;
			     				}
			     		    }},
						{field:'ticketName',title:'券名称',sortable:true},
			 					{field:'ticketType',title:'券类型',sortable:true,formatter:sys.dicts.text('TICKET_TYPE')},
			 					{field:'ticketMoney',title:'券面额',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font>￥"+value/100+"</font>";
			 						}},
			 					{field:'fulluse',title:'满额使用条件',sortable:true,
			 							formatter:function(value,row,index){
				 							return "<font>￥"+value/100+"</font>";
				 						}},
			 					{field:'discount',title:'折扣比例',sortable:true,
				 							formatter:function(value,row,index){
				 								if(value!=null&&value==100){
				 									return "不打折";
				 								}else if(value!=null&&value==0){
				 									return "免费";
				 								}else{
				 									return "<font>"+value/10+"折</font>";
				 								}
					 						}},
			 					{field:'maxdiscountFee',title:'最大优惠金额',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font>￥"+value/100+"</font>";
			 						}},
			 					{field:'isOverly',title:'是否可叠加其他活动',sortable:true,formatter:sys.dicts.text('YESORNO')},
			 					{field:'useRange',title:'券使用范围',sortable:true,
			 						formatter:sys.dicts.text('TICKET_USE_RANGE')},
			 					{field:'ticketValidity',title:'券有效期',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font>"+value+"天</font>";
			 						}},
			 					{field:'ticketBgimage',title:'券背景图片',sortable:true},
			 					{field:'ticketDesc',title:'券使用描述',sortable:true},
			 					{field:'dayPutcount',title:'每日最多发行张数',sortable:true},
			 					{field:'allPutcount',title:'可发行总数',sortable:true},
			 	]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add',
						iconCls : 'icon-add',
						handler : function() {
							$('#editTicketForm').form('reset');
							hid();
							$('#edit-ticket').dialog('open');
						}},
					{id:'btnedit',text:'修改',btnType:'edit',
							handler:function(){
								var rows = $('#data-list').datagrid('getChecked');
								$('#editForm').form('reset');
								if (rows.length == 1) {
									$.ajax({
										url : 'getId.do',
										type : 'post',
										data : {
											id : rows[0].id
										},
										success : function(result) {
											var discount = result.data.discount;
											if(discount!=null&&discount==100){
												//折扣为100%时，即不打折
												discount="不打折";
				 							}else if(discount!=null&&discount==0){
				 								//0折券，即免费
				 								discount="免费";
				 							}else{
				 								discount = discount/10+"折";
				 							}
											var ticketType = result.data.ticketType;
											if(ticketType==1){
												ticketType="抵扣券";
											}else if(ticketType==2){
												ticketType="满减券";
											}else if(ticketType==3){
												ticketType="折扣券";
											}
											$('#ticketTypeEdit').html(ticketType);
											$('#discountEdit').html(discount);
											$('#maxdiscountFeeEdit').html("￥"+result.data.maxdiscountFee/100);
										}
									});
									if(rows[0].ticketType==3){
										//当券类型为3，即为折扣券时，显示折扣比例和最大优惠金额输入框
										show();
									}else{
										//当券类型为1或2，即为抵扣券和满减券时，隐藏折扣比例和最大优惠金额输入框
										hid();
									}
									//修改时，根据关联活动加载活动区域树的数据
									$('#ztree').dialog({
										maximizable:true,
									    href: '../view/fragrans/appsystem/excheck.jsp?param='+rows[0].activityId+'&objId='+rows[0].id,
									});
									_box.handler.edit();
								} else {
									$.messager.show({
										msg : '请选择一条记录',
										title : '提示'
									});
								}
							}},
					{id:'btndelete',text:'删除',btnType:'remove'},
                    {id:'btnauthArea',text:'授权区域',iconCls : 'ext-icon-accept',btnType:'ticketAuthArea',handler:function(){
                        authArea();
                    }}
				]
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
			$('#edit-ticket').dialog({
				buttons : [ {
					text : '保存',
					handler : function() {
						var ticketDescAdd = $('#ticketDescAdd').val();
						 if($.trim(ticketDescAdd)==''){
							 $.messager.alert('提示','券使用描述不能为空');  
							 return;
						 }
						$('#editTicketForm').form('submit', {
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
									$('#edit-ticket').dialog('close');
									$('#data-list').datagrid('reload');
								}
							}
						});
					}
				}, {
					text : '关闭',
					handler : function() {
						$('#edit-ticket').dialog('close');
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

            $('#edit-authArea').dialog({
                buttons : [ {
                    text : '保存',
                    handler : function() {
                        $.messager.confirm('确认', '一旦保存，该活动下的券配置区域都将统一修改成当前区域，确定保存吗？', function(r) {
                            if (r) {
                                var rows = $('#data-list').datagrid('getChecked');
                                var activityId = rows[0].activityId;
                                var areaCodes = $('#authAreaCodeEdit').val();
                                if (isNull(areaCodes)) {
                                    $.messager.alert('提示', '活动区域不能为空');
                                    return;
                                }
                                //统一给活动下的券配置授权区域
                                $.ajax({
                                    url: 'authArea.do',
                                    type: 'post',
                                    traditional: true,
                                    data: {
                                        activityId: activityId,
                                        areaCodes: areaCodes
                                    },
                                    success: function (result) {
                                        $.messager.show({
                                            title: '提示',
                                            msg: result.msg
                                        });
                                        if (result.success) {
                                            $('#data-list').datagrid('reload');
                                            $('#edit-authArea').dialog('close');
                                        }
                                    }
                                });
                            }
                        });
                    }
                }, {
                    text : '关闭',
                    handler : function() {
                        $('#edit-authArea').dialog('close');
                    }

                } ]
            });
		}
	}
	return _this;
}();

$(function(){
	app.activityTicketConf.init();
});

function authArea() {
    var rows = $('#data-list').datagrid('getChecked');
    if (rows.length != 1) {
        $.messager.show({
            title: '提示',
            msg: '请选择一条记录~'
        });
        return;
    }

    $('#authAreaNameEdit').val('');
    $('#authAreaCodeEdit').val('');
    $.ajax({
        url : 'getId.do',
        type : 'post',
        data : {
            id : rows[0].id
        },
        success : function(result) {
        	var areaName = "";
            var areaCode = "";
        	if(!isNull(result.data.areaName)) {
                areaName = result.data.areaName + "";
            }
            if(!isNull(result.data.areaCode)) {
                areaCode = result.data.areaCode + "";
            }
			$('#authAreaNameEdit').val(areaName);
            $('#authAreaCodeEdit').val(areaCode);
        }
    });

    //修改时，根据关联活动加载活动区域树的数据
    $('#ztree').dialog({
        maximizable:true,
        href: '../view/fragrans/appsystem/excheck.jsp?param='+rows[0].activityId+'&objId='+rows[0].id+'&codeEditId=authAreaCodeEdit&nameEditId=authAreaNameEdit',
    });

    $('#authActivityName').text(rows[0].activityName);
    $('#edit-authArea').dialog("open");
}

//提示
$('#fulluseAdd').tooltip({    
	position: 'right',    
	content: '<span style="color:black">单位:分，如满500分使用则填500</span>',    
	onShow: function(){       
		$(this).tooltip('tip').css({            
			backgroundColor: '#ffc',           
			borderColor: '#c93'       
				});    
		}
});

$('#fulluseEdit').tooltip({    
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

//显示折扣比例和最大优惠金额输入框
function show(){
	$("#disc").fadeIn(500);
	$("#discountDiv").fadeIn(500);
	$("#maxdiscFee").fadeIn(500);
	$("#maxdiscountFeeDiv").fadeIn(500);
	$('#discount').validatebox({    
	    required: true, 
	    missingMessage:"请输入折扣比例(比如8折 填写80)"
	});
	$('#maxdiscountFee').validatebox({    
	    required: true, 
	    missingMessage:"比如最大500分 填写500,若为0，则不限制"
	});
	//券类型为折扣券时，设置券面额为0
	$('#ticketMoney').numberbox('setValue', 0);
	//验证框判断券面额是否为0
	$.extend($.fn.validatebox.defaults.rules, {    
	    equals: {    
	        validator: function(value,param){    
	        	return value == 0;    
	        },    
	        message: '折扣券券面额为0'   
	    }    
	}); 
}

//隐藏折扣比例和最大优惠金额输入框
function hid(){
	$("#disc").hide();
	$("#discountDiv").hide();
	$("#maxdiscFee").hide();
	$("#maxdiscountFeeDiv").hide();
	$('#discount').validatebox({    
	    required: false, 
	});
	$('#maxdiscountFee').validatebox({    
	    required: false, 
	});
	//隐藏之后清空输入框中的数据
	$('#discount').val('');
	$('#maxdiscountFee').val('');
	$('#ticketMoney').numberbox('setValue', '');
	//验证券面额不为空
	$.extend($.fn.validatebox.defaults.rules, {    
	    equals: {    
	        validator: function(value,param){    
	        	return value !='';    
	        },    
	        message: '请输入券面额'   
	    }    
	}); 
}
//改变关联活动时，活动区域下拉框显示的是该活动所属的全部区域
$('#activityNameAdd').combobox({
	title:'列表',
	url:'getActivityTicketName.do',
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
	url:'getActivityTicketName.do',
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

function isNull(str){
    if(str==null||str==''||str==undefined){
        return true;
    }
    return false;
}
