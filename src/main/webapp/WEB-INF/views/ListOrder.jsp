
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="List Order" />
</jsp:include>

<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div>


	<script>
		function confirmation() {
			var isConfirm = confirm("คุณต้องการยืนยันการชำระเงินใช่ไหม ?");
			return isConfirm;
		}
	</script>
	<c:choose>

		<c:when test="${listOrder!=null}">
			<table id="listOrder" class="table table-striped">
				<thead>
					<tr>
						<td>สถานะ</td>
						<td>เลขที่ใบสั่งซื้อ</td>
						<td>วันที่สั่งซื้อ</td>
						<td>ผู้สั่งซื้อ</td>
						<td>รายการสินค้า</td>
						<td>ราคา(บาท)</td>
						<td></td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${listOrder}" var="order" varStatus="i">
						<c:choose>
							<c:when test="${order.status == 'รอการชำระเงิน'}">
								<tr>
									<td><span class="glyphicon glyphicon-usd"></span>
										${order.status }</td>
									<td>${order.orderId}</td>
									<td>${order.datetime}</td>
									<td>${order.customer.firstName }${order.customer.lastName }</td>
									<td><a href="#popup_items_${order.orderId }"><span
											class="glyphicon glyphicon-zoom-in"></span></a></td>
									<td>${order.calPrice() }</td>
									<td></td>
								</tr>
							</c:when>
							<c:when test="${order.status == 'รอการตรวจสอบ'}">
								<tr>
									<td><span class="glyphicon glyphicon-repeat"></span>
										${order.status}</td>
									<td>${order.orderId}</td>
									<td>${order.datetime}</td>
									<td>${order.customer.firstName }${order.customer.lastName }</td>
									<td><a href="#popup_items_${order.orderId }"><span
											class="glyphicon glyphicon-zoom-in"></span></a></td>
									<td>${order.calPrice() }</td>
									<td><a onclick="return confirmation()"
										href="<c:url value='/verifyOrder/${order.orderId }' />"
										class="btn btn-danger" role="button">ยืนยันการชำระเงิน</a></td>
								</tr>
							</c:when>
							<c:when test="${order.status == 'รอการจัดส่ง'}">
								<tr>
									<td><span class="glyphicon glyphicon-th-large"></span>
										${order.status}</td>
									<td>${order.orderId}</td>
									<td>${order.datetime}</td>
									<td>${order.customer.firstName }${order.customer.lastName }</td>
									<td><a href="#popup_items_${order.orderId }"><span
											class="glyphicon glyphicon-zoom-in"></span></a></td>
									<td>${order.calPrice() }</td>
									<td>
										<button type="button" class="btn btn-primary"
											data-toggle="modal" data-target="#order_${order.orderId }">แจ้งส่งสินค้า</button>
									</td>
								</tr>
							</c:when>
							<c:when test="${order.status == 'จัดส่งแล้ว'}">
								<tr>
									<td><span class="glyphicon glyphicon-share-alt"></span>
										${order.status}</td>
									<td>${order.orderId}</td>
									<td>${order.datetime}</td>
									<td>${order.customer.firstName }${order.customer.lastName }</td>
									<td><a href="#popup_items_${order.orderId }"><span
											class="glyphicon glyphicon-zoom-in"></span></a></td>
									<td>${order.calPrice() }</td>
									<td><a data-balloon="พิมพ์รายการสั่งซื้อ" data-balloon-pos="down" target="_blank" href="/printOrder/${order.orderId }"><span class="glyphicon glyphicon-print"></span></a></td>
								</tr>
							</c:when>
						</c:choose>
					</c:forEach>
				</tbody>
			</table>

		</c:when>
		<c:otherwise>
		ไม่มีรายการสั่งซื้อ
	</c:otherwise>
	</c:choose>
</div>

<c:forEach items="${listOrder }" var="order">

	<div id="popup_items_${order.orderId }" class="overlay-sher">
		<form:form action="/deliveryOrder" method="POST"
			modelAttribute="delivery">
			<div class="popup-sher">
				<h2>รายการสินค้า (ใบสั่งซื้อ ${order.orderId })</h2>
				<a class="close" href="#">ปิด</a>
				<div class="row">
					<table class="table table-striped"">
						<tr>
							<td>รหัสสินค้า</td>
							<td>ชื่อสินค้า</td>
							<td>จำนวนสินค้าที่สั่ง</td>
						</tr>
						<c:forEach items="${order.listProduct }" var="product">
							<tr>
								<td>${product.pk.product.productId }</td>
								<td>${product.pk.product.productName }</td>
								<td>${product.amount }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</form:form>
	</div>
</c:forEach>

<c:forEach items="${listDeliveryOrder }" var="order">
	<div class="modal fade" id="order_${ order.orderId}" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<form:form action="/deliveryOrder" method="POST"
				modelAttribute="delivery">
				<form:hidden path="order.orderId" value="${order.orderId }" />
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">ปิด</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">ยืนยันจัดส่ง
							(ใบสั่งซื้อที่ ${order.orderId })</h4>
					</div>
					<div class="modal-body">

						<div class="row">
							<div class="col-md-4">
								<form:label path="deliveryType">ประเภทการจัดส่ง</form:label>
							</div>
							<div class="col-md-8">
								<div class="row">
									<div class="col-md-6">
										<div class="radio">
											<label> <form:radiobutton path="deliveryType"
													value="ลงทะเบียน" /> ลงทะเบียน
											</label>
										</div>
									</div>
									<div class="col-md-6">
										<div class="radio">
											<label><form:radiobutton path="deliveryType"
													value="ด่วนพิเศษ" /> ด่วนพิเศษ</label>
										</div>

									</div>


								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<form:label path="deliveryCode">รหัสพัสดุ</form:label>
							</div>
							<div class="col-md-8">
								<form:input path="deliveryCode" class="form-control" length="13" />
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">บันทึก</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">ยกเลิก</button>

					</div>
				</div>
			</form:form>
		</div>
	</div>
</c:forEach>

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