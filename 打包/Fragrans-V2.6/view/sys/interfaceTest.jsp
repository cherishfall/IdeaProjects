<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
</head>
<body class="easyui-layout" style="overflow-y: scroll;">
		<form id="editForm" class="ui-form" method="post">
			<div class="pageFormContent">
				<table cellpadding="5px;" style="width:800px;">
					<tr>
						<td style="text-align: right;">发送地址：</td>
						<td colspan="10">
						<input class="easyui-validatebox" id="gatewayUrl" name="gatewayUrl" type="text"
						style="width:580px;" missingMessage="该项为必输项" data-options="required:false"/>
	 					</td>
	 				</tr>
	 				<tr>
						<td style="text-align: right;">appId：</td>
						<td>
						<input class="easyui-validatebox" type="text" id="appId" name="appId"
							maxlength="32" value="1020140422102642" 
							missingMessage="该项为必输项" data-options="required:true"/>
	 					</td>
	 					<td style="text-align: right;width:50px;">sign_type：</td>
						<td>
						<input class="easyui-validatebox" type="text" id="sign_type" name="sign_type"
							maxlength="32" value="MD5" missingMessage="该项为必输项" data-options="required:true"/>
	 					</td>
	 				</tr>
					<tr>
						<td style="text-align: right;">charset：</td>
						<td><select id="charset" name="charset">
								<option>UTF-8</option>
								<option>GB2312</option>
								<option>GBK</option>
								<option>UNICODE</option>
								<option>ASCII</option>
						</select></td>
						<td style="text-align: right;width:50px;">key：</td>
						<td>
						<input class="easyui-validatebox" type="text" id="key" name="key" style="width:240px;"
							maxlength="80" value="d10de75498ae82987f08d3653b092cc7" 
							missingMessage="该项为必输项" data-options="required:true"/>
	 					</td>
					</tr>
					<tr>
						<td style="text-align: right;">接口名称：</td>
						<td>
						<input id="name" name="name" 
						class="easyui-combotree"
						data-options="url:'${pageContext.request.contextPath}/service/getName.do',fit : true,
						idField : 'id',treeField : 'name',parentField : 'parentId',required:false" style="width:250px;"/>
	 					</td>
					</tr>
					<tr>
						<td style="text-align: right;">service：</td>
						<td>
						<input type="text" id="service" name="service" maxlength="80" style="width:250px;" 
						/>
	 					</td>
					</tr>
					 <tr>
						<td style="text-align: right;">data描述：</td>
						<td  class="formSendContent" colspan="10">
							<textarea class="editor" id="dataDesc" name="dataDesc" readonly="readonly"
									style="height: 60px; width: 580px;"></textarea></td>
					</tr>
					<tr>
						<td style="text-align: right;">发送data：</td>
						<td class="formSendContent" colspan="10">
							<textarea class="editor" id="data" name="data"
									style="height: 100px;  width: 580px;"></textarea></td>
					</tr>
					<tr>
						<td style="text-align: right;">返回结果：</td>
						<td class="formReceiveContent" colspan="10">
							<textarea class="editor" id="result" name="result"
								readonly="readonly" style="height: 140px; width: 580px;"></textarea></td>
					</tr>
					<tr>
						<td style="text-align: right;">
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'"   
       						 onclick="VerificateSendMessage(this);">提交</a>
       					</td>
       					<!-- <td style="text-align: right;width:0px;">
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-arrow_undo'" 
							onclick="$(editForm).form('reset');">重置</a>
						</td>  -->
						 <td style="text-align: right;width:0px;">
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-arrow_undo'" 
							onclick="reset();">重置</a>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<script>
		</script>
		<!-- js -->
		<script type="text/javascript"
			src="<%=basePath%>/assets/js/business/sys/interfaceTest.js"></script>
</body>
</html>
