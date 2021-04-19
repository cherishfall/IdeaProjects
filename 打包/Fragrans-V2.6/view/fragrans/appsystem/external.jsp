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
 	 		<label class="ui-label">应用ID:</label><input name="appId" class="easyui-box ui-text" style="width:150px;">
			<label class="ui-label">授权类型:</label><mytag:dictionary name="authType" id="authType" codeType="AUTH_TYPE" isDefaultLine="1" dataOptions="required:false"/>
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
     <div id="edit-external" class="easyui-dialog" title="添加" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:570px;height:400px;">  
     	<form id="editExternalForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		 <table cellpadding="5px;">
				   		<tr>
							<td style="text-align: right;"> 应用名称：</td>
							<td> 
								 <input class="easyui-combobox" type="text" id="appIdAdd" name="appId" missingMessage="该项为必输项"
			                		    data-options="required:true,validType:'length[1,36]'" style="width:150px;" />
							</td>	
						</tr>
						<tr>
							<td style="text-align: right;"> 数据权限区域：</td>
							<td> 
			                	<input name="areaId" missingMessage="请输入数据权限区域" 
			                	 		class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
										idField : 'id',treeField : 'areaName',parentField : 'parentId',required:true"/>
							</td>
						</tr>
				   		<tr>
							<td style="text-align: right;"> 是否显示空闲泊位数：</td>
							<td> 
								<mytag:dictionary name="isFreeBerth" id="isFreeBerth" codeType="YESORNO" style="width:150px;"/>
							</td>				 
						</tr>
						<tr>
							<td style="text-align: right;">授权类型：</td>
							<td style="text-align: left;"><input name="authType" type="radio" value="1" checked="checked" onclick="showArea()"/>区域
							<input name="authType" type="radio" value="2"  onclick="showPark()"/>停车点</td>
						</tr>
						<tr>
							<td><p id="name" style="width:130px;text-align: right;"></p></td>
							<td>
								<input id="data" name="data" class="easyui-combobox" data-options="required:true" style="width:135px;"/>
							</td>
						</tr>
						<tr>
							<td style="text-align: right;">
								<div id="parkType" style="height:25px;width:130px;text-align: right;">
									停车点类型：
								</div>
							</td>
							<td>
								<div id="authParkTypeDiv" style="height:25px;width:150px;margin:0;padding:0;">
									<mytag:dictionary id="authParkType" name="authParkType" codeType="AUTH_PARK_TYPE" style="width:150px;" dataOptions="required:false"/>
								</div>
							</td>
						</tr>
						
				   		<tr>
							<td style="text-align: right;"> 备注:</td>
		                	<td colspan="3"><textarea name="remark" id="remark" 
								style="height: 60px; width: 380px;" maxlength="225"></textarea></td>
						</tr>
			</table>
     	</form>
  	 </div> 

     <!-- 修改 -->
     <div id="edit-win" class="easyui-dialog" title="修改" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:570px;height:400px;">  
     	<form id="editForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		 <table cellpadding="5px;">
				   		<tr>
							<td style="text-align: right;"> 应用名称:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" id="appIdEdit" name="appId"
			                		style="width:150px;background:#eee" readonly="readonly"/>
							</td>	
						</tr>
						<tr>
							<td style="text-align: right;"> 数据权限区域:</td>
							<td> 
			                	<input name="areaId" missingMessage="请输入数据权限区域" 
			                	 		class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
										idField : 'id',treeField : 'areaName',parentField : 'parentId',required:true"/>
							</td>
						</tr>
				   		<tr>
							<td style="text-align: right;"> 是否显示空闲泊位数:</td>
							<td> 
								<mytag:dictionary name="isFreeBerth" id="isFreeBerth" codeType="YESORNO" style="width:150px;"/>
							</td>				 
						</tr>
				   		<tr>
							<td style="text-align: right;"> 备注:</td>
		                	<td colspan="3"><textarea name="remark" id="remark" 
								style="height: 80px; width: 380px;" maxlength="225"></textarea></td>
						</tr>
			</table>
     	</form>
  	 </div> 
  	 
  	 <!-- check -->
	 <div id="check" class="easyui-dialog"
		data-options="draggable:true,title:'查看',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:670px; height:360px; padding: 10px;">
		<form id="editForm" class="ui-form" method="post">
			<table id="externalConf"></table>
		</form>
	</div>
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/external.js"></script>
  </body>
</html>
