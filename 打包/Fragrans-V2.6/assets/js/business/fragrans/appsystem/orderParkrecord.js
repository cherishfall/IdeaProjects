$package('app.orderParkrecord');
app.orderParkrecord = function(){
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
			event : {
				search : function() { //条件查询验证
					 var param = $("#searchForm").serializeObject();
					 if(param.cityId == '' && param.parkName == '' && param.plateNo == ''
						 && param.parkrecordId == ''){
						 $.messager.show({
								msg : '请至少选择一个查询条件',
								title : '提示'
							});
						 return;
					 }
					 var opts = $("#data-list").datagrid("options");
					 opts.url = "dataList.do";
					 $('#data-list').datagrid('reload',param);
				}
			},	
  			dataGrid:{
  				title:'列表',
	   			url:'',
	   			fitColumns:true,
	   			onLoadSuccess: function(data){
					if(data.rows.length==0){
						var body = $(this).data().datagrid.dc.body2;
						body.find('table tbody').append('<tr><td width="'+body.width()+'" style="height: 25px; padding:10px;text-align: left;"  colspan='+5+'>没有任何结果数据显示！（请确认查询条件是否正确；若正确可忽略该条提示）</td></tr>');
					}
				},
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						//{field:'id',checkbox:true},
	   			        {field:'id',title:'id',hidden:'true'},
	   			        {field:'cityCode',hidden:'true'},
	   			        {field:'parkName',title:'停车点名称',sortable:true,width:140},
	   			        {field:'parkrecordId',title:'停车记录id',sortable:true,width:140},
	 					{field:'areaName',title:'城市名称',sortable:true,width:70},
			 			{field:'plateNo',title:'车牌号',sortable:true,width:100},
			 			{field:'arrivalTime',title:'驶入时间',sortable:true,width:140},
                    	{field:'note',title:'备注',sortable:true,width:140}
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
				]
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
			$(".datagrid-toolbar").keydown(
					function(e) {
						if (e.keyCode == 13) {
							var param = $("#searchForm").serializeObject();
							 if(param.cityId == '' && param.parkName == '' && param.plateNo == ''
								 && param.parkrecordId == ''){
								 $.messager.show({
										msg : '请至少选择一个查询条件',
										title : '提示'
									});
								 return;
							 }
							 var opts = $("#data-list").datagrid("options");
							 opts.url = "dataList.do";
							 $('#data-list').datagrid('reload',param); 
						}
			});
			 //添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
			//var body = $("#data-list").data().datagrid.dc.body2;
			//body.find('table tbody').append('<tr><td width="'+body.width()+'" style="height: 25px; padding:10px;text-align: left;"  colspan='+5+'>没有任何结果数据显示！</td></tr>');
			$("#data-list").datagrid('appendRow', { parkName: '<div style="text-align:center;">请输入查询条件！</div>' }).datagrid('mergeCells', { index:0, field: 'parkName', colspan: 6 })
		}
	}
	return _this;
}();

