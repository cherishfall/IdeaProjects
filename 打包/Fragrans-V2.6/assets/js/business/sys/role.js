$package('base.role');
base.role = function(){
	var _box = null;
	var _this = {
	    menu: $('#menu-tree'),
		addFormPara:function(nodes){
				$.each(nodes,function(i,note){
					var id = note.attributes.id;
					var type = note.attributes.type;
					var $id = $("<input type='hidden' name='modules' class='c_menus'>");
					if(type == 1){
						$id.attr('name','modules');
					}else if(type == 0){
						$id.attr('name','btns');
					}
					$id.val(id);
					_box.form.edit.append($id);
				});
		},
		clearTreeData:function(){
			$(".tree-checkbox1",_this.menu).removeClass("tree-checkbox1").addClass("tree-checkbox0");
			$(".tree-checkbox2",_this.menu).removeClass("tree-checkbox2").addClass("tree-checkbox0");
			$('.c_menus').remove();
		},
		setTreeValue:function(id){
			var node = _this.menu.tree("find",id);
			if(node && node.target){
				//判断是否选择或者半选状态 
				if (node.attributes.check) {
					_this.menu.tree('check', node.target);
				}
			}
		},
		save:function(){
				var nodes = _this.menu.tree('getChecked');
				var innodes =_this.menu.tree('getChecked','indeterminate');
				if(nodes.length == 0 && innodes.length == 0){
					sys.alert('警告','请选择模块列表','warning');
					return;
				}
				$('.c_menus').remove();
				_this.addFormPara(nodes);
				_this.addFormPara(innodes);
				_box.handler.save();
				$('.c_menus').remove();
		},
		config:{
			event:{
				add:function(){
					_box.handler.add();
					_this.menu.tree('reload');
				},
				edit:function(){
					var row  = $('#data-list').datagrid('getChecked');
					if(row.length != 1){
						sys.alert('警告','只能选择一行记录.','warning');
					}else{
						_this.clearTreeData();
						_box.handler.edit(function(result){
							var btnIds  = result.data.btns;
							var menuIds  = result.data.modules;
							$.each(menuIds,function(i,id){
								_this.setTreeValue("module_"+id);
							});
							$.each(btnIds,function(i,id){
								_this.setTreeValue("btn_"+id);
							});
						});
					}
				},
				save:function(){
					//判断是否被禁用帐号
					var state = $("select[name='state']").val();
					if(state == 0){
						sys.confirm("提示","禁用角色将会自动解除关联的用户授权,是否确定?",function(r){
							if(r){
								_this.save();
							}
						});
					}else{
						_this.save();
					}
				}
			},
  			dataGrid:{
  				title:'角色列表',
	   			url:'dataList.do',
	   			columns:[[
						{field:'id',checkbox:true},
						//{field:'id',title:'id',width:80,sortable:true},
						{field:'roleName',title:'角色名称',width:80,sortable:true},
						{field:'roleLevel',title:'角色等级',width:80,sortable:true,formatter:sys.dicts.text("ROLE_LEVEL")},
						{field:'roleDesc',title:'描述',width:280,sortable:true},
						{field:'createdBy',title:'创建人',width:120,sortable:true},
						{field:'updatedBy',title:'修改人',width:120,sortable:true},
						{field:'createTime',title:'创建时间',width:150,sortable:true},
						{field:'updateTime',title:'更新时间',width:150,sortable:true}
						
				]],
				toolbar : [
				   {id : 'btnadd',text : '添加',btnType : 'add'},
		           {id : 'btnedit',text : '修改',btnType : 'edit'},
		           {id : 'btndelete',text : '删除',btnType : 'remove'},
		        ]
				
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
			
			_this.menu.tree({
				title:'权限列表',
				width:230,
				height:200,
				url:'roleModule.do',
				checkbox:true,
				multiple:true,
				cascadeCheck:true,
			});
		}
	}
	return _this;
}();

$("#roleLevel").combobox({
	url:'getRoleLevel.do',
	valueField:'id',  
	textField:'text',
})

$(function(){
	base.role.init();
});	
