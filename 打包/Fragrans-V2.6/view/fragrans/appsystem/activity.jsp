<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:62px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
 	 	   <label class="ui-label">活动标题:</label><input name="activityName" class="easyui-box ui-text" style="width: 100px;">
 	 	   <label class="ui-label">活动状态：</label><mytag:dictionary name="status" id="statusSel" codeType="ACTIVITY_STATUS" isDefaultLine="1" dataOptions="required:false"/>
 	 	   <label class="ui-label">开始时间:</label><input name="startTime" id="startTime"
				class="easyui-datebox" style="width: 130px;"> 
		   <label class="ui-label">结束时间:</label><input name="endTime" id="endTime"
				class="easyui-datebox" style="width: 130px;"> 
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

     <!-- 添加 -->
     <div id="edit-win" class="easyui-dialog" title="活动信息" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:700px;height:400px;">  
     	<form id="editForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		<input class="hidden" id="areaCodeEdit" name="areaCode" style="width:390px;"/>
     		
     		 <table cellpadding="5px;">	
     		 	<tr>
     		 		<td style="text-align: right;">活动标题:</td>
					<td><input class="easyui-validatebox" type="text"
						name="activityName" missingMessage="请输入活动标题"
						data-options="required:true,validType:'length[1,64]'"
						style="width: 220px;" /></td>
					<td style="text-align: right;">
						<div id="activityPreferentialType" style="height:25px;width:90px;text-align: right;">
							优惠类型:
						</div>
					</td>
					<td>
						<div id="activityPreferentialTypeDiv" style="height:25px;width:150px;margin:0;padding:0;">
							<mytag:dictionary codeType="PREFERENTIAL_TYPE"
							id="activityPreferentialTypeAdd" name="activityPreferentialType" 
							dataOptions="required:false"/>
						</div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">
						<div id="topicName" style="height:25px;width:90px;text-align: right;">
							活动主题名称:
						</div>
					</td>
					<td>
						<div id="topicNameDiv" style="height:25px;width:150px;margin:0;padding:0;">
							<input class="easyui-combobox" type="text"
							id="topicNameAdd" name="activityTopicId" style="width: 220px;" 
							data-options="required:true,validType:'length[1,36]'"/>
						</div>
					</td>
					<td style="text-align: right;">
						<div id="areaName" style="height:25px;width:90px;text-align: right;">
							活动城市:
						</div>
					</td>
					<td>
						<div id="areaNameDiv" style="height:25px;width:200px;margin:0;padding:0;">
							<input id="areaNameEdit" name="areaName" missingMessage="请先选择活动主题名称，再选择活动城市"
							class="easyui-validatebox" data-options="fit : true,required:true" style="width: 160px;"
							readonly="readonly"/>
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" 
							style="border-style:none;" onclick="ztreeAdd();"></a>
						</div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">停车点名称:</td>
					<td><input class="easyui-combobox" type="text"
						id="parkName" name="parkId"
						data-options="validType:'length[1,36]'" style="width:220px"/></td>
					<td style="text-align: right;">活动代码:</td>
					<td><input class="easyui-combobox" type="text"
						id="activityCode" name="activityCode"
						data-options="required:true,validType:'length[1,36]'" style="width:180px"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">活动开始时间:</td>
					<td><input class="easyui-datebox" type="text"
						name="startTime" missingMessage="请输入活动开始时间"
						data-options="required:true" style="width: 180px;"/></td>
					<td style="text-align: right;">活动结束时间:</td>
					<td><input class="easyui-datebox" type="text"
						name="endTime" missingMessage="请输入活动结束时间"
						data-options="required:true" /></td>
				</tr>
				<tr>
     		 		<td style="text-align: right;">每日发券上限:</td>
					<td><input class="easyui-numberbox" type="text"
						name="dayTicketCount" data-options="required:false,validType:'length[1,64]'"
						style="width: 180px;" /></td>
						<td style="text-align: right;">发券上限:</td>
					<td><input class="easyui-numberbox" type="text"
						name="allTicketCount" data-options="required:false,validType:'length[1,64]'"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">活动状态:</td>
					<td><mytag:dictionary codeType="ACTIVITY_STATUS" id="status"
							name="status" style="width: 180px;"/>
						<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						onclick="$('#status').combobox('clear');" /></td>
					<td style="text-align: right;">活动类型:</td>
					<td><mytag:dictionary codeType="ACTIVITY_TYPE"
							id="activityType" name="activityType" dataOptions="required:false"/>
							<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						onclick="$('#activityType').combobox('clear');" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">活动内容:</td>
					<td colspan="3"><input class="easyui-validatebox" type="text"
						name="content" missingMessage="请输入活动内容html"
						data-options="required:true,validType:'length[1,1000]'" style="width:450px;"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">宣传图片:</td>
					<td colspan="3"><input class="easyui-validatebox" type="text"
						name="activityImageurl" missingMessage="请输入宣传图片"
						data-options="required:false,validType:'length[1,225]'" style="width:450px;"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">活动URL外连接:</td>
					<td colspan="3"><input class="easyui-validatebox" type="text"
						name="activityUrl" missingMessage="请输入活动URL外连接"
						data-options="required:true,validType:'length[1,225]'" style="width:450px;"/></td>
				</tr>
			 </table>
     	</form>
  	 </div> 
  	 
  	 <!-- ztree -->
	<div id="ztree" class="easyui-dialog" title="城市" 
		data-options="closed:true,iconCls:'ext-icon-picture',modal:true"  
		style="width: 300px; height: 400px;">
	</div>
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/activity.js"></script>
  </body>
</html>
