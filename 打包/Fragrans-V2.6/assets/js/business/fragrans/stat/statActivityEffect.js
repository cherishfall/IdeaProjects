function searchForm(){
	var startDate = $('#startDate').datebox('getValue');
	var endDate = $('#endDate').datebox('getValue');
	var areaCode = $('#areaCode').datebox('getValue');
	if(startDate!=""&&endDate!=""){
		if (startDate > endDate) {
			sys.alert('警告', '起始时间大于结束时间！.', 'warning');
			return;		
		}
	}
	$('#data-list').datagrid({
		url:'dataList.do?startDate='+startDate+
		"&endDate=" +endDate+"&areaCode="+areaCode
	});
}

$('#cityCode').combotree({
    onChange:function(newValue,oldValue){
    	$('#areaCode').combotree({    
    	    url: '../area/getArea.do?parentId='+newValue,
    	    fit : true,
    	    idField : 'id',
    	    treeField : 'areaName',
    	    parentField : 'parentId',
    	}); 
    }
});

$('#dayTime').datebox({
    onSelect: function(date){
    	var dateTime = getDayTime(date);
    	$('#activityTopicId').combotree({    
    	    url: 'getActivityTopic.do?dateTime='+dateTime,
    	    fit : true,
    	    idField : 'id',
    	    treeField : 'topicName',
    	}); 
    }
});

$('#exp_cityCode').combotree({
    onChange:function(newValue,oldValue){
    	console.log("new:"+newValue);
    	$('#exp_areaCode').combotree({    
    	    url: '../area/getArea.do?parentId='+newValue,
    	    fit : true,
    	    idField : 'id',
    	    treeField : 'areaName',
    	    parentField : 'parentId',
    	}); 
    }
});

$(function() {
	$('#data-list').datagrid({
		title:'列表',
		iconCls:"ext-icon-page_excel",
		fitColumns : true,
		fit : true,
		pagination:true,
		columns:[[ 
 			        {field:'id',checkbox:true},
 			        {field:'dayTime',title:'日期',sortable:true,
 			        	formatter:function(value,row,index){
							return value.split(" ")[0];
					}},
 			        {field:'cityName',title:'城市名称',sortable:true},
 			        {field:'areaName',title:'区域名称',sortable:true},
 			        {field:'activityName',title:'活动名称',sortable:true},
 			        {field:'activityId',title:'活动ID',sortable:true},
					{field:'putlogCount',title:'发券总数',sortable:true},
					{field:'usedCount',title:'使用总数',sortable:true},
					{field:'cumulativUnusedUserCount',title:'累计未使用用户数',sortable:true},
					{field:'cumulativeParticipateUserCount',title:'累计参与用户数',sortable:true},
					{field:'cumulativePayfeeOrderCount',title:'累计缴费订单数',sortable:true},
					{field:'payfeeUserCount',title:'缴费用户数',sortable:true},
					{field:'ticketpayUserCount',title:'券缴费用户数',sortable:true},
					{field:'ticketMoneyAmount',title:'券总面额',sortable:true,
						formatter:function(value,row,index){
							return "<font font-weight:bold;'>￥"+value/100+"</font>";
						}
					},
					{field:'actualDiscountAmount',title:'实际抵扣总面额',sortable:true,
						formatter:function(value,row,index){
							return "<font font-weight:bold;'>￥"+value/100+"</font>";
						}
					},
					{field:'ticketDiscountScale',title:'券抵扣金额占比',sortable:true,
						formatter:function(value,row,index){
							return value+"<font font-weight:bold;'>%</font>";
						}},
					{field:'revenueGrowthRate',title:'收入同步增长率',sortable:true,
							formatter:function(value,row,index){
								return value+"<font font-weight:bold;'>%</font>";
							}},
					{field:'createTime',title:'创建时间',sortable:true},
		 	]],
		 	toolbar:[
						{id:'btnGenerate',text:'生成报表',btnType:'add',iconCls:"icon-edit",
							handler : function() {
								$('#generateActivityEffectForm').form('reset');
								generateActivityEffect();
							}},
						{id:'btnExport',text:'导出报表',btnType:'edit',iconCls:"ext-icon-page_excel",
							handler : function() {
								$('#exportActivityEffectForm').form('reset');
								exportActivityEffect();
							}}
					]
	});
	$('#startDate').datebox('setValue', getBeforeSevenDays());
	$('#endDate').datebox('setValue', getYesterDay());
	searchForm();
	$('#generateActivityEffect').dialog({
		buttons : [ {
			text : '保存',
			handler : function() {
				var param = $('#generateActivityEffectForm').serializeObject();
				var dayTime = param.dayTime;
				//验证生成日报时间
				if(dayTime == null || dayTime == '' || dayTime == undefined){
					$.messager.show({
						title : '提示',
						msg : '请选择日期'
					});
					return;
				}
				//生成当前日期
				var nowDate = getNowDate();
				if(dayTime > nowDate){
					$.messager.show({
						title : '提示',
						msg : '请输入合理的日期'
					});
					return;
				}
				$.messager.confirm("提示", "确认生成日报表?", function(r) {
					if (r) {
						$.messager.progress({
				            title:'请稍后',
				            msg:'正在生成日报表...'
						});
						$('#generateActivityEffectForm').form('submit', {
							url : 'generateActivityEffect.do',
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
								if (res.success) {
									$('#generateActivityEffect').dialog('close');
									$('#data-list').datagrid('reload');
								}
							}
						});
					}
				});
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#generateActivityEffect').dialog('close');
			}
		} ]
	});
	$('#exportActivityEffect').dialog({
		buttons : [ {
			text : '保存',
			handler : function() {
				var param = $('#exportActivityEffectForm').serializeObject();
				var startDate = param.startDate;
				var endDate = param.endDate;
				var cityCode = param.cityCode;
				var areaCode = param.areaCode;
				//验证导出日报时间
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
				$.messager.confirm('确认', '确认导出符合查询条件的数据？', function(r) {
					if (r) {
						window.open('exportActivityEffect.do?startDate=' + startDate
								+ '&endDate=' + endDate + '&cityCode=' + cityCode
								+ '&areaCode=' + areaCode );
					}
				});
				$('#exportActivityEffect').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#exportActivityEffect').dialog('close');
			}
		} ]
	});
});

function generateActivityEffect() {
	$('#generateActivityEffect').dialog('open');
}

function getDayTime(date){
	if (!date) return;
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate();
	if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (day >= 0 && day <= 9) {
    	day = "0" + day;
    }
	return year+"-"+month+"-"+day;
}

function exportActivityEffect() {
	$('#exportActivityEffect').dialog('open');
}

function getYesterDay() {
	var date = new Date();
	date.setTime(date.getTime() - 1 * 24 * 60 * 60 * 1000);
	return date.pattern("yyyy-MM-dd");
}

function getBeforeSevenDays() {
	var date = new Date();
	date.setTime(date.getTime() - 7 * 24 * 60 * 60 * 1000);
	return date.pattern("yyyy-MM-dd");
}

function getNowDate(){
	var date = new Date();
	date.setTime(date.getTime());
	return date.pattern("yyyy-MM-dd");
}

