$package('base.quartz');
base.quartz = function(){
	var _box = null;
	var _this = {
		config:{
			event : {
				save : function(){
					var et = $('#excuteTime').val();
					var rt = $('#repeatTime').val();
					if(et == '' && rt == ''){
						$.messager.show({
							titlr : '提示',
							msg : '执行时间和重复执行时间不能都为空'
						})
						return;
					}
					_box.handler.save();
				}
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
						{field:'id',checkbox:true},
	 					{field:'name',title:'任务名称（类名）',sortable:true},
	 					{field:'note',title:'任务描述',sortable:true},
	 					{field:'excuteTime',title:'最近执行时间',sortable:true},
	 					{field:'repeatTime',title:'重复执行时间（定时扫描）',sortable:true},
	 					{field:'isRunning',title:'是否正在运行',sortable:true,formatter:sys.dicts.text('JOB_STATUS'),styler:function(value,row,index){
							if(value == 1){
								  return 'color:red;';  
								}
							}
	 					},
                    	{field:'ipLimited',title:'运行ip',sortable:true},
	 					{field:'creator',title:'创建人',sortable:true},
	 					{field:'createTime',title:'创建时间',sortable:true},
			 	]],
				toolbar:[
					{id:'pause',iconCls:'icon-cancel',text:'暂停/作废',btnType:'pause',handler:function(){
						var rows = $('#data-list').datagrid('getChecked');
						if(rows.length != 0){
							var ids = "";
							for(var i = 0;i < rows.length ; i ++){
								var row = rows[i];
								if(row.isRunning == 2 || row.isRunning == 0){
									$.messager.show({
										titlr : '提示',
										msg : '存在选中任务已停止'
									})
									return;
								}
							}
							for(var i = 0;i < rows.length ; i ++){
								var row = rows[i];
								pause(row);
							}
						}else{
							$.messager.show({
								titlr : '提示',
								msg : '请选择一个任务操作'
							})
						}
					}},
					{id:'recover',iconCls:'icon-ok',text:'恢复',btnType:'recover',handler:function(){
						var rows = $('#data-list').datagrid('getChecked');
						if(rows.length != 0){
							for(var i = 0;i < rows.length ; i ++){
								var row = rows[i];
								if(row.isRunning == 1){
									$.messager.show({
										titlr : '提示',
										msg : '该任务正在运行'
									})
									return;
								}
							}
							for(var i = 0;i < rows.length ; i ++){
								var row = rows[i];
								recover(row);
							}
						}else{
							$.messager.show({
								titlr : '提示',
								msg : '请选择一个任务操作'
							})
						}
					}},
					{id:'btnadd',text:'添加',btnType:'add'},
					{id:'btnedit',text:'修改',btnType:'edit'},
					{id:'btnremove',text:'删除',btnType:'remove'},
				],
				onDblClickRow : function(index,row){
							$('#excuteRecord').datagrid({
								url : basePath + '/quartzDetail/dataList.do?quartzId=' + row.id,
							});
							$('#excuteRecordDialog').dialog('open');
				}
			}
		},
		datagrid_record : function(){
			$('#excuteRecord').datagrid({
				title:'列表',
	   			fitColumns:true,
	   			pagination :true,
	   			height : 360,
	   			columns:[[
						{field:'id',hidden:true},
	 					{field:'name',title:'任务名称（类名）',sortable:true},
	 					{field:'excuteTime',title:'定时执行时间'},
	 					{field:'result',title:'执行结果',sortable:true,styler:function(value,row,index){
	 						if(value == 1){
	 							return 'color:red;';  
	 						}
	 					},formatter:sys.dicts.text('JOB_RESULT')},
	 					{field:'mission',title:'执行内容',sortable:true},
	 					{field:'note',title:'备注',sortable:true},
			 	]],
			})
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
		}
	}
	return _this;
}();

$(function(){
	base.quartz.init();
	base.quartz.datagrid_record();
});		

function pause(row){
	$.ajax({
		url : 'pause.do',
		type : 'post',
		data : {
			id : row.id,
			name : row.name,
		},
		success : function(result){
			$.messager.show({
				title : '提示',
				msg : result.msg
			})
			if(result.success){
				$('#data-list').datagrid('reload');
			}
		}
	})
}

function recover(row){
	$.ajax({
		url : 'recover.do',
		type : 'post',
		data : {
			id : row.id,
			name : row.name,
			repeatTime : row.repeatTime,
			excuteTime : row.excuteTime
		},
		success : function(result){
			$.messager.show({
				titlr : '提示',
				msg : result.msg
			})
			if(result.success){
				$('#data-list').datagrid('reload');
			}
		}
	})
}