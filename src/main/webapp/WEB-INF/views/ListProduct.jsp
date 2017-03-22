
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${listAvaProduct!=null}">
		<table class="table table-striped">
			<tr>
				<td>Img</td>
				<td>Product Name</td>
				<td>Price</td>
				<td>Product Detail</td>
				<td>#</td>
			</tr>
			<c:forEach items="${listAvaProduct}" var="product">
				<tr>
					<td><img src="/Images/${product.imgUrl}" width="100px"
						height="100px" /></td>
					<td>${product.productName}</td>
					<td>${product.price}</td>
					<td>${product.productDetail}</td>
					<td><a
						href="<c:url value='/addToCart/${product.productId}' />"
						class="btn btn-success" role="button" >Add to Cart</a></td>
				</tr>
			</c:forEach>
		</table>
	</c:when>
	<c:when test="${listNotAvaProduct!=null}">
		<table class="table table-striped">
			<tr>
				<td>Img</td>
				<td>Product Name</td>
				<td>Price</td>
				<td>Product Detail</td>
				<td>#</td>
			</tr>
			<c:forEach items="${listNotAvaProduct}" var="product">
				<tr>
					<td><img src="/Images/${product.imgUrl}" width="100px"
						height="100px" /></td>
					<td>${product.productName}</td>
					<td>${product.price}</td>
					<td>${product.productDetail}</td>
					<td><a
						href="<c:url value='/addToCart/${product.productId}' />"
						class="btn btn-success" role="button"
						disabled
						>Add to Cart</a></td>
				</tr>
			</c:forEach>
		</table>
	</c:when>
	<c:otherwise>
	No product.
</c:otherwise>
</c:choose>
<jsp:include page="../componant/footer.jsp" flush="true" />