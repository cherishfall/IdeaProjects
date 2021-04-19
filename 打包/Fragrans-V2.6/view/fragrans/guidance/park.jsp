<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=G0QfVTKgBgDbgLMXB0QbrheA"></script>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 62px;"
		title="过滤条件"
		data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">区域名称:</label><input name="areaId" class="easyui-combotree ui-text" style="width:130px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
				<label class="ui-label">停车点名称:</label><input name="name"
					class="easyui-box ui-text" style="width: 100px;">
				<label class="ui-label">停车点类型:</label>
				<mytag:dictionary codeType="PARK_MODEL" id="parkType"
					name="parkType" isDefaultLine='1' dataOptions="required:false" />
				<label class="ui-label">是否是动态数据:</label>
				<mytag:dictionary codeType="YESORNO" id="isDynamic" name="isDynamic"
					isDefaultLine='1' dataOptions="required:false" />
				<label class="ui-label">是否开放:</label>
				<mytag:dictionary codeType="YESORNO" id="isOpen" name="isOpen"
					isDefaultLine='1' dataOptions="required:false" />
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

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="停车点信息"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 650px; height: 500px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">停车点名称:</td>
					<td><input class="easyui-validatebox" type="text" name="name"
						missingMessage="请输入停车点名称"
						data-options="required:true,validType:'length[1,50]'" /></td>
					<td style="text-align: right;">停车点编码:</td>
					<td><input class="easyui-validatebox" type="text"
						name="parkCode" missingMessage="请输入停车点编码"
						data-options="required:true,validType:'length[1,64]'" /></td>
				</tr>

				<tr>
					<td style="text-align: right;">停车点类型:</td>
					<td><mytag:dictionary codeType="PARK_MODEL" id="parkType"
							name="parkType" /></td>
					<td style="text-align: right;">停车点地址:</td>
					<td><input class="easyui-validatebox" type="text"
						name="address" missingMessage="请输入停车点地址"
						data-options="required:false,validType:'length[1,255]'" /></td>
				</tr>

				<tr>
					<td style="text-align: right;">所在城市:</td>
					<td><input id="cityId" name="cityId" 
						class="easyui-combotree"
						data-options="url:'${pageContext.request.contextPath}/area/getCity.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:true" />
						<img
						src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						onclick="$('#cityId').combotree('clear');"/></td>
					<td style="text-align: right;">所在区域:</td>
					<td><input id="areaId" name="areaId"
						class="easyui-combotree"
						data-options="url:'${pageContext.request.contextPath}/area/getArea.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:true"/>
						<img
						src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						onclick="$('#areaId').combotree('clear');" /></td>
				</tr>

				<tr>
					<td style="text-align: right;">联系人:</td>
					<td><input class="easyui-validatebox" type="text"
						name="contacts" missingMessage="请输入联系人"
						data-options="required:false,validType:'length[1,50]'" /></td>
					<td style="text-align: right;">联系电话:</td>
					<td><input class="easyui-validatebox" type="text" name="phone"
						missingMessage="请输入联系电话"
						data-options="required:false,validType:'mobile'" /></td>
				</tr>

				<tr>
					<td style="text-align: right;">总泊位数:</td>
					<td><input class="easyui-numberbox" type="text"
						name="totalBerthNum" missingMessage="请输入总泊位数"
						data-options="required:true,validType:['length[1,10]']" /></td>
					<td style="text-align: right;">报备总泊位数:</td>
					<td><input class="easyui-numberbox" type="text"
						name="filingBerthNum" missingMessage="请输入报备总泊位数"
						data-options="required:false,validType:['length[1,10]']" /></td>

				</tr>
				<tr>

					<td style="text-align: right;">白天价格:</td>
					<td><input class="easyui-validatebox" type="text"
						name="dayRate" missingMessage="请输入白天价格"
						data-options="required:false,validType:'length[1,100]'" /></td>
					<td style="text-align: right;">晚上价格:</td>
					<td><input class="easyui-validatebox" type="text"
						name="nightRate" missingMessage="请输入晚上价格"
						data-options="required:false,validType:'length[1,100]'" /></td>
				</tr>

				<tr>
					<td style="text-align: right;">百度地图中心点经度 :</td>
					<td><input class="easyui-validatebox" type="text"
						name="longitudeBaidu" id="longitudeBaidu"
						missingMessage="请输入百度地图中心点经度" data-options="required:true"></td>
					<td style="text-align: right;">百度地图中心点纬度:</td>
					<td><input class="easyui-validatebox" type="text"
						name="latitudeBaidu" id="latitudeBaidu"
						missingMessage="请输入百度地图中心点纬度" data-options="required:true">
						<img src="${pageContext.request.contextPath}/assets/images/ext_icons/map/map.png"
						onclick="openMap(120.162145,30.279001)" /></td>
				</tr>



				<tr>
					<td style="text-align: right;">是否是动态数据:</td>
					<td><mytag:dictionary codeType="YESORNO" id="isDynamic"
							name="isDynamic" /></td>
					<td style="text-align: right;">是否开放:</td>
					<td><mytag:dictionary codeType="YESORNO" id="isOpen"
							name="isOpen" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">最低停车收费金额:</td>
					<td><input class="easyui-numberbox" type="text"
						name="minRate"
						data-options="required:false,validType:['length[1,10]']" /></td>
					<td style="text-align: right;">是否支付宝认证停车点:</td>
					<td><mytag:dictionary codeType="YESORNO" id="isAliPark"
							name="isAliPark" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">备注:</td>
					<td colspan="3"><textarea name="remark"
							style="height: 50px; width: 390px;" maxlength="100"></textarea></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="map" class="easyui-dialog"
		style="width: 650px; height: 480px; padding: 5px" closed="true">
		<div id="allMap" style="height: 420px; width: 570px"></div>
	</div>
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/guidance/park.js"></script>
</body>
</html>
