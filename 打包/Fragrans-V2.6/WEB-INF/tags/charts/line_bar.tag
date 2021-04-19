<%@ tag pageEncoding="UTF-8" isELIgnored="false" body-content="empty"%>
<%--自定义div容器id--%>
<%@attribute name="id" required="true" %>
<%--自定义标题--%>
<%@attribute name="title" required="true" %>
<%--图表的长和宽--%>
<%@attribute name="height" required="true" %>
<%@attribute name="width" required="true" %>
<%--自定义子标题--%>
<%@attribute name="subtitle" required="false" %>
<%--自定义数据请求url--%>
<%@attribute name="urls" required="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="${id}" align="center" style="height: ${height};width:${width}"></div>

<script type="text/javascript">
    // 基于准备好的dom，初始化echarts图表
    var ${id} = echarts.init(document.getElementById('${id}'));

    //采用ajax异步请求数据
    $.ajax({
    	async:false,
        type:'post',
        url:'<%=request.getContextPath()%>${urls}',
            dataType:'json',
            success:function(result){
                if(result){
                    ${id}.hideLoading();
                    ${id}.setOption({
                        title : {
                            text: '${title}',
                            subtext: '${subtitle}'
                        },
                        tooltip : {
                            trigger: 'axis'
                        },
                        legend: {
                            data:result.legend
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
                        xAxis : [
                            {
                                type : 'category',
                                boundaryGap : true,
                                data :result.axis
                            }
                        ],
                        yAxis : [
                            {
                                type : 'value',
                                axisLabel : {
                                    formatter: '{value} '
                                }
                            }
                        ]
                    });
                    if(result.series.type=='line'){
                        xAxis.boundaryGap==false;
                    }
        
                    ${id}.setSeries(result.series);
                }
             },
            error:function(errMsg){
                console.error("加载数据失败")
            }
    });

    // 为echarts对象加载数据
   // myChart.setOption(option);
</script>
