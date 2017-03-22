
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<b>My Cart</b><br/>
<c:choose>
	<c:when test="${order!=null}">

		<form:form action="/confirmCart" method="POST"
			modelAttribute="orderList">


			<table class="table table-striped">
				<tr>
					<td>Product Id</td>
					<td>Img</td>
					<td>Product Name</td>
					<td>Price</td>
					<td>Product Detail</td>
					<td>Amount</td>
					<td>Delete</td>
				</tr>
				<form:hidden path="orderId" value="${order.orderId }" />
				<c:forEach items="${order.listProduct}" var="orderLine"
					varStatus="status">

					<tr>
						<td><form:label
								path="listProduct[${status.index }].pk.product.productId">${orderLine.pk.product.productId }</form:label>
							<form:hidden
								path="listProduct[${status.index }].pk.product.productId"
								value="${orderLine.pk.product.productId }" /></td>
						<td><form:label
								path="listProduct[${status.index }].pk.product.imgUrl"
								value="${orderLine.pk.product.imgUrl}">
								<img src="/Images/${orderLine.pk.product.imgUrl}" width="100px" height="100px" />
								<form:hidden
									path="listProduct[${status.index }].pk.product.imgUrl"
									value="${orderLine.pk.product.imgUrl}" />
							</form:label></td>
						<td><form:label
								path="listProduct[${status.index }].pk.product.productName">${orderLine.pk.product.productName}</form:label>
							<form:hidden
								path="listProduct[${status.index }].pk.product.productName"
								value="${orderLine.pk.product.productName}" /></td>
						<td><form:label
								path="listProduct[${status.index }].pk.product.price">${orderLine.pk.product.price}</form:label>
							<form:hidden
								path="listProduct[${status.index }].pk.product.productName"
								value="${orderLine.pk.product.productName}" /></td>
						<td><form:label
								path="listProduct[${status.index }].pk.product.productDetail">${orderLine.pk.product.productDetail}</form:label>
							<form:hidden
								path="listProduct[${status.index }].pk.product.productDetail"
								value="${orderLine.pk.product.productDetail}" /></td>
						<td><form:input path="listProduct[${status.index }].amount"
								value="${orderLine.amount }" /></td>
								
						<td><a href="<c:url value='/RemoveOutOfCart/${orderLine.pk.product.productId}' />"
								class="btn btn-danger" role="button" >Delete</a></td>
					</tr>
				</c:forEach>
			</table>

			<input class="btn btn-primary" type="submit" value="Submit" />
		</form:form>
	</c:when>
	<c:otherwise>
No product.
</c:otherwise>
</c:choose>
<jsp:include page="../componant/footer.jsp" flush="true" />