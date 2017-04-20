<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Register" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="nav-header">
	<b>ตรวจสอบสถานะสินค้า</b>
</div>
<br>
<%@page import="com.tana.utilities.*"%>
<script>

</script>
<div class="form-sher">
	<table id="listOrder" class="table table-striped">
		<thead>
			<tr>
				<td>เลขที่ใบสั่งซื้อ</td>
				<td>สถานะ</td>
				<td>ประเภทการขนส่ง</td>
				<td>รหัสพัสดุ</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${listOrder}" var="order">
				<tr>
					<td>${order.orderId}</td>
					<td>${order.status }</td>
					<td>${order.delivery.deliveryType}</td>
					<td>${order.delivery.deliveryCode }</td>
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