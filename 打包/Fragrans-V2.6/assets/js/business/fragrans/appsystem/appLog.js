$package('app.log');
app.log = function(){
	var _box = null;
	var _this = {
		detail : function(rows) {
			$.ajax({
				url : 'getDetail.do',
				type : 'post',
				data : {
					id : rows[0].id,
				},
				success : function(result){
					$('#detail').dialog('open');
					$('#detailForm').form('clear');
					$('#serviceName').html(result.serviceName);
					$('#detailForm').form('load',{requestMsg:result.requestMsg,repsonseMsg:result.repsonseMsg,note:result.note});
				}
			})
		},
		decodeBase64:function(){
			$('#decodeBase64Div').dialog("open");
		},
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			queryParams:{
	   				startDate : getStartDate(),
	   				endDate : getEndDate(getStartDate()),
	   			},
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'userAccount',title:'用户账号',sortable:true,width:100,
							formatter:function(value,row,index){
								if(value=="(null)"){
									return "";
								}else{
									return value;
								}
							}},
	 					{field:'appId',title:'应用ID',sortable:true,width:100},
			 					{field:'deviceNo',title:'设备号',sortable:true,width:100},
			 					{field:'requestTime',title:'请求时间',sortable:true,width:100},
			 					{field:'responseTime',title:'响应时间',sortable:true,width:100}
			 	]],
				toolbar:[
				    {id:'btndetail',text:'日志详情',btnType:'detail',iconCls : 'ext-icon-report_add',
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
					{id:'btnDecode',text:'BASE64解码',btnType:'decode',iconCls : 'ext-icon-accept',
						handler:function(){
							_this.decodeBase64();
						}
					}
//					{id:'btndelete',text:'删除',btnType:'remove'}
				]
			}
		},
		init:function(){
			$('#startDate').datebox({
				onChange : function(nDate, oDate) {
					$('#endDate').datetimebox('setValue', getEndDate(nDate));
				}
			});
			$('#startDate').datetimebox('setValue', getStartDate());
			_box = new YDataGrid(_this.config); 
			_box.init();
		}
	}
	return _this;
}();

$(function(){
	app.log.init();
});	

//$('#btn-search').bind('click',function(){
//	var param = $('#searchForm').serializeObject();
//	var startDate = param.startDate;
//	var endDate = param.endDate;
//	if (endDate < startDate) {
//		$.messager.show({
//			title : '提示',
//			msg : "请输入合理的时间"
//		});
//	}
//	$('#searchForm').form('submit', {
//		url : 'dataList.do',
//		type : "post",
//		success : function(result) {
//			if(result != null){
//				var res = $.parseJSON(result);
//				var data = new Object();
//				data.total = res.total;
//				data.rows = res.rows;
//				$("#data-list").datagrid("loadData",data);
//			}
//		}
//	});
//});

$('#close').bind('click',function(){
	$('#decodeBase64Form').form('clear');
	$('#decodeBase64Div').dialog('close');
});

$('#confirm').bind('click',function(){
	var param = $('#decodeBase64Form').serializeObject();
	var codeMsg = param.codeMsg;
	if(codeMsg == null || codeMsg == ''){
		$.messager.show({
			title : '提示',
			msg : "请输入加密报文"
		});
	}
	$.ajax({
		url : 'decodeBase64.do',
		type : 'post',
		data : {
			codeMsg : codeMsg,
		},
		success : function(result){
			$('#decodeMsg').val(result.repsonseMsg);
		}
	})
});
