$package('app.appPrebuyParkrecord');
app.appPrebuyParkrecord = function(){
	var _box = null;
	var _this = {
		photo : function(rows,photoUrl,photoCount) {
			if(photoUrl!=null){
				var urls = photoUrl.split("|");
				if(urls!=null && urls!=''){
					$(".slider").YuxiSlider({
					    width:500, //容器宽度
					    height:400, //容器高度
					    control:$('.control'), //绑定控制按钮
					    auto:false,
					   /* during:4000, //间隔4秒自动滑动*/
					    speed:800, //移动速度0.8秒
					    mousewheel:true, //是否开启鼠标滚轮控制
					    direkey:true //是否开启左右箭头方向控制
					});
					var ul=document.getElementById('ulClass');
					var lis=document.querySelectorAll("#ulClass li");
					var len=lis.length;
					if(len!=0){
						for (var j=0;j<len;j++){
						   ul.removeChild(lis[j]);
						}
					}
					for(var i=1;i<=photoCount;i++){
						addElementLi('ulClass',urls[i-1],i,rows[0].areaName + rows[0].parkName + '车牌=' + rows[0].plateNo );
					}
					$('#photoDiv').dialog("open");
					}
			}else{
			$.messager.show({
					msg : '该条记录没有照片',
					title : '提示'
				});
			}
		},
		detail : function(rows) {
			$('#parkrecordDetail').dialog({    
				maximizable:true,
				href: '../view/fragrans/appsystem/parkrecordDetail.jsp?parkrecordId='+rows[0].parkrecordId+'&cityCode='+rows[0].areaCode,    
			});
			$('#parkrecordDetail').dialog("open");
		},
		config:{
			event : {
				search : function() { //条件查询验证
					var startEventTime = $('#startTime').datetimebox('getValue');
					var endEventTime = $('#endTime').datetimebox('getValue');
					if (startEventTime > endEventTime) {
						sys.alert('警告', '起始时间大于结束时间.', 'warning');
						return;
					}
					var start  = new Date(startEventTime.replace(/-/g,"/")).getTime();
					var end = new Date(endEventTime.replace(/-/g,"/")).getTime();
					var endDate = new Date(end);
					var startLon = endDate.setMonth(endDate.getMonth()-3);
					if(start < startLon){
						sys.alert('警告', '起始时间和结束时间之差大于3个月.', 'warning');
						return;
					} 
					var Grid = $('#data-list');
					var Form = {
					  search: $("#searchForm")
					};
					var param = Form.search.serializeObject();
					Grid.datagrid('reload',param);
				}
			},
  			dataGrid:{
  				title:'预买停车记录表',
	   			url:'dataList.do',
	   			fitColumns:true,
	   			queryParams:{
	            	startTime :new Date().pattern("yyyy-MM-dd 00:00:00") ,
	            	endTime : new Date().pattern("yyyy-MM-dd HH:mm:ss"),
	   			},
	   			columns:[[ 
						{field:'id',hidden:'true'},
						{field:'photoUrl',hidden:'true'},
	   			        {field:'userAccount',title:'用户账号',sortable:true,width:140},
	   			        {field:'parkName',title:'停车点名称',sortable:true,width:140},
	   			        {field:'berthCode',title:'泊位编号',sortable:true,width:140},
	   			        {field:'parkrecordId',title:'停车记录id',sortable:true,width:140},
	   			        {field:'cityName',title:'城市名称',sortable:true,width:70},
	 					{field:'areaName',title:'区域名称',sortable:true,width:70},
			 			{field:'plateNo',title:'车牌号',sortable:true,width:80},
			 			{field:'photoCount',title:'照片数量',sortable:true,align:'center',width:90},
			 			{field:'photoScore',title:'照片评分',sortable:true,align:'center',width:90,
			 				formatter:function(value,row,index){
			 					if(Number(value)<60){
			 						return "<font style='color:red;font-weight:bold' >" + value + "</font>"; 
			 					}else{
			 						return '<font style="color:green;font-weight:bold">' + value+'</font>'; 
			 					}
			 				} 
			 			},
			 			{field:'status',title:'预买状态',sortable:true,width:60,formatter:sys.dicts.text('PREBUY_STATUS')},
			 			{field:'isDeparture',title:'是否驶离',sortable:true,width:60,formatter:sys.dicts.text('YESORNO')},
			 			{field:'arrivalTime',title:'驶入时间',sortable:true,width:140},
			 			{field:'overTime',title:'预买截止时间',sortable:true,width:140},
			 	]],
				toolbar:[
					{id:'showPhoto',text:'查看照片',btnType:'photo',iconCls : 'icon-search',
						handler : function() {
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length == 1) {
								var url=rows[0].photoUrl;
								var photoCount=rows[0].photoCount;
								_this.photo(rows,url,photoCount);
							} else {
								$.messager.show({
									msg : '请选择一条记录~',
									title : '提示'
								});
							}
					}},
					{id:'btndetail',text:'停车记录详情',btnType:'detail',iconCls : 'ext-icon-report_add',
						handler : function() {
							var rows = $('#data-list').datagrid('getChecked');
							if (rows.length == 1) {
								_this.detail(rows);
							} else {
								$.messager.show({
									msg : '请选择一条记录',
									title : '提示'
								});
							}
					}},
				]
			}
		},
		init:function(){
			_box = new YDataGrid(_this.config); 
			_box.init();
		}
	}
	return _this;
}();

