<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/view/inc.jsp" %>
   <link rel="stylesheet" href="<%=basePath%>/assets/css/showPhoto/style.css">
   <style type="text/css">
		#picture {
			margin: 0 auto;
			width: 500px;
			padding: 0;
			text-align: center;
		}
		
		#picture img {
			max-width: 500px;
			width: expression(document.body.clientWidth > document.getElementById ("picture").scrollWidth*9/10? "500px": "auto");
		}
	</style>
  </head>
	<body class="easyui-layout">
	<!-- Search panel start -->
 	 <div class="datagrid-toolbar" region="north" style="height:62px;" title="过滤条件" 
 	 	  data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false" >  
 	 <form id="searchForm">
 	 	<p class="ui-fields">
 	 		<label class="ui-label">车位状态:</label><mytag:dictionary name="status" id="status" codeType="PARKSPACE_STATUS" isDefaultLine="1" dataOptions="required:false"/>
 	 		<label class="ui-label">车位类型:</label><mytag:dictionary name="type" id="type" codeType="PARKSPACE_TYPE" isDefaultLine="1" dataOptions="required:false"/>
 	 		<label class="ui-label">用户账号:</label><input name="createdBy" class="easyui-box ui-text" style="width:100px;">
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
     
     <!--照片-->
	 <div id="photoDiv" class="easyui-dialog" title="照片(点击箭头切换)" data-options="closed:true" style="width:640px; height:420px; padding:10px;top:60px;overflow-y:scroll;">
        <a class="control prev"></a><a class="control next abs"></a><!--自定义按钮，移动端可不写-->
        <div id="picture" class="slider" style="width: 500px; height:470px;"><!--主体结构，请用此类名调用插件，此类名可自定义-->
            <ul id="ulClass"></ul>
        </div>
    </div>
    
    <div id="reviewDiv" class="easyui-dialog" title="提交审核结果" data-options="closed:true" style="width:580px; height:320px;padding:50px 0 0 20px;">
  		<table cellpadding="3px;" style="margin:0 0 50px 0;">
			<tr>
				<td style="text-align: right;">审核结果：</td>
				<td colspan="2"><textarea name="reviewResult" id="reviewResult" style="height: 100px; width: 430px;" maxlength="1024"></textarea></td>
			</tr>
		</table>   
		<div style="width:80px;float:left;position: relative;left:15%;">
			<a id="pass" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'" style="margin:0 auto;">通过</a>  
		</div> 
        <div style="width:80px;float:left;position: relative;left:25%;">
			<a id="reject" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-arrow_undo'">驳回</a>  
		</div>
		<div style="width:80px;float:left;position: relative;left:35%;">
			<a id="cancle" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-cancel'">取消车位</a>  
		</div>
     </div>

  	<!-- js -->
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/rent/parkSpaceInfo.js"></script>
	<script type="text/javascript" src="<%=basePath%>/assets/js/business/fragrans/appsystem/YuxiSlider.jQuery.min.js"></script>
  </body>
</html>
