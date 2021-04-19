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
 	 	    <label class="ui-label">缩放级别:</label><input name="zoomLevel" class="easyui-box ui-text" style="width:100px;">
 	 	    <label class="ui-label">停车场个数:</label><input name="parkCount" class="easyui-box ui-text" style="width:100px;">
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
							<td style="text-align: right;"> 城市编码:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="cityCode" missingMessage="请输入城市编码"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 缩放级别小于等于14，大于等于4（可配置）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="zoomLevel" missingMessage="请输入缩放级别小于等于14，大于等于4（可配置）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 经度(高德):</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="longitudeGaode" missingMessage="请输入经度(高德)"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 纬度(高德):</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="latitudeGaode" missingMessage="请输入纬度(高德)"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 经度(百度):</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="longitudeBaidu" missingMessage="请输入经度(百度)"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 纬度(百度):</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="latitudeBaidu" missingMessage="请输入纬度(百度)"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 聚合区域中心点展开中心点经度（高德）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="extendCenterLongitudeGaode" missingMessage="请输入聚合区域中心点展开中心点经度（高德）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 聚合区域中心点展开中心点纬度（高德）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="extendCenterLatitudeGaode" missingMessage="请输入聚合区域中心点展开中心点纬度（高德）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 聚合区域中心点展开中心点经度（百度）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="extendCenterLongitudeBaidu" missingMessage="请输入聚合区域中心点展开中心点经度（百度）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 聚合区域中心点展开中心点纬度（百度）:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="extendCenterLatitudeBaidu" missingMessage="请输入聚合区域中心点展开中心点纬度（百度）"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 停车场个数:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="parkCount" missingMessage="请输入停车场个数"
			                		    data-options="required:true,validType:'length[1,10]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 操作标示 ADD：增加 UPDATE:修改 DELETE:删除:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="flag" missingMessage="请输入操作标示 ADD：增加 UPDATE:修改 DELETE:删除"
			                		    data-options="required:true,validType:'length[1,16]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 创建时间,默认SYSDATE:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="createTime" missingMessage="请输入创建时间,默认SYSDATE"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			     	 <tr>
							<td style="text-align: right;"> 更新时间,默认SYSDATE:</td>
							<td> 
								 <input class="easyui-validatebox" type="text" name="updateTime" missingMessage="请输入更新时间,默认SYSDATE"
			                		    data-options="required:true,validType:'length[1,19]'" />
							</td>					 
						</tr>
				   			</table>
     	</form>
  	 </div> 
  	 
  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/guidance/parkAggregation.js"></script>
  </body>
</html>
