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
//				{id:'btndelete',text:'删除',btnType:'remove',iconCls : 'icon-remove',
//					handler : function() {
//						var rows = $('#data-list').datagrid('getChecked');
//						$.messager.confirm('确认', '确认删除？', function(r) {
//							if(r){
//								var ids = '';
//						    	$.each(rows,function(i,row){
//						    		ids+=row.id+','
//						    	});
//							$.ajax({
//								url:'delete.do',
//								type:'post',
//								dataType:'json',
//								data:{
//									ids : ids
//								},
//								success:function(result){
//									$('#data-list').datagrid('reload');
//									$.messager.show({
//										msg : result.msg,
//										title : '提示'
//									});
//								}
//							});
//						}
//					});
//				}},
				{id:'btnpush',text:'下发消息',btnType:'push',iconCls : 'ext-icon-picture_go',
					handler : function() {
						push();
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
			columns:[[ 
				{field:'id',checkbox:true},
				{field:'messageName',title:'消息名称',sortable:true},
				{field:'areaCodes',title:'城市名称',sortable:true,
					formatter: function(value,row,index){
	     				if (value!=null&&value.length > 15){
	     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
	     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'....</span>';
	     				}else{
	     					return value;
	     				}
	     		    }},
	 			{field:'messageType',title:'消息类型',sortable:true,formatter:sys.dicts.text('MESSAGE_TYPE')},
				{field:'pushRange',title:'推送范围',sortable:true,formatter:sys.dicts.text('PUSH_RANGE')},
				{field:'scale',title:'已读占比',sortable:true},
				{field:'messageTopicName',title:'所属分类',sortable:true}
	 					
	 	]],
		toolbar:toolbar
	});
},
$('#edit-win').dialog({
	buttons:[
		{
			text:'保存',
			handler:function(){
				//验证消息摘要是否为空
				if ($('#messageRemark').val()=='') {
					$.messager.alert('提示','消息摘要不可为空','info');
					return;
				}
				//验证h5页面有值时是否为可点击
				if ($('#messageUrl').val()!='' && $('#isClick').combobox('getValue')==0) {
					$.messager.alert('提示','该消息存在h5页面，必须为可点击！','info');
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
$('#edit-push').dialog({
	buttons:[
		{
			text:'推送消息',
			handler:function(){
				$('#editPushForm').form('submit',{
					url:'savePushTask.do',
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
							$('#edit-push').dialog('close');
							$('#data-list').datagrid('reload');
						}
				}
				});
			}
		},{
			text:'关闭',
			handler:function(){
				$('#edit-push').dialog('close');
			}
		}
	]
}),
$('#areaName').combobox({
	url:'../area/getCity.do',
	valueField : 'id',
	textField : 'text',
	multiple : true,
	width : 250,
	formatter : function(row) {
		var s = "<span><input type='checkbox' class='selectId' style='vertical-align: middle' id='selectId_"
				+ row.id
				+ "'>"
				+ row.text
				+ "<span>";
		return s;
	},
	onSelect : function(record) {
		$("#selectId_" + record.id).attr(
				"checked", true);
	},
	onUnselect : function(record) {
		$("#selectId_" + record.id).attr(
				"checked", false);
	}
}),
$('#messageTopic').combobox({
	title:'消息分类',
	url:'../message/getMessageTopic.do',
	fit : true,
	valueField : 'id',
	textField : 'text'
}),
//改变推送范围时，根据选择的推送范围显示或隐藏区域编辑框
$('#pushRange').combobox({
	onChange:function(newValue,oldValue){
    	if(newValue==100){
			//当消息属于个人用户时，隐藏区域编辑框
			$("#areaDiv").hide();
			$("#areaNameDiv").hide();
			$('#areaName').combobox('clear');
		}else{
			$("#areaDiv").show();
			$("#areaNameDiv").show();
		}
    }
}),
$('#msgButton').on('click', function() {
	   $('#msgImage').trigger('click');
	}),
$('#msgImage').live('change', function() {
	   $('#messageImage').val($('#msgImage').val());
	})	
);


function add(){
	$("#areaDiv").show();
	$("#areaNameDiv").show();
	$('#editForm').form('clear');
	//重新加载下拉框
	$('#areaName').combobox('reload');
	$('#edit-win').dialog('open');
	CKEDITOR.instances.content.setData(' ');//content为控件名称
}

function searchForm(){
	var messageName = $('#messageName').val();
	$('#data-list').datagrid('load', {    
	    name: 'easyui',    
	    messageName: messageName
	}); 
}

function edit(){
		var rows = $('#data-list').datagrid('getChecked');
		//重新加载下拉框
		$('#areaName').combobox('reload');
		if(rows.length != 1){
			$.messager.show({
				title : '提示',
				msg : '请选择一行数据'
			});
			return;
		}
		$('#msgImage').val('');
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
				$('#editForm').form('load', result.data);
				var cityCodeArr = result.data.cityCodeArr;
				if (cityCodeArr!=null&&cityCodeArr.length == 0) {
					$('#areaName').combobox('reload');
				} else {
					//遍历数组勾选下拉框
					$.each(cityCodeArr, function(i, cityCode) {
					$("#selectId_" + cityCode).attr("checked", true);
				});
				}
				if (result.success) {
					$('#edit-win').dialog('open');
					var data = result.data;
					$('#editForm').form('load',data);
					if(rows[0].pushRange==100){
						//当消息属于个人用户时，隐藏区域编辑框
						$("#areaDiv").hide();
						$("#areaNameDiv").hide();
						$('#areaName').combobox('clear');
					}else{
						$("#areaDiv").show();
						$("#areaNameDiv").show();
					}
					CKEDITOR.instances.content.setData(data.content);
				} else {
					$.messager.show({
						msg : result.msg,
						title : '提示'
					});
				}
			}
		});
}

function push(){
	var rows = $('#data-list').datagrid('getChecked');
	if (rows.length != 1) {
		$.messager.show({
			title : '提示',
			msg : '请选择一条记录~'
		});
	} else {
		$('#editPushForm').form('clear');
		$('#pushMessageType').val(1);
		$('#templetType').val(1);
		$('#pushType').val(2);
		$('#messageId').val(rows[0].id);
		$('#messageNamePush').val(rows[0].messageName);
		$('#edit-push').dialog('open');
	}
}

