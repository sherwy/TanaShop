
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table>
<tr>      
        <td>Img</td>
        <td>Product Name</td>
        <td>Price</td>
        <td>Product Detail</td>
        <td>#</td>
    </tr>
<c:forEach items="${listProduct}" var="product">
    <tr>      
        <td><img src="/Images/${product.imgUrl}"/></td>
        <td>${product.productName}</td>
        <td>${product.price}</td>
        <td>${product.productDetail}</td>
        <td><a href="<c:url value='/addToCart/${product.productId}' />" class="btn btn-success" role="button">Add to Cart</a></td>
    </tr>
</c:forEach>
</table>
<jsp:include page="../componant/footer.jsp" flush="true" />