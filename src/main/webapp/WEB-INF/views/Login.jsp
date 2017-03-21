
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Login" />
</jsp:include>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<form:form action="/login" method="POST" modelAttribute="account">
	<table>
		<tr>
			<td><form:label path="username">Username</form:label></td>
			<td><form:input path="username" /></td>
		</tr>
		<tr>
			<td><form:label path="password">Password</form:label></td>
			<td><form:password path="password" /></td>
		</tr>

		<tr>
			<td colspan="2"><input class="btn btn-primary" type="submit"
				value="Submit" /></td>
		</tr>
	</table>
</form:form>

<jsp:include page="../componant/footer.jsp" flush="true" />