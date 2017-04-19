<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="TIS-620"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
<title>Insert title here</title>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
</head>
<link href="/Tools/css/bootstrap.css" rel="stylesheet">
<link href="/Tools/css/main.css" rel="stylesheet">
<body style="width: 1000px;font-size:200%;background-image:url()">

	<div class="form-sher">
		<div class="row">
			<div class="col-md-12" style="text-align: center; font-size:200%; background-color:#c1c1c1;"><b>ใบส่งสินค้า</b></div>
		</div>
		<div class="row">
			<table class="table table-bordered">
				<tr>
					<td style="text-align: right"><b>ใบส่งสินค้า</b></td>
					<td style="text-align: left">${order.orderId }</td>
					<td style="text-align: right"><b>วันที่สั่งซื้อ</b></td>
					<td style="text-align: left">${order.datetime }</td>
				</tr>

				<tr>
					<td style="text-align: right"><b>ผู้สั่งซื้อ</b></td>
					<td style="text-align: left">${order.customer.firstName }
						${order.customer.lastName }</td>
					<td style="text-align: right"><b>รายการสินค้าทั้งหมด</b></td>
					<td style="text-align: left">${fn:length(order.listProduct)}
						รายการ</td>
				</tr>

				<tr>
					<td style="text-align: right"><b>วิธีจัดส่ง</b></td>
					<td style="text-align: left">${order.delivery.deliveryType }</td>
					<td></td>
					<td></td>
				</tr>

			</table>
		</div>
	<div class="row">
		<div class="col-md-12" style="text-align:center; font-size:200%;">
			<b>ข้อมูลรายการสั่งซื้อ</b>
		</div>
	</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-bordered">
					<tr>
						<td style="text-align:center; background-color:#c1c1c1;">ลำดับ</td>
						<td style="text-align:center; background-color:#c1c1c1;">รายการสินค้า</td>
						<td style="text-align:center; background-color:#c1c1c1;">จำนวนสินค้า (ชิ้น)</td>
						<td style="text-align:center; background-color:#c1c1c1;">ราคาต่อหน่วย</td>
						<td style="text-align:center; background-color:#c1c1c1;">จำนวนเงิน(บาท)</td>
						<td style="text-align:center; background-color:#c1c1c1;">ตรวจสอบ</td>
					</tr>

					<c:forEach items="${order.listProduct}" var="product"
						varStatus="index">
						<tr>
							<td>${index.index+1 }</td>
							<td>${product.pk.product.productName }</td>
							<td>${product.amount }</td>
							<td>${product.pk.product.price }</td>
							<td>${product.amount*product.pk.product.price }</td>
							<td style="text-align:center;"><span class="glyphicon glyphicon-unchecked"
								style="font-size: 160%"></span></td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="4" style="text-align:right;">ราคารวม</td>
						<td>${order.calPrice() }</td>
						<td></td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:right;">ค่าส่งสินค้า</td>
						<td>${order.otherAmount }</td>
						<td></td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:right;">จำนวนเงินรวมสุทธิ</td>
						<td><b>${order.calPrice() + order.otherAmount }</b></td>
						<td></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<button onclick="window.print()">พิมพ์รายการ</button>
			</div>
		</div>
	</div>
</body>
</html>