$(function(){
	app.appPrebuyParkrecord.init();
	var date = new Date();
	$('#endTime').datetimebox('setValue',date.pattern("yyyy-MM-dd HH:mm:ss"));
	$('#startTime').datetimebox('setValue',date.pattern("yyyy-MM-dd 00:00:00"));
	
	$('#data-list').datagrid({
	    view: detailview,
	    detailFormatter:function(index,row){
	        return '<div style="padding:2px"><table class="ddv"></table></div>';
	    }, 
	    onExpandRow: function(index,row){
	        var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
	        ddv.datagrid({
	            url:'../appPrebuyDetail/queryByPrebuyId.do',
	            queryParams: {  
	            	prebuyId : row.id
	            },
	            fitColumns:true,
	            rownumbers:true,
	            singleSelect:true,
	            height:'auto',
	            onDblClickRow : function(index, data) {
	            	var orderNo = data.orderNo;
	            	$('#prebuyOrderDetail').dialog({    
	    				maximizable:true,
	    				href: '../view/fragrans/appsystem/orderDetail.jsp?orderNo='+orderNo,    
	    			});
	    			$('#prebuyOrderDetail').dialog("open");
				},
	            columns:[[
	                {field:'id',title:'id',hidden:'true'},
	               	{field:'userId',title:'用户ID',hidden:'true'},
	                {field:'orderNo',title:'订单编号',width:100},
	                {field:'startTime',title:'预买开始时间',width:80},
	                {field:'prebuyTimeLong',title:'预买时长(分钟)',width:60},
	                {field:'payStatus',title:'支付状态',width:50,formatter:sys.dicts.text('PAY_STATUS')},
	                {field:'isPush',title:'推送状态',width:70,formatter:sys.dicts.text('IS_PUSH')}
	            ]],
	            onResize:function(){
	                $('#data-list').datagrid('fixDetailRowHeight',index);
	            },
	            onLoadSuccess:function(){
	                setTimeout(function(){
	                    $('#data-list').datagrid('fixDetailRowHeight',index);
	                },0);
	            }
	        });
	        $('#data-list').datagrid('fixDetailRowHeight',index);
	    }
	});
});	
function AutoResizeImage(maxWidth, maxHeight, objImg) {
    var img = new Image();
    img.src = objImg.src;
    var hRatio;
    var wRatio;
    var Ratio = 1;
    var w = img.width;
    var h = img.height;
    wRatio = maxWidth / w;
    hRatio = maxHeight / h;
    if (maxWidth == 0 && maxHeight == 0) {
        Ratio = 1;
    } else if (maxWidth == 0) { //
        if (hRatio < 1) Ratio = hRatio;
    } else if (maxHeight == 0) {
        if (wRatio < 1) Ratio = wRatio;
    } else if (wRatio < 1 || hRatio < 1) {
        Ratio = (wRatio <= hRatio ? wRatio : hRatio);
    }
    if (Ratio < 1) {
        w = w * Ratio;
        h = h * Ratio;
    }
    objImg.height = h;
    objImg.width = w;
}

