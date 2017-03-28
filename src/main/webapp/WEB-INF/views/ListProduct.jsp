
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>

<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${listAvaProduct!=null}">
		<table class="table table-striped">
			<tr>
				<td>รหัสสินค้า</td>
				<td>รูปภาพสินค้า</td>
				<td>ชื่อสินค้า</td>
				<td>ราคาต่อหน่วย</td>
				<td>รายละเอียดสินค้า</td>
				<td>#</td>
			</tr>
			<c:forEach items="${listAvaProduct}" var="product">
				<tr>
					<td>${product.productId }</td>
					<td><img src="/Images/Products/${product.imgUrl}" width="100px"
						height="100px" /></td>
					<td>${product.productName}</td>
					<td>${product.price}</td>
					<td>${product.productDetail}</td>
					<td><a
						href="<c:url value='/addToCart/${product.productId}' />"
						class="btn btn-success" role="button">เพิ่มลงตะกร้า</a></td>
				</tr>
			</c:forEach>

			<c:choose>
				<c:when test="${listNotAvaProduct!=null}">
					<c:forEach items="${listNotAvaProduct}" var="product">
						<tr>
							<td>${product.productId }</td>
							<td><img src="/Images/Products/${product.imgUrl}" width="100px"
								height="100px" /></td>
							<td>${product.productName}</td>
							<td>${product.price}</td>
							<td>${product.productDetail}</td>
							<td><a
								href="<c:url value='#' />"
								class="btn btn-danger" role="button" disabled>มีสินค้าในตะกร้าแล้ว</a></td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
	</c:when>

	<c:otherwise>
	No product.
</c:otherwise>
</c:choose>
<jsp:include page="../componant/footer.jsp" flush="true" />