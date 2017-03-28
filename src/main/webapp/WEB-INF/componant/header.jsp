<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="TIS-620"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
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
					<a href="/listAdminProduct" class="btn btn-success"
					role="button">Manage Product</a>
					<a href="/addCategory" class="btn btn-success"
					role="button">Add Cateogry</a>
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
					<div class="form-group">
						<form:form action="/login" method="POST" modelAttribute="account">

							<table>
								<tr>
									<td><form:label path="username" for="username">Username</form:label>
										<form:input path="username" class="form-control" /></td>
								</tr>
								<tr>
									<td><form:label path="password" for="password">Password</form:label>
										<form:password path="password" class="form-control" /></td>
								</tr>

								<tr>
									<td colspan="2"><p class="text-center">
											<input class="btn btn-primary btn-default btn-block"
												type="submit" value="Submit" />
										</p></td>
								</tr>
							</table>
						</form:form>
					</div>


					<%
						} else {
					%>
					<div class="row">
						<div class="col-md-12">
							<img src="/Images/Users/<%= user.getImgUrl() %>" width="100px" height="100px" class="img-thumbnail">
						</div>



					</div>
					
					<div class="row">
						<div class="col-md-12"><%=user.getFirstName()%>
							<%=user.getLastName()%></div>



					</div>
					<div class="row">
						<div class="col-md-12">
							<a href="/logout" class="btn btn-warning" role="button">Logout</a>
						</div>
					</div>

					<%
						}
					%>
				</div>
			</div>
			<div class="col-md-9">