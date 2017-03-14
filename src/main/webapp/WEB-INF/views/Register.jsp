<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Register" />
</jsp:include>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<b>Register Form</b>
<br>
<form:form action="/addRegister" method="POST" modelAttribute="account">
	<table>
		<tr>
			<td><form:label path="username" >Username</form:label></td>
			<td><form:input path="username" /></td>
		</tr>
		<tr>
			<td><form:label path="password" >Password</form:label></td>
			<td><form:password path="password" /></td>
		</tr>
		<tr>
			<td><form:label path="firstName" >First Name</form:label></td>
			<td><form:input path="firstName" /></td>
		</tr>
		<tr>
			<td><form:label path="lastName" >Last Name</form:label></td>
			<td><form:input path="lastName" /></td>
		</tr>
		<tr>
			<td><form:label path="gender" >Gender</form:label></td>
			<td><form:radiobutton path="gender" value="M" label="Male" /><form:radiobutton path="gender" value="F" label="Female" /></td>
		</tr>
		<tr>
			<td><form:label path="birthDate" >Birthdate</form:label></td>
			<td><form:input path="birthDate" /></td>
		</tr>
		<tr>
			<td><form:label path="telephoneNumber" >Telephone Number</form:label></td>
			<td><form:input path="telephoneNumber" /></td>
		</tr>
		<tr>
			<td colspan="2"><input class="btn btn-primary" type = "submit" value = "Submit"/></td>
		</tr>
	</table>
</form:form>
<jsp:include page="../componant/footer.jsp" flush="true" />