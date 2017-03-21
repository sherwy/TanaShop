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
	<div class="container">

		<%@ page import="com.tana.entities.*"%>
		<%@ page import="com.tana.utilities.*"%>
		<%
			Account user = (Account) session.getAttribute("user");
		%>

		<%
			if (user != null) { %>
		<a href="/logout" class="btn btn-warning" role="button">Logout</a>
		
		<%		if(user.getRole().equals(UserRole.ADMIN.getRole())){ %> 
					<a href="/addProduct" class="btn btn-success" role="button">Add Product</a>
					<a href="listAllOrder" class="btn btn-success" role="button">Show Orders</a>
		
		<%		}else{%>
					<a href="/listProduct" class="btn btn-success" role="button">List Product</a> <a href="/myCart" class="btn btn-success" role="button">My Cart</a>
		<%		}
			}else {%>

			<a href="/login" class="btn btn-info" role="button">Login</a> <a
				href="/regis" class="btn btn-success" role="button">Register</a>
		<%	}%>