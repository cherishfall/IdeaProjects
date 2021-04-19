$package('app.memberCard');
app.memberCard = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'userId',hidden:true},
	 					{field:'userAccount',title:'用户账号',sortable:true,width:60},
	 					{field:'areaName',title:'区域名称',sortable:true,width:60},
	 					{field:'memberCardNo',title:'会员卡编码',sortable:true,width:60},
	 					{field:'balance',title:'卡内余额',sortable:true,width:60,
		                	formatter:function(value,row,index){
	 							return "<font style='color:green;font-weight:bold;'>￥"+value/100+"</font>";
	 						}},
						{field:'giftAmount',title:'赠送金额',sortable:true,width:60,
							formatter:function(value,row,index){
								return "<font style='color:green;font-weight:bold;'>￥"+value/100+"</font>";
                        }},
	 					{field:'isNoPwdpay',title:'是否开启免密支付',sortable:true,width:60,formatter:sys.dicts.text('YESORNO')},
	 					{field:'status',title:'会员卡状态',sortable:true,width:60,formatter:sys.dicts.text('MEMBER_CARD_STATUS')},
	 					{field:'refundStatus',title:'退款状态',sortable:true,width:60,
                            formatter:function(value){
                                if(value==3){
                                 	return "<font style='color:red;'>"+sys.dicts.text('MEMBER_CARD_REFUND_STATUS',value)+"</font>";
                                }
                                return sys.dicts.text('MEMBER_CARD_REFUND_STATUS',value);
                            }},
	 					{field:'createTime',title:'开卡时间',sortable:true,width:60}
			 	]],
				toolbar:[
					{
						id : 'btnAutoPay',
						iconCls : 'ext-icon-money',
						text : '自动支付列表',
						btnType : 'autoPay',
						handler : function() {
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length == 1) {
								autoPay(rows);
							} else {
								$.messager.show({
									msg : '请选择一个用户',
									title : '提示'
								});
							}
						}
					},
					{
						id : 'btnDeblock',
						iconCls : 'ext-icon-key',
						text : '解锁',
						btnType : 'memberCardDeblock',
						handler : function() {
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length == 1) {
								deblock(rows);
							} else {
								$.messager.show({
									msg : '请选择一个用户',
									title : '提示'
								});
							}
						}
					},{id:'btnAccept',text:'退款受理',btnType:'refundAccept',iconCls : 'ext-icon-accept',
						handler:function(){
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length != 1) {
								$.messager.show({
									title : '提示',
									msg : '请选择一条记录~'
								});
								return;
							} 
							accept(rows);
						}},{
						id : 'btnRefund',
						iconCls : 'ext-icon-pencil_go',
						text : '退款',
						btnType : 'memberCardRefund',
						handler : function() {
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length == 1) {
								refundFee(rows);
							} else {
								$.messager.show({
									msg : '请选择一条记录',
									title : '提示'
								});
							}
						}
					},{
						id : 'btnCancle',
						iconCls : 'ext-icon-shape_square_go',
						text : '注销',
						btnType : 'memberCardCancle',
						handler : function() {
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length == 1) {
								cancle(rows);
							} else {
								$.messager.show({
									msg : '请选择一个用户',
									title : '提示'
								});
							}
						}
					},
					{
						id : 'btnRecord',
						iconCls : 'ext-icon-application_form_magnify',
						text : '余额变动记录',
						btnType : 'memberCardRecord',
						handler : function() {
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length == 1) {
								record(rows);
							} else {
								$.messager.show({
									msg : '请选择一个用户',
									title : '提示'
								});
							}
						}
					},
                    {
                        id : 'btnProcessMemberCard',
                        iconCls : 'ext-icon-cog_edit',
                        text : '申办会员',
                        btnType : 'processMemberCard',
                        handler : function() {
                            //清空表单
                            $('#name').val('');
                            $('#cityCode').combotree('clear');
                            $('#phone').val('');
                            $('#plateNo').val('');
                            $('#price').val('');
                            $('#isAutoPay').combobox('setValue','');
                            $('#plateColor').combobox('setValue','');
                            $('#remark').val('');
                            // 打开弹窗
                            $('#processMemberCardDiv').dialog('open');
                        }
                    }
