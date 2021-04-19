<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
  </head>
	<body class="easyui-layout">
     
     <!-- DataList  -->
     <div region="center" border="false" >
     	<table id="data-list"></table>
     </div>

     <!-- Edit Form -->
     
     <div id="edit-win" class="easyui-dialog"
		data-options="draggable:true,title:'菜单信息',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width:600px; height:420px; padding: 10px;">
		<form id="editForm" class="ui-form" method="post">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">模块名称: </td>
					<td>
					<input class="hidden" type="text" name="id" id="id">
     				<input class="hidden" name="deleted">
					<input class="easyui-validatebox" type="text" name="moduleName" missingMessage="请输入模块名称"
						data-options="required:true,validType:'length[1,50]'">
 					</td>
				 
					<td style="text-align: right;"> 模块描述:  </td>
					<td> 						   
						<input class="easyui-validatebox" type="text" name="moduleDesc" missingMessage="请输入模块描述"
						data-options="required:true,validType:'length[1,100]'">
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">模块URL:   </td>					
					<td>    
						 <input class="easyui-validatebox" type="text" name="moduleUrl" missingMessage="请输入模块URL"
						data-options="required:true,validType:'length[1,100]'">
 					</td>
				 
					<td style="text-align: right;">排序号: </td>
					<td>  
						<input id="orderNum" name="orderNum" class="easyui-validatebox easyui-numberspinner" 
							data-options="required:true,min:0,max:99" missingMessage="请输入排序号" style="width:134px;" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right;"> 操作动作:  </td>
					<td>    
					   <input class="easyui-validatebox" type="text" name="actions" missingMessage="请输入操作动作"
							data-options="required:true,validType:'length[1,500]'">
					</td>

					<td style="text-align: right;"> 菜单图标: </td>
					<td>  
					   <input id="iconCls" name="iconCls" readonly="readonly" style="padding-left: 18px; width: 134px;"/><img class="iconImg ext-icon-zoom" onclick="showIcons();" title="浏览图标" />&nbsp;
					   <img class="iconImg ext-icon-cross" onclick="$('#iconCls').val('');$('#iconCls').attr('class','');" title="清空" />
					</td>
				</tr>
				
				 <tr>
					<td style="text-align: right;"> 上级代码:  </td>
					<td>  
						<input class="easyui-combotree"	name="parentId" id="parentId"
						data-options="required:true,url:'treeList.do'" style="width:134px;">
					</td>

					<td style="text-align: right;">是否超级权限:  </td>
					<td>   
							<mytag:dictionary codeType="YESORNO" id="superAdmin" name="superAdmin"/>  
					</td>
				</tr> 
				
				 <tr>
					<td colspan="4"> <table id="btn-dg"></table> </td>
				</tr> 
				
			</table>
		</form>
	</div> 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/sys/module.js"></script>
  </body>
</html>
