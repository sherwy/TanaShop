
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="List Product" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
	function confirmation() {
		var isConfirm = confirm("คุณต้องการลบสินค้าใช่ไหม ?");
		return isConfirm;
	}
</script>
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
							<td><c:set var="prodUrl" value="${fn:split(product.imgUrl, ',')}" /> 
								<c:if test="${fn:length(prodUrl) gt 0}">
									<img width="100px" height="100px"
										src="/Images/Products/${product.productId }/${prodUrl[0] }"/>
								</c:if></td>
							<td>${product.productName}</td>
							<td>${product.price}</td>
							<td>${product.productDetail}</td>
							<td><a
								href="<c:url value='/editProduct/${product.productId }' />"
								class="btn btn-warning" role="button">Edit</a></td>
							<td><a
								href="<c:url value='/deleteProduct/${product.productId }' />"
								class="btn btn-danger" onclick="return confirmation()"
								role="button">Delete</a></td>
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