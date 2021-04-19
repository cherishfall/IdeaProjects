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

<%--自定义数据请求url--%>
<%@attribute name="urls" required="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="${id}" style="height: ${height};width:${width}" ></div>

<script type="text/javascript">
    // 基于准备好的dom，初始化echarts图表
    <%--var ${id} = echarts.init(document.getElementById('${id}'));--%>
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
            'echarts/chart/pie',
            'echarts/chart/funnel',
            'echarts/chart/line'
        ],
        function (ec) {
            var option_${id} = {
                title : {
                    text: '${title}',
                    subtext: '${subtitle}',
                    x:'center'
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
//                legend: {
//                    x : 'center',
//                    y : 'bottom',
//                    padding:[50,0,0,0],
//                    data:[''],
//                },
//                toolbox: {
//                    show : true,
//                    orient:'vertical',
//                    x : 'left',
//                    y : 'top',
//                    padding:[50,0,0,50],
//                    feature : {
//                        mark : {show: false},
//                        dataView : {show: false, readOnly: false},
//                        magicType : {
//                            show: true,
//                            type: ['pie', 'funnel'],
//                            option: {
//                                funnel: {
//                                    x: '20%',
//                                    width: '50%',
//                                    funnelAlign: 'center',
//                                    max: 1548
//                                }
//                            }
//                        },
//                        restore : {show: false},
//                        saveAsImage : {show: false}
//                    }
//                },
                calculable : false,
                series : ['']
            };

            var myChart_${id} = ec.init(document.getElementById('${id}'));
           //采用ajax异步请求数据
            $.ajax({
                type:'post',
                url:'<%=request.getContextPath()%>${urls}',
                dataType:'json',
                success:function(result){
        //             console.log("pie图像");
        //             console.log(result);
                    if(result){
                        //将返回的category和series对象赋值给options对象内的category和series
                        <%--option_${id}.legend.data = result.legend;--%>
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

//    myChart.setOption(option);
</script>
