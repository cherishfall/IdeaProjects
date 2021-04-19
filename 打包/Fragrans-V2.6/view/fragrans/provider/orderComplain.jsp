<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/view/inc.jsp"%>
<script type="text/javascript" src="<%=basePath%>/assets/js/commons/datagrid-detailview.js"></script>
</head>
<body class="easyui-layout">
	<!-- Search panel start -->
	<div class="datagrid-toolbar" region="north" style="height: 62px;" title="过滤条件" data-options="striped: true,collapsible:true,iconCls:'icon-search',border:false">
		<form id="searchForm">
			<p class="ui-fields">
				<label class="ui-label">区域名称:</label><input name="cityCode" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false"/>
				<label class="ui-label">用户账号:</label><input name="userAccount" class="easyui-box ui-text" style="width:100px;">
				<label class="ui-label">车牌号:</label><input name="palteNo" class="easyui-box ui-text" style="width:100px;">
				<label class="ui-label">处理状态:</label><mytag:dictionary codeType="COMPLAIN_STATUS" id="status" name="status" isDefaultLine='1' dataOptions="required:false"/>  
				<label class="ui-label">退款状态:</label><mytag:dictionary codeType="REFUND_STATUS" id="refundFlag" name="refundFlag" isDefaultLine='1' dataOptions="required:false"/>  
			</p>
			<a href="#" id="btn-search" class="easyui-linkbutton"
				iconCls="icon-search" onclick="submitForm(this)">查询</a> <a href="#" id="btn-reset"
				class="easyui-linkbutton" onclick="$('#searchForm').form('clear');"
				style="margin-top: 3px;" iconCls="ext-icon-application_reset">重置</a>
		</form>
	</div>
	<!--  Search panel end -->
	<!-- DataList  -->
	<div region="center" border="false">
		<div id="ComplainTabs" class="easyui-tabs" data-options="fit:true,border:false,plain:true">
	       <div id="myWork" title="我的工作" style="padding:10px;position: relative;top:10px;" >
	           <table id="data-list" class="easyui-datagrid"></table>
	       </div>
	       <div id="orderComplain" title="订单投诉" style="padding:10px;position: relative;top:-5px;">
	                   　    <table id="data-list-2" class="easyui-datagrid"></table>
	       </div>
	</div>
	</div>

	<!-- Edit Form -->
	<div id="edit-win" class="easyui-dialog" title="编辑"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 500px; height: 400px;">
		<form id="editForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<!-- <input class="hidden" name="deleted"> -->

			<table cellpadding="5px;">
				<tr>
					<td style="text-align: right;">城市名称:</td>
					<td><input id="areaName" name="areaName" class="easyui-combotree"  data-options="fit : true,required:true" />
					<img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png" onclick="$('#areaName').combotree('clear');" />  
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">用户账号:</td>
					<td><input class="easyui-validatebox" type="text" id="userAccount"
						name="userAccount" missingMessage="请输入用户账号"
						data-options="required:true,validType:'length[1,36]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">车牌号:</td>
					<td><input class="easyui-validatebox" type="text" id="palteNo"
						name="palteNo" missingMessage="请输入车牌号"
						data-options="validType:'length[1,64]'" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">是否完成订单:</td>
					<td><mytag:dictionary name="isComplate" id="isComplate"
							codeType="IS_COMPLATE" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">投诉类型:</td>
					<td><mytag:dictionary name="complainType" id="complainType"
							codeType="COMPLAIN_TYPE" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">投诉来源:</td>
					 <td> <select class="selector" id="complainResource" name="complainResource">
   							<option value="2" selected="selected">电话投诉</option>
   							<option value="3">其他</option>
 						</select>
					 </td>
				</tr>
				<tr>
					<td style="text-align: right;">投诉内容:</td>
					<td><textarea id="addComplainDesc" name="addComplainDesc" cols="50" rows="4" 
					 class="easyui-validatebox" type="text"
						 missingMessage="请输入投诉内容"
						data-options="validType:'length[1,2000]'" ></textarea> </td>
				</tr>
			</table>
		</form>
	</div>


	<div id="handle" class="easyui-dialog"
		data-options="draggable:true,title:'投诉处理',iconCls:'icon-save',closed:true,maximizable:true,modal:true " style="width: 600px; height: 465px; padding: 10px;">
		<div id="cc" class="easyui-layout" style="width: 550px; height: 395px;">
			<div data-options="region:'north',split:true" style="width: 500px; height: 215px;">
				<form id="editForm" class="ui-form" method="post">
					<input class="hidden" type="text" name="id">
					<!-- <input class="hidden" name="deleted"> -->
					<table cellpadding="5px;">
						<tr>
							<td style="text-align: right;">申诉描述:</td>
							<td colspan="3"><p id="complainDesc" style=" width: 390px;"> </p></td>
						</tr>
					</table>
					<table cellpadding="5px;">
						<tr>
							<td style="text-align: right;">日志描述:</td>
							<td colspan="2"><textarea name="eventdesc" id="eventdesc"
							style="height: 50px; width: 390px;" maxlength="100"></textarea></td>
						</tr>
					</table>
					<div id="radioDiv" style="padding-bottom:3px;">
					<table cellpadding="3px;">
						<tr>
							<td style="text-align: right;">可处理:</td>
							<td style="text-align: right;">
								<input name="handleRedio" type="radio" value="0" checked="checked" onclick="hiddenReverse()"/> 
							</td>
							<td style="text-align: right;">不可处理</td>
							<td style="text-align: right;">
								<input name="handleRedio" type="radio" value="1"  onclick="showReverse()"/>
							</td>
						</tr>
					</table>
					</div>
					<div id="reverseDiv" style="visibility:hidden;height:25px;width:456px;">
						<table cellpadding="3px;">
						<tr>
							<td style="text-align: right;">扭转角色:</td>
							<td >
								<input id="reverseRole" name="reverseRole" class="easyui-combobox" />
					            <img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						           onclick="$('#reverseRole').combobox('clear');"/>
							</td>
						</tr>
					</table>
					</div>
                    <div style="width:230px;float:right;position: relative;top:15px;">
						<a id="finish" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'">完成申诉</a>  
					</div>
					<div style="width:160px;float:right;position: relative;top:15px;">
						<a id="confirm" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="margin:0 auto;">确定</a>  
					</div> 
				</form>
			</div> 
			<div data-options="region:'center',title:'投诉处理日志（双击进行修改）'" style="padding: 5px;width: 500px; height:150px;">
				<form id="editForm" class="ui-form" method="post" style="width: 500px; height:120px;">
					<table id="log"></table>
				</form>
			</div>
		</div>
	</div>
		
		<div id="viewProcess" class="easyui-dialog"
			data-options="draggable:true,title:'投诉处理',iconCls:'icon-save',closed:true,maximizable:true,modal:true " style="width: 1100px; height: 440px; padding: 10px;">
		<div id="processCc" class="easyui-layout" style="width: 1050px; height: 380px;">
			<div data-options="region:'north',split:true" style="width: 1020px; height: 215px;">
				<form class="ui-form" method="post">
					<input class="hidden" type="text" name="id">
					<table cellpadding="5px;">
						<tr>
							<td style="text-align: right;">申诉描述:</td>
							<td colspan="3"><p id="processComplainDesc" style=" width: 590px;"> </p></td>
						</tr>
					</table>
					<table id="processLog" ></table> 
				</form>
			</div> 
			<div  data-options="region:'center'" style="padding: 5px;width: 700px; height:165px;">
				<form id="processEditForm" class="ui-form" method="post">
				<table cellpadding="3px;">
						<tr>
							<td style="text-align: right;">处理意见:</td>
							<td colspan="2"><textarea name="processResult" id="processResult"
							style="height: 50px; width: 390px;" maxlength="100"></textarea></td>
						</tr>
				</table>
					<div id="processReverseDiv" style="height:25px;width:456px;">
						<table cellpadding="3px;">
						<tr>
							<td style="text-align: right;">扭转角色:</td>
							<td >
								<input id="processReverseRole" name="processReverseRole" class="easyui-combobox" />
					            <img src="${pageContext.request.contextPath}/assets/images/ext_icons/cut_red.png"
						           onclick="$('#processReverseRole').combobox('clear');"/>
							</td>
						</tr>
					</table>
					</div>
					<div style="width:160px;float:left;position: relative;top:15px;left:50px;">
						<a id="processConfirm" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="margin:0 auto;">确定</a>  
					</div> 
                    <div style="width:230px;float:left;position: relative;top:15px;">
						<a id="processClose" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'">关闭</a>  
					</div>
				</form>
			</div>
		</div>
	<!-- detail -->
	<div id="detail" class="easyui-dialog" title="停车记录详情"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 800px; height: 400px;">
	</div>
	
	<div id="updateRefundStatus" class="easyui-dialog" title="更改申诉退款状态"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 250px;">
		<div style="">
		<form id="updateRefundStatusForm" class="ui-form" method="post">
		<table cellpadding="5px;" style="position:relative;left:30px;top:30px">
			<tr>
			  <td style="text-align: right;">退款处理状态:</td>
			  <td><select class="selector" id="refundFlag" name="refundFlag">
   					<option value="1" selected="selected">无退款</option>
   					<option value="2">需要退款</option>
 				  </select></td>
			</tr>
		</table>
		</form>
		</div>
		<div style="width:100px;float:left;position: relative;top:110px;left:70px;">
			<a id="refundConfirm" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="margin:0 auto;">确定</a>  
		</div> 
        <div style="width:100px;float:left;position: relative;top:110px;left:80px;"">
			<a id="refundClose" href="#" class="easyui-linkbutton" data-options="iconCls:'ext-icon-tick'">关闭</a>  
		</div>
		
	</div>
	
	<div id="exportOrderComplain" class="easyui-dialog" title="导出申诉表"
		data-options="closed:true,iconCls:'icon-save',modal:true"
		style="width: 350px; height: 260px;" singleSelect:false>
		<form id="exportOrderComplainForm" class="ui-form" method="post">
			<input class="hidden" type="text" name="id">
			<div class="ui-edit">
				<div class="fitem">
				<div style="padding:5px;">
				<label class="ui-label">城市名称:</label><input id="exp_cityCode" name="cityCode" class="easyui-combotree ui-text" style="width:150px;" data-options="url:'${pageContext.request.contextPath}/area/getAreaTree.do',fit : true,
						idField : 'id',treeField : 'areaName',parentField : 'parentId',required:false" />
				</div>
				<div style="padding:5px;">
				<label class="ui-label">处理状态:</label>
				<mytag:dictionary name="status" id="status" codeType="COMPLAIN_STATUS" dataOptions="required:false"/>
				</div>
				<div style="padding:5px;">
					<label>开始日期:</label> 
					<input id="startDate" name="startDate" class="easyui-datebox" data-options="width:150" />
				</div>
				<div style="padding:5px;">
					<label>结束日期:</label> 
					<input id="endDate" name="endDate" class="easyui-datebox" data-options="width:150" />
				</div>	
				</div>
			</div>
		</form>
	</div>
	
	</div>
	<!-- js -->
	<script type="text/javascript"
		src="<%=basePath%>/assets/js/business/fragrans/provider/orderComplain.js"></script>
</body>
</html>
