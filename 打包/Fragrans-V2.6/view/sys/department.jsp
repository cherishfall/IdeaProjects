<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout">
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>

<!-- 添加 -->
	<div id="edit-win" class="easyui-dialog"
		data-options="draggable:true,title:'部门管理',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width: 650px; height: 350px; padding: 10px;">
		<form id="editForm" class="ui-form" method="post">
		<input class="hidden" type="text" name="id" />
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">部门名称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="departmentName" missingMessage="请输入部门名称"
						data-options="required:true,validType:'length[1,50]'" style="width:150px">
					</td>
					<td style="text-align: right;">上级部门代码:</td>
					<td><input class="easyui-combotree" name="parentId"
						id="departmentTree" data-options="required:true" style="width:200px"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">所在城市:</td>
					<td><input id="cityCode" name="cityCode" 
						class="easyui-combotree" missingMessage="请先选好上级部门" 
						data-options="fit : true, 
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:true" style="width:150px"/>
						<img
						src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						onclick="$('#cityCode').combotree('clear');"/></td>
					<td style="text-align: right;">所在区域:</td>
					<td><input id="areaCode" name="areaCode"
						class="easyui-combotree"
						data-options="url:'${pageContext.request.contextPath}/area/getArea.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
						<img
						src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						onclick="$('#areaCode').combotree('clear');" /></td>
					
				</tr>
				<tr>
					<td style="text-align: right;">联系人:</td>
					<td><input class="easyui-validatebox" type="text"
						name="contacts" missingMessage="请输入联系人"
						data-options="required:false,validType:'length[1,50]'" style="width:150px"/>
					</td>
					<td style="text-align: right;">联系方式:</td>
					<td><input class="easyui-validatebox" type="text" name="phone"
						missingMessage="请输入联系方式"
						data-options="required:true,validType:'mobile'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">排序号:</td>
					<td><input id="orderNum" name="orderNum"
						class="easyui-validatebox easyui-numberspinner"
						data-options="required:true,min:0,max:99" missingMessage="请输入排序号"
						style="width:150px" /></td>
					<td style="text-align: right;">地址:</td>
					<td><input class="easyui-validatebox" type="text"
						name="address" missingMessage="请输入地址"
						data-options="required:false,validType:'length[1,100]'" />
					</td>
				</tr>

				<tr>
					<td style="text-align: right;">备注:</td>
					<td colspan="3"><textarea name="note"
							style="height: 50px; width: 390px;" maxlength="100"></textarea></td>
				</tr>

			</table>
		</form>
	</div>

<!-- 修改 -->
	<div id="edit-department" class="easyui-dialog"
		data-options="draggable:true,title:'编辑部门',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width: 600px; height: 350px; padding: 10px;">
		<form id="departmentEditForm" class="ui-form" method="post">
		<input class="hidden" type="text" name="id" />
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">部门名称:</td>
					<td><input class="easyui-validatebox" type="text"
						name="departmentName" missingMessage="请输入部门名称"
						data-options="required:true,validType:'length[1,50]'">
					</td>
					<td style="text-align: right;">联系人:</td>
					<td><input class="easyui-validatebox" type="text"
						name="contacts" missingMessage="请输入联系人"
						data-options="required:false,validType:'length[1,50]'" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">联系方式:</td>
					<td><input class="easyui-validatebox" type="text" name="phone"
						missingMessage="请输入联系方式"
						data-options="required:true,validType:'mobile'" /></td>
					<td style="text-align: right;">排序号:</td>
					<td><input name="orderNum"
						class="easyui-validatebox easyui-numberspinner"
						data-options="required:true,min:0,max:99" missingMessage="请输入排序号"
						style="width: 134px;" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">地址:</td>
					<td><input class="easyui-validatebox" type="text"
						name="address" missingMessage="请输入地址"
						data-options="required:false,validType:'length[1,100]'" />
					</td>
				</tr>

				<tr>
					<td style="text-align: right;">备注:</td>
					<td colspan="3"><textarea name="note"
							style="height: 50px; width: 390px;" maxlength="100"></textarea></td>
				</tr>

			</table>
		</form>
	</div>

	 <script type="text/javascript"
		src="<%=basePath%>/assets/js/business/sys/department.js"></script> 
</body>
</html>
