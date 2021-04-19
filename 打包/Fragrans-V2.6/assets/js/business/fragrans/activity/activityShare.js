$package('app.activityShare');
app.activityShare = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'activityName',title:'分享主题名称',sortable:true},
			 					{field:'activityType',title:'分享类型',sortable:true,
			 						formatter:sys.dicts.text('SHARE_TYPE')},
			 					{field:'activityDesc',title:'分享描述',sortable:true},
			 					{field:'shareUrl',title:'分享地址',sortable:true},
			 					{field:'shareImage',title:'分享配图',sortable:true},
			 					{field:'isTiger',title:'是否分享即刻触发',sortable:true,
			 						formatter:sys.dicts.text('YESORNO')},
			 					{field:'isFromuserTiger',title:'是否允许来源用户触发',sortable:true,
			 						formatter:sys.dicts.text('YESORNO')},
			 					{field:'getCount',title:'可领取次数',sortable:true},
			 					{field:'validity',title:'有效期 ',sortable:true},
			 					{field:'status',title:'状态',sortable:true,
			 						formatter:sys.dicts.text('SHARE_STATUS')},
			 					{field:'displayConf',title:'显示类型 ',sortable:true,
			 							formatter:sys.dicts.text('DISPLAYCONF')},
			 	]],
			 	toolbar:[
			 	         {id:'btnadd',text:'添加',btnType:'add'},
						 {id:'btnedit',text:'修改',btnType:'edit',
							 handler : function() {
									edit();
								}},
						 {id:'btndelete',text:'删除',btnType:'remove',iconCls : 'icon-remove',
								handler : function() {
									var rows = $('#data-list').datagrid('getChecked');
									$.messager.confirm('确认', '确认删除？', function(r) {
										if(r){
											var ids = '';
									    	$.each(rows,function(i,row){
									    		ids+=row.id+','
									    	});
										$.ajax({
											url:'delete.do',
											type:'post',
											dataType:'json',
											data:{
												ids : ids
											},
											success:function(result){
												$('#data-list').datagrid('reload');
												$.messager.show({
													msg : result.msg,
													title : '提示'
												});
											}
										});
									}
								});
							}},
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
	app.activityShare.init();
});	

function edit(){
	var rows = $('#data-list').datagrid('getChecked');
	if(rows.length != 1){
		$.messager.show({
			title : '提示',
			msg : '请选择一行数据'
		});
		return;
	}
	var row = rows[0];
	var id = row.id;
	$.ajax({
		url : 'getId.do',
		type : 'post',
		dataType : 'json',
		data : {
			id : id
		},
		success : function(result) {
			if (result.success) {
				$('#edit-win').dialog('open');
				var data = result.data;
				$('#editForm').form('load',data);
			} else {
				$.messager.show({
					msg : result.msg,
					title : '提示'
				});
			}
		}
	});
}

