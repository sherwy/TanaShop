
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<b>แจ้งชำระเงิน</b>
<br>
<div class="form-group">
	<form:form action="/confirmPayment" method="POST"
		modelAttribute="payment" enctype="multipart/form-data">
		<table class="table table-bordered">
			<tr>
				<td><form:label path="bank">บัญชีธนาคาร</form:label></td>
				<td><form:select path="bank" class="form-control">
						<option value="กสิกรไทย">ธนาคารกสิกรไทย</option>
						<option value="ไทยพาณิชย์">ธนาคารไทยพาณิชย์</option>
						<option value="กรุงศรี">ธนาคารกรุงศรี</option>
						<option value="กรุงไทย">ธนาคารกรุงไทย</option>
					</form:select></td>
			</tr>
			<tr>
				<td><label >วันที่ชำระเงิน</label></td>
				<td><input name="date" class="form-control"  type="date"  /> </td>
			</tr>
			<tr>
				<td><label>เวลาที่ชำระเงิน</label></td>
				<td><form:input path="paymentHour" type="text"
						class="form-control" /> <form:input path="paymentMins"
						type="text" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="imgUrl">หลักฐานการโอนเงิน</form:label></td>
				<td><input name="file" type="file" class="form-control" /> <form:hidden
						path="imgUrl" value="tt" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="row">
						<div class="col-md-4"></div>
						<div class="col-md-4">
							<p class="text-center">
								<input class="btn btn-success" type="submit"
									value="แจ้งการชำระเงิน" />
							</p>
						</div>
						<div class="col-md-4"></div>
					</div>
				</td>
			</tr>
		</table>
	</form:form>
</div>


<jsp:include page="../componant/footer.jsp" flush="true" />