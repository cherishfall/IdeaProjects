<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../inc.jsp"%>
<body>
<div class="easyui-accordion" data-options="fit:true,border:false">
	<c:forEach var="node" items="${menuList}">
		<div title="${node.text}">
			<ul id="tt" class="easyui-tree">
				<c:forEach var="modules" items="${node.children}">
					<li><span>${modules.text}</span>
						<ul>
							<c:forEach var="module" items="${modules.children}">
								<li><a class="menu-item" href="<%=basePath%>${module.url}">${module.text}</a>
								</li>
							</c:forEach>
						</ul></li>
				</c:forEach>
			</ul>
		</div>
	</c:forEach>
</div>
</body>