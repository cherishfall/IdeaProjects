$package('app.parkMonthlyRecord');
app.parkMonthlyRecord = function(){
	var _box = null;
	var _this = {
		config:{
			event : {
				search : function() { //条件查询验证
					var startEventTime = $('#searchStartTime').datebox('getValue');
					var endEventTime = $('#searchEndTime').datebox('getValue');
					if (startEventTime > endEventTime) {
						sys.alert('警告', '起始时间大于结束时间.', 'warning');
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
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
						{field:'areaCode',title:'区域编码',sortable:true,hidden:true},
	 					{field:'areaName',title:'区域名称',sortable:true,width:80},
	 					{field:'monthlyCarId',title:'包月车辆ID',sortable:true,width:100},
//	 					{field:'monthlyId',title:'包月记录ID',sortable:true,width:100},
	 					{field:'plateNo',title:'车牌号',sortable:true,width:100},
	 					{field:'plateColor',title:'车牌颜色',sortable:true,width:100,formatter:sys.dicts.text('PLATE_COLOR')},
	 					{field:'phone',title:'包月手机号',sortable:true,width:100},
//	 					{field:'parkName',title:'包月停车点集合',sortable:true,width:200,
//	 						formatter: function(value,row,index){
//			     				if (value!=null&&value.length > 15){
//			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
//			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'...</span>';
//			     				}else{
//			     					return value;
//			     				}
//			     		    } },
//	 					{field:'monthlyFee',title:'包月费用',sortable:true,
//	 						formatter:function(value,row,index){
//	 							return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
//	 						}},
//	 					{field:'startTime',title:'包月开始时间',sortable:true},
//	 					{field:'endTime',title:'包月结束时间',sortable:true},
//	 					{field:'status',title:'包月状态',sortable:true,formatter:sys.dicts.text('MONTHLY_RECORD_STATUS')},
//	 					{field:'isPush',title:'推送提醒状态',sortable:true,formatter:sys.dicts.text('IS_PUSH')},
//	 					{field:'note',title:'包月描述',sortable:true},
//	 					{field:'createdBy',title:'创建人',sortable:true},
//	 					{field:'updatedBy',title:'修改人',sortable:true},
	 					{field:'createTime',title:'创建时间',sortable:true,width:100}
//	 					{field:'updateTime',title:'更新时间',sortable:true}
			 	]]
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
	app.parkMonthlyRecord.init();
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
	            url:'getMonthlyRecordDetail.do',
	            queryParams: {  
	            	monthlyCarId : row.monthlyCarId,
	            	areaCode : row.areaCode
	            },
	            columns:[[
//	                        {field:'id',checkbox:true},
							{field:'areaName',title:'区域名称',sortable:true},
							{field:'monthlyId',title:'包月记录ID',sortable:true},
							{field:'plateNo',title:'车牌号',sortable:true},
							{field:'plateColor',title:'车牌颜色',sortable:true,formatter:sys.dicts.text('PLATE_COLOR')},
							{field:'phone',title:'包月手机号',sortable:true},
							{field:'parkName',title:'包月停车点集合',sortable:true,
								formatter: function(value,row,index){
									if (value!=null&&value.length > 10){
										var aa = value.replace(/(\n)+|(\r\n)+/g, "");
										return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,10)+'...</span>';
									}else{
										return value;
									}
							    } },
							{field:'monthlyFee',title:'包月费用',sortable:true,
								formatter:function(value,row,index){
									return "<font style='color:red;font-weight:bold;'>￥"+value/100+"</font>";
								}},
							{field:'startTime',title:'包月开始时间',sortable:true},
							{field:'endTime',title:'包月结束时间',sortable:true},
							{field:'status',title:'包月状态',sortable:true,formatter:sys.dicts.text('MONTHLY_RECORD_STATUS')},
							{field:'isPush',title:'推送提醒状态',sortable:true,formatter:sys.dicts.text('IS_PUSH')},
							{field:'createTime',title:'创建时间',sortable:true}
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

