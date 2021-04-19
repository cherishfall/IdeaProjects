<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/view/inc.jsp" %>
 
<!DOCTYPE html>
<html>
 <head>
  <title>中国好停车客户端应用管理平台</title>
  <!--[if lt IE 9]>
   <script src="assets/plug-in/login/js/html5.js"></script>
  <![endif]-->
  <!--[if lt IE 7]>
  <script src="assets/plug-in/login/js/iepng.js" type="text/javascript"></script>
  <script type="text/javascript">
	EvPNG.fix('div, ul, img, li, input'); //EvPNG.fix('包含透明PNG图片的标签'); 多个标签之间用英文逗号隔开。
</script>
  <![endif]-->
 </head>
 <body> 
    <div  style="padding:80px;">
    
     <form name="formLogin" id="formLogin" action="<%=basePath %>/gateway.do"  method="post" enctype="multipart/form-data">
       <p>
        data ： <input  name="data" type="text" id="data"    value="330110|529d593a-f5fe-49a2-8876-b3b66210bde9|1|93034823"/>
      </p>
       <p>
        appid ： <input  name="app_id" type="text" id="app_id"    value="1020151028382929"/>
      </p>
      <p>
        cityCode ： <input  name="cityCode" type="text" id="cityCode"    value="330110"/>
      </p>
       <p>
       service ： <input  name="service" type="text" id="service" value="innotek.public.user.upload.file"/>
      </p>
      <p>
       uploadFile ： <input  name="uploadFile" type="file" id="uploadFile"  />
      </p>
      <p>
       key ： <input  name="key" type="text" id="key" value="05726fecf12d22e7d7cab3998e26a6cb" />
      </p>
      <p>
       input_charset ： <input  name="input_charset" type="text" id="input_charset" value="UTF-8" />
      </p>
      <p>
       sign_type ： <input  name="sign_type" type="text" id="sign_type" value="MD5" />
      </p>
      <p>
       req_time ： <input  name="req_time" type="text" id="req_time" value="1461664955215" />
      </p>
      <button id="but_login" type="submit">Submit-Form</button>
     </form>
     
    </div> 
    
  <script type="text/javascript" src="assets/plug-in/jquery/jquery-1.8.3.min.js"></script>
 </body>
</html>