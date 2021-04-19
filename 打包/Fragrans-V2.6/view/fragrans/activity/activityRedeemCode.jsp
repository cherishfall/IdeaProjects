<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@include file="/view/inc.jsp"%>
	</head>
	<body class="easyui-layout">
	
		<!-- DataList  -->
		<div region="center" border="false">
			<table id="data-list"></table>
		</div>
	
		<!-- 添加 -->
		<div id="add-win" class="easyui-dialog" title="兑换码配置"
			data-options="closed:true,iconCls:'icon-save',modal:true"
			style="width: 600px; height: 300px;">
			<form id="addForm" class="ui-form" method="post" enctype="multipart/form-data">
				<input class="hidden" type="text" name="id">
	
				<table cellpadding="5px;">
					<tr>
						<td style="text-align: right;">关联活动:</td>
						<td>
							<input class="easyui-combobox" type="text"
							id="activityName" name="activityId" style="width: 350px;"
							data-options="required:true,validType:'length[1,36]',editable:false" />
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">兑换码:</td>
						<td>
							<input class="easyui-validatebox" type="text"
							name="redeemCode" missingMessage="请输入兑换码"
							data-options="required:true,validType:'length[1,255]'"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">兑换码宣传图片:</td>
						<td>
							<input class="easyui-validatebox" type="text"
							id="reddemImageurl" name="reddemImageurl"
							data-options="required:true,validType:'length[1,255]'"  style="width: 350px;"/>
	           				<input type="button" id="msgButton" value="上传"/>
	             	 		<input type="file" id="msgImage" name="msgImage" style="display:none;"/>
	             	 	</td>
					</tr>
					<tr>
						<td style="text-align: right;">兑换活动URL外连接:</td>
						<td>
							<input class="easyui-validatebox" type="text"
							name="redeemActivityUrl" style="width: 390px;"
							data-options="required:true,validType:'length[1,225]'"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
		
		<!-- 修改 -->
		<div id="edit-win" class="easyui-dialog" title="兑换码配置"
			data-options="closed:true,iconCls:'icon-save',modal:true"
			style="width: 600px; height: 300px;">
			<form id="editForm" class="ui-form" method="post" enctype="multipart/form-data">
				<input class="hidden" type="text" name="id">
	
				<table cellpadding="5px;">
					<tr>
			   			<td style="text-align: right;">关联活动:</td>
						<td>
							<p id="activityNameEdit"></p>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">兑换码:</td>
						<td>
							<input class="easyui-validatebox" type="text"
							name="redeemCode" missingMessage="请输入兑换码"
							data-options="required:true,validType:'length[1,255]'"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">兑换码宣传图片:</td>
						<td>
							<input class="easyui-validatebox" type="text"
							id="reddemImageurlEdit" name="reddemImageurl"
							data-options="required:true,validType:'length[1,255]'"  style="width: 350px;"/>
	           				<input type="button" id="msgButtonEdit" value="上传"/>
	             	 		<input type="file" id="msgImageEdit" name="msgImage" style="display:none;"/>
	             	 	</td>
					</tr>
					<tr>
						<td style="text-align: right;">兑换活动URL外连接:</td>
						<td>
							<input class="easyui-validatebox" type="text"
							name="redeemActivityUrl" style="width: 390px;"
							data-options="required:true,validType:'length[1,225]'"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	
		<!-- js -->
		<script type="text/javascript"
			src="<%=basePath%>/assets/js/business/fragrans/activity/activityRedeemCode.js"></script>
	</body>
</html>
