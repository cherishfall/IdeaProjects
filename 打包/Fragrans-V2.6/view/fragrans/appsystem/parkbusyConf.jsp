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
 	 	   <label class="ui-label">停车点类型:</label><mytag:dictionary name="parkModel" id="parkModel" codeType="PARK_LOT_MODE" isDefaultLine="1" dataOptions="required:false"/>
 	 	   <label class="ui-label">配置规则:</label><mytag:dictionary name="confType" id="confType" codeType="CONF_TYPE" isDefaultLine="1" dataOptions="required:false"/>
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
     <div id="edit-win" class="easyui-dialog" title="停车点空闲或繁忙配置" data-options="closed:true,iconCls:'icon-save',modal:true" style="width:580px;height:280px;">  
     	<form id="editForm" class="ui-form" method="post">  
     		 <input class="hidden" type="text" name="id">
     		<!-- <input class="hidden" name="deleted"> -->
     		
     		 <table cellpadding="5px;">	
				   			     	 <tr>
							<td style="text-align: right;"> 停车点类型:</td>
							<td> 
								<mytag:dictionary name="parkModel" id="parkModel" codeType="PARK_LOT_MODE"/>
							</td>	
							<td style="text-align: right;"> 配置规则:</td>
							<td> 
								<mytag:dictionary name="confType" id="confType" codeType="CONF_TYPE"/>
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 泊位阈值下线数:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" name="totalBerthMin" missingMessage="请输入泊位阈值下线数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>	
							<td style="text-align: right;"> 泊位阈值上线数:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" name="totalBerthMax" missingMessage="请输入泊位阈值上线数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>				 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 繁忙定义占比:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" name="busyProc" missingMessage="请输入繁忙定义占比"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>	
							<td style="text-align: right;"> 繁忙阈值配置:</td>
							<td> 
								 <input class="easyui-numberbox" type="text" name="busyCount" missingMessage="请输入繁忙阈值配置"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 繁忙描述:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="busyDesc" missingMessage="请输入繁忙描述"
			                		    data-options="required:true,validType:'length[1,16]'" />
							</td>
							<td style="text-align: right;"> 空闲描述:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="freeDesc" missingMessage="请输入空闲描述"
			                		    data-options="required:true,validType:'length[1,16]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/parkbusyConf.js"></script>
  </body>
</html>
