
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="List Product" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${listAdminProduct!=null}">
		<table class="table table-striped">
			<tr>
				<td>รหัสสินค้า</td>
				<td>รูปภาพ</td>
				<td>ชื่อสินค้า</td>
				<td>ราคาต่อหน่วย</td>
				<td>รายละเอียดสินค้า</td>
				<td>การแก้ไข</td>
				<td>การลบ</td>
			</tr>
			<c:forEach items="${listAdminProduct}" var="product">
				<c:choose>
					<c:when test="${product.status != 'Deleted' }">
						<tr>
							<td>${product.productId }</td>
							<td><img src="/Images/Products/${product.imgUrl}"
								width="100px" height="100px" /></td>
							<td>${product.productName}</td>
							<td>${product.price}</td>
							<td>${product.productDetail}</td>
							<td><a
								href="<c:url value='/editProduct/${product.productId }' />"
								class="btn btn-warning" role="button">Edit</a></td>
							<td><a
								href="<c:url value='/deleteProduct/${product.productId }' />"
								class="btn btn-danger" role="button">Delete</a></td>
						</tr>
					</c:when>
				</c:choose>

			</c:forEach>
		</table>
	</c:when>

	<c:otherwise>
	No product.
</c:otherwise>
</c:choose>
<jsp:include page="../componant/footer.jsp" flush="true" />