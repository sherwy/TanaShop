<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Register" />
</jsp:include>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<b>Register Form</b>
<br>
<div class="form-group">
	<form:form action="/addRegister" method="POST" modelAttribute="account"
		enctype="multipart/form-data">
		<table class="table table-bordered">
			<tr>
				<td><form:label path="username">Username</form:label></td>
				<td><form:input path="username" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="password">Password</form:label></td>
				<td><form:password path="password" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="firstName">First Name</form:label></td>
				<td><form:input path="firstName" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="lastName">Last Name</form:label></td>
				<td><form:input path="lastName" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="gender">Gender</form:label></td>
				<td>
					<div class="row">
						<div class="col-md-2">
							<div class="radio">
								<label> <form:radiobutton path="gender" value="M" />
									Male
								</label>
							</div>
						</div>
						<div class="col-md-2">
							<div class="radio">
								<label><form:radiobutton path="gender" value="F" />
									Female </label>
							</div>

						</div>


					</div>
				</td>
			</tr>
			<tr>
				<td><form:label path="birthDate">Birthdate</form:label></td>
				<td><form:input path="birthDate" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="telephoneNumber">Telephone Number</form:label></td>
				<td><form:input path="telephoneNumber" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="imgUrl">Image</form:label></td>
				<td><input name="file" type="file" class="form-control" /> <form:hidden
						path="imgUrl" value="" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="row">
						<div class="col-md-4"></div>
						<div class="col-md-4">
							<p class="text-center">
								<input class="btn btn-success" type="submit" value="Register" />
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