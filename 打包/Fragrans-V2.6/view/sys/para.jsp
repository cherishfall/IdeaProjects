<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
     <div class="datagrid-toolbar" region="north" style="height:62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:false,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">参数关键字:</label><input name="paraName"
					class="easyui-box ui-text" style="width: 100px;"> 
			</p>
			<a href="#" id="btn-search" class="easyui-linkbutton" style="margin-top:3px;" iconCls="icon-search" >查询</a>
			<a href="#" id="btn-reset" class="easyui-linkbutton" onclick="$('#searchForm').form('clear');" style="margin-top:3px;" iconCls="ext-icon-application_reset" >重置</a>
		</form>
	</div>
     <!--  Search panel end -->
     
     <!-- DataList  -->
     <div region="center" border="false" >
     <table id="data-list"></table>
     </div>

     <!-- Edit Form -->
     
     <div id="edit-win" class="easyui-dialog"
		data-options="draggable:true,title:'参数信息',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:600px; height:350px; padding: 10px;">
		<form id="editForm" class="ui-form" method="post">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">参数关键字:</td>
					<td>
						<input class="hidden" type="text" name="id">  					
						<input class="easyui-validatebox" type="text" name="paraName" missingMessage="请输入参数关键字"
								data-options="required:true,validType:'length[1,30]'" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">参数类别:</td>
					<td> 
						 <mytag:dictionary codeType="PARA_TYPE" id="paraType" name="paraType" dataOptions="required:true"/> 
 					</td>
				 
					<td style="text-align: right;">参数状态:</td>
					<td>  						
						<mytag:dictionary codeType="STATE" id="state" name="state"/> 
					</td>
				</tr>
				<tr>
				 
					<td style="text-align: right;"> 参数值: </td>
					<td colspan="3"> 						
						   <textarea class="easyui-validatebox" rows="3" cols="55"  type="text" name="paraValue" missingMessage="请输入参数值"
								data-options="required:true,validType:'length[1,500]'"></textarea>
	      
					</td>
				</tr>
				<tr>
				 
					<td style="text-align: right;">参数描述: </td>
					<td colspan="3"> 
					    <textarea class="easyui-validatebox" rows="3" cols="55"  type="text" name="paraDesc" missingMessage="请输入参数描述"
								data-options="required:true,validType:'length[1,100]'"></textarea>     
					</td>
				</tr> 				
			</table>
		</form>
	</div>
     
     
<!--      <div id="edit-win" class="easyui-dialog" title="编辑" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:400px;height:400px;">   -->
<!--      	<form id="editForm" class="ui-form" method="post">   -->
<!--      		 <input class="hidden" type="text" name="id"> -->
<!--      		<input class="hidden" name="deleted"> -->
<!--      		 <div class="ui-edit"> -->
<!-- 	     	   <div class="ftitle">信息</div>  -->
<!-- 	   	       <div class="fitem">   -->
<!--                <label>参数关键字:</label>   -->
<!--                <input class="easyui-validatebox" type="text" name="paraKey" missingMessage="请输入参数关键字" -->
<!-- 	                data-options="required:true,validType:'length[1,30]'"> -->
<!-- 	           </div>  -->
<!-- 	   	       <div class="fitem"> -->
<!--                <label>参数值:</label>   -->
<!--                <textarea class="easyui-validatebox" rows="5" cols="20"  type="text" name="paraValue" missingMessage="请输入参数值" -->
<!-- 	                data-options="required:true,validType:'length[1,500]'"></textarea> -->
<!-- 	           </div>  -->
<!-- 	   	        <div class="fitem"> -->
<!--                <label>参数名称:</label>   -->
<!--                <input class="easyui-validatebox"  name="paraName" missingMessage="请输入参数名称" -->
<!-- 	                data-options="required:true,validType:'length[1,25]'"> -->
<!-- 	           </div>  -->
<!-- 		   	    <div class="fitem">   -->
<!--                <label>参数描述:</label>   -->
<!--                <input class="easyui-validatebox" type="text" name="paraDesc" missingMessage="请输入参数描述" -->
<!-- 	                data-options="required:true,validType:'length[1,100]'"> -->
<!-- 	           </div>  -->
<!-- 	           <div class="fitem">   -->
<!-- 	               <label>是否通用:</label>   -->
<%-- 	                <mytag:dictionary codeType="ISCOMMON" id="isCommon" name="isCommon" dataOptions="required:true"/>  --%>
<!-- 	           </div> -->
<!--    	    	   <div class="fitem">   -->
<!--                <label>参数状态:</label>   -->
<%-- 	               <mytag:dictionary codeType="STATE" id="state" name="state"/>   --%>
<!-- 	           </div>  -->
<!-- 	            </div> -->
<!--      	</form> -->
<!--   	 </div>  -->
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/sys/para.js"></script>
  </body>
</html>
