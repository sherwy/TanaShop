<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Register" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div class="nav-header">
	<b>สมัครสมาชิก</b>
</div>
<br>
<script>
	$(document).ready(function() {
		$("#file").change(function() {
			updateImg(this);
		});
	});

	function updateImg(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			var reg = /^.+(\.jpg|\.JPG|\.jpeg|\.JPEG|\.png|\.PNG)$/;
			if (!reg.test(input.value)) {
				alert("กรุณาเลือกรูปภาพที่มีนามสกุล .jpg , .jpeg หรือ .png เท่านั้น");
				input.value = "";
			} else if (input.files[0].size >= 1048576) {
				alert("กรุณาเลือกรูปภาพที่มีขนาดไฟล์น้อยกว่า 1MB");
				input.value = "";
			} else {
				reader.onload = function(e) {
					$('#preview').attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
	}

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
		if (frm.confirm - password.value == "") {
			alert("กรุณายืนยันรหัสผ่าน");
			frm.confirm - password.focus();
			return false;
		} else {
			if (frm.confirmpassword.value != frm.password.value) {
				alert("รหัสผ่านกับยืนยันรหัสผ่านไม่ตรงกัน กรุณาลองอีกครั้ง");
				frm.confirmpassword.value = "";
				frm.confirmpassword.focus();
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

		if (frm.zipcode.value == "") {
			alert("กรุณากรอกรหัสไปรษณีย์");
			frm.zipcode.focus();
			return false;
		} else {
			var reg = /^[0-9]{5}$/;
			if (!reg.test(frm.zipcode.value)) {
				alert("กรุณารหัสไปรษณีย์ทีเป็นตัวเลข 5 คัว");
				frm.zipcode.value = "";
				frm.zipcode.focus();
				return false;
			}
		}

		if (frm.address.value == "") {
			alert("กรุณากรอกที่อยู่");
			frm.telephoneNumber.focus();
			return false;
		}
	
		if(frm.email.value == ""){
			alert("กรุณาอีเมล");
			frm.email.focus();
			return false;
		}else{
			var reg = /^[A-Za-z0-9\.\-\_]+\@[A-Za-z0-9]+(\.[A-Za-z]+)+$/;
			if (!reg.test(frm.email.value)) {
				alert("กรุณาอีเมลให้ตรงรูปแบบ");
				frm.email.focus();
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
	<form:form action="/addRegister" method="POST"
		modelAttribute="account1" enctype="multipart/form-data">

		<div class="form-sher">
			<div class="row">
				<div class="col-md-2 header-sher">
					<form:label path="username">ชื่อผู้ใช้</form:label>
				</div>
				<div class="col-md-6">
					<form:input path="username" placeholder="ชื่อผู้ใช้"
						class="form-control" value="${account.username }"/>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 header-sher">
					<form:label path="password">รหัสผ่าน</form:label>
				</div>
				<div class="col-md-6">
					<form:password path="password" placeholder="รหัสผ่าน้"
						class="form-control" />
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 header-sher">
					<label>ยืนยันรหัสผ่าน</label>
				</div>
				<div class="col-md-6">
					<input type="password" name="confirmpassword" id="confirmpassword"
						placeholder="ยืนยันรหัสผ่าน้" class="form-control" />
				</div>
			</div>
			<hr />
			<div class="row">
				<div class="col-md-2 header-sher">
					<form:label path="firstName">ชื่อ</form:label>
				</div>
				<div class="col-md-6">
					<form:input path="firstName" placeholder="ชื่อ"
						class="form-control" value="${account.firstName }"/>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 header-sher">
					<form:label path="lastName">นามสกุล</form:label>
				</div>
				<div class="col-md-6">
					<form:input path="lastName" placeholder="นามสกุล"
						class="form-control" value="${account.lastName }"/>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 header-sher">
					<form:label path="address">ที่อยู่่</form:label>
				</div>
				<div class="col-md-6">
					<form:textarea path="address" placeholder="ที่อยู่"
						class="form-control"></form:textarea>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 header-sher">
					<form:label path="zipcode">รหัสไปรษณีย์</form:label>
				</div>
				<div class="col-md-2">
					<form:input path="zipcode" placeholder="รหัสไปรษณีย์" maxlength="5"
						class="form-control" value="${account.zipcode }"/>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 header-sher">
					<form:label path="telephoneNumber">โทรศัพท์มือถือ</form:label>
				</div>
				<div class="col-md-2">
					<form:input path="telephoneNumber" placeholder="โทรศัพท์มือถือ"
						maxlength="10" class="form-control" value="${account.telephoneNumber }"/>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 header-sher">
					<form:label path="email">อีเมล</form:label>
				</div>
				<div class="col-md-5">
					<form:input path="email" placeholder="อีเมล" class="form-control"  value="${account.email }"/>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 header-sher">
					<form:label path="imgUrl">รูปภาพ</form:label>
				</div>
				<div class="col-md-3">
					<input name="file" id="file" type="file" class="form-control"   value="${account.imgUrl }"/>
					<form:hidden path="imgUrl" value="${account.imgUrl }" />
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 header-sher"><label>รูปภาพตัวอย่าง</label></div>
				<div class="col-md-4">
					<img id="preview" class="img-thumbnail" width="200px" />
				</div>
				<div class="col-md-6"></div>
			</div>
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
		</div>
		
		
	</form:form>
</div>
<jsp:include page="../componant/footer.jsp" flush="true" />