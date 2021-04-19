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
				<label class="ui-label">信息名称：</label><input name="codeTypeDesc"
					class="easyui-box ui-text" style="width: 100px;"> 
				<label class="ui-label">信息类型：</label><input name="codeType" class="easyui-box ui-text" style="width:100px;">
			</p>
			<a href="#" id="btn-search" style="margin-top:3px;" class="easyui-linkbutton" iconCls="icon-search">查询</a>
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
		data-options="draggable:true,title:'字典信息',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:600px; height:350px; padding: 10px;">
		<form id="editForm" class="ui-form" method="post">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">信息名称: </td>
					<td>
					 <input class="hidden" type="text" name="id" />
					 <input class="easyui-validatebox" type="text" name="codeTypeDesc" missingMessage="请输入信息名称"
	                        data-options="required:true,validType:'length[1,10]'">
 					</td>
				 
					<td style="text-align: right;">信息类型: </td>
					<td> 
						   <input class="easyui-validatebox" type="text" name="codeType" missingMessage="请输入信息类型"
							data-options="required:true,validType:'length[1,25]'">
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">信息值:  </td>					
					<td> 						  
						   <input class="easyui-validatebox" type="text" name="codeValue" missingMessage="请输入信息值"
							data-options="required:true,validType:'length[1,32]'">
 					</td>
				 
					<td style="text-align: right;"> 信息描述: </td>
					<td>  					 
					   <input class="easyui-validatebox" type="text" name="codeText" missingMessage="请输入信息描述"
						data-options="required:true,validType:'length[1,32]'">
					</td>
				</tr>
				<tr>
					<td style="text-align: right;"> 排序号: </td>
					<td> 					
						<input id="orderNum" name="orderNum" class="easyui-validatebox easyui-numberspinner" 
						data-options="required:true,min:0,max:99" missingMessage="请输入排序号" style="width:134px;" /> 
					</td>

					<td style="text-align: right;">是否默认: </td>
					<td> 
	                <mytag:dictionary codeType="IS_DEFAULT" id="isDefault" name="isDefault" dataOptions="required:true"/> 
					</td>
				</tr>
				
				<tr>
					<td style="text-align: right;"> 状态: </td>
					<td colspan="3"> 						
						<mytag:dictionary codeType="STATE" id="state" name="state" dataOptions="required:true"/>  
					</td>					 
				</tr>
				 
				
			</table>
		</form>
	</div>
     
     
     
<!--      <div id="edit-win" class="easyui-dialog" title="编辑" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:400px;height:350px;">   -->
<!--      	<form id="editForm" class="ui-form" method="post">   -->
<!--      		 <input class="hidden" type="text" name="id"> -->
<!--      		 <input class="hidden" name="deleted"> -->
<!--      		 <div class="ui-edit"> -->
<!-- 	     	   <div class="ftitle">数据字典信息</div>     -->
<!-- 	           <div class="fitem">   -->
<!-- 	               <label>信息名称:</label> -->
<!-- 	               <input class="easyui-validatebox" type="text" name="codeName" missingMessage="请输入信息名称" -->
<!-- 	                data-options="required:true,validType:'length[1,10]'"> -->
<!-- 	           </div>  -->
<!-- 	           <div class="fitem">   -->
<!-- 	               <label>信息类型:</label>   -->
<!-- 	               <input class="easyui-validatebox" type="text" name="codeType" missingMessage="请输入信息类型" -->
<!-- 	                data-options="required:true,validType:'length[1,25]'"> -->
<!-- 	           </div>  -->
<!-- 	           <div class="fitem">   -->
<!-- 	               <label>信息值:</label>   -->
<!-- 	               <input class="easyui-validatebox" type="text" name="codeValue" missingMessage="请输入信息值" -->
<!-- 	                data-options="required:true,validType:'length[1,5]'"> -->
<!-- 	           </div>  -->
<!-- 	           <div class="fitem">   -->
<!-- 	               <label>信息描述:</label>   -->
<!-- 	               <input class="easyui-validatebox" type="text" name="codeText" missingMessage="请输入信息描述" -->
<!-- 	                data-options="required:true,validType:'length[1,10]'"> -->
<!-- 	           </div>   -->
<!-- 	           <div class="fitem">   -->
<!-- 	               <label>排序号:</label>   -->
<!-- 	                <input id="orderNum" name="orderNum" class="easyui-validatebox easyui-numberspinner"  -->
<!-- 				    data-options="required:true,min:0,max:99" missingMessage="请输入排序号" style="width:134px;" /> -->
<!-- 	           </div> -->
<!-- 	           <div class="fitem">   -->
<!-- 	               <label>是否通用:</label>   -->
<%-- 	                <mytag:dictionary codeType="ISCOMMON" id="isCommon" name="isCommon" dataOptions="required:true"/>  --%>
<!-- 	           </div> -->
<!-- 	           <div class="fitem">   -->
<!-- 	               <label>状态:</label> -->
<%-- 	               <mytag:dictionary codeType="STATE" id="state" name="state"/>   --%>
<!-- 	           </div>  -->
<!-- 	         </div> -->
<!--      	</form> -->
<!--   	 </div>  -->
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/sys/dictionary.js"></script>
  </body>
</html>
