var codeEditId = "areaCodeEdit";
var nameEditId = "areaNameEdit";
var setting = {
			view: {
				selectedMulti: false
			},
			check: {
				enable: true
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				onCheck: onCheck
			}
		};

		var clearFlag = false;
		function onCheck(e, treeId, treeNode) {
			count();
			if (clearFlag) {
				clearCheckedOldNodes();
			}
		}
		function clearCheckedOldNodes() {
			var zTree = $.fn.zTree.getZTreeObj("cityTree"),
			nodes = zTree.getChangeCheckedNodes();
			for (var i=0, l=nodes.length; i<l; i++) {
				nodes[i].checkedOld = nodes[i].checked;
			}
		}
		function count() {
			var zTree = $.fn.zTree.getZTreeObj("cityTree");
			type =  { "Y" : "", "N" : "" };
			zTree.setting.check.chkboxType = type;
			var checkCount = zTree.getCheckedNodes(true).length;
			var checkNodes = zTree.getCheckedNodes(true);
			//组装勾选的值的id
			var ids="";
			if (checkNodes && checkNodes.length>0) {
				for(var i=0;i<checkNodes.length;i++){
					var checkNode = checkNodes[i];
					ids += checkNode.id+",";
				}
			}
			//组装勾选的值的text
			var names="";
			if (checkNodes && checkNodes.length>0) {
				for(var i=0;i<checkNodes.length;i++){
					var checkNode = checkNodes[i];
					names += checkNode.name+",";
				}
			}
			//将组装好的值赋值给对应id的输入框
			$("#areaCodeAdd").val(ids.substring(0,ids.length-1));
			$("#areaNameAdd").val(names.substring(0,names.length-1));
            $('#'+codeEditId).val(ids.substring(0,ids.length-1));
            $('#'+nameEditId).val(names.substring(0,names.length-1));
		}
		function createTree(zNodes) {
			$.fn.zTree.init($("#cityTree"), setting, zNodes);
			var objId = $('#objId').val();
			console.log("objId:"+objId);
			if(objId!=''){
				//修改时，自动勾选已保存的城市
				$.ajax({
					url : '../excheck/getAreaCodes.do',
					type : 'post',
					data : {
						objId : objId
					},
					success : function(result) {
						if(isNull(result)){
							return;
						}
						var zTree = $.fn.zTree.getZTreeObj("cityTree");
						type =  { "Y" : "", "N" : "" };
						zTree.setting.check.chkboxType = type;
						var ids = result.ids, i = 0, l = ids.length, node = null; 
						for( ; i < l; i ++ ) { 
							zTree.checkNode(zTree.getNodeByParam( "id",ids[i] ), true); 
						} 
						$('#'+codeEditId).val(result.ids);
						$('#'+nameEditId).val(result.names);
					}
				});
			}
			count();
		}
$(function(){
	var param = $('#param').val();
    if(!isNull($('#codeEditId').val())){
        codeEditId = $('#codeEditId').val();
	}
    if(!isNull($('#nameEditId').val())){
        nameEditId = $('#nameEditId').val();
    }
	if(param==''){
		//查询所有城市，无需关联其他
		$.ajax({
			url : '../activityTopic/getCity.do',
			type : 'post',
			success : function(result) {
				var zNodes = result;
				createTree(zNodes);
			}
		});
	}else if(param=='all'){
		//查询所有城市，无需关联其他
		$.ajax({
			url : '../excheck/getCityList.do',
			type : 'post',
			success : function(result) {
				var zNodes = result;
				createTree(zNodes);
			}
		});
	}else{
		//关联param字段，根据param查询城市
		$.ajax({
			url : '../excheck/getCity.do',
			type : 'post',
			data : {
				param : param,
			},
			success : function(result) {
				var zNodes = result;
				createTree(zNodes);
			}
		});
	}
});

function isNull(str){
	if(str=='null'||str==null||str==''||str==undefined){
		return true;
	}
	return false;
}
