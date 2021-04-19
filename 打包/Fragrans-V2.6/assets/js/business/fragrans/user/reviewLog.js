$package('app.reviewLog');
app.reviewLog = function(){
	var _box = null;
	var _this = {
		config:{
  			dataGrid:{
  				title:'列表(默认显示未审核和审核中的记录)',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			rowStyler:function(index,row){   
					if(row.reviewStatus==0){
		   				return 'background-color:#fbffd3;';
		   			}else if(row.reviewStatus==1){   
		   				return 'background-color:#d3faf9;';   
	   			    }else if(row.reviewStatus==2){
	   			    	return 'background-color:#fef6eb;';
	   			    }else if(row.reviewStatus==3){
	   			    	return 'background-color:#faf2cc;';
	   			    }
		   		 },
	   			columns:[[ // ,formatter:sys.dicts.text('OPEN_FLAG')
						{field:'id',checkbox:true},
						{field:'licensePhoto',title:'照片正页',hidden : true},
						{field:'licensePhotoVice',title:'照片副页',hidden : true},
						{field:'areaName',title:'区域',sortable:true},
						{field:'createdBy',title:'提交人',sortable:true},
						{field:'plateNo',title:'车牌号码',sortable:true},
						{field:'plateColor',title:'车牌颜色',sortable:true,formatter:sys.dicts.text('PLATE_COLOR')},
//	 					{field:'busiType',title:'审批类型',sortable:true},
	 					{field:'busiDesc',title:'业务描述',sortable:true},
	 					{field:'reviewStatus',title:'审核状态',sortable:true,
	 						formatter: function(value,row,index){
			     				if (value==2){
			     					return '<span style="color:green;">'+sys.dicts.text('REVIEW_STATUS',value)+'</span>';
			     				}else if(value==3){
			     					return '<span style="color:red;">'+sys.dicts.text('REVIEW_STATUS',value)+'</span>';
	 							}else{
			     					return sys.dicts.text('REVIEW_STATUS',value);
			     				}
			     		    }},
	 					{field:'reviewer',title:'审核人',sortable:true},
	 					{field:'reviewTime',title:'审核时间',sortable:true},
	 					{field:'passReason',title:'通过原因',sortable:true,
	 						formatter: function(value,row,index){
			     				if (value!=null&&value.length > 15){
			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'...</span>';
			     				}else{
			     					return value;
			     				}
			     		    }},
	 					{field:'rejectReason',title:'驳回原因',sortable:true,
		     		    	formatter: function(value,row,index){
			     				if (value!=null&&value.length > 15){
			     					var aa = value.replace(/(\n)+|(\r\n)+/g, "");
			     					return '<span class="easyui-tooltip" title=\"'+ aa +'\">'+value.substring(0,15)+'...</span>';
			     				}else{
			     					return value;
			     				}
			     		    }},
	 					{field:'createTime',title:'提交时间',sortable:true}
			 	]],
				toolbar:[
					{id:'btnaccept',text:'批量受理',iconCls : 'ext-icon-accept',btnType:'reviewAccept',handler:function(){
						var rows = $('#data-list').datagrid('getChecked');
						if (rows.length == 0) {
							$.messager.show({
								title : '提示',
								msg : '至少选择一条记录~'
							});
						} else {
							accept(rows);
						}
					}},
					{id:'btnhandle',text:'处理',iconCls : 'ext-icon-arrow_undo',btnType:'reviewHandle',handler:function(){
						var rows = $('#data-list').datagrid('getChecked');
						if (rows.length != 1) {
							$.messager.show({
								title : '提示',
								msg : '请选择一条记录~'
							});
						} else {
							handle(rows);
						}
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

function accept(rows){
	var reviewLogIds = [];
	for(var i=0;i<rows.length;i++){
		reviewLogIds.push(rows[i].id);
	}
	$.messager.confirm('确认', '确认受理？', function(r) {
		if (r) {
			$.ajax({
				url : 'accept.do',
				type : 'post',
				traditional: true,
				data : {
					ids : reviewLogIds
				},
				success : function(result) {
					$.messager.show({
						title : '提示',
						msg : result.msg
					});
					if (result.success) {
						$('#data-list').datagrid('reload');
					}
				}
			});
		}
	});
}

function getReason(){
	var reasonSelect = $('#reasonSelect').val();
	$('#reason').val(reasonSelect);
	$('#reasonSelect').val('');
}

function handle(rows){
    $("#reasonSelect").removeAttr("disabled");  
	$('#reason').attr("disabled",false);
	$('#pass').show();
	$('#reject').show();
	$('#plateNo').html(rows[0].plateNo);
	var plateColor = sys.dicts.text('PLATE_COLOR',rows[0].plateColor);
	var color = 'white';
    switch (plateColor)
    {
        case '蓝':
            color = '#0290e6';
            break;
        case '黄':
            color = '#fce609';
            break;
        case '黑':
            color = 'black';
            break;
    }
	$('#plateColor').html(plateColor+'<div style="float:left; display:inline;width: 32px;height: 18px;background-color: '+color+';margin-right:10px"></div>');
	$('#reason').val('');
	if(rows[0].reviewStatus=='0'){
		 $.messager.alert('提示','请先受理~');  
		 return;
	}
	if(rows[0].reviewStatus=='2'){
		$('#reason').val(rows[0].passReason);
		$("#reasonSelect").attr("disabled",true);
		$('#reason').attr("disabled",true);
		$('#pass').hide();
		$('#reject').hide();
	}
	if(rows[0].reviewStatus=='3'){
		$('#reason').val(rows[0].rejectReason);
		$("#reasonSelect").attr("disabled",true);
		$('#reason').attr("disabled",true);
		$('#pass').hide();
		$('#reject').hide();
	}
	$('#handle').dialog("open");
	loadPhoto(rows);
}

function loadPhoto(rows){
	//照片正页
	var licensePhoto = rows[0].licensePhoto;
	//照片副页
	var licensePhotoVice = rows[0].licensePhotoVice;
	//照片数组
	var photoUrls = [];
	if(licensePhoto!=null&&licensePhoto!=''&&licensePhoto!=undefined){
		photoUrls.push(licensePhoto);
	}
	if(licensePhotoVice!=null&&licensePhotoVice!=''&&licensePhotoVice!=undefined){
		photoUrls.push(licensePhotoVice);
	}
	if(photoUrls.length!=0){
		var ul=document.getElementById('ulClass');
		var lis=document.querySelectorAll("#ulClass li");
		var len=lis.length;
		if(len!=0){
			for (var j=0;j<len;j++){
			   ul.removeChild(lis[j]);
			}
		}
		for(var i=1;i<=photoUrls.length;i++){
			addElementLi('ulClass',photoUrls[i-1],i);
		}
	}else{
		var ul=document.getElementById('ulClass');
		//添加 li
		var li = document.createElement("li");
		li.setAttribute("align", "center");
		li.innerHTML = "<p>该条记录没有照片</p>";
		ul.appendChild(li);
	}
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

$('#pass').bind('click',function(){
	var passType = 1;
	var rows = $('#data-list').datagrid('getChecked');
	//通过原因
	var passReason = $('#reason').val();
	$.messager.confirm('提示', '确定通过？', function(r) {
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
					id : rows[0].id,
					plateNo : rows[0].plateNo,
					plateColor : rows[0].plateColor,
					passReason : passReason,
					type : passType
				},
				success : function(result) {
					if(result.success){
						$.messager.show({
							msg : result.msg,
							title : '提示'
						});
						$('#data-list').datagrid('reload');
	   					$('#handle').dialog('close');
   					}else{
   						$.messager.alert('提示',result.msg,'info');
   					}
   					$.messager.progress('close');
				}
			});
		}
	});
});

$('#reject').bind('click',function(){
	var rejectType = 2;
	var rows = $('#data-list').datagrid('getChecked');
	//驳回原因
	var rejectReason = $('#reason').val();
	if(rejectReason==null||rejectReason==''||rejectReason==undefined){
		$.messager.show({
			msg : '驳回原因不能为空',
			title : '提示'
		});
		return;
	}
	$.messager.confirm('提示', '确定驳回？', function(r) {
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
   					id : rows[0].id,
   					rejectReason : rejectReason,
   					type : rejectType
   				},
   				success : function(result) {
   					if(result.success){
						$.messager.show({
							msg : result.msg,
							title : '提示'
						});
						$('#data-list').datagrid('reload');
	   					$('#handle').dialog('close');
   					}else{
   						$.messager.alert('提示',result.msg,'info');
   					}
   					$.messager.progress('close');
   				}
			});
		}
	 });
});

$(function(){
	app.reviewLog.init();
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

