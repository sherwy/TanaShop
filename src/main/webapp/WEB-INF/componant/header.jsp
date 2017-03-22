<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="/Tools/css/bootstrap.css" rel="stylesheet">
<script src="/Tools/js/bootstrap.js"></script>
<title>Tana Shop :: ${param.title }</title>
</head>
<body>
	<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="container">

		<%@ page import="com.tana.entities.*"%>
		<%@ page import="com.tana.utilities.*"%>
		<%
			Account user = (Account) session.getAttribute("user");
		%>
		<div class="row">
			<div class="col-md-12">
				<%
					if (user != null) {
				%>
				

				<%
					if (user.getRole().equals(UserRole.ADMIN.getRole())) {
				%>
				<a href="/addProduct" class="btn btn-success" role="button">Add
					Product</a> <a href="listAllOrder" class="btn btn-success"
					role="button">Show Orders</a>

				<%
					} else {
				%>
				<a href="/listProduct" class="btn btn-success" role="button">List
					Product</a> <a href="/myCart" class="btn btn-success" role="button">My
					Cart</a>
				<%
					}
					} else {
				%>

				<a href="/regis" class="btn btn-success" role="button">Register</a>
				<%
					}
				%>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3">
				<div>
					<%
						if (user == null) {
					%>
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
								<td colspan="2"><input class="btn btn-primary"
									type="submit" value="Submit" /></td>
							</tr>
						</table>
					</form:form>


					<%
						} else {
					%>
					<%=user.getFirstName()%>
					<%=user.getLastName()%>
					<a href="/logout" class="btn btn-warning" role="button">Logout</a>
					<%
						}
					%>
				</div>
			</div>
			<div class="col-md-9">