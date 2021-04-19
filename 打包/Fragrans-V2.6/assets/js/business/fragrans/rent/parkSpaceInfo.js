$package('rent.parkSpaceInfo');
rent.parkSpaceInfo = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表(默认显示审核中的记录)',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			rowStyler:function(index,row){   
					if(row.status==0){
		   				return 'background-color:#fbffd3;';
		   			}else if(row.status==2){   
		   				return 'background-color:#d3faf9;';   
	   			    }else if(row.status==3){
	   			    	return 'background-color:#fef6eb;';
	   			    }else if(row.status==4){
	   			    	return 'background-color:#faf2cc;';
	   			    }
		   		},
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
						{field:'userId',hidden:true},
						{field:'imgUrl',hidden:true},
						{field:'createdBy',title:'用户账号',sortable:true},
	 					{field:'areaName',title:'区域名称',sortable:true},
	 					{field:'name',title:'车位名称',sortable:true},
	 					{field:'address',title:'车位地址',sortable:true},
	 					{field:'longitudeGaode',title:'经度(高德)',sortable:true},
	 					{field:'latitudeGaode',title:'纬度(高德)',sortable:true},
	 					{field:'count',title:'车位数量',sortable:true},
	 					{field:'phone',title:'联系电话',sortable:true},
	 					{field:'startDate',title:'起租日期',sortable:true,
	 						formatter:function(value,row,index){
								return value.split(" ")[0];
							}},
	 					{field:'type',title:'车位类型',sortable:true,formatter:sys.dicts.text('PARKSPACE_TYPE')},
	 					{field:'status',title:'车位状态',sortable:true,formatter:sys.dicts.text('PARKSPACE_STATUS')},
	 					{field:'isParkCart',title:'是否允许停放大车',sortable:true,formatter:sys.dicts.text('YESORNO')},
	 					{field:'isReleCert',title:'是否需要放行证明',sortable:true,formatter:sys.dicts.text('YESORNO')},
	 					{field:'reviewer',title:'审核人',sortable:true},
	 					{field:'reviewResult',hidden:true}
//	 					{field:'evalNum',title:'评价数',sortable:true}
			 	]],
				toolbar:[
						{id:'btnphoto',text:'查看照片',iconCls : 'ext-icon-picture',btnType:'parkSpacePhoto',handler:function(){
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length != 1) {
								$.messager.show({
									title : '提示',
									msg : '请选择一条记录~'
								});
							} else {
								loadPhoto(rows);
							}
						}},
						{id:'btnreview',text:'提交审核',iconCls : 'ext-icon-accept',btnType:'parkSpaceReview',handler:function(){
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length != 1) {
								$.messager.show({
									title : '提示',
									msg : '请选择一条记录~'
								});
							} else {
								review(rows);
							}
						}},
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

function review(rows){
	$('#reviewResult').val(rows[0].reviewResult);
	$('#reviewDiv').dialog("open");
}

function loadPhoto(rows){
	//照片
	var imgUrls = rows[0].imgUrl;
	if(imgUrls==null||imgUrls==''||imgUrls==undefined){
		$.messager.alert('提示','该条记录没有照片');
		return;
	}
	//照片数组
	var imgUrl = imgUrls.split("|");
	
	var ul=document.getElementById('ulClass');
	var lis=document.querySelectorAll("#ulClass li");
	var len=lis.length;
	if(len!=0){
		for (var j=0;j<len;j++){
		   ul.removeChild(lis[j]);
		}
	}
	for(var i=1;i<=imgUrl.length;i++){
		addElementLi('ulClass',imgUrl[i-1],i);
	}
	$('#photoDiv').dialog("open");
}

function addElementLi(obj,src,i) {
	var ul = document.getElementById(obj);
	//添加 li
	var li = document.createElement("li");
	//设置 li 属性，如 id
	li.setAttribute("id", "newli"+i);
	li.setAttribute("align", "center");
	li.innerHTML = "<img style='height:420px;' src='"+src+"'/>";
	ul.appendChild(li);
}

function submitReviewResult(rows,status,reviewResult,txt){
	$.messager.confirm('提示', '确定'+txt+'吗？', function(r) {
		if (r) {
			$.messager.progress({
				title:'请稍后',
				msg:'正在处理...'
			});
			$.ajax({
				url : 'submitReviewResult.do',
				type : 'post',
				dataType : 'json',
				data : {
					berthId : rows[0].id,
					userId : rows[0].userId,
					status : status,
					reviewResult : reviewResult
				},
				success : function(result) {
					if(result.success){
						$.messager.show({
							msg : result.msg,
							title : '提示'
						});
						$('#data-list').datagrid('reload');
	   					$('#reviewDiv').dialog('close');
   					}else{
   						$.messager.alert('提示',result.msg,'info');
   					}
   					$.messager.progress('close');
				}
			});
		}
	});
}

$('#pass').bind('click',function(){
	var pass = 2;
	var rows = $('#data-list').datagrid('getChecked');
	//通过原因
	var reviewResult = $('#reviewResult').val();
	submitReviewResult(rows,pass,reviewResult,'通过');
});

$('#reject').bind('click',function(){
	var reject = 0;
	var rows = $('#data-list').datagrid('getChecked');
	//驳回原因
	var reviewResult = $('#reviewResult').val();
	if(reviewResult==null||reviewResult==''||reviewResult==undefined){
		$.messager.alert('警告','审核描述不能为空');
		return;
	}
	submitReviewResult(rows,reject,reviewResult,'驳回');
});

$('#cancle').bind('click',function(){
	var cancle = 3;
	var rows = $('#data-list').datagrid('getChecked');
	//取消原因
	var reviewResult = $('#reviewResult').val();
	if(reviewResult==null||reviewResult==''||reviewResult==undefined){
		$.messager.alert('警告','审核描述不能为空');
		return;
	}
	submitReviewResult(rows,cancle,reviewResult,'取消车位');
});

$(function(){
	rent.parkSpaceInfo.init();
	$(".slider").YuxiSlider({
	    width:580, //容器宽度
	    height:420, //容器高度
	    control:$('.control'), //绑定控制按钮
	    auto:false,
	   /* during:4000, //间隔4秒自动滑动*/
	    speed:800, //移动速度0.8秒
	    mousewheel:true, //是否开启鼠标滚轮控制
	    direkey:true //是否开启左右箭头方向控制
	});
});		