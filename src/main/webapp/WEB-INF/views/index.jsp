
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="row">
	<h1>
		<b>สินค้าใหม่</b>
	</h1>
	<c:choose>
		<c:when test="${listNewProd != null }">
			<c:forEach items="${listNewProd }" var="newProd">
				<div class="card">
					<c:set var="newProdUrl" value="${fn:split(newProd.imgUrl, ',')}" />
					<c:forEach items="${newProdUrl }" var="imgUrl">
						<img src="/Images/Products/${newProd.productId }_${newProd.productName }/${imgUrl }" alt="Avatar">
					</c:forEach>
					<div class="card-content">
						<h4>
							<b>${newProd.productName }</b>
						</h4>
						<p>${newProd.productDetail }</p>
					</div>
				</div>
			</c:forEach>
		</c:when>
	</c:choose>

</div>
<jsp:include page="../componant/footer.jsp" flush="true" />