$(function(){
	//定义按钮
	var toolbar = [
		   			{id:'btnadd',text:'添加',btnType:'add',
						iconCls : 'icon-add',
						handler : function() {
							add();
						}},
					{id:'btnedit',text:'修改',btnType:'edit',iconCls : 'icon-edit',
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
										id : ids
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
				];
	//构建grid
	$('#data-list').datagrid({
  				title:'列表',
	   			url:'dataList.do',
	   			fit:true,
				border:false,
				nowrap: true,
				autoRowHeight: false,
				striped: false,
				collapsible:false,
				remoteSort: false,
				pagination:true,
				rownumbers:true,
				singleSelect:false,
				checkOnSelect:false,
				selectOnCheck:false,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'topicName',title:'活动主题名称',sortable:true},
	 					{field:'areaCodes',title:'活动城市',sortable:true,
	 						formatter: function(value,row,index){
			     				if (value!=null&&value.length > 15){
			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'....</span>';
			     				}else{
			     					return value;
			     				}
			     		    }},
			 					{field:'topicAbstract',title:'活动主题摘要',sortable:true},
			 					{field:'startTime',title:'开始时间',sortable:true,
			 						formatter:function(value,row,index){
									return value.split(" ")[0];
								}},
			 					{field:'endTime',title:'结束时间',sortable:true,
									formatter:function(value,row,index){
										return value.split(" ")[0];
									}},
			 					{field:'status',title:'主题状态',sortable:true,formatter:sys.dicts.text('ACTIVITY_STATUS')},
			 					{field:'displayconf',title:'显示策略',sortable:true,formatter:sys.dicts.text('DISPLAYCONF')},
			 					{field:'topicImageurl',title:'宣传图片',sortable:true,
			 						formatter: function(value,row,index){
					     				if (value!=null&&value.length > 20){
					     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
					     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,20)+'...</span>';
					     				}else{
					     					return value;
					     				}
					     		    }},
			 					{field:'topicUrl',title:'活动URL外连接',sortable:true,
					     		    	formatter: function(value,row,index){
						     				if (value!=null&&value.length > 20){
						     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
						     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,20)+'...</span>';
						     				}else{
						     					return value;
						     				}
						     		    }},
			 					{field:'orderNum',title:'排序号',sortable:true},
			 	]],
			 	toolbar:toolbar
			});
		},
		$('#edit-win').dialog({
			buttons:[
				{
					text:'保存',
					handler:function(){
						var param = $('#editForm').serializeObject();
						var startTimeEdit = param.startTime;
						var endTimeEdit = param.endTime;
						if (endTimeEdit < startTimeEdit) {
							$.messager.show({
								title : '提示',
								msg : "开始时间不能大于结束时间"
							});
							return;
						}
						$('#editForm').form('submit',{
							url:'save.do',
							type:'post',
							success:function(result){
								var mes = eval('('+result+')');
								if (mes.success==false) {
									$.messager.alert('提示',mes.msg,'info');
								}else{
									$.messager.show({
										title : '提示',
										msg : mes.msg
									});
									$('#edit-win').dialog('close');
									$('#data-list').datagrid('reload');
								}
							}
						});
					}
				},{
					text:'关闭',
					handler:function(){
						$('#edit-win').dialog('close');
					}
				}
			]
		}),
		$('#ztree').dialog({
			buttons : [{
				text : '确定',
				handler : function() {
					$('#ztree').dialog('close');
				}
			}]
		}),
		$('#ztree').dialog({    
			maximizable:true,
		    href: '../view/fragrans/appsystem/excheck.jsp?param=""'+'&objId=""',    
		}),
		$('#topicUrl').tooltip({    
			position: 'right',    
			content: '<span style="color:black">若为空则该主题不可点击</span>',    
			onShow: function(){       
				$(this).tooltip('tip').css({            
					backgroundColor: '#ffc',           
					borderColor: '#c93'       
						});    
				}
		}),
		$('#msgButton').on('click', function() {
			   $('#msgImage').trigger('click');
			}),
		$('#msgImage').live('change', function() {
			   $('#topicImageurl').val($('#msgImage').val());
			})
);

function add(){
	//重新加载城市下拉框
	$('#ztree').dialog({    
		maximizable:true,
	    href: '../view/fragrans/appsystem/excheck.jsp?param=""'+'&objId=""',    
	});
	$('#editForm').form('clear');
	$('#edit-win').dialog('open');
}

function edit(){
		var rows = $('#data-list').datagrid('getChecked');
		if(rows.length != 1){
			$.messager.show({
				title : '提示',
				msg : '请选择一行数据'
			});
			return;
		}
		$('#msgImage').val('');
		//加载城市
		$('#ztree').dialog({    
			maximizable:true,
		    href: '../view/fragrans/appsystem/excheck.jsp?param=""'+'&objId='+rows[0].id,    
		});
		$.ajax({
			url : 'getId.do',
			type : 'post',
			dataType : 'json',
			data : {
				id : rows[0].id
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

function searchForm(){
	var param = $('#searchForm').serializeObject();
	var topicName = param.topicName;
	var status = param.status;
	var displayconf = param.displayconf;
	var startTime = param.startTime;
	var endTime = param.endTime;
	$.ajax({
		url : 'dataList.do',
		type : 'post',
		dataType : 'json',
		data : {
			topicName : topicName,
			status : status,
			displayconf : displayconf,
			startTime : startTime,
			endTime : endTime
		},
		success : function(result) {
			var data=new Object();
			data.total = result.total;
			data.rows = result.rows;
			$("#data-list").datagrid("loadData",data);
		}
	});
}