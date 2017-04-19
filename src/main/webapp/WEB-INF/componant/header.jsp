<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="TIS-620"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
<link href="/Tools/css/bootstrap.css" rel="stylesheet">
<link href="/Tools/css/main.css" rel="stylesheet">
<link rel="shortcut icon" href="../favicon.ico">
<link rel="stylesheet" type="text/css"
	href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css">

<link href='http://fonts.googleapis.com/css?family=PT+Sans+Narrow&v1'
	rel='stylesheet' type='text/css' />
<link href='http://fonts.googleapis.com/css?family=Pacifico'
	rel='stylesheet' type='text/css' />
<%@page import="com.google.gson.Gson"%>
<%
	String generalDetailJson = JsonReader.readUrl("http://localhost:8081/rest/generalDetailShop");
	String welcomeDetailJson = JsonReader.readUrl("http://localhost:8081/rest/welcomeDetail");
	Gson gson = new Gson();
	GeneralDetail general = gson.fromJson(generalDetailJson, GeneralDetail.class);
	WelcomeDetail welcome = gson.fromJson(welcomeDetailJson, WelcomeDetail.class);

	AlertMessage alert = (AlertMessage) session.getAttribute("alert");
	if (alert != null) {
		request.setAttribute("alert", alert);
		session.removeAttribute("alert");
	}
%>
<title><%=general.getShopName()%> :: ${param.title }</title>
<link rel="stylesheet" type="text/css" href="/Tools/css/style.css" />
<link rel="stylesheet" type="text/css" href="/Tools/css/elastislide.css" />
<script type="text/javascript" src="/Tools/js/jquery.tmpl.min.js"></script>
<script type="text/javascript" src="/Tools/js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="/Tools/js/jquery.elastislide.js"></script>
<script type="text/javascript" src="/Tools/js/gallery.js"></script>
<script type="text/javascript" src="/Tools/js/jquery.mousewheel.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.0.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-migrate-1.4.0.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("body").css("display", "none");
		$("body").fadeIn(500);
	});
</script>
<noscript>
	<style>
.es-carousel ul {
	display: block;
}
</style>
</noscript>
<script id="img-wrapper-tmpl" type="text/x-jquery-tmpl">	
			<div class="rg-image-wrapper">
				{{if itemsCount > 1}}
					<div class="rg-image-nav">
						<a href="#" class="rg-image-nav-prev">Previous Image</a>
						<a href="#" class="rg-image-nav-next">Next Image</a>
					</div>
				{{/if}}
				<div class="rg-image"></div>
				<div class="rg-loading"></div>
				<div class="rg-caption-wrapper">
					<div class="rg-caption" style="display:none;">
						<p></p>
					</div>
				</div>
			</div>
		</script>
