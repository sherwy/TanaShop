<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Register" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<b>สมัครสมาชิก</b>
<br>
<div class="form-group">
	<form:form action="/addRegister" method="POST" modelAttribute="account"
		enctype="multipart/form-data">
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
				<td><form:label path="birthDate">วัน - เดือน - ปี เกิด</form:label></td>
				<td><form:input path="birthDate" class="form-control" /></td>
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
								<input class="btn btn-success" type="submit" value="สมัครสมาชิก" />
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