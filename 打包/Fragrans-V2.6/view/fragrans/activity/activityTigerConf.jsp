<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@include file="/view/inc.jsp" %>
	</head>
	<body class="easyui-layout">

	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 62px;"
		 title="过滤条件"
		 data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">活动标题:</label><input name="activityName" class="easyui-box ui-text" style="width: 100px;">
			</p>
			<a href="#" id="btn-search" class="easyui-linkbutton"
			   iconCls="icon-search">查询</a> <a href="#" id="btn-reset"
											   class="easyui-linkbutton" onclick="$('#searchForm').form('clear');"
											   style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
		</form>
	</div>
	<!--  Search panel end -->
	<!-- DataList  -->
	<div region="center" border="false" >
		<table id="data-list"></table>
	</div>

	<!-- 添加 -->
	<div id="edit-Tiger" class="easyui-dialog" title="活动触发" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:400px;height:240px;">  
		<form id="editTigerForm" class="ui-form" method="post">  
			<input class="hidden" type="text" name="id">
			<table cellpadding="5px;">	
				<tr>
					<td style="text-align: right;">关联活动:</td>
					<td>
						<input class="easyui-validatebox" type="text" id="activityId" name="activityId"
		                		    data-options="required:false,validType:'length[1,36]'" style="width:200px;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;"> 触发类型:</td>
					<td style="text-align: left;">
						<input name="tigerType" type="radio" value="1" checked="checked" onclick="show()"/>随机策略
						<input name="tigerType" type="radio" value="2"  onclick="hid()"/>订单限制策略
					</td>					 
				</tr>
				<tr>
				   	<td style="text-align: right;">
						<div id="tickAdd" style="height:25px;width:110px;text-align: right;">
							触发生成总张数:
						</div>
					</td>
					<td>
						<div id="ticketCountDivAdd" style="height:25px;width:150px;margin:0;padding:0;">
							<input class="easyui-numberbox" type="text" id="ticketCountAdd" name="ticketCount" missingMessage="请输入触发生成总张数"
			                		    data-options="required:false,validType:'length[1,10]',min:1" style="width:150px;"/>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div> 
  	 
	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="活动触发条件配置" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:400px;height:240px;">  
		<form id="editForm" class="ui-form" method="post">  
			<input class="hidden" type="text" name="id">
     		
			<table cellpadding="5px;">	
				<tr>
					<td style="text-align: right;">关联活动:</td>
					<td>
						<p id="activityName"></p>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;"> 触发类型:</td>
					<td style="text-align: left;">
						<input name="tigerType" type="radio" value="1" checked="checked" onclick="show()"/>随机策略
						<input name="tigerType" type="radio" value="2"  onclick="hid()"/>订单限制策略
					</td>					 
				</tr>
				<tr>
					<td style="text-align: right;">
						<div id="tickEdit" style="height:25px;width:110px;text-align: right;">
							触发生成总张数:
						</div>
					</td>
					<td>
						<div id="ticketCountDivEdit" style="height:25px;width:150px;margin:0;padding:0;">
							<input class="easyui-numberbox" type="text" id="ticketCountEdit" name="ticketCount" missingMessage="请输入触发生成总张数"
				                		    data-options="required:false,validType:'length[1,10]',min:1" style="width:150px;"/>
						</div>
					</td>
				</tr>
			</table>
		</form>
  	 </div> 
  	 
	<!-- 配置 -->
	<div id="edit-deploy" class="easyui-dialog" title="活动触发条件配置" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:1100px;height:400px;">  
		<form id="editDeployForm" class="ui-form" method="post">  
		<input class="hidden" type="text" name="id" id="tigerConfId">
			<div id="orderLimitDiv">
				<!-- 订单触发条件限制 -->
				<table id="orderLimit"></table>
			</div>
			<div id="tigerTicketRelDiv">
				<table id="tigerTicketRelByRandom"></table>
			</div>
		</form>
	</div> 
  	 
	<!-- tigerTicketRel -->
	<div id="ticketRel" class="easyui-dialog"
		data-options="draggable:true,title:'触发配置停车券',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:900px; height:400px; padding: 10px;">
		<form id="editTicketRelForm" class="ui-form" method="post">
			<table id="tigerTicketRel"></table>
		</form>
	</div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/activity/activityTigerConf.js"></script>
  </body>
</html>
