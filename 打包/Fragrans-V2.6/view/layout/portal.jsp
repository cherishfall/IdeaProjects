<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/view/inc.jsp"%>
<body>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/assets/css/index/font-awesome.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/assets/css/index/style.css" />
<style>
.page_container { border: 0px; width:100%; margin:0 auto; text-align:left; height:680px;  }  
.banner { height:50%; /*     background:red; */ clear:both; }  
.bottom { clear:both; /*       background:blue;   */ height:50%; }
/*数字滚动插件的CSS可调整样式*/
.mt-number-animate{ font-family: '微软雅黑'; line-height:40px; height: 40px;
/*设置数字显示高度*/; 
font-size: 36px;
/*设置数字大小*/ 
overflow: hidden; display: inline-block; position: relative; }
.mt-number-animate .mt-number-animate-dot{ width: 15px;
/*设置分割符宽度*/ 
line-height: 40px; float: left; text-align: center;}
.mt-number-animate .mt-number-animate-dom{ width: 17px;
/*设置单个数字宽度*/ 
text-align: center; float: left; position: relative; top: 0;}
.mt-number-animate .mt-number-animate-dom .mt-number-animate-span{ width: 100%; float: left;}
</style>
	
    <div id="main" style="width:100%;height:100%;">
        <div data-options="region:'center',border:0" style="padding:10px">
			<div style="width:100%;height:70%;">     		
				 <div class="wrapper">
						<%--<div class="counter col_fourth">--%>
							<%--<i class="fa fa-user fa-2x"></i>--%>
							<%--<h2 class="count-title" id="registerUserCount" data-to="0">0</h2>--%>
							<%--<p class="count-text ">注册用户</p>--%>
						<%--</div>--%>
						<%----%>
						<%--<div class="counter col_fourth">--%>
							<%--<i class="fa fa-user-md fa-2x"></i>--%>
							<%--<h2 class="count-title" id="activityUserCount" data-to="0">0</h2>--%>
							<%--<p class="count-text ">活跃用户</p>--%>
						<%--</div>--%>
						<%----%>
						<%--<div class="counter col_fourth">--%>
							<%--<i class="fa fa-rmb fa-2x"></i>--%>
							<%--<h2 class="count-title" id="payOrderUserCount" data-to="0">0</h2>--%>
							<%--<p class="count-text ">缴费用户</p>--%>
						<%--</div>--%>
						<%----%>
						<%--<div class="counter col_fourth">--%>
							<%--<i class="fa fa-group fa-2x"></i>--%>
							<%--<h2 class="count-title" id="registerTotalUserCount" >0</h2>--%>
							<%--<p class="count-text ">累计用户</p>--%>
						<%--</div>--%>
						<%----%>
						<%--&lt;%&ndash;<div class="counter col_fifth end">&ndash;%&gt;--%>
							<%--&lt;%&ndash;<i class="fa fa-signal fa-2x"></i>&ndash;%&gt;--%>
							<%--&lt;%&ndash;<h2 class="count-title" id="UserGrowthCount" data-to="0">0</h2>&ndash;%&gt;--%>
							<%--&lt;%&ndash;<p class="count-text " id="usergrowthCountText">同比增长(%)</p>&ndash;%&gt;--%>
						<%--&lt;%&ndash;</div>&ndash;%&gt;--%>
					<%----%>
					<%--</div>--%>
				<%----%>
					<%--<div class="wrapper">--%>
						<%--<div class="counter col_fourth">--%>
							<%--<i id="end" class="fa fa-ruble fa-2x"></i>--%>
							<%--<h2 class="count-title" id="totalSuccessPayFee" data-to="0">0</h2>--%>
							<%--<p class="count-text ">缴费总金额</p>	   --%>
						<%--</div>--%>
						<%----%>
						<%--<div class="counter col_fourth">--%>
							<%--<i class="fa fa-rupee fa-2x"></i>--%>
							<%--<h2 class="count-title" id="alipayOrderPayAmount" data-to="0">0</h2>--%>
							<%--<p class="count-text ">支付宝金额</p>--%>
						<%--</div>--%>
						<%----%>
						<%--<div class="counter col_fourth">--%>
							<%--<i class="fa fa-comments fa-2x"></i>--%>
							<%--<h2 class="count-title" id="wxpayOrderPayAmount" data-to="0">0</h2>--%>
							<%--<p class="count-text ">微信金额</p>--%>
						<%--</div>--%>
					<%----%>
						<%--<div class="counter col_fourth">--%>
							<%--<i class="fa fa-comments-o fa-2x"></i>--%>
							<%--<h2 class="count-title" id="otherOrderPayAmount" data-to="0">0</h2>--%>
							<%--<p class="count-text ">其他金额</p>--%>
						<%--</div>--%>
						<%----%>
						<%--&lt;%&ndash;<div class="counter col_fifth end">&ndash;%&gt;--%>
							<%--&lt;%&ndash;<i class="fa fa-ticket fa-2x"></i>&ndash;%&gt;--%>
							<%--&lt;%&ndash;<h2 class="count-title" id="ticketOrderPayAmount" data-to="0">0</h2>&ndash;%&gt;--%>
							<%--&lt;%&ndash;<p class="count-text ">优惠金额</p>&ndash;%&gt;--%>
						<%--&lt;%&ndash;</div>&ndash;%&gt;--%>
					<%--</div>--%>
			   <%--</div>--%>

			<!-- 支付统计 -->
			<div data-options="border:0">
				<div style="width:100%;height:75%;">
					<div style="float:left;width:45%; text-align:center;">
						<chart:line id="memberWeekRecharge" title="会员卡过去七天充值曲线图" urls="/charts/memberLine.do?days=7" height="100%" width="100%"/>
					</div>
					<div style="float:left;width:40%; text-align:center;">
						<chart:pie id="memberRechargeRate" title="今日会员卡充值金额比例" urls="/charts/memberRechargeRatePie.do" height="100%" width="100%"/>
					</div>
					<div style="float:left;width:15%; text-align:left;margin-top:10%;">
						<div style="font-weight: bold;font-size: 14px;padding-bottom: 20px;">
							今日充值：￥<span id="todayMemberRechargeAmount"></span>
						</div>
						<div style="font-weight: bold;font-size: 14px;padding-bottom: 20px;">
							今日消费：￥<span id="todayMemberConsumeAmount"></span>
						</div>
						<div style="font-weight: bold;font-size: 14px;padding-bottom: 20px;">
							今日充值人数：<span id="todayMemberRechargeUserCount"></span>
						</div>
						<div style="font-weight: bold;font-size: 14px;padding-bottom: 20px;">
							今日充值订单数：<span id="todayMemberRechargeCount"></span>
						</div>
					</div>
				</div>
			</div>
        
				<!-- 支付统计 -->
               <div class="easyui-tabs" data-options="border:0">
					<div align="center"  data-options="title:'今天',iconCls:'iconImg ext-icon-report'">
						<div class="page_container">  
						    <div class="banner">
						     		<%--
						     		<chart:rosepie id="yesterday_char" title="支付概况统计" 
						     		urls="/charts/RosePie.do?days=0" width="1080" height="330"></chart:rosepie> 
						     		--%>
						    </div>   
						    <div class="bottom">
						    	 	<!-- 			  用户统计 -->
						     		<div style="width:100%;height:100%;">
								       <div style="float:left;width:50%; text-align:center;">
									   		<chart:standardringpie id="registerUserCompare" title="终端类型占比" urls="/charts/StandardRingPie.do?days=0" displaylabel="true" displaytitle="false" width="98%" height="95%"></chart:standardringpie>
									   </div>
								       <div style="float:left;width:50%; text-align:center;">
								       		<chart:ringpie id="dayStat" title="注册用户占比" urls="/charts/RingPie.do?days=0" displaylabel="true" displaytitle="false" width="98%" height="95%"></chart:ringpie>
								       </div>
								    </div>
						    </div>  
						</div>  
					</div>
					<div align="center" data-options="title:'昨天',iconCls:'iconImg ext-icon-report'">
						 <div class="page_container">  
						    <div class="banner">
						     		<%--
						     		<chart:rosepie id="yesterday_char_1" title="支付概况统计" 
						     		urls="/charts/RosePie.do?days=1" width="1080" height="330"></chart:rosepie> 
						     		--%>
						    </div>   
						    <div class="bottom">
						    	 	<!-- 			  用户统计 -->
						     		<div style="width:100%;height:100%;">
								       <div style="float:left;width:50%; text-align:center;">
									   		<chart:standardringpie id="registerUserCompare_1" title="终端类型占比" urls="/charts/StandardRingPie.do?days=1" displaylabel="true" displaytitle="false" width="98%" height="95%"></chart:standardringpie>
									   </div>
								       <div style="float:left;width:50%; text-align:center;">
								       		<chart:ringpie id="dayStat_1" title="注册用户占比" urls="/charts/RingPie.do?days=1" displaylabel="true" displaytitle="false" width="98%" height="95%"></chart:ringpie>
								       </div>
								    </div>
						    </div>  
						</div> 
					</div>
				</div>

				<!-- 最近七天收入统计 -->
			    <div style="width:100%;height:75%;padding:40px 0 0 0;">
			    	<chart:ybar id="weekStatUser" title="最近七天用户统计" urls="/charts/userLine.do?days=7" height="100%" width="100%" ></chart:ybar>
			    </div>
				
				<!-- 最近七天支付统计 -->
				<div style="width:100%;height:75%;padding:40px 0 0 0;">
			    	<chart:line_bar_pie height="100%" width="100%" urls="/charts/lineBarPie.do?days=7" title="最近七天支付统计" id="statDaily"/>
			    </div>
			    
			    <!-- 最近七天收入统计 -->
			    <div style="width:100%;height:75%;padding:40px 0 0 0;">
			    	<chart:line id="weekStat" title="最近七天收入统计" urls="/charts/line.do?days=7" height="100%" width="100%" ></chart:line>
			    </div>
        </div>
    </div>
    
	<script src="<%=basePath%>/assets/js/index/index.js"></script>
	<script src="<%=basePath%>/assets/js/index/NumberScrollPlus.js"></script>
	<script src="<%=basePath%>/assets/js/index/jquery_fly.js"></script>
    
    <%--<script type="text/javascript">--%>
        <%--$(function(){--%>
          <%--$('#main').layout();--%>
          <%--//初始化指标--%>
          <%--var registerUserCount = 0;--%>
          <%--var activityUserCount = 0;--%>
          <%--var registerTotalUserCount = 0;--%>
          <%--var totalSuccessPayFee = 0;--%>
          <%--var wxpayOrderPayAmount = 0;--%>
<%--//          var ticketOrderPayAmount = 0;--%>
          <%--var otherOrderPayAmount = 0;--%>
          <%--var alipayOrderPayAmount = 0;--%>
          <%--var payOrderUserCount = 0;--%>
<%--//          var UserGrowthCount = 0;--%>
          <%--var todayMemberRechargeAmount = 0;--%>
          <%--var todayMemberConsumeAmount = 0;--%>
          <%--var todayMemberRechargeUserCount = 0;--%>
          <%--var todayMemberRechargeCount = 0;--%>


          <%--function reflushData(){--%>
        	  <%--var url = "<%=basePath%>/homeStat/refreshData.do";--%>
        	  <%--$.ajax({--%>
        			<%--url : url,--%>
        			<%--type : 'get',--%>
        			<%--async:false,--%>
        			<%--success : function(resultObj) {--%>
        				<%--//注册用户数--%>
        				<%--registerUserCount = resultObj.registerUserCount;--%>
        				<%--activityUserCount = resultObj.activityUserCount;--%>
        				<%--registerTotalUserCount = resultObj.registerTotalUserCount;--%>
        				<%--payOrderUserCount = resultObj.payOrderUserCount;--%>
        				<%--totalSuccessPayFee = resultObj.totalSuccessPayFee;--%>
        				<%--wxpayOrderPayAmount = resultObj.wxpayOrderPayAmount;--%>
        				<%--otherOrderPayAmount = resultObj.otherOrderPayAmount;--%>
<%--//        				ticketOrderPayAmount = resultObj.ticketOrderPayAmount;--%>
        				<%--alipayOrderPayAmount = resultObj.alipayOrderPayAmount;--%>
<%--//        				UserGrowthCount = resultObj.UserGrowthCount;--%>
                        <%--todayMemberRechargeAmount = resultObj.todayMemberRechargeAmount;--%>
                        <%--todayMemberConsumeAmount = resultObj.todayMemberConsumeAmount;--%>
                        <%--todayMemberRechargeUserCount = resultObj.todayMemberRechargeUserCount;--%>
                        <%--todayMemberRechargeCount = resultObj.todayMemberRechargeCount;--%>

        				<%--setRunNumber($("#registerUserCount"),registerUserCount,0,false);--%>
        				<%--setRunNumber($("#activityUserCount"),activityUserCount,0,false);--%>
        				<%--setRunNumber($("#registerTotalUserCount"),registerTotalUserCount,0,false);--%>
        				<%--setRunNumber($("#payOrderUserCount"),payOrderUserCount,0,false);--%>
        				<%----%>
        				<%--setRunNumber($("#wxpayOrderPayAmount"),wxpayOrderPayAmount,2,false);--%>
        				<%--setRunNumber($("#otherOrderPayAmount"),otherOrderPayAmount,2,false);--%>
<%--//        				setRunNumber($("#ticketOrderPayAmount"),ticketOrderPayAmount,2,false);--%>
        				<%--setRunNumber($("#alipayOrderPayAmount"),alipayOrderPayAmount,2,false);--%>
        				<%--setRunNumber($("#totalSuccessPayFee"),totalSuccessPayFee,2,false);--%>
<%--//        				$("#usergrowthCountText").html('');--%>
<%--//        				if(resultObj.usergrowthCountText == 1){ //下降了--%>
<%--//        					$("#usergrowthCountText").html("<font style=' font-size:13px;'>同比降低(%)</font>");--%>
<%--//        				}else{--%>
<%--//        					$("#usergrowthCountText").html("<font style=' font-size:13px;'>同比增长(%)</font>");--%>
<%--//        				}--%>
<%--//        				setRunNumber($("#UserGrowthCount"),UserGrowthCount,2,false);--%>

                        <%--$("#todayMemberRechargeAmount").html(todayMemberRechargeAmount);--%>
                        <%--$("#todayMemberConsumeAmount").html(todayMemberConsumeAmount);--%>
                        <%--$("#todayMemberRechargeUserCount").html(todayMemberRechargeUserCount);--%>
                        <%--$("#todayMemberRechargeCount").html(todayMemberRechargeCount);--%>
        			<%--},--%>
        			<%--error : function(result) {--%>
        				<%--alert('数据加载错误！');--%>
        				<%--return ;--%>
        			<%--}--%>
        		<%--});--%>
          <%--}--%>
          <%--//判断是否是小数--%>
          <%--function hasDot(num) {--%>
       	    <%--if (!isNaN(num)) {--%>
       	        <%--return ((num + '').indexOf('.') != -1) ? true : false;--%>
       	    <%--}--%>
          <%--}--%>
          <%----%>
      	 <%--// 设置滚动数组的值 1,dom对象；2，滚动数值；3.数组精度；4.是否 显示动画；--%>
   		 <%--function setRunNumber(obj,number,dot,flyMoney){--%>
   		    <%--//获取当前选项卡的下标；只有下标为0{首页}的打开时，才请求首页数据--%>
  		    <%--var index = $('#layout_center_tabs').tabs('getTabIndex', $('#layout_center_tabs').tabs('getSelected'));--%>
   			<%--//获取之前的值--%>
 			<%--var oldNumberValue = obj.text();--%>
   			<%--//判断值是否有变化--%>
   			<%--if(index ==0 && oldNumberValue != number){--%>
   				<%--if(flyMoney){--%>
   					<%--var offset = $('#end').offset(), flyer = $('<img class="u-flyer" src="<%=basePath%>/assets/images/gold.gif"/>');--%>
   		  			<%--flyer.fly({--%>
   		  				<%--start: {--%>
   		  					<%--left: 1080,--%>
   		  					<%--top: 100--%>
   		  				<%--},--%>
   		  				<%--end: {--%>
   		  					<%--left: offset.left,--%>
   		  					<%--top: offset.top,--%>
   		  					<%--width: 0,--%>
   		  					<%--height: 0--%>
   		  				<%--},--%>
   		  				<%--onEnd: function(){ //结束回调 		--%>
   		  					 <%--//获取之前的值--%>
   		  					<%--if(hasDot(number)){--%>
   	    					 	<%--obj.numberAnimate({num:number, dot:2, speed:2000});--%>
   	    					<%--}else{--%>
   	    						<%--obj.numberAnimate({num:number,speed:2000});--%>
   	    					<%--}--%>
   		  		       <%--} --%>
   		  			<%--});--%>
   				<%--}else{--%>
   					<%--if(hasDot(number)){--%>
   					 	<%--obj.numberAnimate({num:number, dot:2, speed:2000});--%>
   					<%--}else{--%>
   						<%--obj.numberAnimate({num:number,speed:2000});--%>
   					<%--}--%>
   				<%--}--%>
   			 <%--}--%>
   		  <%--}--%>
          <%----%>
   		 <%--//调用加载方法--%>
         <%--reflushData();--%>
  		<%--});--%>

  		<%----%>
      <%----%>
    <%--</script>--%>
</body>
</html>