//!function(a){a.fn.extend({YuxiSlider:function(b){var c={width:640,height:360,control:null,auto:!0,during:3e3,speed:800,mousewheel:!1,direkey:!1},d=a.extend(c,b);return a(this).each(function(){var b=a(this),c=a("ul",b),e=a("li",b),f=e.length,g=0,h=null/*,i='<div class="desc"><p class="title"><a href=""></a></p><span class="num"><em class="curr-num"></em><em class="line"></em><em class="total-num"></em></span></div><div class="bg"></div>'*//*;b.append(i)*/;var j=a("p.title a",b),k=a("em.curr-num",b),l=a("em.total-num",b),m=0,n={},o={},p={mobileDevice:navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i),init:function(){if(p.style(),p.mobileDevice){var e=a(window).width(),g=d.width/d.height;d.width=e,d.height=e/g,b.css({fontSize:a(window).width()/640*1.285+"rem"})}b.add("img",b).width(d.width).height(d.height),c.width(f*d.width),p.description(),p.bindControl(),f>2&&c.prepend(a("li",c).last()).css({left:-d.width}),d.auto&&p.auto()},auto:function(){h=d.auto?setInterval(function(){p.moving(!0)},d.during):null},stop:function(){h&&clearInterval(h)},description:function(){k.text(g+1),l.text(f),j.text(e.eq(g).find("img").attr("alt")).attr("href",e.eq(g).find("a").attr("href")).width(d.width-a("span.num",b).width()-20)},bindControl:function(){if(p.mobileDevice){if(d.control&&d.control.remove(),2>=f)return;c.get(0).addEventListener("touchstart",p.touchstart,!1),c.get(0).addEventListener("touchmove",p.touchmove,!1),c.get(0).addEventListener("touchend",p.touchend,!1)}else{b.hover(function(){d.auto&&p.stop(),a(document).on("keydown",function(a){a.preventDefault(),(39===a.keyCode||40===a.keyCode)&&p.moving(!0),(37===a.keyCode||38===a.keyCode)&&p.moving(!1)})},function(){a(document).unbind(),d.auto&&p.auto()});var e=void 0!==document.mozHidden?"DOMMouseScroll":"mousewheel";d.mousewheel&&b.on(e,function(a){a.preventDefault(),a.stopPropagation();var c=a.originalEvent.wheelDelta?a.originalEvent.wheelDelta:-a.originalEvent.detail,d=b.data("timeoutId");d&&clearInterval(d),b.data("timeoutId",setTimeout(function(){p.moving(0>c?!0:!1),b.removeData("timeoutId")},100))}),d.control&&d.control.on("click",function(){p.moving(a(this).index()?!0:!1)}).hover(function(){d.auto&&p.stop()},function(){d.auto&&p.auto()})}},moving:function(b){if(1!=f){var e=0,h=!0;"boolean"==typeof b?h=b:(h=b>0?!1:!0,e=b),g=h?g>=f-1?0:g+1:0>=g?f-1:g-1,p.description(),f>2?(h?c.append(a("li",c).first()).css({left:0+e}):c.prepend(a("li",c).last()).css({left:-2*d.width+e}),c.stop().animate({left:[-d.width,"easeOutExpo"]},d.speed)):h?c.stop().animate({left:-d.width},.6*d.speed,function(){a(this).append(a("li",this).first()).css({left:0})}):c.prepend(a("li",c).last()).css({left:-d.width+e}).stop().animate({left:0},.6*d.speed)}},touchPos:function(a){for(var c,d,e,b=a.changedTouches,f={},g=0;g<b.length;g++)c=b[g],d=c.clientX,e=c.clientY;return f.x=d,f.y=e,f},touchstart:function(a){p.stop(),m=(new Date).getTime(),n=p.touchPos(a),o.left=c.offset().left},touchmove:function(a){a.preventDefault();var b=p.touchPos(a).x-n.x;c.stop().css({left:o.left+b})},touchend:function(a){var b=p.touchPos(a).x-n.x,e=(new Date).getTime()-m;0!==Math.abs(b)&&(350>=e?p.moving(b):Math.abs(b)<=d.width/2?c.stop().animate({left:[o.left,"easeOutExpo"]},d.speed/2):p.moving(b),d.auto&&p.auto())},style:function(){b.css({position:"relative",overflow:"hidden"}).fadeIn(450),e.css({display:"inline","float":"left"}),c.add(a(".bg",b)).add(a(".desc",b)).add(a(".num",b)).css({position:"absolute"}),a(".bg",b).css({background:"#000",filter:"alpha(opacity=50)",opacity:.5}).add(a(".desc",b)).css({width:"100%",height:"3em",bottom:0,left:0}),a(".desc").css({zIndex:2}),a("p.title",b).css({"float":"left",height:"1em",padding:"1em .5em",fontFamily:"microsoft yahei"}),a("p.title a",b).css({display:"block",color:"#fff",textOverflow:"ellipsis",whiteSpace:"nowrap",overflow:"hidden"}),a("span.num",b).css({right:".5em",color:"#fff",fontStyle:"italic",fontFamily:'Georgia, "Monotype Corsiva", Arial, sans-serif'}),a("em",b).css({display:"inline-block",position:"relative"}),a("em.curr-num",b).css({fontSize:"2.4em",height:"2em",lineHeight:"2em",color:"#cc191b",bottom:".625em"}),a("em.total-num",b).css({fontSize:"1.2em",height:"2em",lineHeight:"2em",top:".6em"}),a("em.line",b).css({width:"16px",height:"3em"/*,background:"url(images/splash_white.png) center no-repeat"*/})}};p.init()})}})}(jQuery),$.extend($.easing,{easeOutExpo:function(a,b,c,d,e){return b==e?c+d:d*(-Math.pow(2,-10*b/e)+1)+c}});

function addElementLi(obj,src,i,txt) {
var ul = document.getElementById(obj);
//添加 li
var li = document.createElement("li");
//设置 li 属性，如 id
li.setAttribute("id", "newli"+i);
li.setAttribute("align", "center");
li.innerHTML = "<img style='height:400px;' src='"+src+"'  alt='"+txt+"' />";
ul.appendChild(li);
}

function toDecimal(x) { 
    var f = parseFloat(x); 
    if (isNaN(f)) { 
      return 0; 
    } 
    f = Math.round(x*100)/100/100; 
    return f; 
  }