<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="TIS-620"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
<link href="/Tools/css/bootstrap.css" rel="stylesheet">
<link href="/Tools/css/main.css" rel="stylesheet">
<link rel="shortcut icon" href="../favicon.ico">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>

<title>Tana Shop :: ${param.title }</title>
</head>
<body>
	<script language="JavaScript">
		function validateLogin(frm) {
			if (frm.username.value == "") {
				alert("กรุณากรอกชื่อผู้ใช้");
				return false;
			}

			if (frm.password.value == "") {
				alert("กรุณากรอกรหัสผ่าน");
				return false;
			}
		}
	</script>

	<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="container">

		<%@ page import="com.tana.entities.*"%>
		<%@ page import="com.tana.utilities.*"%>
		<%
			Account user = (Account) session.getAttribute("user");
		%>

		<!--  banner -->
		<div class="row headerbanner"></div>

		<!-- nav -->
		<div class="row">
			<div class="navContainer">
				<div class="col-md-3">
					<div class="row">
						<div class="col-md-12">
							<a href="#">
								<div class="navBlock">หน้าแรก</div>
							</a>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="row">
						<div class="col-md-6">
							<a href="/howTo">

								<div class="navBlock">วิธีการสั่งซื้อ</div>
							</a>
						</div>
						<div class="col-md-6">
							<a
								href="<%if (user != null && user.getRole().equals(UserRole.USER.getRole())) {%>/myCart<%} else {%>#<%}%>">
								<div class="navBlock">ตะกร้าสินค้า</div>
							</a>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="col-md-6">
						<a
							href="<%if (user != null && user.getRole().equals(UserRole.USER.getRole())) {%>/confirmPayment<%} else {%>#<%}%>">
							<div class="navBlock">แจ้งการชำระเงิน</div>
						</a>
					</div>
					<div class="col-md-6">
						<a href="#">
							<div class="navBlock">เว็บบอร์ด</div>
						</a>
					</div>
				</div>
				<div class="col-md-3">
					<div class="col-md-6">
						<a href="#">
							<div class="navBlock">เกี่ยวกับเรา</div>
						</a>
					</div>
					<div class="col-md-6">
						<a href="#">
							<div class="navBlock">ติดต่อเรา</div>
						</a>
					</div>
				</div>
			</div>
		</div>

		<!-- content -->
		<div class="row">

			<!-- nav left -->
			<div class="col-md-3 menuNav">
				<%
					if (user == null) {
				%>
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<form:form action="/login" method="POST" modelAttribute="account">

								<table class="tableLogin">
									<tr>
										<td colspan="2"><c:choose>
												<c:when test="${loginErrorMsg != null }">
													<div class="alert alert-${loginErrorMsg.status }">
														<span class="label label-${loginErrorMsg.status }">
															<h3>
																<span class="${loginErrorMsg.icon }"> </span>
																${loginErrorMsg.header }
															</h3>
														</span>
														<p>${loginErrorMsg.text }</p>
													</div>
												</c:when>
											</c:choose></td>
									</tr>
									<tr>
										<td><form:label path="username" for="username">ชื่อผู้ใช้</form:label>
											<form:input path="username" class="form-control" /></td>
									</tr>
									<tr>
										<td><form:label path="password" for="password">รหัสผ่าน</form:label>
											<form:password path="password" class="form-control" /></td>
									</tr>

									<tr>
										<td>
											<div class="row footerLogin">
												<div class="col-md-6">
													<a href="/regis" class="btn btn-success buttonFooter"
														role="button">Register</a>
												</div>
												<div class="col-md-6">
													<input
														class="btn btn-primary btn-default btn-block buttonFooter"
														type="submit" onclick="return validateLogin(account)"
														value="Login" />
												</div>
											</div>
										</td>
									</tr>
								</table>
							</form:form>
						</div>
					</div>
				</div>



				<%
					} else {
				%>
				<div class="row ">
					<div class="col-md-6">
						<img
							src="/Images/Users/<%=user.getUsername()%>/<%=user.getImgUrl()%>"
							width="100%" height="100%" class="img-thumbnail">
					</div>
					<div class="col-md-6">
						<div>
							<b><%=user.getFirstName()%></b>
							<%=user.getLastName()%></div>
						<div>
							-
							<%=user.getUsername()%>
							-
						</div>
					</div>



				</div>
				<div class="row footerLogin">
					<div class="col-md-6">
						<a href="/logout" class="btn btn-danger buttonFooter"
							role="button">ออกจากระบบ</a>
					</div>
					<div class="col-md-6">
						<a href="#" class="btn btn-success buttonFooter" role="button">แก้ไขข้อมูลส่วนตัว</a>
					</div>

				</div>

				<%
					}
				%>
				<div class="row">
					<div class="col-md-12">
						<%
							if (user != null) {
						%>


						<%
							if (user.getRole().equals(UserRole.ADMIN.getRole())) {
						%>
						<div class="menuNavBlock">
							<a href="/addProduct"> <img
								src="../../Images/Menu Nav/menunav-addproduct.jpg" height="100%"
								width="100%" alt="Avatar" class="img-thumbnail imgOpacity">
							</a>
						</div>
						<div class="menuNavBlock">
							<a href="listAllOrder"> <img
								src="../../Images/Menu Nav/menunav-listproducts.jpg"
								height="100%" width="100%" alt="Avatar"
								class="img-thumbnail imgOpacity">
							</a>
						</div>
						<a href="/listAdminProduct" class="btn btn-success" role="button">Manage
							Product</a> <a href="/addCategory" class="btn btn-success"
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


						<%
							}
						%>
					</div>
				</div>
			</div>

			<!-- content -->
			<div class="col-md-9">