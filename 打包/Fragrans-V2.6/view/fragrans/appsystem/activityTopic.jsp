<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height:62px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
 	 	   <label class="ui-label">主题名称：</label><input name="topicName" class="easyui-box ui-text" style="width:100px;">
 	 	   <label class="ui-label">主题状态：</label><mytag:dictionary name="status" id="statusSel" codeType="ACTIVITY_STATUS" isDefaultLine="1" dataOptions="required:false"/>
 	 	   <label class="ui-label">显示策略：</label><mytag:dictionary name="displayconf" id="displayconfSel" codeType="DISPLAYCONF" isDefaultLine="1" dataOptions="required:false"/>
 	 	   <label class="ui-label">开始时间:</label><input name="startTime" id="startTime"
				class="easyui-datebox" style="width: 130px;"> 
		   <label class="ui-label">结束时间:</label><input name="endTime" id="endTime"
				class="easyui-datebox" style="width: 130px;"> 
        </p>
        <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search" onclick= "searchForm();">查询</a>
        <a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
      </form>  
     </div>
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>

	<!-- 添加 -->
	<div id="edit-win" class="easyui-dialog" title="活动主题配置"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 600px; height: 380px;">
		<form id="editForm" class="ui-form" method="post" enctype="multipart/form-data" >
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->
			<input class="hidden" id="areaCodeEdit" name="areaCode" style="width:390px;"/>

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">排序号:</td>
					<td><input class="easyui-numberbox" type="text"
						name="orderNum" missingMessage="请输入数字"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">活动主题名称:</td>
					<td colspan="2"><input class="easyui-validatebox" type="text"
						name="topicName" missingMessage="请输入活动主题名称"
						data-options="required:true,validType:'length[1,64]'"
						style="width: 200px;" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">
						<div id="areaName" style="height:25px;width:90px;text-align: right;">
							活动城市:
						</div>
					</td>
					<td colspan="2">
						<div id="areaNameDiv" style="height:25px;width:230px;margin:0;padding:0;">
							<input id="areaNameEdit" name="areaName"
							class="easyui-validatebox" data-options="fit : true,required:true" style="width: 200px;"
							readonly="readonly"/>
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" 
							style="border-style:none;" onclick="$('#ztree').dialog('open');"></a>
						</div>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">活动主题摘要:</td>
					<td colspan="3"><input class="easyui-validatebox" type="text"
						name="topicAbstract" missingMessage="请输入活动主题摘要"
						data-options="required:false,validType:'length[1,36]'"
						style="width: 390px;" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">开始时间:</td>
					<td><input class="easyui-datebox" type="text" name="startTime"
						missingMessage="请输入开始时间"
						data-options="required:true,validType:'length[1,10]'"
						style="width: 150px;" /></td>
					<td style="text-align: right;">结束时间:</td>
					<td><input class="easyui-datebox" type="text" name="endTime"
						missingMessage="请输入结束时间"
						data-options="required:true,validType:'length[1,10]'"
						style="width: 150px;" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">主题状态:</td>
					<td><mytag:dictionary name="status" id="status"
							codeType="ACTIVITY_STATUS" style="width:150px;" /></td>
					<td style="text-align: right;">显示策略:</td>
					<td><mytag:dictionary name="displayconf" id="displayconf" codeType="DISPLAYCONF"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">宣传图片:</td>
			 		<td colspan="3"> 
             	 		<input class="easyui-validatebox" id="topicImageurl" name="topicImageurl"
           				data-options="required:false,validType:'length[1,225]'" style="width: 350px;"/>
           				<input type="button" id="msgButton" value="上传"/>
             	 		<input type="file" id="msgImage" name="msgImage" style="display:none;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">活动URL外连接:</td>
					<td colspan="3"><input class="easyui-validatebox" type="text"
						id="topicUrl" name="topicUrl" data-options="required:false,validType:'length[1,225]'"
						style="width: 390px;" /></td>
				</tr>
			</table>
		</form>
	</div>
	
	 <!-- ztree -->
	<div id="ztree" class="easyui-dialog" title="城市" 
		data-options="closed:true,iconCls:'ext-icon-picture',modal:true"  
		style="width: 300px; height: 400px;">
	</div>
	
	<%-- <!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="活动主题配置"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 600px; height: 350px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">活动主题名称:</td>
					<td colspan="2"><input class="easyui-validatebox" type="text"
						name="topicName" missingMessage="请输入活动主题名称"
						data-options="required:true,validType:'length[1,64]'"
						style="width: 200px;" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">活动主题摘要:</td>
					<td colspan="3"><input class="easyui-validatebox" type="text"
						name="topicAbstract" missingMessage="请输入活动主题摘要"
						data-options="required:false,validType:'length[1,36]'"
						style="width: 390px;" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">开始时间:</td>
					<td><input class="easyui-datebox" type="text" name="startTime"
						missingMessage="请输入开始时间"
						data-options="required:true,validType:'length[1,10]'"
						style="width: 150px;" /></td>
					<td style="text-align: right;">结束时间:</td>
					<td><input class="easyui-datebox" type="text" name="endTime"
						missingMessage="请输入结束时间"
						data-options="required:true,validType:'length[1,10]'"
						style="width: 150px;" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">活动状态:</td>
					<td><mytag:dictionary name="status" id="status"
							codeType="ACTIVITY_STATUS" style="width:150px;" /></td>
					<td style="text-align: right;">显示策略:</td>
					<td><mytag:dictionary name="displayconf" id="displayconf" codeType="DISPLAYCONF"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">宣传图片:</td>
					<td colspan="3"><input class="easyui-validatebox" type="text"
						name="topicImageurl" missingMessage="请输入宣传图片"
						data-options="required:false,validType:'length[1,225]'"
						style="width: 390px;" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">活动URL外连接:</td>
					<td colspan="3"><input class="easyui-validatebox" type="text"
						name="topicUrl" missingMessage="请输入活动URL外连接"
						data-options="required:true,validType:'length[1,225]'"
						style="width: 390px;" /></td>
				</tr>
			</table>
		</form>
	</div>
 --%>
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/activityTopic.js"></script>
</body>
</html>
