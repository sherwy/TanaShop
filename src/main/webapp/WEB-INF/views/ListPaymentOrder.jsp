<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Register" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="nav-header">
	<b>รายการแจ้งชำระเงิน</b>
</div>
<br>
<%@page import="com.tana.utilities.*"%>
<script>
	function confirmation() {
		var isConfirm = confirm("คุณต้องการยืนยันการชำระเงินนี้ใช่ไหม ?");
		return isConfirm;
	}
</script>
<div class="form-sher">
	<table id="listOrder" class="table table-striped">
		<thead>
			<tr>
				<td>สถานะ</td>
				<td>เลขที่ใบชำระเงิน</td>
				<td>ผู้แจ้งชำระเงิน</td>
				<td>ช่องทางการชำระเงิน</td>
				<td>จำนวนเงิน</td>
				<td>วันที่ชำระเงิน</td>
				<td>ใบสั่งซื้อ</td>
				<td>ยืนยันชำระเงิน</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${listOrder}" var="order">
				<tr>
					<td>${order.status }</td>
					<td>${order.payment.id}</td>
					<td>${order.customer.firstName }${order.customer.lastName }</td>
					<td>${order.payment.bank.bankAccountNumber }</td>
					<td>${order.calPrice() + order.otherAmount }</td>
					<td>${order.datetime }</td>
					<td>${order.orderId }</td>
					<td><c:set var="status"
							value="${fn:split(mapStatus.get(order.status), ',')}" /> <c:set
							var="icon" value="${status[0] }" /> <c:set var="iconStatus"
							value="${status[1] }" />
						<div class="symbol-sher">
							<c:choose>
								<c:when test="${order.status == mapStatus.get('0') }">
									<a href="/verifyOrder/${order.orderId }"
										data-balloon="ยืนยันการชำระเงิน" data-balloon-pos="down"
										class="fail" onclick="return confirmation()"><span
										class="glyphicon glyphicon-share-alt "></span></a>
								</c:when>
								<c:when test="${order.status == mapStatus.get('1') }">
										class="glyphicon glyphicon-ok "></span></a>
									<a href="#" data-balloon="ยืนยันการชำระเงินเรียบร้อยแล้ว"
										data-balloon-pos="down" class="success"><span class="glyphicon glyphicon-ok"></span></a>
								</c:when>
							</c:choose>

						</div></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<script>
	$(function() {
		$("#listOrder").dataTable({
			responsive : true,
			ajax : '/api/data',
			scrollY : 200,
			deferRender : true,
			scroller : true
		});
	})
</script>
<jsp:include page="../componant/footer.jsp" flush="true" />