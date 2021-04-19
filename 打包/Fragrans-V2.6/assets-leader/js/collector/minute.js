//统计图
require.config({
	  paths: {
	    echarts: 'http://echarts.baidu.com/build/dist'
	  }
	});

	// 使用
	require(
	  [
	    'echarts',
	    'echarts/chart/line', // 使用柱状图就加载bar模块，按需加载
	  ],
	  function (ec) {
	    // 基于准备好的dom，初始化echarts图表
	    var myChart = ec.init(document.getElementById('chart')); 
	    //设置数据
	    var option = {
	    	    legend: {
	    	        data:['高度(km)与气温(°C)变化关系']
	    	    },
	    	    toolbox: {
	    	        show : true,
	    	        feature : {
	    	            mark : {show: true},
	    	            dataView : {show: true, readOnly: false},
	    	            magicType : {show: true, type: ['line', 'bar']},
	    	            restore : {show: true},
	    	            saveAsImage : {show: true}
	    	        }
	    	    },
	    	    calculable : true,
	    	    tooltip : {
	    	        trigger: 'axis',
	    	        formatter: "Temperature : <br/>{b}km : {c}°C"
	    	    },
	    	    xAxis : [
	    	        {
	    	            type : 'value',
	    	            axisLabel : {
	    	                formatter: '{value} °C'
	    	            }
	    	        }
	    	    ],
	    	    yAxis : [
	    	        {
	    	            type : 'category',
	    	            axisLine : {onZero: false},
	    	            axisLabel : {
	    	                formatter: '{value} km'
	    	            },
	    	            boundaryGap : false,
	    	            data : ['0', '10', '20', '30', '40', '50', '60', '70', '80']
	    	        }
	    	    ],
	    	    series : [
	    	        {
	    	            name:'高度(km)与气温(°C)变化关系',
	    	            type:'line',
	    	            smooth:true,
	    	            itemStyle: {
	    	                normal: {
	    	                    lineStyle: {
	    	                        shadowColor : 'rgba(0,0,0,0.4)'
	    	                    }
	    	                }
	    	            },
	    	            data:[15, -50, -56.5, -46.5, -22.1, -2.5, -27.7, -55.7, -76.5]
	    	        }
	    	    ]
	    	};

	    // 为echarts对象加载数据 
	    myChart.setOption(option); 
	  }
	);