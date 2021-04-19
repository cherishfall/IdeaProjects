$(function(){
	//定义按钮
	var toolbar = [
	   			{id:'btnadd',text:'添加',btnType:'add',
					iconCls : 'icon-add',
					handler : function() {
						$('#editForm').form('reset');
						add();
					}},
				{id:'btnedit',text:'修改',btnType:'edit',iconCls : 'icon-edit',
						handler : function() {
							$('#editForm').form('reset');
							var node = $('#data-list').treegrid('getSelected');
							edit(node);
						}},
				{id:'btndelete',text:'删除',btnType:'remove',iconCls : 'icon-remove',
							handler : function() {
								var node = $('#data-list').treegrid('getSelected');
								$.messager.confirm('确认', '确认删除？', function(r) {
									if(r){
									$.ajax({
										url:'delete.do',
										type:'post',
										dataType:'json',
										data:{
											id : node.id
										},
										success:function(result){
											$('#data-list').treegrid('reload');
											$.messager.show({
												msg : result.msg,
												title : '提示'
											});
										}
									});
								}
								});
							}}, {
								text : '展开',
								iconCls : 'icon-redo',
								handler : function() {
									var node = $('#data-list').treegrid('getSelected');
									if (node) {
										$('#data-list').treegrid('expandAll', node.cid);
									} else {
										$('#data-list').treegrid('expandAll');
									}
								}
							}, {
								text : '折叠',
								iconCls : 'icon-undo',
								handler : function() {
									var node = $('#data-list').treegrid('getSelected');
									if (node) {
										$('#data-list').treegrid('collapseAll', node.cid);
									} else {
										$('#data-list').treegrid('collapseAll');
									}
								}
							}
			];
	
	
	//构建grid
	$('#data-list').treegrid({
		title:'列表',
		url:'dataList.do',
		fit : true,
		idField : 'id',
		treeField : 'departmentName',
		parentField : 'parentId',
		border : false,
		columns:[[
		        {field:'id',hidden:true},
		        {field:'cityCode',hidden:true,title:'城市编码'},
				{field:'areaCode',hidden:true,title:'区域编码'},
				{field:'departmentName',width : 200,title:'部门名称'},
				{field:'cityName',	width : 100,title:'城市名称'},
				{field:'areaName',	width : 100,title:'区域名称'},
				{field:'contacts',	width : 70,title:'联系人'},
				{field:'phone',	width : 100,title:'联系方式'},
				{field:'address',	width : 80,title:'地址'},
				{field:'createTime',	width : 150,title:'创建时间'},
				{field:'note',	width : 180,title:'备注'},
				{field:'orderNum',	width : 80,title:'排序号'},
	 	]],
		toolbar:toolbar
	});
	
	//初始化权限按钮
	initTbar($('#data-list'),toolbar,basePath+'/department/list.action');
},
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
						$.messager.show({
							title : '提示',
							msg : mes.msg
						});
						$('#edit-win').dialog('close');
						$('#data-list').treegrid('reload');
						$('#departmentTree').combotree('reload');
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
$('#edit-department').dialog({
	buttons:[
		{
			text:'保存',
			handler:function(){
				$('#departmentEditForm').form('submit',{
					url:'save.do',
					type:'post',
					success:function(result){
						var mes = eval('('+result+')');
						$.messager.show({
							title : '提示',
							msg : mes.msg
						});
						$('#edit-department').dialog('close');
						$('#data-list').treegrid('reload');
					}
				});
			}
		},{
			text:'关闭',
			handler:function(){
				$('#edit-department').dialog('close');
			}
		}
	]
}),
$('#departmentTree').combotree({  
	title:'列表',
	url:'getDeparmentTree.do',
	fit : true,
	idField : 'id',
	treeField : 'departmentName',
	parentField : 'parentId'
})

);
function add(){
	$('#edit-win').dialog('open');
	$('#editForm').form('clear');
	//获取 datagrid 当前选择的行
	var node = $('#data-list').treegrid('getSelected');
	$('#departmentTree').combotree({
		onChange:function(newValue,oldValue){
			$('#cityCode').combotree({
				url:'getAreaTreeById.do?parentId='+newValue,
				 onChange:function(newValue,oldValue){
				    	$('#areaCode').combotree({    
				    	    url: '../area/getArea.do?parentId='+newValue,
				    	    fit : true,
				    	    idField : 'id',
				    	    treeField : 'areaName',
				    	    parentField : 'parentId',
				    	    required: false  
				    	}); 
				    }
			});
	    }		
	});
	if(node!=null){
		 //默认选择gridtree
		$('#departmentTree').combotree('setValue', node.id);
	}
	$('#cityCode').combotree({
		url:'getAreaTreeById.do?parentId='+node.id,
	    onChange:function(newValue,oldValue){
	    	$('#areaCode').combotree({    
	    	    url: '../area/getArea.do?parentId='+newValue,
	    	    fit : true,
	    	    idField : 'id',
	    	    treeField : 'areaName',
	    	    parentField : 'parentId',
	    	    required: false  
	    	}); 
	    }
	})
}

function edit(node){
	if(node){
		if(node.id == 1){
			$.messager.show({
				title : '提示',
				msg : '顶级节点不允许修改'
			});
			return;
		}
		$('#edit-department').dialog('open');
		$('#departmentEditForm').form('load',{id:node.id,departmentName:node.departmentName,parentId:node.parentId,cityCode:node.cityName,areaCode:node.areaName,
			contacts:node.contacts,phone:node.phone,orderNum:node.orderNum,address:node.address,note:node.note});
	}else{
		$.messager.show({
			title : '提示',
			msg : '请选择一条记录'
		});
	}
}

