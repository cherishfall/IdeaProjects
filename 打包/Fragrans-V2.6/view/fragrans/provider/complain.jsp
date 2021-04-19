<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
<script type="text/javascript" src="<%=basePath%>/assets/js/commons/datagrid-detailview.js"></script>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:62px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
				<label class="ui-label">区域名称:</label><input id="cityCode" name="cityId" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
				<label class="ui-label">用户账号:</label><input name="userAccount" class="easyui-box ui-text" style="width:100px;">
				<label class="ui-label">车牌号:</label><input name="palteNo" class="easyui-box ui-text" style="width:80px;">
				<label class="ui-label">停车记录id:</label><input name="parkrecordId" class="easyui-box ui-text" style="width:80px;">
				<label class="ui-label">处理状态:</label><mytag:dictionary codeType="COMPLAIN_STATUS" id="complainStatus" name="status" isDefaultLine='1' dataOptions="required:false" style="width:100px;"/>  
				<label class="ui-label">退款状态:</label><mytag:dictionary codeType="REFUND_STATUS" id="complainRefundFlag" name="refundFlag" isDefaultLine='1' dataOptions="required:false" style="width:100px;"/>
        </p>
        <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search">查询</a>
        <a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
      </form>  
     </div> 
     <!--  Search panel end -->
	 <!-- DataList  -->
     <div region="center" border="false" >
     <table id="data-list"></table>
     </div>

	<!-- detail -->
	<div id="detail" class="easyui-dialog" title="停车记录详情"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 800px; height: 400px;">
	</div>
	
	<div id="updateRefundStatus" class="easyui-dialog" title="更改申诉退款状态"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 250px;">
		<div style="">
		<form id="updateRefundStatusForm" class="ui-form" method="post">
		<table cellpadding="5px;" style="position:relative;left:30px;top:30px">
			<tr>
			  <td style="text-align: right;">退款处理状态:</td>
			  <td><select class="selector" id="refundFlag" name="refundFlag">
   					<option value="1" selected="selected">无退款</option>
   					<option value="2">需要退款</option>
 				  </select></td>
			</tr>
		</table>
		</form>
		</div>
		<div style="width:100px;float:left;position: relative;top:110px;left:70px;">
			<a id="refundConfirm" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="margin:0 auto;">确定</a>  
		</div> 
        <div style="width:100px;float:left;position: relative;top:110px;left:80px;"">
			<a id="refundClose" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'">关闭</a>  
		</div>
		
	</div>
	
	<div id="exportOrderComplain" class="easyui-dialog" title="导出申诉表"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 260px;" singleSelect:false>
		<form id="exportOrderComplainForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem">
				<div style="padding:5px;">
				<label class="ui-label">城市名称:</label><input id="exp_cityCode" name="cityCode" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" />
				<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png" onclick="$('#exp_cityCode').combotree('clear');" />
				</div>
				<div style="padding:5px;">
				<label class="ui-label">处理状态:</label>
				<mytag:dictionary name="status" id="status" codeType="COMPLAIN_STATUS" dataOptions="required:false"/>
				<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png" onclick="$('#status').combobox('clear');" />
				</div>
				<div style="padding:5px;">
					<label>开始日期:</label> 
					<input id="startDate" name="startDate" class="easyui-datebox" data-options="width:150" />
				</div>
				<div style="padding:5px;">
					<label>结束日期:</label> 
					<input id="endDate" name="endDate" class="easyui-datebox" data-options="width:150" />
				</div>	
				</div>
			</div>
		</form>
	</div>
	
	<!-- detail -->
	<div id="detail" class="easyui-dialog" title="停车记录详情"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 800px; height: 400px;">
	</div>
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/provider/complain.js"></script>
</body>
</html>
