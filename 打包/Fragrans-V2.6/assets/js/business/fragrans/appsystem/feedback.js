$package('app.feedback');
app.feedback = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[
						{field:'id',checkbox:true},
	 					{field:'account',title:'用户账户',sortable:true},
	 					{field:'areaName',title:'区域',sortable:true},
	 					{field:'phone',title:'手机号',sortable:true},
	 					{field:'machineType',title:'机器类型',sortable:true},
	 					{field:'plate',title:'车牌号',sortable:true},
	 					{field:'contact',title:'联系人',sortable:true},
	 					{field:'type',title:'问题类型',sortable:true,formatter:sys.dicts.text('FEEDBACK_TYPE')},
                    	{field:'processStatus',title:'处理状态',sortable:true,formatter:sys.dicts.text('COMPLAIN_STATUS')},
	 					{field:'content',title:'反馈内容',sortable:true,
	 						formatter: function(value,row,index){
			     				if (value!=null&&value.length > 15){
			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'...</span>';
			     				}else{
			     					return value;
			     				}
			     		    }},
	 					{field:'processResult',title:'处理结果',sortable:true,
			     		    	formatter: function(value,row,index){
				     				if (value!=null&&value.length > 15){
				     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
				     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'...</span>';
				     				}else{
				     					return value;
				     				}
				     		    }},
	 					{field:'processedBy',title:'处理人',sortable:true},
	 					{field:'createTime',title:'创建时间',sortable:true},
	 					{field:'processTime',title:'处理时间',sortable:true}
			 	]],
				toolbar:[
					{id:'btnedit',text:'处理反馈',btnType:'feedback',iconCls : 'icon-edit',
						handler:function(){
							edit();
					}},
					{id:'btnExport',text:'导出反馈',iconCls:"ext-icon-page_excel",
						handler : function() {
							window.open('exportDataList.do');
						}}
				]
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
			$('#edit-win').dialog({
				buttons:[
					{
						text:'提交反馈处理',
                        iconCls:"ext-icon-accept",
						handler:function(){
							$('#editForm').form('submit',{
								url:'submitResult.do',
								type:'post',
								success:function(result){
									var mes = eval('('+result+')');
									$.messager.show({
										title : '提示',
										msg : mes.msg
									});
									$('#edit-win').dialog('close');
									$('#data-list').datagrid('reload');
							}
							});
						}
					},{
                        text:'受理',
                        iconCls:"ext-icon-hourglass",
                        handler:function(){
                            accept();
                        }
                    },{
                        text:'完成处理',
                        iconCls:"ext-icon-tick",
                        handler:function(){
                            finish();
                        }
                    },{
						text:'关闭',
						handler:function(){
							$('#edit-win').dialog('close');
						}
					}
				]
			})
		}
	}
	return _this;
}();

$(function(){
	app.feedback.init();
	var param = $('#searchForm').serializeObject();
	var startTime = param.startTime;
	var endTime = param.endTime;
	if (endTime < startTime) {
		$.messager.show({
			title : '提示',
			msg : "开始时间必须小于结束时间"
		});
		return;
	}
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
				$('#editForm').form('load',{id:data.id,account:data.account,plate:data.plate,contact:data.contact,
					appId:data.appId,appVersion:data.appVersion,type:sys.dicts.text("FEEDBACK_TYPE",data.type),content:data.content,
					processResult:data.processResult});
			} else {
				$.messager.show({
					msg : result.msg,
					title : '提示'
				});
			}
		}
	});
}

function accept(){
    var rows = $('#data-list').datagrid('getChecked');
    var processResult = $('#processResult').val();
    if (rows.length != 1) {
        $.messager.show({
            title : '提示',
            msg : '请选择一条记录~'
        });
        return;
    }
    if(rows[0].processStatus==1){
        $.messager.show({
            title : '提示',
            msg : '该条反馈正在处理中，请勿重复受理'
        });
        return;
	}
    if(rows[0].processStatus==2){
        $.messager.show({
            title : '提示',
            msg : '该条反馈已完成处理，无需受理'
        });
        return;
    }
	$.ajax({
		url : 'accept.do',
		type : 'post',
		data : {
			id : rows[0].id,
            processResult:processResult
		},
		success : function(result) {
			$.messager.show({
				title : '提示',
				msg : result.msg
			});
			if (result.success) {
                $('#edit-win').dialog('close');
				$('#data-list').datagrid('reload');
			}
		}
	});
}

function finish(){
    var rows = $('#data-list').datagrid('getChecked');
	var processResult = $('#processResult').val();
    if (rows.length != 1) {
        $.messager.show({
            title : '提示',
            msg : '请选择一条记录~'
        });
        return;
    }
    if(rows[0].processStatus==2){
        $.messager.show({
            title : '提示',
            msg : '该条反馈已完成处理，请勿重复提交'
        });
        return;
    }
    $.messager.confirm('确认', '确定完成处理？', function(r) {
        if (r) {
            $.ajax({
                url: 'finish.do',
                type: 'post',
                data: {
                    id: rows[0].id,
                    processResult:processResult
                },
                success: function (result) {
                    $.messager.show({
                        title: '提示',
                        msg: result.msg
                    });
                    if (result.success) {
                        $('#edit-win').dialog('close');
                        $('#data-list').datagrid('reload');
                    }
                }
            });
        }
    });
}