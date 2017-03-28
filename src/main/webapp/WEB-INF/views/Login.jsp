
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Login" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<form:form action="/login" method="POST" modelAttribute="account">
	<table>
		<tr>
			<td><form:label path="username">ชื่อผู้ใช้</form:label></td>
			<td><form:input path="username" /></td>
		</tr>
		<tr>
			<td><form:label path="password">รหัสผ่าน</form:label></td>
			<td><form:password path="password" /></td>
		</tr>

		<tr>
			<td colspan="2"><input class="btn btn-primary" type="submit"
				value="เข้าสู่ระบบ" /></td>
		</tr>
	</table>
</form:form>

<jsp:include page="../componant/footer.jsp" flush="true" />