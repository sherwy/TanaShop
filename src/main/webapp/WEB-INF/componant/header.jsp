<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="TIS-620"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
<link href="/Tools/css/bootstrap.css" rel="stylesheet">
<link href="/Tools/css/main.css" rel="stylesheet">
<link rel="shortcut icon" href="../favicon.ico">
<title>Tana Shop :: ${param.title }</title>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("body").css("display", "none");
		$("body").fadeIn(500);
	});
</script>
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
			<nav class="navbar navbar-default">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#menunav-all"
						aria-expanded="false">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#"><span
						class="glyphicon glyphicon-chevron-right"></span></a>
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="menunav-all">
					<ul class="nav navbar-nav menuNavBlock">
						<%
							if (user == null || user.getRole().equals(UserRole.ADMIN.getRole())) {
						%>
						<li class="menuNav"><a href="/index">หน้าแรก</a></li>
						<li class="menuNav"><a href="/howTo">วิธีการสั่งซื้อ</a></li>
						<li class="menuNav"><a href="#">เว็บบอร์ด</a></li>
						<li class="menuNav"><a href="#">เกี่ยวกับเรา</a></li>
						<li class="menuNav"><a href="#">ติดต่อเรา</a></li>
						<%
							} else if (user != null && user.getRole().equals(UserRole.USER.getRole())) {
						%>

						<li class="menuNav"><a href="/index">หน้าแรก</a></li>
						<li class="menuNav"><a href="/howTo">วิธีการสั่งซื้อ</a></li>
						<li class="menuNav"><a href="/myCart">ตะกร้าสินค้า</a></li>
						<li class="menuNav"><a href="/confirmPayment">แจ้งการชำระเงิน</a></li>
						<li class="menuNav"><a href="#">เว็บบอร์ด</a></li>
						<li class="menuNav"><a href="#">เกี่ยวกับเรา</a></li>
						<li class="menuNav"><a href="#">ติดต่อเรา</a></li>

						<%
							}
						%>
					</ul>
				</div>

			</div>
			</nav>
		</div>

		<%
			if (user != null && user.getRole().equals(UserRole.ADMIN.getRole())) {
		%>
		<div class="row">
			<nav class="navbar navbar-default">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#manunav-admin"
						aria-expanded="false">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#"><span
						class="glyphicon glyphicon-asterisk"></span></a>
				</div>
				<div class="collapse navbar-collapse" id="manunav-admin">
					<ul class="nav navbar-nav navbar-right menuNavBlock-admin">
						<li class="menuNav-admin"><a href="/editGeneralDetail">ข้อมูลทั่วไป</a></li>
						<li class="menuNav-admin"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">จัดการสินค้า <span class="caret"></span>
						</a>
							<ul class="menuNavBlock-inside dropdown-menu">
								<li class="menuNav-inside"><a href="/addProduct">เพิ่มสินค้าใหม่</a></li>
								<li class="menuNav-inside"><a href="/listAdminProduct">รายการสินค้า</a></li>
								<li class="menuNav-inside"><a href="/addCategory">เพิ่มหมวดหมู่</a></li>
							</ul></li>
						<li class="menuNav-admin"><a href="/listAllOrder">รายการสั่งซื้อ</a></li>
						<li class="menuNav-admin"><a href="#">การเงิน</a></li>
						<li class="menuNav-admin"><a href="#">ขนส่งสินค้า</a></li>
						<li class="menuNav-admin"><a href="#">จัดการลูกค้า</a></li>


					</ul>
				</div>

			</div>
			</nav>
		</div>
		<%
			}
		%>

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
														<strong>
															<h3>
																<span class="${loginErrorMsg.icon }"> </span>
																${loginErrorMsg.header }
															</h3>
														</strong>

														<p class="error-text">${loginErrorMsg.text }</p>
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
			</div>

			<!-- content -->
			<div class="col-md-9">