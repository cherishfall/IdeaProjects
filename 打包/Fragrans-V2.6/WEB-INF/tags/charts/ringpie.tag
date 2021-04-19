<%@ tag pageEncoding="UTF-8" isELIgnored="false" body-content="empty"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>
<%--自定义div容器id--%>
<%@attribute name="id" required="true" %>
<%--自定义标题--%>
<%@attribute name="title" required="true" %>
<%--自定义子标题--%>
<%@attribute name="subtitle" required="false" %>
<%--图表容器的高度和宽度--%>
<%@attribute name="height" required="true" %>
<%@attribute name="width" required="true" %>
<%--是否显示标题栏目--%>
<%@attribute name="displaytitle" required="false" %>
<%--是否显示内园饼上的文字--%>
<%@attribute name="displaylabel" required="true" %>

<%--自定义数据请求url--%>
<%@attribute name="urls" required="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="${id}" style="height: ${height};width:${width}" ></div>
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
            'echarts/chart/bar',
            'echarts/chart/funnel',
            'echarts/chart/pie'
        ],
        function (ec) {
          var option_${id} = {
        		  title : {
      		        text: '${title}',
      		        subtext: '',
      		        x:'center'
      		    },
      		  legend: {
   	           orient : 'horizontal',
   	           x : 'center',
   	           y:'bottom',
//    	           padding:[80,0,0,50],
   	           data:['']
   	    },
        		    tooltip : {
						trigger: 'item',
						formatter: "{a} <br/>{b} : {c} ({d}%)"
					},
					
					toolbox: {
						show : false,
						padding:[80,50,0,0],
						orient : 'vertical',
						feature : {
							mark : {show: false},
							dataView : {show: false, readOnly: false},
							magicType : {
								show: true, 
								type: ['pie', 'funnel']
							},
							restore : {show: false},
							saveAsImage : {show: true}
						} 					 
					},
					calculable : false,
					series : [
						{
							itemStyle : {
								normal : {
									label : {
										show : <%=displaylabel%>,
										position : 'inner'
									},
									labelLine : {
										show : false
									}
								}
							} 
						} 
					]
				};
				//--- 折柱 ---
				var myChart_${id} = ec.init(document.getElementById('${id}'));	
				 //采用ajax异步请求数据
			    $.ajax({
			        type:'post',
			        url:'<%=request.getContextPath()%>${urls}',
			        dataType:'json',
			        success:function(result){
			            if(result){
			                //将返回的category和series对象赋值给options对象内的category和series
			                option_${id}.legend.data = result.legend[0].data;
// 			                option_${id}.legend.x = result.legend[0].x;
// 			                option_${id}.legend.y = result.legend[0].y;
			                
			                option_${id}.series=result.pieSeries;
			                myChart_${id}.hideLoading();
			                myChart_${id}.setOption(option_${id});
			            }
			        },
			        error:function(errMsg){
			            console.error("加载数据失败")
			        }
			    });
				myChart_${id}.setOption(option_${id});
			}
		);
    </script>