//					{id:'btnadd',text:'添加',btnType:'add'},
//					{id:'btnedit',text:'修改',btnType:'edit'},
//					{id:'btndelete',text:'删除',btnType:'remove'}
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

/**
 * 批量受理退款
 * @param rows 受理记录
 */
function accept(rows){
//	var cardIds = [];
//	for(var i=0;i<rows.length;i++){
//		if(rows[i].refundStatus == 0){
//			 $.messager.alert('提示','该会员卡退款申请正在处理~');  
//			 return;
//		}
//		cardIds.push(rows[i].id);
//	}
	if(rows[0].refundStatus == 1){
		 $.messager.alert('提示','该会员卡退款申请正在处理~');  
		 return;
	}
	$.ajax({
		url : 'getRefundInfo.do',
		type : 'post',
		data : {
			userId : rows[0].userId
		},
		success : function(result){
			if(result.success){
				var refundBalance = result.data.refundBalance/100;
				if(isEmpty(refundBalance) || refundBalance == 0){
					 $.messager.alert('提示','可退款金额小于等于0元，不可退款~');  
					 return;
				}
				$.messager.confirm('警告', '确认受理？若受理该记录，则用户会员卡将被冻结直至退款结束！', function(r) {
					if (r) {
						$.ajax({
							url : 'accept.do',
							type : 'post',
							traditional: true,
							data : {
								ids : rows[0].id
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
		}
	});
}

function refundFee(rows){
	if(rows[0].refundStatus != 1){
		 $.messager.alert('提示','该会员卡退款申请未受理~');  
		 return;
	}
	$.ajax({
		url : 'getRefundInfo.do',
		type : 'post',
		data : {
			userId : rows[0].userId
		},
		success : function(result){
			if(result.success){
				$('#refund').dialog('open');
				$('#refundForm').form('clear');
				$('#refundForm').form('load',{
					userId:rows[0].userId,
					userAccount:result.data.userAccount,
					memberCardNo:result.data.memberCardNo,
					balance:"￥"+result.data.balance/100,
					refundBalance:"￥"+result.data.refundBalance/100});
			}
			
		}
	});
	$('#refund').dialog({
		buttons : [ {
			text : '确认退款',
			handler : function() {
				var param = $('#refundForm').serializeObject();
				var refundBalance = param.refundBalance;
				if(isEmpty(refundBalance) || refundBalance == '￥0'){
					$.messager.alert('提示','可退金额小于或等于0，不可退款'); 
					return;
				}
				if(isEmpty(param.reason)){
					$.messager.alert('提示','退款原因不可为空'); 
					return;
				}
				$.messager.confirm('确认', '是否确认退款  <span style="color:red;font-weight:bold;font-size:15px;">'+refundBalance+'元</span>  (该操作不可逆)', function(r) {
				if (r) {
//					$.ajax({
//						url : 'memberCardRefund.do',
//						type : 'post',
//						data : {
//							userId : rows[0].userId,
//							refundBalance : refundBalance,
//							reason : reason,
//						},
//						success : function(result){
//							var res = $.parseJSON(result);
//							$.messager.show({
//								title : '提示',
//								msg : res.msg
//							});
//							if (res.success) {
//								$('#data-list').datagrid('reload');
//							}
//						}
//					});
					$('#refund').dialog('close');
					$.messager.progress({
		                title:'请稍后',
		                msg:'正在为用户退款<span style="color:red;font-weight:bold;font-size:15px;">'+refundBalance+'元</span>...'
					});
					$('#refundForm').form('submit', {
						url : 'memberCardRefund.do',
						type : "post",
						onSubmit : function() {
							return $(this).form('validate');
						},
						success : function(result) {
							$.messager.progress('close');
							var res = $.parseJSON(result);
							$.messager.show({
								title : '提示',
								msg : res.msg
							});
							$('#data-list').datagrid('reload');
						}
					});
				
					}
				});
					
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#refund').dialog('close');
			}

		} ]
	});
	
}

function cancle(rows){
	var row = rows[0];
	var status = row.status;
	if(status == 1){
		sys.alert('提示', '锁定状态不可注销~', 'warning');
		return;
	}
	if(status == 2){
		sys.alert('提示', '该会员卡已注销~', 'warning');
		return;
	}
	$.messager.confirm('确认', '确认注销？', function(r) {
		if (r) {
			$.ajax({
				url : 'cancle.do',
				type : 'post',
				traditional: true,
				data : {
					id : row.id
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

function deblock(rows){
	var row = rows[0];
	var status = row.status;
	if(status == 0){
		sys.alert('提示', '正常状态无需解锁~', 'warning');
		return;
	}
	if(status == 2){
		sys.alert('提示', '注销状态不可解锁~', 'warning');
		return;
	}
	$.messager.confirm('确认', '确认解锁？', function(r) {
		if (r) {
			$.ajax({
				url : 'deblock.do',
				type : 'post',
				traditional: true,
				data : {
					id : row.id
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

function record(rows){
	$('#recordDialog').dialog('open');
	$('#record-data').datagrid({
			fitColumns:true,  
    		singleSelect:true,  
    		height:'auto',
    		pagination:true,
			rownumbers:true,
			fit:true,
            url:'getMemberCardRecord.do',
            queryParams: {  
            	userId : rows[0].userId,
            },
            columns:[[
//	                        {field:'id',checkbox:true},
						{field:'userAccount',title:'用户账号',sortable:true},
						{field:'handleType',title:'操作类型',sortable:true,formatter:sys.dicts.text('MEMBER_CARD_HANDLE_TYPE')},
						{field:'objId',title:'操作对象',sortable:true},
						{field:'price',title:'本次操作金额',sortable:true,
							formatter:function(value,row,index){
								return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
							}},
						{field:'balanceBefore',title:'操作前余额',sortable:true,
								formatter:function(value,row,index){
									return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
								}},
						{field:'balanceAfter',title:'操作后余额',sortable:true,
									formatter:function(value,row,index){
										return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
									}},
						{field:'giveAmount',title:'赠送金额',sortable:true,
										formatter:function(value,row,index){
											return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
										}},
						{field:'changeStatus',title:'状态',sortable:true,formatter:sys.dicts.text('ORDER_STATUS')},
//						{field:'subject',title:'标题',sortable:true},
//						{field:'handleBody',title:'描述',sortable:true,
//			     		     formatter: function(value,row,index){
//				     				if (value!=null&&value.length > 10){
//				     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
//				     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,10)+'...</span>';
//				     				}else{
//				     					return value;
//				     				}
//				     	}},
						{field:'createTime',title:'创建时间',sortable:true}
				]],
			});
}

function autoPay(rows) {
	$('#autoPay').dialog('open');
	$('#autoPay-data').datagrid(
					{
						rownumbers : true,
						title : '自动支付信息',
						fitColumns : true,
						singleSelect : true,
						url : 'getAutoPayList.do?userId=' + rows[0].userId,
						width : 350,
						height : 220,
						onDblClickRow : function(index, data) {
							$('#userCar').datagrid('beginEdit', index);
						},
						columns : [ [
								{
									field : 'id',
									hidden : true
								},
								{
									field : 'userId',
									hidden : true
								},
								{
									field : 'plateNo',
									title : '车牌号',
									width : 150,
									align : 'center'
								},
								{
									field : 'isAutoPay',
									title : '是否开启自动支付',
									width : 100,
				                	formatter:function(value,row,index){
				                		if(value==0){
				                			return "<font style='color:red;font-weight:bold;'>"+sys.dicts.text('YESORNO',value)+"</font>";
				                		}else if(value==1){
				                			return "<font style='color:green;font-weight:bold;'>"+sys.dicts.text('YESORNO',value)+"</font>";
				                		}
				                		return "";
			 						}
								}]],
					});
}

$(function(){
	app.memberCard.init();
});	

/**
 * “余额变动记录”查询
 */
$('#btn-search-record').bind('click',function(){
	var rows = $('#data-list').datagrid('getChecked');
	var userId = rows[0].userId;
	var param = $('#recordSearchForm').serializeObject();
	var handleType = param.handleType;
	var objId = param.objId;
	var changeStatus = param.changeStatus;
	$('#record-data').datagrid('load', {    
	    name: 'easyui',    
	    userId:userId,
	    handleType: handleType,objId:objId,changeStatus:changeStatus});
});

$('#processMemberCardDiv').dialog({
    buttons:[
        {
            text:'开通',
            iconCls : 'ext-icon-tick',
            handler:function(){
                var name = $('#name').val();
                var cityCode = $('#cityCode').combotree('getValue');
                var phone = $('#phone').val();
                var plateNo = $('#plateNo').val().toUpperCase();
                var plateColor = $('#plateColor').combobox('getValue');
                var isAutoPay = $('#isAutoPay').combobox('getValue');
                var price = $('#price').val();
                var remark = $('#remark').val();
                if(cityCode==null||cityCode==''||cityCode==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '请选择区域'
                    });
                    return;
                }
                if(name==null||name==''||name==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '姓名不能为空'
                    });
                    return;
                }
                if(phone==null||phone==''||phone==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '手机号码不能为空'
                    });
                    return;
                }
                var validPhone = /^(13[0-9]|14[57]|15[012356789]|16[6]|17[035678]|18[0-9]|19[9])[0-9]{8}$/.test(phone);
                if(!validPhone){
                    $.messager.show({
                        title : '提示',
                        msg : '手机号码格式不正确'
                    });
                    return;
                }
                if(plateNo==null||plateNo==''||plateNo==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '车牌号不能为空'
                    });
                    return;
                }
                var validPlateNo = /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4,5}[A-Z0-9挂学警港澳]{1}$/.test(plateNo);
                if(!validPlateNo){
                    $.messager.show({
                        title : '提示',
                        msg : '车牌号码格式不正确'
                    });
                    return;
                }
                if(plateColor==null||plateColor==''||plateColor==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '请选择车牌颜色'
                    });
                    return;
                }
                var validPrice = /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/.test(price);
                if(!validPrice){
                    $.messager.show({
                        title : '提示',
                        msg : '请输入正确的金额'
                    });
                    return;
                }
                if(isAutoPay==null||isAutoPay==''||isAutoPay==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '请选择是否开通代扣'
                    });
                    return;
                }
                if(remark==null||remark==''||remark==undefined){
                    $.messager.show({
                        title : '提示',
                        msg : '原泊车卡号不能为空'
                    });
                    return;
                }
                var bgcolor = 'white';
                var color = 'black';
                if(plateColor==0){
                    bgcolor ='blue';
                    color = 'white'
                }else if(plateColor==1){
                    bgcolor ='yellow';
                }else if(plateColor==2){
                    bgcolor = 'white';
                }else if(plateColor==3){
                    bgcolor = 'black';
                    color = 'white'
                }
                var mes = '请确认信息，手机号：<span style="color: #00B83F">'+phone+'</span>，车牌号：<span style="background-color:'+bgcolor+';color:'+color+';border:1px solid '+color+';font-weight: bold;">'+plateNo+'</span>，金额：<span style="color: #CC2222;font-weight: bold;">'+price+'元</span>，确认开通吗？';
                $.messager.confirm('确认',mes , function(r) {
                    if (r) {
                        $('#processMemberCardDiv').dialog('close');
                        $.ajax({
                            url: 'processMemberCard.do',
                            type: 'post',
                            data : {
                            	name : name,
                                cityCode : cityCode,
                                phone : phone,
                                plateNo : plateNo,
                                price : price,
                                plateColor : plateColor,
                                isAutoPay : isAutoPay,
								remark : remark
                            },
                            success: function (result) {
                                if (result.success) {
                                    var resp = result.data;
                                    if (resp=="SUCCESS"){
                                        $.messager.alert('提示',result.msg,'info');
                                        $('#data-list').datagrid('reload');
                                    }
                                } else {
                                    $.messager.alert('提示',result.msg,'error');
                                }
                            },
                            error : function(e) {
                                $.messager.confirm('提示', '登录超时,点击确定重新登录.', function(r) {
                                    if(r){
                                        window.top.location = urls['msUrl'] + "/login.action";
                                    }
                                });
                            }
                        });
                    }
                });
            }
        },{
            text:'重置表单',
            iconCls:'ext-icon-arrow_undo',
            handler:function(){
                //清空表单
                $('#name').val('');
                $('#cityCode').combotree('clear');
                $('#phone').val('');
                $('#plateNo').val('');
                $('#price').val('');
                $('#isAutoPay').combobox('setValue','');
                $('#plateColor').combobox('setValue','');
                $('#remark').val('');
            }
        }
    ]
});
