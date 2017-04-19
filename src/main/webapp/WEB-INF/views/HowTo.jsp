
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="nav-header">
	<b>วิธีการสั่งซื้อ</b>
</div>
<br>
<ul class="media-list">
	<li class="media">
		<div class="pull-left">
			<a href="#"> <span class="span-img-howto">1</span>
			</a>
		</div>
		<div class="media-body">
			<h4 class="media-heading">เลือกสินค้า</h4>
			เลือกสินค้าที่คุณต้องการ หลังจากนั้นคลิก "หยิบลงตะกร้า"
		</div>
	</li>
	<li class="media">
		<div class="pull-left">
			<a href="#"> <span class="span-img-howto">2</span>
			</a>
		</div>
		<div class="media-body">
			<h4 class="media-heading">เลือกวิธีจัดส่งสินค้า</h4>
			เมื่อเลือกสินค้าครบแล้วหลังจากนั้นคลิกเลือกวิธีการจัดส่งสินค้า
		</div>
	</li>
	<li class="media">
		<div class="pull-left">
			<a href="#"> <span class="span-img-howto">3</span>
			</a>
		</div>
		<div class="media-body">
			<h4 class="media-heading">ยืนยันการสั่งซื้อ</h4>
			เมื่อเลือกวิธีการจัดส่งสินค้าแล้วหลังจากนั้นคลิก "ยืนยันการสั่งซื้อ"
		</div>
	</li>
	<li class="media">
		<div class="pull-left">
			<a href="#"> <span class="span-img-howto">4</span>
			</a>
		</div>
		<div class="media-body">
			<h4 class="media-heading">ชำระสินค้า</h4>
			ชำระค่าสินค้าและบริการผ่านธนาคารที่ร้านค้าได้เปิดบัญชีไว้
		</div>
	</li>
	<li class="media">
		<div class="pull-left">
			<a href="#"> <span class="span-img-howto">5</span>
			</a>
		</div>
		<div class="media-body">
			<h4 class="media-heading">แจ้งชำระเงิน</h4>
			แจ้งชำระเงินผ่านทางหน้าเว็บไซต์โดยคลิกที่ "แจ้งชำระเงิน"
		</div>
	</li>
	<li class="media">
		<div class="pull-left">
			<a href="#"> <span class="span-img-howto">6</span>
			</a>
		</div>
		<div class="media-body">
			<h4 class="media-heading">รอการตรวจสอบ</h4>
			รอทางร้านตรวจสอบรายการชำระเงินภายใน 1-2 วัน
			โดยสามารถตรวจสอบสถานะได้ที่ "ตรวจสอบสถานะสินค้า"
		</div>
	</li>
	<li class="media">
		<div class="pull-left">
			<a href="#"> <span class="span-img-howto">7</span>
			</a>
		</div>
		<div class="media-body">
			<h4 class="media-heading">จัดส่งสินค้า</h4>
			หลังจากแจ้งชำระเงินเรียบร้อยแล้วทางร้านจะจัดส่งสินค้าให้คุณทันทีตามระยะเวลาการจัดส่งที่ได้แจ้งไว้
		</div>
	</li>
</ul>
<div class="nav-header">
	<b>วิธีการชำระเงิน</b>
</div>
<div class="row">
	<div class="col-md-12">
		<table class="table table-hover">
			<tr>
				<th>ลำดับ</th>
				<th>ธนาคาร</th>
				<th>เลขที่่บัญชี</th>
				<th>ชื่อบัญชี</th>
				<th>สาขา</th>
				<th>ประเภท</th>
			</tr>
			<c:forEach items="${listBank }" var="bank" varStatus="index">
				<tr>
					<td>${index.index+1 }</td>
					<td>${bank.bankName }</td>
					<td>${bank.bankAccountNumber }</td>
					<td>${bank.bankAccountName }</td>
					<td>${bank.branch }</td>
					<td>${bank.bankAccountType }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>


<br>


<jsp:include page="../componant/footer.jsp" flush="true" />