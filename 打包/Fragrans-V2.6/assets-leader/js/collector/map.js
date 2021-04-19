//百度地图
var map = new BMap.Map("allmap");
var point = new BMap.Point(120.149996,30.294565);
map.centerAndZoom(point, 15);

var json_data = [[120.147158,30.294931],[120.130271,30.293996],[120.139073,30.298985]];
var pointArray = new Array();
for(var i=0;i<json_data.length;i++){
	var marker = new BMap.Marker(new BMap.Point(json_data[i][0], json_data[i][1])); // 创建点
	map.addOverlay(marker);    //增加点
	marker.addEventListener("click",attribute);
}
//让所有点在视野范围内
map.setViewport(pointArray);
//获取覆盖物位置
function attribute(e){
	var p = e.target;
	alert("marker的位置是" + p.getPosition().lng + "," + p.getPosition().lat);   
}
map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放

//获取当前时间
function updateDate() {
    document.getElementById('time').innerHTML =
        new Date().toLocaleString() + " 星期" 
        + "日一二三四五六".charAt(new Date().getDay());
}
setInterval("updateDate();", 1000);
//刷新当前页面
//function myrefresh(){
//	window.location.reload();
//}
//setTimeout('myrefresh()',5000);