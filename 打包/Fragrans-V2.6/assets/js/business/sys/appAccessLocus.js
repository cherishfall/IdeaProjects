$(function() {

	$("div #step-1").css("display", "block");
	curStep = $("li a[class='selected']");
	var href = curStep.attr("href");
	var curDiv = $("href");

	$("ul li a").bind("click", function() {
		if ($(this).attr("isdone") == "1") {
			curStep.attr("class", "done");
			curDiv.css('display', 'none');
			$(this).attr("class", "selected");
			Div = $($(this).attr("href"));
			Div.css('display', 'block');
			curStep = $(this);
			curDiv = Div;
		}
	})

	$("li a[href='#step-1']").trigger("click");
	$('#startTime').datebox('setValue', getNowDay());
	$('#endTime').datebox('setValue', getNowDay());
	$('#appVersion').combobox({
		url : 'queryAppVersion.do',
		valueField : 'value',
		textField : 'text',
		onLoadSuccess : function() { // 加载完成后,设置选中第一项
			var val = $(this).combobox("getData");
			$(this).combobox("setValue", val[0].value);
		}

	});
	// alert(defaultAppVersion);
	require.config({
		paths : {
			echarts : 'http://echarts.baidu.com/build/dist'
		}
	});
	require([ 'echarts', 'echarts/chart/pie' // 按需加载所需图表，如需动态类型切换功能，别忘了同时加载相应图表

	], function(ec) {
		myChart1 = ec.init(document.getElementById('step-1'));
		myChart2 = ec.init(document.getElementById('step-2'));
		myChart3 = ec.init(document.getElementById('step-3'));
		myChart4 = ec.init(document.getElementById('step-4'));
		myChart5 = ec.init(document.getElementById('step-5'));
		myChart6 = ec.init(document.getElementById('step-6'));
	});

	option = {
		title : {
			text : 'App用户访问轨迹统计',
			x : 'center'
		},
		tooltip : {
			trigger : 'item',
			formatter : "{a} <br/>{b} : {c} ({d}%)"
		},
		legend : {
			orient : 'vertical',
			x : 'left',
			data : []
		},
		toolbox : {
			feature : {
				mark : {
					show : true
				},
				dataView : {
					show : true,
					readOnly : false
				},
				magicType : {
					show : true,
					type : [ 'pie', 'funnel' ],
					option : {
						funnel : {
							x : '25%',
							width : '50%',
							funnelAlign : 'left',
							max : 1548
						}
					}
				},
				restore : {
					show : true
				},
				saveAsImage : {
					show : true
				}
			}
		},
		calculable : true,
		series : [ {
			name : '访问轨迹',
			type : 'pie',
			radius : '50%',
			center : [ '50%', '60%' ],
			data : [],
			itemStyle : {
				normal : {
					label : {
						show : true,
						formatter : '{b} : {c} ({d}%)'
					},
					labelLine : {
						show : true
					}
				}
			}

		} ]
	};
	var startTime = $('#startTime').datebox('getValue');
	var endTime = $('#endTime').datebox('getValue');
	var defaultAppVersion=2.5;
	var defaultResult;
	$.ajaxSetup({
		async : false
	// 同步执行
	});
	$.ajax({
		type : "post",
		url : "dataList.action",
		data : {
			startTime : startTime,
			endTime : endTime,
			appVersion : defaultAppVersion
		},
		dataType : "json", // 返回数据形式为json
		success : function(result) {
			defaultResult = result;
			console.log(data);
		},
		error : function(errorMsg) {
			alert("不好意思，大爷，图表请求数据失败啦!");
		}
	});

	var data;
	// 点击查询重新加载图表
	$("#btn-search").click(function() {
		$("ul li a").attr("isdone", 0);
		curStep = $("li a[href='#step-1']");
		$("ul li a").attr("class", "disabled");
		var Form = $("#searchForm");
		var param = Form.serializeObject();
		// app版本号请求值
		var val;
		$('#appVersion').combobox({
			onBeforeLoad : function(param) {
				val = $(this).combobox("getText");

			},

			onLoadSuccess : function() {
				$(this).combobox("setValue", val);
			}

		});
		var data;
		// 设置为同步传输
		$.ajaxSetup({
			async : false
		});
		
		$.ajax({
			type : "post",
			url : "dataList.action",
			data : {
				startTime : param.startTime,
				endTime : param.endTime,
				appVersion : val
			},

			dataType : "json", // 返回数据形式为json
			success : function(result) {
				$('#ztree').tree("collapseAll");
				option.legend.data = [];
				option.series[0].data = [];
				myChart1.setOption(option, true);
				myChart2.setOption(option, true);
				myChart3.setOption(option, true);
				myChart4.setOption(option, true);
				myChart5.setOption(option, true);
				myChart6.setOption(option, true);
				defaultResult = result;
				if (result.msg != null) {
					$.messager.show({
						msg : result.msg,
						title : '提示'
					});
				}
			}

		})

	})

	$("#btn-reset").click(function() {
		$("#searchForm input").val("");
	})

	$('#ztree').tree({
		url : '../appMenu/dataList.do',
		loadFilter : function(rows) {
			return convert(rows);
		}

	});
	$('#ztree')
			.tree(
					{
						onLoadSuccess : function(node, data) {
							$('#ztree').tree("collapseAll");
						},
						onClick : function(node) {
							$(this).tree('expand', node.target);
							var handleId = node.id;
							for (var i = 0; i < defaultResult.length; i++) {
								if (handleId == defaultResult[i].id) {
									// 根据id的长度显示在相应的div中
									if (handleId.length == 0) {
										option.legend.data = defaultResult[i].echartData.legend;
										option.series[0].data = defaultResult[i].echartData.series;
										myChart1.hideLoading();
										myChart1.setOption(option, true);
										$("li a[href='#step-1']").attr(
												"isdone", 1);
										$("li a[href='#step-1']").trigger(
												"click");
									}
									if (handleId.length == 1) {
										option.legend.data = defaultResult[i].echartData.legend;
										option.series[0].data = defaultResult[i].echartData.series;
										myChart2.hideLoading();
										myChart2.setOption(option, true);
										$("li a[href='#step-2']").attr(
												"isdone", "1");
										$("li a[href='#step-2']").trigger(
												"click");
									}
									if (handleId.length == 2) {
										option.legend.data = defaultResult[i].echartData.legend;
										option.series[0].data = defaultResult[i].echartData.series;
										myChart3.hideLoading();
										myChart3.setOption(option, true);
										$("li a[href='#step-3']").attr(
												"isdone", "1");
										$("li a[href='#step-3']").trigger(
												"click");
									}
									if (handleId.length == 3) {
										option.legend.data = defaultResult[i].echartData.legend;
										option.series[0].data = defaultResult[i].echartData.series;
										myChart4.hideLoading();
										myChart4.setOption(option, true);
										$("li a[href='#step-4']").attr(
												"isdone", "1");
										$("li a[href='#step-4']").trigger(
												"click");
									}
									if (handleId.length == 4) {
										option.legend.data = defaultResult[i].echartData.legend;
										option.series[0].data = defaultResult[i].echartData.series;
										myChart5.hideLoading();
										myChart5.setOption(option, true);
										$("li a[href='#step-5']").attr(
												"isdone", "1");
										$("li a[href='#step-5']").trigger(
												"click");
									}
									if (handleId.length == 5) {
										option.legend.data = defaultResult[i].echartData.legend;
										option.series[0].data = defaultResult[i].echartData.series;
										myChart6.hideLoading();
										myChart6.setOption(option, true);
										$("li a[href='#step-6']").attr(
												"isdone", "1");
										$("li a[href='#step-6']").trigger(
												"click");
									}
								}
							}
						},
						onExpand : function(node) {
							var handleId = node.id;

							for (var i = 0; i < defaultResult.length; i++) {
								if (handleId == defaultResult[i].id) {
									if (handleId.length == 0) {
										option.legend.data = defaultResult[i].echartData.legend;
										option.series[0].data = defaultResult[i].echartData.series;
										myChart1.hideLoading();
										myChart1.setOption(option, true);
										$("li a[href='#step-1']").attr(
												"isdone", 1);
										$("li a[href='#step-1']").trigger(
												"click");
									}
									if (handleId.length == 1) {
										option.legend.data = defaultResult[i].echartData.legend;
										option.series[0].data = defaultResult[i].echartData.series;
										myChart2.hideLoading();
										myChart2.setOption(option, true);
										$("li a[href='#step-2']").attr(
												"isdone", "1");
										$("li a[href='#step-2']").trigger(
												"click");
									}
									if (handleId.length == 2) {
										option.legend.data = defaultResult[i].echartData.legend;
										option.series[0].data = defaultResult[i].echartData.series;
										myChart3.hideLoading();
										myChart3.setOption(option, true);
										$("li a[href='#step-3']").attr(
												"isdone", "1");
										$("li a[href='#step-3']").trigger(
												"click");
									}
									if (handleId.length == 3) {
										option.legend.data = defaultResult[i].echartData.legend;
										option.series[0].data = defaultResult[i].echartData.series;
										myChart4.hideLoading();
										myChart4.setOption(option, true);
										$("li a[href='#step-4']").attr(
												"isdone", "1");
										$("li a[href='#step-4']").trigger(
												"click");
									}
									if (handleId.length == 4) {
										option.legend.data = defaultResult[i].echartData.legend;
										option.series[0].data = defaultResult[i].echartData.series;
										myChart5.hideLoading();
										myChart5.setOption(option, true);
										$("li a[href='#step-5']").attr(
												"isdone", "1");
										$("li a[href='#step-5']").trigger(
												"click");
									}
									if (handleId.length == 5) {
										option.legend.data = defaultResult[i].echartData.legend;
										option.series[0].data = defaultResult[i].echartData.series;
										myChart6.hideLoading();
										myChart6.setOption(option, true);
										$("li a[href='#step-6']").attr(
												"isdone", "1");
										$("li a[href='#step-6']").trigger(
												"click");
									}
								}
							}
						}
					});

})

function convert(rows) {
	function exists(rows, parentId) {
		for (var i = 0; i < rows.length; i++) {
			if (rows[i].id == parentId)
				return true;
		}
		return false;
	}

	var nodes = [];
	// get the top level nodes
	for (var i = 0; i < rows.length; i++) {
		var row = rows[i];
		if (!exists(rows, row.parentId)) {
			nodes.push({
				id : row.id,
				text : row.name
			});
		}
	}

	var toDo = [];
	for (var i = 0; i < nodes.length; i++) {
		toDo.push(nodes[i]);
	}
	while (toDo.length) {
		var node = toDo.shift(); // the parent node
		// get the children nodes
		for (var i = 0; i < rows.length; i++) {
			var row = rows[i];
			if (row.parentId == node.id) {
				var child = {
					id : row.id,
					text : row.name
				};
				if (node.children) {
					node.children.push(child);
				} else {
					node.children = [ child ];
				}
				toDo.push(child);
			}
		}
	}
	return nodes;

}