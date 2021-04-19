<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
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
	<div class="datagrid-toolbar" region="north" style="height: 62px;" title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">提交人:</label><input name="createdBy" class="easyui-box ui-text" style="width: 100px;"> 
				<label class="ui-label">车牌号码:</label><input name="plateNo" class="easyui-box ui-text" style="width: 100px;"> 
				<label class="ui-label">区域名称:</label><input id="cityCode" name="cityCode" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
				<label class="ui-label">审核人:</label><input name="reviewer" class="easyui-box ui-text" style="width: 100px;"> 
				<label class="ui-label">审核状态:</label>
				<mytag:dictionary codeType="REVIEW_STATUS" id="reviewStatus" name="reviewStatus" isDefaultLine='1' dataOptions="required:false" style="width:120px;"/>
			</p>
			<a href="#" id="btn-search" class="easyui-linkbutton"
				iconCls="icon-search">查询</a> <a href="#" id="btn-reset"
				class="easyui-linkbutton" onclick="$('#searchForm').form('clear');"
				style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
		</form>
	</div>
	<!--  Search panel end -->

	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>
	
	<div id="handle" class="easyui-dialog"
		data-options="draggable:true,title:'车牌认证审核',iconCls:'icon-save',closed:true,maximizable:true,maximized:true,modal:true " style="width:660px; height:420px; padding:10px;top:60px;overflow-y:scroll;">
		<div id="license-photo-div" class="easyui-accordion" style="width:auto;height:auto;">   
		    <div id="photoDiv" title="行驶证照片(点击展开或折叠)" data-options="iconCls:'ext-icon-pictures'" style="overflow:auto;padding:10px;">
		    	<a class="control prev"></a><a class="control next abs"></a><!--自定义按钮，移动端可不写-->
		        <div id="picture" class="slider"><!--主体结构，请用此类名调用插件，此类名可自定义-->
		            <ul id="ulClass"></ul>
		        </div>
		    </div>
		</div>
		<div style="width:auto;height:auto;">
			<div title="审核" class="easyui-panel" data-options="iconCls:'ext-icon-hourglass'" style="padding:10px;width:1112px;">
		    	<table cellpadding="3px;" style="margin:0 0 50px 0;">
					<tr>
						<td style="text-align: right;">车牌号码：</td>
						<td id="plateNo"></td>
					</tr>
					<tr>
						<td style="text-align: right;">车牌颜色：</td>
						<td id="plateColor"></td>
					</tr>
					<tr>
						<td style="text-align: right;">通过/驳回原因：</td>
						<!-- <td colspan="2"><textarea name="reason" id="reason" style="height: 100px; width: 450px;" maxlength="225"></textarea></td> -->
						<td colspan="2"><div style="position:relative;"><span style="width:18px;overflow:hidden;">
										<select id="reasonSelect" style="height: 100px; width: 450px; background-color:#ececec; border:1px solid #dddddd;" maxlength="225" onchange="getReason();"> 
										  <option value="">===========以下为常见的驳回原因============</option>
										  <option value="您好！请上传清晰有效的车辆行驶证进行车牌认证！">您好！请上传清晰有效的车辆行驶证进行车牌认证！</option> 
										  <option value="您好！您上传的行驶证不清晰无法看清车牌，请上传清晰有效的车辆行驶证进行车牌认证！">您好！您上传的行驶证不清晰无法看清车牌，请上传清晰有效的车辆行驶证进行车牌认证！</option>
										  <option value="您好！您绑定的车牌颜色与实际不符，请在app修改车牌颜色，再上传车辆行驶证进行认证！">您好！您绑定的车牌颜色与实际不符，请在app修改车牌颜色，再上传车辆行驶证进行认证！</option> 
										  <option value="您好！您上传的行驶证无法看到完整的车牌，请上传清晰有效的车辆行驶证进行车牌认证！">您好！您上传的行驶证无法看到完整的车牌，请上传清晰有效的车辆行驶证进行车牌认证！</option>
										  <option value="您好！行驶证的车牌与认证的车牌不一致，请上传清晰有效的车辆行驶证进行车牌认证！">您好！行驶证的车牌与认证的车牌不一致，请上传清晰有效的车辆行驶证进行车牌认证！</option> 
										</select></span><input name="reason" id="reason" style="height: 100px; width: 433px;position:absolute;left:0px;border:1px solid #dddddd;" maxlength="225"></div></td>
					</tr>
				</table>   
				<div style="width:80px;float:left;position: relative;left:10%;">
					<a id="pass" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'" style="margin:0 auto;">通过</a>  
				</div> 
                   <div style="width:80px;float:left;position: relative;left:30%;">
					<a id="reject" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-arrow_undo'">驳回</a>  
				</div>
			</div>
		</div>  
	</div>
	
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/appsystem/YuxiSlider.jQuery.min.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/user/reviewLog.js"></script>
</body>
</html>
