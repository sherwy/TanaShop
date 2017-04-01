
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="List Order" />
</jsp:include>

<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${listOrder!=null}">
		<table class="table table-striped">
			<tr>
				<td>ลำดับ</td>
				<td>รหัสรายการ</td>
				<td>สถานะ</td>
				<td>วันที่ออกรายการ</td>
				<td>ชื่อลูกค้า</td>
				<td>#</td>
			</tr>
			<c:forEach items="${listOrder}" var="order" varStatus="i">
				<c:choose>
					<c:when test="${order.status == 'รอการชำระเงิน'}">
						<tr>
							<td>${i.index+1 }</td>
							<td>${order.orderId}</td>
							<td><span class="glyphicon glyphicon-usd"></span>
								${order.status}</td>
							<td>${order.datetime}</td>
							<td>${order.customer.firstName } ${order.customer.lastName }</td>
							<td></td>
						</tr>
					</c:when>
					<c:when test="${order.status == 'รอการตรวจสอบ'}">
						<tr>
							<td>${i.index+1 }</td>
							<td>${order.orderId}</td>
							<td><span class="glyphicon glyphicon-repeat"></span>
								${order.status}</td>
							<td>${order.datetime}</td>
							<td>${order.customer.firstName } ${order.customer.lastName }</td>
							<td>
								<a href="<c:url value='/verifyOrder/${order.orderId }' />" disabled class="btn btn-danger" role="button">ยืนยันการชำระเงิน</a>
							</td>
						</tr>
					</c:when>
					<c:when test="${order.status == 'รอการจัดส่ง'}">
						<tr>
							<td>${i.index+1 }</td>
							<td>${order.orderId}</td>
							<td><span class="glyphicon glyphicon-th-large"></span>
								${order.status}</td>
							<td>${order.datetime}</td>
							<td>${order.customer.firstName } ${order.customer.lastName }</td>
							<td><a href="<c:url value='/deliveryOrder/${order.orderId }' />" disabled class="btn btn-primary" role="button">แจ้งส่งสินค้า</a></td>
						</tr>
					</c:when>
				</c:choose>
			</c:forEach>
		</table>

	</c:when>
	<c:otherwise>
		ไม่มีรายการสั่งซื้อ
	</c:otherwise>
</c:choose>
<jsp:include page="../componant/footer.jsp" flush="true" />