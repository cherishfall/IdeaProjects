var type = 1;
$package('app.pushTask');
app.pushTask = function(){
	var _box = null;
	var _this = {
		config:{
			event : {
				add : function() {
					//添加
					//默认下发类型为定时
					showTime();
					//隐藏选择城市编辑框
					hideArea();
					//隐藏用户账号编辑框
					hideAccount();
					// _box.handler.add();
                    add();
				},
				edit : function() {
					var rows = $('#data-list').datagrid('getChecked');
					if (rows.length != 1) {
						$.messager.show({
							title : '提示',
							msg : '请选择一条记录~'
						});
					} else {
						if(rows[0].exeStatus==2){
							$.messager.alert('提示','任务执行中，不允许修改');  
							return;
						}
						if(rows[0].exeStatus==4){
							$.messager.alert('提示','不允许修改执行失败的任务');  
							return;
						}
						if(rows[0].exeStatus==5){
							$.messager.alert('提示','任务已执行，不允许修改');  
							return;
						}
						//推送类型 1定时 2立刻
						if(rows[0].pushType==1){
							showTime();
						}else{
							hideTime();
						}
						//推送范围  1个人  2区域  3未注册用户  4全部用户
						if(rows[0].pushRange==1){
							showAccount();
						}else{
							hideAccount();
						}
						if(rows[0].pushRange==2){
							showArea();
						}else{
							hideArea();
						}
						// _box.handler.edit();
                        edit();
					}
				},
			},
  			dataGrid:{
  				title:'列表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
	 					{field:'title',title:'消息标题',sortable:true,
							formatter: function(value,row,index){
			     				if (value!=null&&value.length > 15){
			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'....</span>';
			     				}else{
			     					return value;
			     				}
			     		    }},
	 					{field:'messageType',title:'消息类型',sortable:true,formatter:sys.dicts.text('PUSH_MESSAGE_TYPE')},
	 					{field:'pushRange',title:'推送范围类型',sortable:true,formatter:sys.dicts.text('PUSH_RANGE_TYPE')},
	 					{field:'pushClientType',title:'推送对象类型',sortable:true,formatter:sys.dicts.text('PUSH_CLIENT_TYPE')},
	 					{field:'pushType',title:'下发类型',sortable:true,formatter:sys.dicts.text('PUSH_TYPE')},
			 			{field:'content',title:'消息内容',sortable:true,
	 						formatter: function(value,row,index){
			     				if (value!=null&&value.length > 15){
			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'....</span>';
			     				}else{
			     					return value;
			     				}
			     		    }},
	 					{field:'pushTime',title:'下发时间',sortable:true},
	 					// {field:'isVoice',title:'是否开启声音',sortable:true,formatter:sys.dicts.text('YESORNO')},
	 					// {field:'isShock',title:'是否开启振动',sortable:true,formatter:sys.dicts.text('YESORNO')},
	 					{field:'isDisplay',title:'是否显示提示',sortable:true,formatter:sys.dicts.text('YESORNO')},
	 					// {field:'isClear',title:'是否可清除',sortable:true,formatter:sys.dicts.text('YESORNO')},
	 					// {field:'isOpen',title:'是否启动应用',sortable:true,formatter:sys.dicts.text('YESORNO')},
	 					{field:'exeStatus',title:'任务执行状态',sortable:true,formatter:sys.dicts.text('EXE_STATUS')},
	 					{field:'exeResult',title:'任务执行结果描述',sortable:true},
	 					{field:'templetType',title:'模板类型',sortable:true,formatter:sys.dicts.text('TEMPLET_TYPE')},
			 	]],
				toolbar:[
					{id:'btnadd',text:'添加',btnType:'add'},
					{id:'btnedit',text:'修改',btnType:'edit'},
                    {id:'btndelete',text:'删除',btnType:'remove',iconCls : 'icon-edit',
                        handler : function() {
                            deleteData();
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
	app.pushTask.init();
    $('#edit-win').dialog({
        buttons:[
            {
                text:'保存',
                handler:function(){
                    var content = $("#content").val();
                    if(content==''){
                        $.messager.alert('提示','消息内容不能为空');
                        return;
                    }
                    var pushType = $('#pushTime').datetimebox('getValue');
                    if(pushType==''&&type==1){
                        $.messager.alert('提示','下发类型为定时时，下发时间不能为空');
                        return;
                    }
                    if(pushType==''){
                        $.messager.confirm('确认', '此操作执行会立刻下发消息，确认下发？', function(r) {
                            if (r) {
                                save();
                            }
                        });
                    }else{
                        save();
                    }
                }
            },{
                text:'关闭',
                handler:function(){
                    $('#edit-win').dialog('close');
                }
            }
        ]
    }),
    $('#accountButton').on('click', function() {
        $('#accountText').trigger('click');
    }),
	$('#accountText').live('change', function() {
		$('#userAccount').val($('#accountText').val());
	})

});


function save(){
	$('#templetType').val("1");
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

function deleteData(){
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
}

function add(){
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


$('#area').combotree({
	title:'区域列表',
	url:'../area/getAreaTree.do',
	fit : true,
	idField : 'id',
	panelHeight : '200',
	treeField : 'areaName',
	parentField : 'parentId',
});

$('#pushRangeEdit').combobox({
	onChange:function(newValue,oldValue){
		//推送范围  1个人  2区域  3未注册用户  4全部用户
		if(newValue==1){
    		showAccount();
		}else{
			hideAccount();
		}
    	if(newValue==2){
    		showArea();
		}else{
			hideArea();
		}
    }
});

function showArea(){
	//推送类型为区域，显示区域编辑框
	$("#areaDiv").show();
}

function hideArea(){
	//推送类型不是区域，隐藏区域编辑框
	$("#areaDiv").hide();
	$('#area').combobox('clear');
}

function showAccount(){
	//推送类型不是区域，显示用户账号编辑框
	$("#userAccountDiv").show();
}

function hideAccount(){
	//推送类型为区域，隐藏用户账号编辑框
	$("#userAccountDiv").hide();
	$('#userAccount').val('');
}

function showTime(){
	//下发类型为定时，显示下发时间编辑框
	$("#time").show();
	$("#pushTimeDiv").show();
	type = 1;
}

function hideTime(){
	//下发类型为立刻，隐藏下发时间编辑框
	$("#time").hide();
	$("#pushTimeDiv").hide();
	$('#pushTime').datetimebox('clear');
	type = 2;
}

$('#userAccount').tooltip({    
	position: 'right',    
	content: '<span style="color:black">多个用户用&符号分割；上传文件仅支持.txt格式文本</span>',
	onShow: function(){       
		$(this).tooltip('tip').css({            
			backgroundColor: '#ffc',           
			borderColor: '#c93'       
				});    
		}
});

$('#isDisplayDiv').tooltip({    
	position: 'right',    
	content: '<span style="color:black">若为否：直接打开app首页</span>',    
	onShow: function(){       
		$(this).tooltip('tip').css({            
			backgroundColor: '#ffc',           
			borderColor: '#c93'       
				});    
		}
});
