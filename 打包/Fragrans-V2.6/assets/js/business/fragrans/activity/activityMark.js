$package('app.activityMark');
app.activityMark = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
			 					{field:'activityName',title:'活动id',sortable:true},
			 					{field:'mark',title:'活动标识',sortable:true},
			 					{field:'activityType',title:'活动类型',sortable:true,formatter:sys.dicts.text('activityType')},
			 					{field:'dayGetcount',title:'每日可领张数',sortable:true},
			 					{field:'allGetcount',title:'总共可领张数',sortable:true},
			 					{field:'createTime',title:'创建时间',sortable:true},
			 					{field:'updateTime',title:'更新时间',sortable:true}
			 	]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add',
						handler:function(){
							$.ajax({
								url : 'getActivityBySpecific.do',
								type : 'post',
								success : function(result) {
									if(result==0){
										sys.alert('提示','每个活动都已配置活动标识','info');
									}else{
										$('#editMarkForm').form('reset');
										$('#edit-mark').dialog('open');
									}
								}
							});
						}},
					{id:'btnedit',text:'修改',btnType:'edit',
							handler:function(){
								var rows = $('#data-list').datagrid('getChecked');
								if (rows.length == 0) {
									$.messager.show({
										title : '提示',
										msg : '请选择一条记录~'
									});
								}else if (rows.length > 1) {
									$.messager.show({
										title : '提示',
										msg : '只能选择一条记录~'
									});
								}else {
									$('#activityIdEdit').html(rows[0].activityName);
									_box.handler.edit();
								}
							}},
					{id:'btndelete',text:'删除',btnType:'remove'}
				]
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
			$('#edit-mark').dialog({
				buttons:[
				         {
				        	 text:'保存',
				        	 handler:function(){
				        		 $('#editMarkForm').form('submit',{
				        			 url:'save.do',
				        			 type : 'post',
				        			 success:function(result){
				        				 var mes = eval('('+result+')');
				        				 $.messager.show({
				        					 title : '提示',
				        					 msg : mes.msg
				        				 });
				        				 $('#edit-mark').dialog('close');
				        				 $('#data-list').datagrid('reload');
				        			 }
				        		 });
				        	 }
				         },{
				        	 text:'关闭',
				        	 handler:function(){
				        		 $('#edit-mark').dialog('close');
				        	 }
				         }
				      ]
			});
		}
	}
	return _this;
}();

//属于指定用户送券活动代码的活动
$('#activityIdAdd').combobox({
	title:'列表',
	url:'getActivityBySpecific.do',
	fit : true,
	editable:false,
	valueField : 'id',
	textField : 'text',
});

$(function(){
	app.activityMark.init();
});		