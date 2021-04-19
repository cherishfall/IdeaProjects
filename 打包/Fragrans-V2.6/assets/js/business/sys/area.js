var globLon="";
var globLat="";
$(function(){
	var toolbar = [
	   			{id:'btnadd',text:'添加',btnType:'add',
					iconCls : 'icon-add',
					handler : function() {
						add();
					}},
				{id:'btnedit',text:'修改',btnType:'edit',iconCls : 'icon-edit',
						handler : function() {
							var node = $('#data-list').treegrid('getSelected');
							
							edit(node);
						}},
				{id:'btndelete',text:'删除',btnType:'remove',iconCls : 'icon-remove',
							handler : function() {
								$.messager.confirm('确认', '确认删除？', function(r) {
									if(r){
								var node = $('#data-list').treegrid('getSelected');
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
								})
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
		treeField : 'areaName',
		parentField : 'parentId',
		border : false,
		columns:[[
		        {field:'id',hidden:true},
				{field:'areaName',title:'区域名称'},
				{field:'areaCode',title:'区域代码'},
				{field:'areaLevel',title:'区域等级',formatter : function(value, row, index) {
					if (value == 0) {
						return "根节点";
					}
					if (value == 1) {
						return "省";
					}
					if (value == 2) {
						return "地市";
					}
					if (value == 3) {
						return "区县";
					}
				}},
				{field:'gatewayUrl',title:'网关地址'},
				{field:'longitudeGaode',title:'高德中心点经度'},
				{field:'latitudeGaode',title:'高德中心点纬度'},
				{field:'longitudeBaidu',title:'百度中心点经度'},
				{field:'latitudeBaidu',title:'百度中心点纬度'},
				{field:'displayNo',title:'排序号'},
				{field:'isSupportPay',title:'是否支持支付',formatter : sys.dicts.text('YESORNO')},
				{field:'isBatchpay',title:'是否支持批量缴费',formatter : sys.dicts.text('YESORNO')},
				{field:'isDeleteParkrecord',title:'是否支持批量删除',formatter : sys.dicts.text('YESORNO')},
				{field:'isMemberCardPay',title:'是否支持会员卡支付',formatter : sys.dicts.text('YESORNO')},
				{field:'isSupportAccount',title:'是否支持对账',formatter : sys.dicts.text('YESORNO')},
				{field:'isOnline',title:'是否上线',formatter : sys.dicts.text('IS_ONLINE')},
				{field:'citySpell',title:'城市拼音'}
	 	]],
		toolbar:toolbar
	});
	//地图框
	$('#map').dialog({
		title : '点击选择坐标',
		buttons : [{
			text : '确认选点',
			iconCls : 'icon-ok',
			handler : function(){
				$('#longitudeBaidu').val(globLon);
				$('#latitudeBaidu').val(globLat);
				$('#map').dialog('close');
			}
		},{
			text : '关闭',
			iconCls : 'icon-remove',
			handler : function(){
				$('#map').dialog('close');
			}
		}]
	})
	//初始化权限按钮
	initTbar($('#data-list'),toolbar,basePath+'/area/list.action');
},
$('#edit-win').dialog({
	buttons:[
		{
			text:'保存',
			iconCls:'icon-save',
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
						if(mes.success){
							$('#edit-win').dialog('close');
							$('#data-list').treegrid('reload');
						}
					}
				});
			}
		},{
			text:'关闭',
			iconCls:'ext-icon-application_close',
			handler:function(){
				$('#edit-win').dialog('close');
			}
		}
	]
}),
$('#regionTree').combotree({
	title:'列表',
	url:'getAreaTree.do',
	fit : true,
	idField : 'id',
	panelHeight : '200',
	treeField : 'areaName',
	parentField : 'parentId',
})
);
function add(){
	$('#editShowOnly').hide();
	$('#regionTree').combotree('reload');
	$('#edit-win').dialog('open');
	$('#editForm').form('clear');
	
	//获取 datagrid 当前选择的行
	var node = $('#data-list').treegrid('getSelected');
	if(node!=null){
		 //默认选择gridtree
		$('#regionTree').combotree('setValue', node.id);
	}
	
}

function edit(node){
	if(node){
		console.log(node);
		if(node.areaLevel == null ){
			$.messager.show({
				title : '提示',
				msg : '顶级节点不允许修改'
			});
			return;
		}
		$('#editShowOnly').show();
		$('#edit-win').dialog('open');
		$('#editForm').form('load',node);
	}else{
		$.messager.show({
			title : '提示',
			msg : '请选择一条记录'
		});
	}
}



function openMap(longitudeCity,latitudeCity){
	$('#map').dialog('open');
	var map = new BMap.Map("allMap");
	
	globLon = $('#longitudeBaidu').val();
	globLat = $('#latitudeBaidu').val();
	var defaultPoint = new BMap.Point(120.162145,30.279001);
	if(globLon != '' || globLat != ''){
		longitudeCity = globLon;
		latitudeCity = globLat;
		defaultPoint = new BMap.Point(globLon,globLat);
	} 
	map.centerAndZoom(defaultPoint, 15);  // 初始化地图,设置中心点坐标和地图级别
	var marker = new BMap.Marker(defaultPoint);
	map.addOverlay(marker);
	
	map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
	map.enableContinuousZoom(); 
	
	var gc = new BMap.Geocoder();
	gc.getLocation(defaultPoint, function(rs) {
		var addComp = rs.addressComponents;
		var lc = addComp.province + " " + addComp.city
				+ " " + addComp.district + " "
				+ addComp.street + " "
				+ addComp.streetNumber;
		var infoWindow = new BMap.InfoWindow(
				"<p><b>经度：</b> " + defaultPoint.lng
						+ "　　<b>纬度：</b> " + defaultPoint.lat
						+ "</p><p><b>位置：</b> " + lc
						+ "</p>", {
					title : '当前位置信息',
					height : 80,
					width : 230
				});
		marker.addEventListener("click", function() {
			this.openInfoWindow(infoWindow);
		});
		marker.openInfoWindow(infoWindow);
	});
	
	
	var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
	var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
	
	map.addControl(top_left_control);        
	map.addControl(top_left_navigation); 
	//点击事件
	map.addEventListener("click",function(e){
		map.clearOverlays();
		globLon = e.point.lng;
		globLat = e.point.lat;
//		var marker = new BMap.Marker(new BMap.Point(globLon,globLat));
//		map.addOverlay(marker);
		
//		var marker = new BMap.Marker();
		var point = new BMap.Point(globLon, globLat);
		
		map.centerAndZoom(point, 15);
		var marker = new BMap.Marker(point, {
			icon : null
		});
		map.addOverlay(marker);
		
		var gc = new BMap.Geocoder();
		gc.getLocation(point, function(rs) {
			var addComp = rs.addressComponents;
			var lc = addComp.province + " " + addComp.city
					+ " " + addComp.district + " "
					+ addComp.street + " "
					+ addComp.streetNumber;
			var infoWindow = new BMap.InfoWindow(
					"<p><b>经度：</b> " + point.lng
							+ "　　<b>纬度：</b> " + point.lat
							+ "</p><p><b>位置：</b> " + lc
							+ "</p>", {
						title : '当前位置信息',
						height : 80,
						width : 230
					});
			marker.addEventListener("click", function() {
				this.openInfoWindow(infoWindow);
			});
			marker.openInfoWindow(infoWindow);
		});
		
		
		
	});
}