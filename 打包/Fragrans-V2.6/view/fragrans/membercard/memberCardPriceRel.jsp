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
       	  <label class="ui-label">是否通用:</label>
			<mytag:dictionary name="isCommon" id="sisCommon" codeType="YESORNO"
						isDefaultLine='1' dataOptions="required:false" />
		  <label class="ui-label">区域名称:</label>
 	 	  	<input name="areaId" class="easyui-combotree ui-text" class="hidden" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/> 
		  <label class="ui-label">是否默认:</label>
			<mytag:dictionary name="isDefault" id="sisDefault" codeType="YESORNO"
				isDefaultLine='1' dataOptions="required:false" />
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
     <div id="edit-win" class="easyui-dialog" title="编辑" data-options="closed:true,iconCls:'icon-save',modal:true" 
     	style="width:450px;height:350px;">  
     	<form id="editForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		 <table cellpadding="5px;">	
					<tr>
						<td style="text-align: right;"> 实付金额:</td>
						<%--<td> --%>
		                	<%--<mytag:dictionary name="payAmount" id="payAmount" codeType="MC_PAYFEE"--%>
								<%--style="width:200px;" isDefaultLine='0' dataOptions="required:true,editable:false" />--%>
						<%--</td>					 --%>
						<td><input class="easyui-validatebox" type="text"
								   name="payAmount" id="payAmount" missingMessage="请输入实付金额"
								   data-options="required:true,validType:'length[1,7]'"/></td>
					</tr>
			   		<tr>
						<td style="text-align: right;"> 充值金额:</td>
						<%--<td> --%>
		                	<%--<mytag:dictionary name="rechargeAmount" id="rechargeAmount" codeType="MC_RECHARGEFEE"--%>
								<%--style="width:200px;" isDefaultLine='0' dataOptions="required:true,editable:false" />--%>
						<%--</td>					 --%>
						<td><input class="easyui-validatebox" type="text"
								   name="rechargeAmount" id="rechargeAmount" missingMessage="请输入充值金额"
								   data-options="required:true,validType:'length[1,7]'"/></td>
					</tr>
			   		<tr>
						<td style="text-align: right;"> 是否通用 :</td>
						<td> 
							<mytag:dictionary name="isCommon" id="isCommon" codeType="YESORNO"
								style="width:200px;" isDefaultLine='0' dataOptions="required:true,editable:false" />
						</td>					 
					</tr>
					<tr id="area_tr" style="display:none">
						<td style="text-align: right;"> 区域名称:</td>
						<td> 
							<input name="areaId"  class="easyui-combotree ui-text" class="hidden" style="width:200px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
								idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/> 
						</td>					 
					</tr>
			   		<tr>
						<td style="text-align: right;"> 是否默认:</td>
						<td> 
							<mytag:dictionary name="isDefault" id="isDefault" codeType="YESORNO"
								style="width:200px;" isDefaultLine='0' dataOptions="required:true,editable:false" />
						</td>					 
					</tr>
			   		<tr>
						<td style="text-align: right;"> 排序号:</td>
						<td> 
							 <input class="easyui-numberbox" type="text" name="displayNo" missingMessage="请输入排序号"
		                		    style="width:200px;" data-options="required:true,validType:'length[1,2]'" />
						</td>					 
					</tr>
					 <tr>
						 <td style="text-align: right;">开始时间:</td>
						 <td><input class="easyui-datetimebox" type="text" name="startTime"
									missingMessage="请输入开始时间"
									data-options="required:true,validType:'length[1,32]'"
									style="width: 150px;" /></td>
					 </tr>
					 <tr>
						 <td style="text-align: right;">结束时间:</td>
						 <td><input class="easyui-datetimebox" type="text" name="endTime"
									missingMessage="请输入结束时间"
									data-options="required:true,validType:'length[1,32]'"
									style="width: 150px;" /></td>
					 </tr>
   			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/membercard/memberCardPriceRel.js"></script>
  </body>
</html>
