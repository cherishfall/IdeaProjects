$package('app.order');
app.order = function(){
	var _box = null;
	var _this = {
		detail : function(rows) {
			$('#detail').dialog({    
				maximizable:true,
				href: '../view/fragrans/appsystem/parkrecordDetail.jsp?parkrecordId='+rows[0].parkrecordId+'&cityCode='+rows[0].areaCode,    
			});
			$('#detail').dialog("open");
		},
		notify : function(rows) {
			// if(rows[0].notifyStatus==0&&rows[0].orderStatus==200){
            if(rows[0].notifyStatus==0){
				$.messager.confirm('确认', '确定要执行此操作吗？', function(r) {
					if(r){
						$.messager.progress({
					        title:'请稍后',
					        msg:'正在发送通知...'
						});
						$.ajax({
							url : 'sendNotify.do',
							type : 'post',
							data : {
								buyerAccount : rows[0].buyerAccount,
								orderNo : rows[0].orderNo,
								payMent : rows[0].payType,
								payTime : rows[0].payTime,
                                orderTime : rows[0].orderTime,
								billNo : rows[0].billNo,
								areaCode : rows[0].areaCode
							},
							success : function(result){
								$.messager.progress('close');
								console.log(result);
								$.messager.show({
									msg : result.msg,
									title : '提示'
								});
								$('#data-list').datagrid('reload');
							}
						});
					}
				});
			}else if(rows[0].notifyStatus==1){
				$.messager.show({
					msg : '已通知成功，无需再通知',
					title : '提示'
				});
			}
			// else if(rows[0].notifyStatus==0&&rows[0].notifyStatus!=200){
			// 	$.messager.show({
			// 		msg : '未支付成功，无需通知',
			// 		title : '提示'
			// 	});
			// }
		},
		config:{
			event : {
				search : function() { //条件查询验证
					var startEventTime = $('#startTime').datetimebox('getValue');
					var endEventTime = $('#endTime').datetimebox('getValue');
					if (startEventTime > endEventTime) {
						sys.alert('警告', '起始时间大于结束时间.', 'warning');
						return;
					}
					var start  = new Date(startEventTime.replace(/-/g,"/")).getTime();
					var end = new Date(endEventTime.replace(/-/g,"/")).getTime();
					var endDate = new Date(end);
					var startLon = endDate.setMonth(endDate.getMonth()-3);
					//alert(formatDateToStr(startLon));
					if(start < startLon){
						sys.alert('警告', '起始时间和结束时间之差大于3个月.', 'warning');
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
  				title:'列表(双击查看支付明细)',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			rownumbers:true,
	   			singleSelect:true,
	            height:'auto',
	            queryParams:{
	            	startTime :new Date().pattern("yyyy-MM-dd 00:00:00") ,
	            	endTime : new Date().pattern("yyyy-MM-dd HH:mm:ss"),
	   			},
	            onDblClickRow : function(index, data) {
	            	var orderNo = data.orderNo;
	            	$('#paylog').dialog({    
	    				maximizable:true,
	    				href: '../view/fragrans/appsystem/orderDetail.jsp?orderNo='+orderNo,    
	    			});
	    			$('#paylog').dialog("open");
				},
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'cityCode',hidden:true},
			 					{field:'areaCode',hidden:true},
                    			{field:'billNo',hidden:true},
			 					{field:'cityName',title:'城市名称',sortable:true},
			 					{field:'areaName',title:'区级名称',sortable:true},
			 					{field:'userAccount',title:'用户账号',sortable:true},
			 					{field:'orderNo',title:'交易订单编号',sortable:true},
			 					{field:'parkrecordId',title:'停车记录ID',sortable:true},
			 					{field:'payType',title:'支付方式',sortable:true,formatter:sys.dicts.text('PAY_METHOD')},
			 					{field:'price',title:'订单金额',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
			 						}
			 					},
			 					/*{field:'counterFee',title:'手续费',sortable:true,
			 						formatter:function(value,row,index){
			 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
			 						}
			 					},*/
			 					{field:'orderStatus',title:'订单状态',sortable:true,formatter:sys.dicts.text('ORDER_STATUS')},
			 					{field:'notifyStatus',title:'通知状态',sortable:true,
			 						formatter:function(value,row,index){
				 						if (row.orderStatus==200){
				 							return sys.dicts.text('NOTIFY_STATUS',value);
				 						} else {
				 							return "";
				 						}
			 						}
			 					},
			 					{field:'notifyCount',title:'通知次数',sortable:true},
			 					{field:'payTime',title:'支付时间',sortable:true},
			 					{field:'buyerAccount',title:'买家账号',sortable:true},
			 					{field:'orderTime',title:'订单生成时间',sortable:true}
			 	]],
			 	toolbar:[
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
							{id:'btnnotify',text:'手动通知',btnType:'notify',iconCls : 'ext-icon-phone_sound',
								handler : function() {
									var rows = $('#data-list').datagrid('getChecked');
									if (rows.length == 1) {
										_this.notify(rows);
									} else {
										$.messager.show({
											msg : '请选择一条记录',
											title : '提示'
										});
									}
							}},
							{id:'btnExport',text:'导出支付订单',btnType:'export',iconCls:"ext-icon-page_excel",
		                        handler : function() {
		                            $('#exportForm').form('reset');
		                            exportRecord();
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
	app.order.init();
	var date = new Date();
	$('#endTime').datetimebox('setValue',date.pattern("yyyy-MM-dd HH:mm:ss"));
	$('#startTime').datetimebox('setValue',date.pattern("yyyy-MM-dd 00:00:00"));
	
	// 导出
    $('#export-win').dialog({
        buttons : [ {
            text : '导出',
            handler : function() {
                var param = $('#exportForm').serializeObject();
                var startDate = param.startDate;
                var endDate = param.endDate;
                var cityId = param.cityId;
                //验证导出日报时间
                if(isEmpty(cityId) && isEmpty(startDate) && isEmpty(endDate)){
                    $.messager.show({
                        title : '提示',
                        msg : '请选择一个有效的查询条件'
                    });
                    return;
                }
                if(isEmpty(cityId) && !(!isEmpty(startDate) && !isEmpty(endDate))){
                    $.messager.show({
                        title : '提示',
                        msg : '请选择一个有效的查询时间段'
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
                $.messager.confirm('确认', '确认导出符合查询条件的数据？', function(r) {
                    if (r) {
                        window.open('export.do?startDate=' + startDate
                            + '&endDate=' + endDate + '&cityId=' + cityId);
                    }
                });
                $('#export-win').dialog('close');
            }
        }, {
            text : '关闭',
            handler : function() {
                $('#export-win').dialog('close');
            }
        } ]
    });
});	

function formatterDate(date){
	date.setTime(date.getTime());
	return date.pattern("yyyy-MM-dd HH:mm:ss");
}

function toDecimal(x) { 
    var f = parseFloat(x); 
    if (isNaN(f)) { 
      return 0; 
    } 
    f = Math.round(x*100)/100/100; 
    return f; 
}

function exportRecord(){
    $('#export-win').dialog('open');
}