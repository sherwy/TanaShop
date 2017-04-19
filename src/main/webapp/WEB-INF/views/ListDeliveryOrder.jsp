<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Register" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="nav-header">
	<b>รายการจัดขนส่งสินค้า</b>
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
				<td>เลขที่ใบสั่งซื้อ</td>
				<td>ผู้แจ้งสั่งซื้อ</td>
				<td>สินค้าที่จัดส่ง</td>
				<td>รายละเอียดที่จัดส่ง</td>
				<td>ประเภทการขนส่ง</td>
				<td>รหัสพัสดุ</td>
				<td>ยืนยันการจัดส่ง</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${listOrder}" var="order">
				<tr>
					<td>${order.status }</td>
					<td>${order.payment.id}</td>
					<td>${order.customer.firstName }${order.customer.lastName }</td>
					<td><a href="#popup_items_${order.orderId }"><span class="glyphicon glyphicon-zoom-in"></span></a></td>
					<td><b>ผู้รับ :</b> ${order.customer.firstName }
						${order.customer.lastName }<br /> <b>ที่อยู่ :</b>
						${order.customer.address } <br /> <b>รหัสไปรษณีย์ :</b>
						${order.customer.zipcode } <br /> <b>เบอร์โทรศัพท์ :</b>
						${order.customer.telephoneNumber }</td>
					<td>${order.delivery.deliveryType}</td>
					<td>${order.delivery.deliveryCode }</td>
					<td><c:set var="status"
							value="${fn:split(mapStatus.get(order.status), ',')}" /> <c:set
							var="icon" value="${status[0] }" /> <c:set var="iconStatus"
							value="${status[1] }" />
						<div class="symbol-sher">
							<c:choose>
								<c:when test="${order.status == mapStatus.get('0') }">
									<a href="#popup_${order.orderId }"
										data-balloon="ยืนยันการจัดส่ง" data-balloon-pos="down"
										class="fail"><span class="glyphicon glyphicon-th-large "></span></a>
								</c:when>
								<c:when test="${order.status == mapStatus.get('1') }">
									<a href="#" data-balloon="ยืนยันจัดส่งเรียบร้อยแล้ว"
										data-balloon-pos="down" class="success"><span
										class="glyphicon glyphicon-ok "></span></a>
								</c:when>
							</c:choose>

						</div></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>



<c:forEach items="${listOrder }" var="order">
	<div id="popup_${order.orderId }" class="overlay-sher">
		<form:form action="/deliveryOrder" method="POST"
			modelAttribute="delivery">
			<div class="popup-sher">
				<h2>ยืนยันจัดส่ง (ใบสั่งซื้อที่ ${order.orderId })</h2>
				<form:hidden path="order.orderId" value="${order.orderId }" />
				<a class="close" href="#">ปิด</a>
				<div class="row">
					<div class="col-md-2">
						<form:label path="deliveryType">ประเภทการจัดส่ง</form:label>
					</div>
					<div class="col-md-4">
						<div class="radio">
							<label> <form:radiobutton path="deliveryType"
									value="ลงทะเบียน" /> ลงทะเบียน
							</label>
						</div>
					</div>
					<div class="col-md-4">
						<div class="radio">
							<label><form:radiobutton path="deliveryType"
									value="ด่วนพิเศษ" /> ด่วนพิเศษ</label>
						</div>

					</div>
				</div>
				<div class="row">
					<div class="col-md-2">
						<form:label path="deliveryCode">รหัสพัสดุ</form:label>
					</div>
					<div class="col-md-4">
						<form:input path="deliveryCode" class="form-control" length="13" />
					</div>
				</div>

				<div class="row">
					<div class="col-md-2"></div>
					<div class="col-md-4">
						<button type="submit" class="btn btn-primary">บันทึก</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">ยกเลิก</button>
					</div>
				</div>




			</div>
		</form:form>
	</div>

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
	<script type="text/javascript">
		$('#carousel_${prod_productId }').elastislide();
	</script>

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