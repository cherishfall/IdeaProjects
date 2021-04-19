<%@ tag pageEncoding="UTF-8" isELIgnored="false" body-content="empty"%>
<%
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath();
%>
<%--自定义div容器id--%>
<%@attribute name="id" required="true"%>
<%--自定义标题--%>
<%@attribute name="title" required="true"%>
<%--图表的长和宽--%>
<%@attribute name="height" required="true"%>
<%@attribute name="width" required="true"%>
<%--自定义子标题--%>
<%@attribute name="subtitle" required="false"%>
<%--自定义数据请求url--%>
<%@attribute name="urls" required="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="${id}" align="center" style="height: ${height};width:${width}"></div>
<!--Step:1 Prepare a dom for ECharts which (must) has size (width & hight)-->
<!--Step:1 为ECharts准备一个具备大小（宽高）的Dom-->
<!--Step:2 Import echarts.js-->
<!--Step:2 引入echarts.js-->
<script type="text/javascript">
	// Step:3 conifg ECharts's path, link to echarts.js from current page.
    // Step:3 为模块加载器配置echarts的路径，从当前页面链接到echarts.js，定义所需图表路径
    require.config({
        paths: {
            echarts: '<%=basePath%>/assets/js/echarts-2.1.8/build/dist/'
        }
    });
    // Step:4 require echarts and use it in the callback.
    // Step:4 动态加载echarts然后在回调函数中开始使用，注意保持按需加载结构定义图表路径
    require(
        [
            'echarts',
            'echarts/theme/macarons',
            'echarts/chart/bar',
            'echarts/chart/funnel',
            'echarts/chart/pie'
        ],
        function (ec,theme) {
			//--- 折柱 ---
			var myChart_${id} = ec.init(document.getElementById('${id}'),theme);	
			 //采用ajax异步请求数据
		    $.ajax({
		        type:'post',
		        url:'<%=request.getContextPath()%>${urls}',
		        dataType:'json',
		        success:function(result){
	            if(result){
            	var option_${id} = {
        		    title : {
        		        text: '${title}',
        		        subtext: '',
        		        x:'center',
        		        textStyle:{
	      		       		fontSize: 18,
	      		          	fontWeight: 'bolder',
	      		          	color: '#333'
      		       		}
        		    },
        	        tooltip : {
				        trigger: 'axis'
				    },
				    toolbox: {
				        show : true,
				        x : 'left',
						y : 'center',
						orient:'vertical',
				        feature : {
				            mark : {show: false},
				            dataView : {show: false, readOnly: false},
				            magicType : {show: false, type: ['line', 'bar', 'stack', 'tiled']},
				            restore : {show: true},
				            saveAsImage : {show: true}
				        }
				    },
				    calculable : false,
				    legend: {
				    	x : 'center',
						y : 'bottom',
				        data:result.legend[0][0].data,
				        selected : {//写result.legend[0][0].data[4]时,js报错
				        	'支付金额(元)':false
				        }
				    },
				    xAxis : [
				        {
				            type : 'category',
				            splitLine : {show : false},
				            data : result.legend[1][0].data
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value',
				            position: 'right'
				        }
				    ],
				    series : [
				        {
				            name:result.series[0].name,
				            type:'bar',
				            data:result.series[0].data
				        },
				        {
				            name:result.series[10].name,
				            type:'bar',
				            data:result.series[10].data
				        },
				        {
				            name:result.series[1].name,
				            type:'bar',
				            tooltip : {trigger: 'item'},
				            stack: '支付次数',
				            data:result.series[1].data
				        },
				        {
				            name:result.series[2].name,
				            type:'bar',
				            tooltip : {trigger: 'item'},
				            stack: '支付次数',
				            data:result.series[2].data
				        },
				        {
				            name:result.series[3].name,
				            type:'bar',
				            tooltip : {trigger: 'item'},
				            stack: '支付次数',
				            data:result.series[3].data
				        },
				        {
				            name:result.series[4].name,
				            type:'bar',
				            tooltip : {trigger: 'item'},
				            stack: '支付次数',
				            data:result.series[4].data
				        },
				        {
				            name:result.series[5].name,
				            type:'line',
				            data:result.series[5].data
				        },
				
				        {
				            name:'支付笔数细分',
				            type:'pie',
				            tooltip : {
				                trigger: 'item',
				                formatter: '{a} <br/>{b} : {c} ({d}%)'
				            },
				            center: [160,130],
				            radius : [0, 50],
				            itemStyle :　{
				                normal : {
				                    labelLine : {
				                        length : 20
				                    }
				                }
				            },
				            data:[
				                {value:result.series[6].data[0], name:result.series[6].name},
				                {value:result.series[7].data[0], name:result.series[7].name},
				                {value:result.series[8].data[0], name:result.series[8].name},
				                {value:result.series[9].data[0], name:result.series[9].name}
				            ]
				        }
				    ]
				};
				myChart_${id}.setOption(option_${id});
            }
        },
        error:function(errMsg){
            console.error("加载数据失败");
        }
    });
	}
);
</script>
