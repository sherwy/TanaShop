
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="List Order" />
</jsp:include>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${listOrder!=null}">
		<table class="table table-striped">
			<tr>
				<td>#</td>
				<td>Order Id</td>
				<td>Order Status</td>
				<td>Date</td>
				<td>Owner</td>
			</tr>
			<c:forEach items="${listOrder}" var="order" varStatus="i">
				<c:choose>
					<c:when test="${order.orderStatus == 'Pending Payment'}">
						<tr>
							<td>${i.index+1 }</td>
							<td>${order.orderId}</td>
							<td><span class="glyphicon glyphicon-usd"></span>
								${order.orderStatus}</td>
							<td>${order.datetime}</td>
							<td>${order.customer.firstName } ${order.customer.lastName }</td>
						</tr>
					</c:when>
					<c:when test="${order.orderStatus == 'Pending Confirm Payment'}">
						<tr>
							<td>${i.index+1 }</td>
							<td>${order.orderId}</td>
							<td><span class="glyphicon glyphicon-repeat"></span>
								${order.orderStatus}</td>
							<td>${order.datetime}</td>
							<td>${order.customer.firstName } ${order.customer.lastName }</td>
						</tr>
					</c:when>
					<c:when test="${order.orderStatus == 'Pending Sending'}">
						<tr>
							<td>${i.index+1 }</td>
							<td>${order.orderId}</td>
							<td><span class="glyphicon glyphicon-th-large"></span>
								${order.orderStatus}</td>
							<td>${order.datetime}</td>
							<td>${order.customer.firstName } ${order.customer.lastName }</td>
						</tr>
					</c:when>
				</c:choose>
			</c:forEach>
		</table>

	</c:when>
	<c:otherwise>
		No order.
	</c:otherwise>
</c:choose>
<jsp:include page="../componant/footer.jsp" flush="true" />