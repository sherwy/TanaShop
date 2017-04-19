
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.tana.utilities.*" %>

<div class="nav-header">
	<b>แจ้งชำระเงิน</b>
</div>
<br>
<script>
	function validateConfirmPayment(frm){
		if(frm.date.value ==""){
			alert("กรุณาระบุวันที่ชำระเงิน");
			return false;
		}
		if(frm.paymentHour.value == "" || frm.paymentMins.value == ""){
			alert("กรุณาระบุเวลาที่ชำระเงิน");
			return false;
		}else{
			var reg = /^[0-9]{1,2}$/;
			if(!reg.test(frm.paymentHour.value) || !reg.test(frm.paymentMins.value)){
				alert("กรุณาระบุเวลาที่ชำระเงินเป็นตัวเลขเท่านั้น");
				return false;
			}
		}
		
		if (frm.file.value == "") {
			alert("กรุณากรอกเลือกรูปภาพ");
			frm.file.focus();
			return false;
		} else {
			var reg = /^.+(\.jpg|\.JPG|\.jpeg|\.JPEG|\.png|\.PNG)$/;
			if (!reg.test(frm.file.value)) {
				alert("กรุณาเลือกรูปภาพที่มีนามสกุล .jpg , .jpeg หรือ .png เท่านั้น");
				return false;
			}
			if (frm.file.files[0].size >= 1048576) {
				alert("กรุณาเลือกรูปภาพที่มีขนาดไฟล์น้อยกว่า 1MB");
				return false;
			}
		}
		
	}
</script>
<div class="form-group">
	<form:form action="/confirmPayment" method="POST"
		modelAttribute="payment" enctype="multipart/form-data">
		<div class="form-sher">
			<div class="row">
				<div class="col-md-2">
					<form:label path="bank.id">บัญชีธนาคาร</form:label>
				</div>
				<div class="col-md-4">
					<form:select path="bank.id" class="form-control">
						<c:forEach items="${listBank }" var="bank">
							<option value="${bank.id }">${bank.bankName } - ${bank.bankAccountNumber }</option>
						</c:forEach>
					</form:select>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2">
					<label>วันที่ชำระเงิน</label>
				</div>
				<div class="col-md-4">
					<input name="date" class="form-control" type="date"
						placeholder="วันที่ชำระเงิน" />
				</div>
			</div>
			<div class="row">
				<div class="col-md-2">
					<label>เวลาที่ชำระเงิน</label>
				</div>
				<div class="col-md-2">
					<form:input path="paymentHour" placeholder="ชั่วโมง" type="number" min="0" max="23"
						class="form-control" />
				</div>
				<div class="col-md-2">
					<form:input path="paymentMins" placeholder="นาที" type="number" min="0" max="59"
						class="form-control" />
				</div>
			</div>
			<div class="row">
				<div class="col-md-2">
					<form:label path="imgUrl">หลักฐานการโอนเงิน</form:label>
				</div>
				<div class="col-md-4">
					<input name="file" type="file" class="form-control" />
					<form:hidden path="imgUrl" />
				</div>
			</div>
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<p class="text-center">
						<input class="btn btn-success" type="submit" onclick="return validateConfirmPayment(payment)"
							value="แจ้งการชำระเงิน" />
					</p>
				</div>
				<div class="col-md-4"></div>
			</div>
		</div>
	</form:form>
</div>


<jsp:include page="../componant/footer.jsp" flush="true" />