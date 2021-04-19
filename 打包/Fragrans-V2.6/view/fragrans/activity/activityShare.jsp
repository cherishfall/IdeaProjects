<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">分享类型:</label>
				<mytag:dictionary codeType="SHARE_TYPE" id="activityType"
					name="activityType" isDefaultLine='1' dataOptions="required:false" />
				<label class="ui-label">状态:</label>
				<mytag:dictionary codeType="SHARE_STATUS" id="status" name="status"
					isDefaultLine='1' dataOptions="required:false" />
				<label class="ui-label">显示类型:</label>
				<mytag:dictionary codeType="DISPLAYCONF" id="displayConf"
					name="displayConf" isDefaultLine='1' dataOptions="required:false" />
			</p>
			<a href="#" id="btn-search" class="easyui-linkbutton"
				iconCls="icon-search">查询</a> <a href="#" id="btn-reset"
				class="easyui-linkbutton" onclick="$('#searchForm').form('clear');"
				style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
		</form>
	</div>
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="分享活动信息配置"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 600px; height: 350px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">分享主题名称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="activityName" missingMessage="请输入分享主题名称"
						data-options="required:true,validType:'length[1,64]'" /></td>
					<td style="text-align: right;">分享类型:</td>
					<td><mytag:dictionary codeType="SHARE_TYPE" id="activityType"
							name="activityType" isDefaultLine='1' dataOptions="required:true" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">是否分享即刻触发:</td>
					<td><mytag:dictionary codeType="YESORNO" id="isTiger"
							name="isTiger" dataOptions="required:false" /></td>
					<td style="text-align: right;">是否允许来源用户触发:</td>
					<td><mytag:dictionary codeType="YESORNO" id="isFromuserTiger"
							name="isFromuserTiger" dataOptions="required:true" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">可领取次数:</td>
					<td><input class="easyui-validatebox" type="text"
						name="getCount" missingMessage="请输入可领取次数"
						data-options="required:true,validType:'length[1,10]'" /></td>
					<td style="text-align: right;">有效期:</td>
					<td><input class="easyui-validatebox" type="text"
						name="validity" missingMessage="请输入有效期 单位：天"
						data-options="required:true,validType:'length[1,10]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">状态:</td>
					<td><mytag:dictionary codeType="SHARE_STATUS" id="status"
							name="status" isDefaultLine='1' dataOptions="required:true" /></td>
					<td style="text-align: right;">显示类型 :</td>
					<td><mytag:dictionary codeType="DISPLAYCONF" id="displayConf"
							name="displayConf" isDefaultLine='1' dataOptions="required:true" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">分享描述:</td>
					<td colspan="3"><input class="easyui-validatebox" type="text"
						name="activityDesc" missingMessage="请输入分享描述"
						data-options="required:true,validType:'length[1,225]'"
						style="width: 390px;"/></td>
				</tr>
				<tr>
					<td style="text-align: right;">分享地址:</td>
					<td colspan="3"><input class="easyui-validatebox" type="text"
						name="shareUrl" missingMessage="请输入分享地址"
						data-options="required:true,validType:'length[1,100]'"
						style="width: 390px;" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">分享配图:</td>
					<td colspan="3"><input class="easyui-validatebox" type="text"
						name="shareImage" style="width: 390px;" missingMessage="请输入分享配图"
						data-options="required:true,validType:'length[1,100]'" /></td>
				</tr>
			</table>
		</form>
	</div>

	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/activity/activityShare.js"></script>
</body>
</html>
