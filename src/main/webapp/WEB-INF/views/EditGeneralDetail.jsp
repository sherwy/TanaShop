
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Edit General Detail" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script language="JavaScript">
	function validateGeneralDetail(frm){
		if(frm.shopName.value == ""){
		   alert("กรุณากรอกชื่อร้าน");
		   frm.shopName.focus();
			return fales;
		   }
		if(frm.shopDescription.value == ""){
		   alert("กรุณากรอกรายละเอียดร้านค้า");
		   frm.shopDescription.focus();
			return fales;
		   }
		if(frm.shopDetail.value == ""){
		   alert("กรุณากรอกข้อมูลร้านค้า");
		   frm.shopDetail.focus();
			return fales;
		   }
		if(frm.shopTelephone.value == ""){
		   alert("กรุณากรอกเบอร์โทรศัพท์");
		   frm.shopTelephone.focus();
			return fales;
		   }else{
		   var reg = /^(0)[0-9]{9}$/;
		   if(reg.test(frm.shopTelephone.value)){
		   	alert("กรุณากรอกเบอร์โทรศัพท์ที่เป็นตัวเลขและขึ้นต้นด้วย 0");
		   	frm.shopTelephone.focus();
			return fales;
		   }
		   }
		if(frm.email.value == ""){
		   alert("กรุณากรอกอีเมล");
		   frm.email.focus();
			return fales;
		   }
	}
</script>
<div class="form-group">
	<form:form action="/editGeneralDetail" method="POST"
		modelAttribute="generalDetail">
		<table class="table table-bordered">
			<c:choose>
				<c:when test="${detail != null }">
					<tr>
						<td><form:label path="shopName">ชื่อร้าน</form:label></td>
						<td><form:input path="shopName" class="form-control"
								value="${detail.shopName }" /></td>
					</tr>
					<tr>
						<td><form:label path="shopDescription">รายละเอียดร้านค้า</form:label></td>
						<td><form:textarea path="shopDescription"
								class="form-control" value="${detail.shopDescription}" /></td>
					</tr>
					<tr>
						<td><form:label path="shopDetail">ข้อมูลร้านค้า</form:label></td>
						<td><form:textarea path="shopDetail" class="form-control"
								value="${detail.shopDetail}" /></td>
					</tr>
					<tr>
						<td><form:label path="shopTelephone">เบอร์โทรศัพท์</form:label></td>
						<td><form:input path="shopTelephone" class="form-control"
								value="${detail.shopTelephone}" /></td>
					</tr>
					<tr>
						<td><form:label path="email">อีเมล</form:label></td>
						<td><form:input path="email" class="form-control"
								value="${detail.email}" /></td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="row">
								<div class="col-md-4"></div>
								<div class="col-md-4">
									<p class="text-center">
										<input class="btn btn-primary" onclick="validateGeneralDetail(generalDetail)" type="submit"
											value="บันทึก" />
									</p>
								</div>
								<div class="col-md-4"></div>
							</div>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td><form:label path="shopName">ชื่อร้าน</form:label></td>
						<td><form:input path="shopName" class="form-control"
								value="" /></td>
					</tr>
					<tr>
						<td><form:label path="shopDescription">รายละเอียดร้านค้า</form:label></td>
						<td><form:textarea path="shopDescription"
								class="form-control" value="" /></td>
					</tr>
					<tr>
						<td><form:label path="shopDetail">ข้อมูลร้านค้า</form:label></td>
						<td><form:textarea path="shopDetail" class="form-control"
								value="" /></td>
					</tr>
					<tr>
						<td><form:label path="shopTelephone">เบอร์โทรศัพท์</form:label></td>
						<td><form:input path="shopTelephone" class="form-control"
								value="" /></td>
					</tr>
					<tr>
						<td><form:label path="email">อีเมล</form:label></td>
						<td><form:input path="email" class="form-control"
								value="" /></td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="row">
								<div class="col-md-4"></div>
								<div class="col-md-4">
									<p class="text-center">
										<input class="btn btn-primary" onclick="validateGeneralDetail(generalDetail)" type="submit"
											value="บันทึก" />
									</p>
								</div>
								<div class="col-md-4"></div>
							</div>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>

		</table>
	</form:form>
</div>

<jsp:include page="../componant/footer.jsp" flush="true" />
