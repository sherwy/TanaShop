
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>
<%@ page import="com.tana.entities.*" %>
<%
	Account user = (Account) session.getAttribute("user");
%>

<%
	if (user != null) {
%>
<a href="/logout" class="btn btn-warning" role="button">Logout</a>
<%
	} else {
%>

<a href="/login" class="btn btn-info" role="button">Login</a>
<%
	}
%>
<a href="/regis" class="btn btn-success" role="button">Register</a>
<br>

<jsp:include page="../componant/footer.jsp" flush="true" />