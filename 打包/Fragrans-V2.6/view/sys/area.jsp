<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=G0QfVTKgBgDbgLMXB0QbrheA"></script>
</head>
<body class="easyui-layout">
	<!-- DataList  -->
	<div region="center" border="false">
		<table id="data-list"></table>
	</div>
<div id="edit-win" class="easyui-dialog"
		data-options="draggable:true,title:'区域信息',iconCls:'icon-save',closed:true,maximizable:true,modal:true "
		style="width: 650px; height:430px; padding: 10px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id"> 
			<input class="hidden" name="areaLevel">
			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">区域名称:</td>
					<td>
						<input class="easyui-validatebox" type="text"  name="areaName" missingMessage="请输入区域名称" 
 							   data-options="required:true,validType:'length[1,25]'">
 					</td>
				 
					<td style="text-align: right;">区域代码:</td>
					<td > 
						<input class="easyui-numberbox" type="text"  name="areaCode" missingMessage="请输入区域编码" data-options="required:true,validType:['length[1,10]']"/> 
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">网关地址:</td>
					<td colspan="3">
						<input class="easyui-validatebox" type="text" name="gatewayUrl" missingMessage="请输入网关地址"
  						data-options="validType:['length[1,200]']"  style="width:400px;"/>
 					</td>
 				</tr>
 				<tr>
					<td style="text-align: right;"> 是否支持支付: </td>
					<td>  
						<mytag:dictionary codeType="YESORNO" id="isSupportPay" name="isSupportPay" />
					</td>
					<td style="text-align: right;"> 是否支持对账: </td>
					<td>  
						<mytag:dictionary codeType="YESORNO" id="isSupportAccount" name="isSupportAccount" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right;"> 是否上线: </td>
					<td>  
						<mytag:dictionary codeType="IS_ONLINE" id="isOnline" name="isOnline" />
					</td>
					<td style="text-align: right;"> 是否支持批量缴费: </td>
					<td>  
						<mytag:dictionary codeType="YESORNO" id="isBatchpay" name="isBatchpay" />
					</td>
				</tr>
				
				<tr>
					<td style="text-align: right;">百度地图中心点经度 :</td>
					<td> 
						<input class="easyui-validatebox" type="text" name="longitudeBaidu" id="longitudeBaidu" missingMessage="请输入百度地图中心点经度"
 							data-options="required:true" readonly="readonly">
					</td>
					<td style="text-align: right;">百度地图中心点纬度:</td>
					<td> 
						<input class="easyui-validatebox" type="text" name="latitudeBaidu" id="latitudeBaidu" missingMessage="请输入百度地图中心点纬度"
							data-options="required:true" readonly="readonly">
						<img src="${pageContext.request.contextPath}/assets/images/ext_icons/map/map.png" onclick="openMap(120.162145,30.279001)" />  
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">所属区域:</td>
					<td> 
						 <input id="regionTree" name="parentId" class="easyui-combotree"  data-options="fit : true,required:true" />
						 <img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png" onclick="$('#regionTree').combotree('clear');" />  
					</td>
					<td style="text-align: right;"> 排序号: </td>
					<td>  
						<input id="displayNo" name="displayNo" class="easyui-validatebox easyui-numberspinner"
							data-options="required:true,min:0,max:99" missingMessage="请输入排序号" style="width: 134px;" />
					</td>
				</tr>
				<tr>
 					<td style="text-align: right;"> 是否支持批量删除: </td>
					<td>  
						<mytag:dictionary codeType="YESORNO" id="isDeleteParkrecord" name="isDeleteParkrecord" />
					</td>
					<td style="text-align: right;"> 是否支持会员卡支付: </td>
					<td>  
						<mytag:dictionary codeType="YESORNO" id="isMemberCardPay" name="isMemberCardPay" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">城市拼音:</td>
					<td>
						<input class="easyui-validatebox" type="text"  name="citySpell"
 							   data-options="required:false,validType:'length[1,36]'">
 					</td>
				</tr>
				<tr>
					<td style="text-align: right;">备注:</td>
					<td colspan="3">
						<input class="easyui-validatebox" type="text"  
							name="remark" missingMessage="请输入备注" data-options="validType:'length[1,100]'"
							style="width:400px;" />  
					</td>
				</tr>
				
			</table>
		</form>
	</div>


	
	<div id="map" class="easyui-dialog" style="width:650px;height:480px;padding:5px"
         closed="true" >
         <div id="allMap" style="height:420px;width:570px" ></div>
    </div>
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/sys/area.js"></script>
</body>
</html>