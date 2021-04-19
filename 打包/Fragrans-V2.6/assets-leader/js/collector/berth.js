var map = new BMap.Map("allmap");    // 创建Map实例
map.centerAndZoom(new BMap.Point(120.139586,30.266694), 15);  // 初始化地图,设置中心点坐标和地图级别
map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
map.setCurrentCity("杭州西湖区");          // 设置地图显示的城市 此项是必须设置的
map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