$(function(){
	app.orderParkrecord.init();
	$('#data-list').datagrid({
	    view: detailview,
	    detailFormatter:function(index,row){
	        return '<div style="padding:2px"><table class="ddv"></table></div>';
	    }, 
	    onExpandRow: function(index,row){
	        var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
	        ddv.datagrid({
	            url:'../order/queryByParkrecordId.do',
	            queryParams: {  
	            	parkrecordId : row.parkrecordId,
	            	cityCode : row.cityCode
	            },
	            fitColumns:true,
	            rownumbers:true,
	            singleSelect:true,
	            height:'auto',
	            onDblClickRow : function(index, data) {
	            	var orderNo = data.orderNo;
	            	$('#paylog').dialog({    
	    				maximizable:true,
	    				href: '../view/fragrans/appsystem/orderDetail.jsp?orderNo='+orderNo,    
	    			});
	    			$('#paylog').dialog("open");
				},
	            columns:[[
	                {field:'id',title:'id',hidden:'true'},
	               	{field:'userAccount',title:'用户账号',width:90},
	                {field:'cityName',title:'城市名称',width:60},
	                {field:'areaName',title:'区域名称',width:60},
	                {field:'orderNo',title:'交易订单编号',width:150},
	                {field:'payType',title:'支付方式',width:70,formatter:sys.dicts.text('PAY_METHOD')},
	                {field:'price',title:'订单金额',width:70,
	                	formatter:function(value,row,index){
 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
 						}
	                },
                    {field:'memberCardFee',title:'使用赠送金额',width:70,
                        formatter:function(value,row,index){
                            return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
                        }
                    },
	                {field:'payTime',title:'支付时间',width:150},
	                {field:'orderStatus',title:'订单状态码',width:80,formatter:sys.dicts.text('ORDER_STATUS')},
	                {field:'notifyStatus',title:'通知状态',width:70,formatter:sys.dicts.text('NOTIFY_STATUS'),
	                	formatter:function(value,row,index){
	 						if (row.orderStatus==200){
	 							return sys.dicts.text('NOTIFY_STATUS',value);
	 						} else {
	 							return "";
	 						}
 						}
	                },
	                {field:'isComplate',hidden : true},
	                //{field:'isComplate',title:'退款状态',width:80,formatter:sys.dicts.text('IS_REFUND')},
//	                {field : 'refundFee',title:'退款金额',width:80,
//	                	formatter:function(value,row,index){
//	                		if(value>0){
//	                			return "<font style='color:blue;font-weight:bold;'>￥"+value/100+"</font>";
//	                		}else{
//	                			return "";
//	                		}
//						}},
	                {
						field : 'oper',
						title : '操作',
						width : 100,
						align : 'center',
						formatter : function(value, row, index) {
							var orderNo = row.orderNo;
							if(row.orderStatus==200){
								if(row.count>0&row.sucRefund>0){
									var s = '<a href="#" onclick="refund(\''+orderNo+'\')" style="color:#37d03f">已退款'+row.sucRefund/100+'元</a> ';
									return s;
								}else if(row.count==0){
									var s = '<a href="#" onclick="refund(\''+orderNo+'\')">退款</a> ';
									return s;
								}else{
									var s = '<a href="#" onclick="refund(\''+orderNo+'\')" style="color:red">退款失败</a> ';
									return s;
								}
							}
						}
					},
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

function refund(orderNo){
	$('#refundForm').form('clear');
	$('#refund').dialog({
		buttons : [ {
			text : '确认退款',
			handler : function() {
				if($.trim($('#refundFee').val())==0.00){
					$.messager.alert('提示','退款金额不能为0'); 
					return;
				}
				
				if($.trim($('#refundFee').val())==''){
					$.messager.alert('提示','退款金额为空！'); 
					return;
				}
				
				if($.trim($('#reason').val())==''){
					$.messager.alert('提示','退款原因不能为空！'); 
					return;
				}
				
				// 获取退款金额
				var refundFee = $('#refundFee').val();
				$.messager.confirm('确认', '是否确认退款  <span style="color:red;font-weight:bold;font-size:15px;">'+refundFee+'元</span>  (该操作不可逆)', function(r) {
				if (r) {
					$('#refund').dialog('close');
					$.messager.progress({
		                title:'请稍后',
		                msg:'正在为用户退款<span style="color:red;font-weight:bold;font-size:15px;">'+refundFee+'元</span>...'
					});
					$('#refundForm').form('submit', {
						url : '../orderRefund/createRefundRecord.do',
						type : "post",
						onSubmit : function() {
							return $(this).form('validate');
						},
						success : function(result) {
							$.messager.progress('close');
							var res = $.parseJSON(result);
							if(res!=null){
								if (res.success) {
									$('#data-list').datagrid('reload');
								}
								$.messager.show({
									title : '提示',
									msg : res.msg
								});
							}
						}
					});
				}
				})
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#refund').dialog('close');
			}

		} ]
	});
	$.ajax({
		url : '../orderRefund/queryAllRefundFeeByOrderNo.do',
		type : 'post',
		data : {
			orderNo : orderNo
		},
		success : function(result){
			$('#refund').dialog('open');
			$('#refundForm').form('clear');
			$('#refundFee').numberbox({    
			    min:0.00,
			    max:result.price/100-result.sucRefund/100,
			    precision:2    
			}); 
			$('#refundForm').form('load',{payTime:result.payTime,orderNo:result.orderNo,price:"￥"+result.price/100,payType:sys.dicts.text('PAY_METHOD',result.payType),
				sucRefund:result.sucRefund/100,failRefund:result.failRefund/100});
		}
	})
}

function toDecimal(x) { 
    var f = parseFloat(x); 
    if (isNaN(f)) { 
      return 0; 
    } 
    f = Math.round(x*100)/100/100; 
    return f; 
  }

