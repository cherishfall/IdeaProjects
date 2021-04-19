<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<%@include file="/view/inc.jsp" %>
	<script src="<%=basePath%>/assets/js/ckeditor/ckeditor.js"></script>
	<script src="<%=basePath%>/assets/js/ckeditor/samples/js/sample.js"></script>
	<link rel="stylesheet" href="<%=basePath%>/assets/js/ckeditor/samples/css/samples.css">
	<link rel="stylesheet" href="<%=basePath%>/assets/js/ckeditor/samples/toolbarconfigurator/lib/codemirror/neo.css">
	</head>
	<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height:62px;" title="过滤条件" 
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">推送类型:</label><mytag:dictionary name="pushRange" id="pushRange" codeType="PUSH_RANGE_TYPE" isDefaultLine="1" dataOptions="required:false"/>
				<label class="ui-label">下发类型:</label><mytag:dictionary name="pushType" id="pushType" codeType="PUSH_TYPE" isDefaultLine="1" dataOptions="required:false"/>
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

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="消息任务配置" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:680px;height:400px;">  
		<form id="editForm" class="ui-form" method="post" enctype="multipart/form-data">
			<input class="hidden" type="text" name="id">
     		
			<table cellpadding="5px;">	
				<tr>
					<td style="text-align: right;">模板类型:</td>
					<td style="text-align: left;">
						<input class="hidden" name="templetType" id="templetType" value="1"/>Notification模板
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">消息类型:</td>
					<td colspan="3"> 
						<mytag:dictionary name="messageType" id="messageType" codeType="PUSH_MESSAGE_TYPE" dataOptions="required:true"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;"> 消息标题:</td>
					<td colspan="3"> 
						<input class="easyui-validatebox" type="text" name="title" missingMessage="请输入消息标题"
							data-options="required:true,validType:'length[1,64]'" style="width:200px;"/>
					</td>
				</tr>
		   		<tr>
		   			<td style="text-align: right;"> 推送类型:</td>
					<td colspan="3"> 
						 <mytag:dictionary name="pushRange" id="pushRangeEdit" codeType="PUSH_RANGE_TYPE" style="width:200px;"/>
					</td>
				</tr>
				<tr id="areaDiv">
					<td style="text-align: right;">选择区域:</td>
					<td colspan="3"> 
						 <input class="easyui-combotree" type="text" id="area" name="area"
	                		    data-options="required:false" style="width:160px;"/>
					</td>
				</tr>
				<tr id="userAccountDiv">
					<td style="text-align: right;"> 用户账号:</td>
					<td colspan="3"> 
						 <textarea id="userAccount" name="userAccount"
	                		    data-options="required:false" style="width:460px;"></textarea>
						 <input type="button" id="accountButton" value="上传"/>
						 <input type="file" id="accountText" name="accountText" style="display:none;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">下发类型:</td>
					<td style="text-align: left;"><input name="pushType" type="radio" value="1" checked="checked" onclick="showTime()"/>定时
						<input name="pushType" type="radio" value="2" onclick="hideTime()"/>立刻
					</td>
					<td id="time" style="text-align: right;">
							下发时间:
					</td>
					<td id="pushTimeDiv">
						<input class="easyui-datetimebox" type="text" id="pushTime" name="pushTime" missingMessage="请输入下发时间"
		                	data-options="required:false,validType:'length[1,19]'" style="width:160px;"/>
					</td>
				</tr>
		   		<tr>
		   			<td style="text-align: right;"> 推送对象类型:</td>
					<td> 
						 <mytag:dictionary name="pushClientType" id="pushClientType" codeType="PUSH_CLIENT_TYPE"/>
					</td>
					<td style="text-align: right;"> 是否显示提示:</td>
					<td id="isDisplayDiv">
						<mytag:dictionary name="isDisplay" id="isDisplay" codeType="YESORNO" dataOptions="required:false" style="width:160px;"/>
					</td>
				</tr>
		   	<%--	<tr>
		   			<td style="text-align: right;"> 是否开启振动:</td>
					<td> 
						<mytag:dictionary name="isShock" id="isShock" codeType="YESORNO" dataOptions="required:false"/>
					</td>
					<td style="text-align: right;"> 是否开启声音:</td>
					<td>
						<mytag:dictionary name="isVoice" id="isVoice" codeType="YESORNO" dataOptions="required:false" style="width:160px;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;"> 是否可清除:</td>
					<td> 
						<mytag:dictionary name="isClear" id="isClear" codeType="YESORNO" dataOptions="required:false"/>
					</td>
					<td style="text-align: right;"> 是否启动应用:</td>
					<td> 
						<mytag:dictionary name="isOpen" id="isOpen" codeType="YESORNO" dataOptions="required:false" style="width:160px;"/>
					</td>	
				</tr>--%>
				<tr>
					<td style="text-align: right;">消息内容:</td>
					<td colspan="3">
						<textarea id="content" name="content" style="width:460px;height:60px;" maxlength="510"></textarea>
					</td>				 
				</tr>
			</table>
		</form>
	</div> 
  	 
	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/pushTask.js"></script>
  </body>
</html>