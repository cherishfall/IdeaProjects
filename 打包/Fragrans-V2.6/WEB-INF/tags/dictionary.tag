<%@tag pageEncoding="UTF-8" isELIgnored="false" body-content="empty"%>
<!--标签 id -->
<%@ attribute name="id" required="true"%>
<!--标签name -->
<%@ attribute name="name" required="true"%>
<!--数据字典信息类型 -->
<%@ attribute name="codeType" required="true"%>
<!--是否有默认横线 -->
<%@ attribute name="isDefaultLine" required="false"%>
<!--是否自适应高度 -->
<%@ attribute name="isAutoHeight" required="false"%>
<!--是否可编辑 -->
<%@ attribute name="isEditable" required="false"%>
<!--是否可编辑 -->
<%@ attribute name="defaultValue" required="false"%>
<!--是否可编辑 -->
<%@ attribute name="isDisabled" required="false"%>
<!--样式 -->
<%@ attribute name="style" required="false"%>
<!--easyui 数据选项-->
<%@ attribute name="dataOptions" required="false"%>
<!--是否通用-->
<%@ attribute name="isCommon" required="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${isDefaultLine == null}" >
	<c:set var="isDefaultLine" value="0"/>
</c:if>

<c:if test="${isAutoHeight == null}" >
	<c:set var="isAutoHeight" value="auto"/>
</c:if>

<c:if test="${isEditable == null}" >
	<c:set var="isEditable" value="false"/>
</c:if>

<c:if test="${isDisabled == null}" >
	<c:set var="isDisabled" value="false"/>
</c:if>

<c:if test="${style == null}" >
	<c:set var="style" value=""/>
</c:if>
<c:if test="${isCommon == null}" >
	<c:set var="isCommon" value="1"/>
</c:if>

<c:if test="${dataOptions == null}" >
	<c:set var="dataOptions" value="required:true"/>
</c:if>

<input id="${id}" name="${name}" style="${style}" valueField="codeValue" textField="codeText"  value="${defaultValue}"
		class="easyui-combobox" panelHeight="${isAutoHeight}"
	    url="<%=request.getContextPath()%>/tag/getDictionaryItems.do?codeType=${codeType}&isDefaultLine=${isDefaultLine}&isCommon=${isCommon}" 
	    data-options="${dataOptions}" editable="${isEditable}" ${isDisabled ? 'disabled' : ''}>
    