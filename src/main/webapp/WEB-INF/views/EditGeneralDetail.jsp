
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Edit General Detail" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="nav-header">
	<b>เกี่ยวกับร้าน</b>
</div>
<br>
<div class="form-group">
	<script>
		$(document).ready(function() {
			$('#shopDescription').val("${detail.shopDescription}");
			$('#shopDetail').val("${detail.shopDetail}");
			$('#address').val("${detail.address}");
		});

		function validateGenaralForm(frm) {
			if (frm.shopName.value == "") {
				alert("กรุณากรอกชื่อร้าน");
				frm.shopName.focus();
				return false;
			}
			if (frm.shopDescription.value == "") {
				alert("กรุณากรอกรายละเอียดร้านค้า");
				frm.shopDescription.focus();
				return false;
			}
			if (frm.shopDetail.value == "") {
				alert("กรุณากรอกข้อมูลร้านค้า");
				frm.shopDetail.focus();
				return false;
			}
			if (frm.shopTelephone.value == "") {
				alert("กรุณากรอกเบอร์โทรศัพท์");
				frm.shopTelephone.focus();
				return false;
			} else {
				var reg = /^(0)[0-9]{9}$/
				if (!reg.test(frm.shopTelephone.value)) {
					alert("กรุณากรอกเบอร์โทรศัพท์ที่เป็นตัวเลข 10 หลักและขึ้นต้นด้วย 0");
					frm.shopTelephone.focus();
					return false;
				}
			}
			if (frm.email.value == "") {
				alert("กรุณากรอกอีเมล");
				frm.email.focus();
				return false;
			}
			if (frm.address.value == "") {
				alert("กรุณากรอกที่อยู่");
				frm.address.focus();
				return false;
			}
			if (frm.file.value != "") {
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
	<form:form action="/editGeneralDetail" method="POST"
		modelAttribute="generalDetail"  enctype="multipart/form-data">
		<div class="form-sher">
			<c:choose>
				<c:when test="${detail != null }">
					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="shopName">ชื่อร้าน</form:label>
						</div>
						<div class="col-md-6">
							<form:input path="shopName" class="form-control"
								value="${detail.shopName }" />
						</div>
					</div>

					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="shopDescription">รายละเอียดร้านค้า</form:label>
						</div>
						<div class="col-md-6">
							<form:textarea path="shopDescription" class="form-control"></form:textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="shopDetail">ข้อมูลร้านค้า</form:label>
						</div>
						<div class="col-md-6">
							<form:textarea path="shopDetail" class="form-control"></form:textarea>
						</div>
					</div>

					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="shopTelephone">เบอร์โทรศัพท์</form:label>
						</div>
						<div class="col-md-6">
							<form:input path="shopTelephone" class="form-control"
								value="${detail.shopTelephone}" />
						</div>
					</div>

					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="email">อีเมล</form:label>
						</div>
						<div class="col-md-6">
							<form:input path="email" class="form-control"
								value="${detail.email}" />
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="address">ที่อยู่</form:label>
						</div>
						<div class="col-md-6">
							<form:textarea path="address" class="form-control"></form:textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="imgUrl">รูปภาพ</form:label>
						</div>
						<div class="col-md-3">
							<input name="file" id="file" type="file" class="form-control"
								value="${detail.imgUrl }" />
							<form:hidden path="imgUrl" value="${detail.imgUrl }" />
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="shopName">ชื่อร้าน</form:label>
						</div>
						<div class="col-md-6">
							<form:input path="shopName" class="form-control" />
						</div>
					</div>

					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="shopDescription">รายละเอียดร้านค้า</form:label>
						</div>
						<div class="col-md-6">
							<form:textarea path="shopDescription" class="form-control"></form:textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="shopDetail">ข้อมูลร้านค้า</form:label>
						</div>
						<div class="col-md-6">
							<form:textarea path="shopDetail" class="form-control"></form:textarea>
						</div>
					</div>

					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="shopTelephone">เบอร์โทรศัพท์</form:label>
						</div>
						<div class="col-md-6">
							<form:input path="shopTelephone" class="form-control" />
						</div>
					</div>

					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="email">อีเมล</form:label>
						</div>
						<div class="col-md-6">
							<form:input path="email" class="form-control" />
						</div>
					</div>

					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="address">ที่อยู่</form:label>
						</div>
						<div class="col-md-6">
							<form:textarea path="address" class="form-control"></form:textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="imgUrl">รูปภาพ</form:label>
						</div>
						<div class="col-md-3">
							<input name="file" id="file" type="file" class="form-control"
								value="${account.imgUrl }" />
							<form:hidden path="imgUrl"  />
						</div>
					</div>
					
				</c:otherwise>
			</c:choose>


			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<p class="text-center">
						<input class="btn btn-primary"
							onclick="return validateGeneralForm(generalDetail)" type="submit"
							value="บันทึก" />
					</p>
				</div>
				<div class="col-md-4"></div>
			</div>
		</div>
	</form:form>
</div>

<jsp:include page="../componant/footer.jsp" flush="true" />
