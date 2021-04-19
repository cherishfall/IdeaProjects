<%@ tag pageEncoding="UTF-8" isELIgnored="false" body-content="empty"%>
<!--标签 id -->
<%@ attribute name="id" required="true"%>
<!--标签name -->
<%@ attribute name="name" required="true"%>
<!--是否自适应高度 -->
<%@ attribute name="isAutoHeight" required="false"%>
<!--是否有默认横线 -->
<%@ attribute name="isDefaultLine" required="false"%>
<!--easyui 数据选项-->
<%@ attribute name="dataOptions" required="false"%>
<!-- berthId -->
<%@ attribute name="berthId" required="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:if test="${isAutoHeight == null}">
    <c:set var="isAutoHeight" value="200" />
</c:if>
<c:if test="${dataOptions == null}">
    <c:set var="dataOptions" value="required:true" />
</c:if>
<script type="text/javascript">
    $(function(){
            $('#${id}').combobox({
                title: '部门',
                url: '<%=request.getContextPath()%>/tag/getFlowPark.do',
                fit: true,
                valueField:'id',
                textField:'text'
            });
    })
</script>

<input id="${id}" name="${name}" valueField="id" textField="parkName"
       class="easyui-combobox" panelHeight="${isAutoHeight}"
       data-options="${dataOptions},editable:false">







