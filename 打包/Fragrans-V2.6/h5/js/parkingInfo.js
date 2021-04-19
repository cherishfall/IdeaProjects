$(function(){
	var parkId = GetQueryString("parkId");
	var contentType = $("#contentType").val();
	var mapType = $("#mapType").val();
	var param="parkId="+parkId+"&contentType="+contentType+"&mapType="+mapType;
	$.ajax({
		url:'/fragrans/parkingInfo/getInfo.do',
		data:param,
		type:'post',
		dataType:'json',
		success:function(result){
			if(result!=null&&result.resultCode==200){
				//停车点类型
				var parkType=result.parkType;
				if(parkType==1){
					//停车点
					document.getElementById("parkImg").src="../img/parkingspot.png";
				}else{
					document.getElementById("parkImg").src="../img/parkinglot.png";
				}
				document.getElementById("parkName").innerHTML=result.parkName;
				//繁忙程度
				document.getElementById("busyDesc").innerHTML=result.busyDesc;
				if(result.parkType ==  "" || result.parkType == 2){
					//停车场详情
					document.getElementById("berthIdleCountAndAll").innerHTML= result.berthCount;
					document.getElementById("berth_title").innerHTML = '总泊位数：';
					if(result.busyDesc != ""){
						//繁忙程度不等于空，显示状态栏
						document.getElementById("isBusyDesc").style.display = "block";
					} 
				}else{
					//停车点详情
					document.getElementById("berthIdleCountAndAll").innerHTML=result.berthIdleCount+"/"+result.berthCount;
					document.getElementById("berth_title").innerHTML = '剩余泊位/总泊位数：';
					document.getElementById("isBusyDesc").style.display = "none";
				}
				
				//费率
				document.getElementById("dayRate").innerHTML="日费率：" + result.dayRate;
				document.getElementById("nightRate").innerHTML="夜费率：" + result.nightRate;
				//document.getElementById("address").innerHTML=result.address;
				//是否对外开放描述
				if(result.openDesc != null && result.openDesc !=''){
					document.getElementById("openDesc").style.display="block";
				}
			}
		}
		});
});

//获取参数
function GetQueryString(name)
{
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null){
    	 return unescape(r[2]); 
     }else{
    	 return null;
     }
}