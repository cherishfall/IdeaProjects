$package('app.orderBatchpayRel');
app.orderBatchpayRel = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
                queryParams:{
                    startTime :new Date().pattern("yyyy-MM-dd 00:00:00") ,
                    endTime : new Date().pattern("yyyy-MM-dd HH:mm:ss"),
                },
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
//	 					{field:'userId',title:'用户ID',sortable:true},
	 					{field:'userAccount',title:'用户账号',sortable:true,width:100},
//	 					{field:'cityCode',title:'区域编码',sortable:true},
	 					{field:'areaName',title:'区域名称',sortable:true,width:100},
	 					{field:'batchpayNo',title:'批量缴费订单编号',sortable:true,width:200},
	 					{field:'batchpayCount',title:'缴费记录数',sortable:true,width:100},
//	 					{field:'orderNo',title:'订单编号',sortable:true},
//	 					{field:'parkrecordId',title:'停车记录ID',sortable:true},
//	 					{field:'parkName',title:'停车场（点）',sortable:true},
	 					{field:'isPaid',title:'是否支付成功',sortable:true,width:100,
	 						formatter:sys.dicts.text('BATCHPAY_ORDER_STATUS')},
	 					{field:'createTime',title:'创建时间',sortable:true,width:100}
			 	]]
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
            var date = new Date();
            $('#endTime').datetimebox('setValue',date.pattern("yyyy-MM-dd HH:mm:ss"));
            $('#startTime').datetimebox('setValue',date.pattern("yyyy-MM-dd 00:00:00"));
		}
	}
	return _this;
}();

$(function(){
	app.orderBatchpayRel.init();
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
	            url:'getBatchpayOrderDetail.do',
	            queryParams: {  
	            	batchpayNo : row.batchpayNo
	            },
	            columns:[[
	                      {field : 'orderNo',title : '订单编号'},
	                      {field : 'parkrecordId',title : '停车记录ID',width:60},
	                      {field : 'payment',title : '支付方式',width:60,
	                    	  formatter:sys.dicts.text('PAY_METHOD') 
	                       },
	                      {field:'parkFee',title:'应付金额',sortable:true,width:60,
	 						  formatter:function(value,row,index){
	 							  return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
		 				  }
		 				  },
		 				  {field:'discountFee',title:'折扣金额',sortable:true,width:60,
		 					  formatter:function(value,row,index){
		 						  return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
		 					  }
		 				  },
		 				  {field:'ticketFee',title:'停车券抵扣金额',sortable:true,width:60,
		 					  formatter:function(value,row,index){
		 						  return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
		 					  }
		 				  },
		 				  {field:'payFee',title:'第三方实付金额',sortable:true,width:60,
		 					  formatter:function(value,row,index){
		 						  return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
		 					  }
		 				  },
		 				  {field:'counterFee',title:'手续费',sortable:true,width:60,
		 						formatter:function(value,row,index){
		 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
		 						}
		 				  },
		 				 {field:'isPaid',title:'支付状态',sortable:true,width:60,formatter:sys.dicts.text('ORDER_STATUS')},
	 					 {field:'createTime',title:'订单生成时间',sortable:true,width:80}
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

$(".datagrid-toolbar").keydown(
		function(e) {
			if (e.keyCode == 13) {
				var param = $("#searchForm").serializeObject();
				 if(param.userAccount == '' && param.batchpayNo == '' && param.isPaid == '' && param.areaId == '' ){
					 $.messager.show({
							msg : '请至少选择一个查询条件',
							title : '提示'
						});
					 return;
				 }
				 var opts = $("#data-list").datagrid("options");
				 opts.url = "dataList.do";
				 $('#data-list').datagrid('reload',param); 
				 return false;
			}
});

