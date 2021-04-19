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
 	 		<label class="ui-label">日期:</label>
				 <input id="dayTime" name="dayTime" class="easyui-datebox" data-options="width:150" />
			<label class="ui-label">区域名称:</label><input id="areaCode" name="areaCode" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
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
     <div id="edit-win" class="easyui-dialog" title="编辑" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:400px;height:300px;">  
     	<form id="editForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		 <table cellpadding="5px;">	
				   			     	 <tr>
							<td style="text-align: right;"> 日期:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="dayTime" missingMessage="请输入日期"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 城市:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="cityCode" missingMessage="请输入城市"
			                		    data-options="required:true,validType:'length[1,16]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 交易成功笔数:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="tranSuccessCount" missingMessage="请输入交易成功笔数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 交易成功金额(分):</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="tranSuccessAmount" missingMessage="请输入交易成功金额(分)"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 交易失败笔数:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="tranFaultCount" missingMessage="请输入交易失败笔数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 交易失败金额(分):</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="tranFaultAmount" missingMessage="请输入交易失败金额(分)"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 预约数:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="bookCount" missingMessage="请输入预约数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 预约金额（分）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="bookAmount" missingMessage="请输入预约金额（分）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 应缴金额（分）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="shouldPaidAmount" missingMessage="请输入应缴金额（分）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 实缴金额（分）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="actuallyPaidAmount" missingMessage="请输入实缴金额（分）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 创建时间,默认SYSDATE:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="createTime" missingMessage="请输入创建时间,默认SYSDATE"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/stat/transactionDaily.js"></script>
  </body>
</html>
