$package('app.userDaily');
app.userDaily = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'dayTime',title:'日期',sortable:true,formatter:function(value,row,index){
							return value.split(" ")[0];
						}},
	 					{field:'cityName',title:'城市名称'},
	 					{field:'areaCode',title:'区域编码',hidden:true},
	 					{field:'regUserCount',title:'注册用户数',sortable:true},
	 					{field:'regUserPayCount',title:'注册有缴费用户数',sortable:true},
	 					{field:'activeUserCount',title:'活跃用户数',sortable:true},
	 					{field:'activeDeviceCount',title:'活跃设备数',sortable:true},
	 					{field:'newDeviceCount',title:'新增设备数',sortable:true},
	 					{field:'userPayCount',title:'缴费用户数',sortable:true},
	 					{field:'activityUserCount',title:'参与活动用户数',sortable:true},
	 					{field:'regUserMonthCount',title:'本月累计注册用户数',sortable:true,hidden:true},
	 					{field:'growth',title:'同比增长',sortable:true,formatter:function(value,row,index){
	 						var growth = (value*100);
	 						// 小数点后的位数
	 						var growthstr = "" + growth;
	 						var str = growthstr.substring(growthstr.indexOf(".") + 1,growthstr.length);
	 						if(str.length >=2 && growthstr.indexOf(".") > 0){
	 							growth = growth.toFixed(2);
	 						} else if(str.length <2 && growthstr.indexOf(".") > 0){
	 							growth = growth.toFixed(1);
	 						}
	 						var color = 'red';
	 						if(growth < 0) {
	 							color = 'green';
	 							growth = '↓' + (-growth);
	 						} else {
	 							growth = '↑' + growth;
	 						}
							return row.regUserMonthCount + ",  <font style='color:" + color + ";font-weight:bold;'>"+growth+"%</font>";
						}},
	 					{field:'createTime',title:'创建时间',sortable:true,hidden:true}
			 	]],
				toolbar:[
//					{id:'btnadd',text:'添加',btnType:'add'},
//					{id:'btnedit',text:'修改',btnType:'edit'},
//					{id:'btndelete',text:'删除',btnType:'remove'}
					{id:'btnExport',text:'汇总导出',btnType:'export',iconCls:"ext-icon-page_excel",
						handler : function() {
							$('#exportStatUserDailyListForm').form('reset');
							exportStatUserDailyList();
						}},
					{id:'btnOrder',text:'汇总生成',btnType:'order',iconCls:"ext-icon-table_save",
						handler : function() {
							$('#statUserDailyListForm').form('reset');
							statUserDailyList();
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
	app.userDaily.init();
	
	// 导出
	$('#exportStatUserDailyList').dialog({
		buttons : [ {
			text : '导出',
			handler : function() {
				var param = $('#exportStatUserDailyListForm').serializeObject();
				var dayTimeStart = param.dayTimeStart;
				var dayTimeEnd = param.dayTimeEnd;
				var cityId = param.cityId;
				//验证导出日报时间
				if(dayTimeStart == null || dayTimeStart == '' || dayTimeStart == undefined
						|| dayTimeEnd == null || dayTimeEnd == '' || dayTimeEnd == undefined){
					$.messager.show({
						title : '提示',
						msg : '请选择日期'
					});
					return;
				}
				if (dayTimeEnd < dayTimeStart) {
					$.messager.show({
						title : '提示',
						msg : "开始时间必须小于结束时间"
					});
					return;
				}
				window.open('exportStatUserDailyList.do?dayTimeStart=' + dayTimeStart
					+ '&dayTimeEnd=' + dayTimeEnd + '&cityId=' + cityId);
				$('#exportStatUserDailyList').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#exportStatUserDailyList').dialog('close');
			}
		} ]
	});
	
	// 账单比对
	$('#statUserDailyList').dialog({
		buttons : [ {
			text : '汇总',
			handler : function() {
				var param = $('#statUserDailyListForm').serializeObject();
				var dayTime = param.dayTime;
				//验证导出日报时间
				if(dayTime == null || dayTime == '' || dayTime == undefined){
					$.messager.show({
						title : '提示',
						msg : '请选择汇总日期'
					});
					return;
				}
				$.messager.confirm('确认', '确认重新汇总'+dayTime+'用户汇总信息？', function(r) {
					if (r) {
						$.messager.progress({
				            title:'请稍后',
				            msg:'正在汇总用户信息...'
						});
						$.ajax({
							url : 'getStatUserDaily.do',
							type : 'post',
							data : {"dayTime":dayTime},
							success : function(result) {
								$.messager.progress('close');
								$.messager.show({
									title : '提示',
									msg : result.msg
								});
								$('#data-list').datagrid('reload');
							}
						});
					}
				});
				$('#statUserDailyList').dialog('close');
			}
		}, {
			text : '关闭',
			handler : function() {
				$('#statUserDailyList').dialog('close');
			}
		} ]
	});
});		

function exportStatUserDailyList() {
	$('#exportStatUserDailyList').dialog('open');
}

function statUserDailyList() {
	$('#statUserDailyList').dialog('open');
}