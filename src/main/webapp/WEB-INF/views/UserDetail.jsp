<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Register" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div class="form-sher">

	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<div class="nav-header">
						<b>ข้อมูลทั่วไป</b>
					</div>
					<br>
				</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-6">
							<img width="400px"
								src="/Images/Users/${user.username }/${user.imgUrl}" />
						</div>
						<div class="col-md-6">
							<div class="row">
								<div class="col-md-4">
									<b>ชื่อที่ใช้แสดง</b>
								</div>
								<div class="col-md-8">${user.username }</div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<b>ชื่อสกุล</b>
								</div>
								<div class="col-md-8">${user.firstName }${user.lastName }
								</div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<b>อีเมล</b>
								</div>
								<div class="col-md-8">${user.email }</div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<b>โทรศัพท์</b>
								</div>
								<div class="col-md-8">${user.telephoneNumber }</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<div class="nav-header">
						<b>รายการสั่งซื้อ</b>
					</div>
					<br>
				</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
							<table id="listUser" class="table table-striped">
								<thead>
									<tr>
										<td>สถานะ</td>
										<td>เลขที่ใบสั่งซื้อ</td>
										<td>วันที่สั่งซื้อ</td>
										<td>รายการสินค้า</td>
										<td>ราคา (บาท)</td>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${listDeliveredOrder}" var="order"
										varStatus="i">
										<tr>
											<td>${order.status }</td>
											<td>${order.orderId}</td>
											<td>${order.datetime}</td>
											<td><a href="#popup_items_${order.orderId }" data-balloon="ดูข้อมูล"
										data-balloon-pos="down" ><span class="glyphicon glyphicon-eye-open"></span></a></td>
											<td>${order.otherAmount + order.calPrice() }</td>
											<td></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<div class="nav-header">
						<b>รายการแจ้งชำระเงิน</b>
					</div>
					<br>
				</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
							<table class="table table-striped">
								<thead>
									<tr>
										<td>สถานะ</td>
										<td>เลขที่ใบชำระเงิน</td>
										<td>ช่องทางชำระเงิน</td>
										<td>จำนวนเงิน (บาท)</td>
										<td>วันที่ชำระ</td>
										<td>ใบสั่งซื้อ</td>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${listPaymentOrder}" var="order"
										varStatus="i">
										<tr>
											<td>${order.status }</td>
											<td>${order.payment.id}</td>
											<td>${order.payment.bank.bankName}
												>${order.payment.bank.bankAccountNumber}</td>
											<td>${order.otherAmount + order.calPrice() }</td>
											<td>${order.datetime }</td>
											<td>${order.orderId }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<c:forEach items="${listDeliveredOrder }" var="order">
	<div id="popup_items_${order.orderId }" class="overlay-sher">
			<div class="popup-sher">
				<h2>รายการสินค้า (ใบสั่งซื้อ ${order.orderId })</h2>
				<a class="close" href="#">ปิด</a>
				<div class="row">
					<table class="table table-striped">
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
	</div>
	<script type="text/javascript">
		$('#carousel_${prod_productId }').elastislide();
	</script>

</c:forEach>
<script>
	$(function() {
		$("#listUser").dataTable({
			responsive : true,
			ajax : '/api/data',
			scrollY : 200,
			deferRender : true,
			scroller : true
		});
	})
</script>
<jsp:include page="../componant/footer.jsp" flush="true" />