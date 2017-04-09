<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Register" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<b>สมัครสมาชิก</b>
<br>
<script language="JavaScript">
	function validateRegisterForm(frm) {
		if (frm.username.value == "") {
			alert("กรุณากรอกชื่อผู้ใช้");
			frm.username.focus();
			return false;
		} else {
			var reg = /^[A-Za-z0-9]{2,15}$/;
			if (!reg.test(frm.username.value)) {
				alert("กรุณากรอกชื่อผู้ใช้ที่เป็นภาษาอังกฤษหรือตัวเลขตั้งแต่ 2 ถึง 15 ตัวอักษร");
				frm.username.focus();
				return false;
			}
		}
		if (frm.password.value == "") {
			alert("กรุณากรอกรหัสผ่าน");
			frm.password.focus();
			return false;
		} else {
			var reg = /^[A-Za-z0-9]{4,10}$/;
			if (!reg.test(frm.password.value)) {
				alert("กรุณากรอกรหัสผ่านที่เป็นภาษาอังกฤษหรือตัวเลขตั้งแต่ 4 ถึง 10 ตัวอักษร");
				frm.password.focus();
				return false;
			}
		}
		if (frm.firstName.value == "") {
			alert("กรุณากรอกชื่อ");
			frm.firstName.focus();
			return false;
		} else {
			var reg = /^[A-Za-z\u0E01-\u0E4C]{2,50}$/;
			if (!reg.test(frm.firstName.value)) {
				alert("กรุณากรอกชื่อที่เป็นภาษาไทยหรืออังกฤษตั้งแต่ 2 ถึง 50 ตัวอักษร");
				frm.firstName.focus();
				return false;
			}
		}
		if (frm.lastName.value == "") {
			alert("กรุณากรอกนามสกุล");
			frm.lastName.focus();
			return false;
		} else {
			var reg = /^[A-Za-z\u0E01-\u0E4C\s]{2,100}$/;
			if (!reg.test(frm.lastName.value)) {
				alert("กรุณากรอกนามสกุลที่เป็นภาษาไทยหรืออังกฤษหรือเว้นวรรคตั้งแต่ 2 ถึง 100 ตัวอักษร");
				frm.lastName.focus();
				return false;
			}
		}
		if (frm.gender.value == "") {
			alert("กรุณากรอกเพศ");
			frm.gender.focus();
			return false;
		}
		if (frm.date.value == "") {
			alert("กรุณากรอกวันเกิด");
			return false;
		}
		if (frm.telephoneNumber.value == "") {
			alert("กรุณากรอกหมายเลขโทรศัพท์");
			frm.telephoneNumber.focus();
			return false;
		} else {
			var reg = /^(0)[0-9]{9}$/;
			if (!reg.test(frm.telephoneNumber.value)) {
				alert("กรุณากรอกหมายเลขโทรศัพท์ 10 ตัวอักษรและขึ้นต้นด้วยเลข 0");
				frm.telephoneNumber.focus();
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
			if(frm.file.files[0].size >= 1048576){
				alert("กรุณาเลือกรูปภาพที่มีขนาดไฟล์น้อยกว่า 1MB");
				return false;
			}
		}
	}
</script>
<div class="form-group">
	<form:form action="/addRegister" method="POST"
		modelAttribute="account1" enctype="multipart/form-data">
		<table class="table table-bordered">
			<tr>
				<td><form:label path="username">ชื่อผู้ใช้</form:label></td>
				<td><form:input path="username" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="password">รหัสผ่าน</form:label></td>
				<td><form:password path="password" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="firstName">ชื่อ</form:label></td>
				<td><form:input path="firstName" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="lastName">นามสกุล</form:label></td>
				<td><form:input path="lastName" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="gender">เพศ</form:label></td>
				<td>
					<div class="row">
						<div class="col-md-2">
							<div class="radio">
								<label> <form:radiobutton path="gender" value="M" />
									ชาย
								</label>
							</div>
						</div>
						<div class="col-md-2">
							<div class="radio">
								<label><form:radiobutton path="gender" value="F" />
									หญิง </label>
							</div>

						</div>


					</div>
				</td>
			</tr>
			<tr>
				<td><label>วัน - เดือน - ปี เกิด</label></td>
				<td><input name="date" type="date" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="telephoneNumber">โทรศัพท์มือถือ</form:label></td>
				<td><form:input path="telephoneNumber" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="imgUrl">รูปภาพ</form:label></td>
				<td><input name="file" type="file" class="form-control" /> <form:hidden
						path="imgUrl" value="" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="row">
						<div class="col-md-4"></div>
						<div class="col-md-4">
							<p class="text-center">
								<input class="btn btn-success"
									onclick="return validateRegisterForm(account1)" type="submit"
									value="สมัครสมาชิก" />
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