</head>
<body>

	<script language="JavaScript">
		function validateLogin(frm) {
			if (frm.username.value == "") {
				alert("��سҡ�͡���ͼ����");
				return false;
			}

			if (frm.password.value == "") {
				alert("��سҡ�͡���ʼ�ҹ");
				return false;
			}
		}
	</script>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
	<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:if test="${requestScope.alert != null }">
		<c:set var="alert" value="${requestScope.alert }" />
	</c:if>
	<div class="container">
		<%@ page import="com.tana.entities.*"%>
		<%@ page import="com.tana.utilities.*"%>
		<%
			Account user = (Account) session.getAttribute("user");
			String isAdminView = (String) session.getAttribute(SessionUtility.isAdminView);
			System.out.print(isAdminView);
		%>

		<%
			if (user != null) {
				if ((UserRole.ADMIN.isRole(user))) {
		%>
		<div class="row adminView">
			<div class="content">
				<a href="/requestUserView" class="btn warning success" role="button">����ͧ�١���
					<span class="glyphicon glyphicon-record"></span>
				</a>
			</div>
		</div>
		<%
			} else if ("true".equals(isAdminView)) {
		%>
		<div class="row adminView">
			<div class="content">
				�س���ѧ���������ͧ�١��� <a href="/backToAdminRole"
					class="btn warning fail" role="button">�͡�ҡ����ͧ�١��� <span
					class="glyphicon glyphicon-remove-circle"></span></a>
			</div>
		</div>


		<%
			}
			}
		%>

		<!--  banner -->
		<div class="row headerbanner">
			<marquee><%=welcome.getWelcomeText()%></marquee>
		</div>

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
						<li class="menuNav"><a href="/index">˹���á</a></li>
						<li class="menuNav"><a href="/howTo">�Ըա����觫���</a></li>
						<li class="menuNav"><a href="/aboutUs">����ǡѺ���</a></li>

						<%
							} else if (user != null && user.getRole().equals(UserRole.USER.getRole())) {
						%>

						<li class="menuNav"><a href="/index">˹���á</a></li>
						<li class="menuNav"><a href="/howTo">�Ըա����觫���</a></li>
						<li class="menuNav"><a href="/myCart">�С����Թ���</a></li>
						<li class="menuNav"><a href="/confirmPayment">�駡�ê����Թ</a></li>
						<li class="menuNav"><a href="/aboutUs">����ǡѺ���</a></li>
						<li class="menuNav"><a href="/contactUs">�Դ������</a></li>

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
						<li class="menuNav-admin"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">�����ŷ���� <span class="caret"></span>
						</a>
							<ul class="menuNavBlock-inside dropdown-menu">
								<li class="menuNav-inside"><a href="/editGeneralDetail">����ǡѺ��ҹ</a></li>
								<li class="menuNav-inside"><a href="/welcomeDetail">��ͤ�����͹�Ѻ</a></li>
							</ul></li>
						<li class="menuNav-admin"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">�Ѵ����Թ��� <span class="caret"></span>
						</a>
							<ul class="menuNavBlock-inside dropdown-menu">
								<li class="menuNav-inside"><a href="/addProduct">�����Թ�������</a></li>
								<li class="menuNav-inside"><a href="/listAdminProduct">��¡���Թ���</a></li>
								<li class="menuNav-inside"><a href="/addCategory">������Ǵ����</a></li>
							</ul></li>
						<li class="menuNav-admin"><a href="/listAllOrder">��¡����觫���</a></li>
						<li class="menuNav-admin"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">����Թ <span class="caret"></span>
						</a>
							<ul class="menuNavBlock-inside dropdown-menu">
								<li class="menuNav-inside"><a href="/listPaymentOrder">��¡���駪����Թ</a></li>
								<li class="menuNav-inside"><a href="/addBank">�ѭ�ո�Ҥ��</a></li>
							</ul></li>
						<li class="menuNav-admin"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">�����Թ��� <span class="caret"></span>
						</a>
							<ul class="menuNavBlock-inside dropdown-menu">
								<li class="menuNav-inside"><a href="/listDeliveryOrder">��¡�èѴ���Թ���</a></li>
							</ul></li>
						<li class="menuNav-admin"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">�Ѵ����١��� <span class="caret"></span>
						</a>
							<ul class="menuNavBlock-inside dropdown-menu">
								<li class="menuNav-inside"><a href="/replyContact">��¡�õԴ��ͨҡ�١���</a></li>
								<li class="menuNav-inside"><a href="/listUser">��ª����١���</a></li>
							</ul></li>
						</li>


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
													<div class="alert alert-${loginErrorMsg.icon.status }">
														<button type="button" class="close" data-dismiss="alert"
															aria-label="Close">
															<span aria-hidden="true">�Դ</span>
														</button>
														<strong>
															<h3 class="center-content">
																<span class="${loginErrorMsg.icon.icon }"> </span>
																${loginErrorMsg.alertTitle }
															</h3>
														</strong>

														<p class="error-text">${loginErrorMsg.alertDetail }</p>
													</div>
												</c:when>
											</c:choose></td>
									</tr>
									<tr>
										<td><form:label path="username" for="username">���ͼ����</form:label>
											<form:input path="username" class="form-control" /></td>
									</tr>
									<tr>
										<td><form:label path="password" for="password">���ʼ�ҹ</form:label>
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
							role="button">�͡�ҡ�к�</a>
					</div>
					<%
						if (UserRole.USER.isRole(user)) {
					%>
					<div class="col-md-6">
						<a href="/editProfile" class="btn btn-success buttonFooter"
							role="button">��䢢�������ǹ���</a>
					</div>
					<%
						}
					%>
				</div>

				<%
					}
				%>

				<hr />
				<div class="row nav-category">
					<div class="row">
						<div class="col-md-12">
							<div class="nav-header">
								<b>�������Թ���</b>
							</div>
						</div>
					</div>
					<div class="row child-nav">
						<div class="col-md-12">
							<a href="/listProduct/new"> �Թ������� ( <c:choose>
									<c:when test="${listNewProd != null }">
										<c:out value="${fn:length(listNewProd)}" />
									</c:when>
									<c:otherwise>
							0
							</c:otherwise>
								</c:choose> )
							</a>
						</div>

					</div>
					<div class="row child-nav">
						<div class="col-md-12">
							<a href="/listProduct/recommended">�Թ����й� ( <c:choose>
									<c:when test="${listRecommendedProd != null }">
										<c:out value="${fn:length(listRecommendedProd)}" />
									</c:when>
									<c:otherwise>
							0
							</c:otherwise>
								</c:choose> )
							</a>
						</div>
					</div>
					<div class="row child-nav">
						<div class="col-md-12">
							<a href="/listProduct/all">�Թ��ҷ����� ( <c:choose>
									<c:when test="${listAllProd != null }">
										<c:out value="${fn:length(listAllProd)}" />
									</c:when>
									<c:otherwise>
							0
							</c:otherwise>
								</c:choose> )
							</a>
						</div>
					</div>
					<hr />

				</div>
				<div class="row nav-category">
					<div class="row">
						<div class="col-md-12">
							<div class="nav-header">
								<b>��Ǵ�����Թ���</b>
							</div>
						</div>
					</div>
					<c:choose>
						<c:when test="${listNavCategory != null }">
							<c:forEach items="${listNavCategory }" var="category">
								<div class="row child-nav">
									<div class="col-md-12">
										<a href="/listProductByCategory/${category.categoryId}">${category.categoryName }</a>

										<c:forEach items="${category.listChildCategory }"
											var="categoryChild">
											<a href="/listProductByCategory/${categoryChild.categoryId}"><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-${categoryChild.categoryName }</p></a>

										</c:forEach>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
								�������Ǵ����
						</c:otherwise>
					</c:choose>

					<hr />
				</div>
			</div>

			<!-- content -->
			<div class="col-md-9 content-body">

				<c:choose>
					<c:when test="${alert != null }">
						<div class="alert alert-${alert.icon.status }">

							<button type="button" class="close" data-dismiss="alert"
								aria-label="Close">
								<span aria-hidden="true">�Դ</span>
							</button>
							<strong>
								<h3 class="center-content">
									<span class="${alert.icon.icon }"> </span> ${alert.alertTitle }
								</h3>
							</strong>

							<p class="error-text">${alert.alertDetail }</p>
						</div>
					</c:when>
				</c:choose>