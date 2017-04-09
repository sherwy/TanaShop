
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
	
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${errorMsg != null }">
		<div class="alert alert-${errorMsg.status }">
			<span class="label label-${errorMsg.status }">
				<h3>
					<span class="${errorMsg.icon }"> </span>
					${errorMsg.header }
				</h3>
			</span>
			<p>${errorMsg.text }</p>
		</div>
	</c:when>
</c:choose>

<jsp:include page="../componant/footer.jsp" flush="true" />