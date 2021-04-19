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
	   			fitColumns:true,
	   			columns:[[
						{field:'id',checkbox:true},
	 					{field:'activityName',title:'所属活动',sortable:true},
			 			{field:'redeemCode',title:'兑换码',sortable:true},
			 			{field:'reddemImageurl',title:'兑换码宣传图片',sortable:true},
			 			{field:'redeemActivityUrl',title:'兑换活动URL外连接',sortable:true}
			 	]],
			 	toolbar:toolbar
	});
},
//添加的保存按钮
$('#add-win').dialog({
	buttons:[
		{
			text:'保存',
			handler:function(){
				$('#addForm').form('submit',{
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
							$('#add-win').dialog('close');
							$('#data-list').datagrid('reload');
						}
					}
				});
			}
		},{
			text:'关闭',
			handler:function(){
				$('#add-win').dialog('close');
			}
		}
	]
}),
//上传图片按钮
$('#msgButton').on('click', function() {
	   $('#msgImage').trigger('click');
	}),
$('#msgImage').live('change', function() {
	   $('#reddemImageurl').val($('#msgImage').val());
	}),
//修改的保存按钮
$('#edit-win').dialog({
	buttons:[
		{
			text:'保存',
			handler:function(){
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
//上传图片按钮
$('#msgButtonEdit').on('click', function() {
	   $('#msgImageEdit').trigger('click');
	}),
$('#msgImageEdit').live('change', function() {
	   $('#reddemImageurlEdit').val($('#msgImageEdit').val());
	})
);

//添加方法
function add(){
	$('#addForm').form('clear');
	$('#activityName').combobox({
		title:'列表',
		url:'getValidActivity.do',
		fit : true,
		valueField : 'id',
		textField:'text',
	});
	$('#add-win').dialog('open');
}

//修改方法
function edit(){
	var rows = $('#data-list').datagrid('getChecked');
	if(rows.length != 1){
		$.messager.show({
			title : '提示',
			msg : '请选择一行数据'
		});
		return;
	}
	$('#msgImageEdit').val('');
	$('#activityNameEdit').html(rows[0].activityName);
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

$(function(){
	app.activityRedeemCode.init();
});		