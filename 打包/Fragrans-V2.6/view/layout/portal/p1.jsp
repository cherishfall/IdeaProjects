<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/view/inc.jsp"%>
<html>
<head>
<title></title>
<link rel="stylesheet prefetch" href="<%=basePath%>/assets/css/index/font-awesome.min.css" />
<link rel="stylesheet" href="<%=basePath%>/assets/css/index/style.css" media="screen" type="text/css" />
</head>
<body>
	 <div class="wrapper">
		<div class="counter col_fifth">
			<i class="fa fa-user fa-2x"></i>
			<h2 class="timer count-title" id="count-number1" data-to="56783" data-speed="1500"></h2>
			<p class="count-text ">注册用户</p>
		</div>
		
		<div class="counter col_fifth">
			<i class="fa fa-user-md fa-2x"></i>
			<h2 class="timer count-title" id="count-number2" data-to="17870" data-speed="1500"></h2>
			<p class="count-text ">活跃用户</p>
		</div>
		
		<div class="counter col_fifth">
			<i class="fa fa-rmb fa-2x"></i>
			<h2 class="timer count-title" id="count-number3" data-to="918" data-speed="1500"></h2>
			<p class="count-text ">缴费用户</p>
		</div>
		
		<div class="counter col_fifth ">
			<i class="fa fa-signal fa-2x"></i>
			<h2 class="timer count-title" id="count-number4" data-to="45" data-speed="1500"></h2>
			<p class="count-text ">环比增长(%)</p>
		</div>
	
		<div class="counter col_fifth end">
			<i class="fa fa-group fa-2x"></i>
			<h2 class="timer count-title" id="count-number5" data-to="56784" data-speed="1500"></h2>
			<p class="count-text ">累计用户</p>
		</div>
		
	</div>

	<div class="wrapper">
		<div class="counter col_fifth">
			<i id="end" class="fa fa-ruble fa-2x"></i>
			<h2 class="timer count-title" id="count-number6" data-to="5677" data-speed="1500"></h2>
			<p class="count-text ">缴费总金额</p>	   
			 
		</div>
		
		<div class="counter col_fifth">
			<i class="fa fa-rupee fa-2x"></i>
			<h2 class="timer count-title" id="count-number7" data-to="2675" data-speed="1500"></h2>
			<p class="count-text ">支付宝金额</p>
		</div>
		
		<div class="counter col_fifth">
			<i class="fa fa-comments fa-2x"></i>
			<h2 class="timer count-title" id="count-number8" data-to="2576" data-speed="1500"></h2>
			<p class="count-text ">微信金额</p>
		</div>
	
		<div class="counter col_fifth">
			<i class="fa fa-comments-o fa-2x"></i>
			<h2 class="timer count-title" id="count-number9" data-to="12.9" data-speed="1500"></h2>
			<p class="count-text ">微信公众号</p>
		</div>
		
		<div class="counter col_fifth end">
			<i class="fa fa-ticket fa-2x"></i>
			<h2 class="timer count-title" id="count-number10" data-to="345" data-speed="1500"></h2>
			<p class="count-text ">停车券抵扣</p>
		</div>
	</div>

	<script src="<%=basePath%>/assets/js/index/jquery.js"></script>
	<script src="<%=basePath%>/assets/js/index/index.js"></script>
	<script src="<%=basePath%>/assets/js/index/NumberScroll.js"></script>
	<script src="<%=basePath%>/assets/js/index/jquery_fly.js"></script>
	<script src="<%=basePath%>/assets/js/index/requestAnimationFrame.js"></script>

	<script type="text/javascript">
	$(function(){
		  var numRun1 = $("#count-number1").numberAnimate({num:'56783',  speed:2000});
		  var nums1 = 56783;
		  setInterval(function(){
		    nums1+= 2;
		    numRun1.resetData(nums1);
		  },4000);
		 
		  //初始化  


		  var numRun7 = $("#count-number7").numberAnimate({num:'3234.50', dot:2, speed:2000});
		  var nums7 = 3234.50;
		  setInterval(function(){
		    nums7+= 24.50;
		    numRun7.resetData(nums7);
		  },4000);


		setInterval(function(){
		   var s = getScrollTop();
		   if(s<200){
				addProduct();
		   } 
		  },4000);
		  

		  var numRun8 = $("#count-number8").numberAnimate({num:'1834.50', dot:2, speed:2000});
		  var nums8 = 1834.50;
		  setInterval(function(){
		    nums8+= 24.16;
		    numRun8.resetData(nums8);
		  },4000);
		  
		});


		function getScrollTop(){
		    var scrollTop=0;
		    if(document.documentElement&&document.documentElement.scrollTop)
		    {
		        scrollTop=document.documentElement.scrollTop;
		    }
		    else if(document.body)
		    {
		        scrollTop=document.body.scrollTop;
		    }
		    return scrollTop;
		}

		//$('html,body').on('click', addProduct);
		function addProduct(event) {
			var offset = $('#end').offset(), flyer = $('<img class="u-flyer" src="<%=basePath%>/assets/css/indeximages/gold.gif"/>');
			flyer.fly({
				start: {
					left: 1080,
					top: 100
				},
				end: {
					left: offset.left,
					top: offset.top,
					width: 0,
					height: 0
				},
				 onEnd: function(){ //结束回调 		
		                 var numRun6 = $("#count-number6").numberAnimate({num:'5234.50', dot:2, speed:2000});
						  var nums6 = 5234.50;				   
							nums6+= 28;
							numRun6.resetData(nums6);
						   
		            } 
			});
		}
	</script>
</body>
</html>
