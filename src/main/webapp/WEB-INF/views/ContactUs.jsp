<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Register" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@page import="com.tana.entities.Account"%>
<%
	Account user = (Account) session.getAttribute("user");
%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row">
	<script>
		function validateContactUs(frm) {
			if (frm.title.value == "") {
				alert("กรุณากรอกหัวข้อเรื่อง");
				frm.title.focus();
				return false;
			}
			if (frm.text.value == "") {
				alert("กรุณากรอกข้อความ");
				frm.text.focus();
				return false;
			}
		}
	</script>
	<div class="form-sher">
		<form:form action="/contactUs" method="POST" modelAttribute="contact">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="nav-header">
							<b>ติดต่อเรา</b>
						</div>
						<br>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-2"></div>
							<div class="col-md-6">
								<div class="row">
									<div class="col-md-4 header-sher">
										<b>ชื่อ - นามสกุล</b>
									</div>
									<div class="col-md-8"><%=user.getFirstName()%>
										<%=user.getLastName()%></div>
								</div>
								<div class="row">
									<div class="col-md-4 header-sher">
										<b>อีเมล</b>
									</div>
									<div class="col-md-8"><%=user.getEmail()%></div>
								</div>
								<div class="row">
									<div class="col-md-4 header-sher">
										<b>เบอร์โทรศัพท์</b>
									</div>
									<div class="col-md-8"><%=user.getTelephoneNumber()%></div>
								</div>
								<div class="row">
									<div class="col-md-4 header-sher">
										<b>หัวข้อเรื่อง</b>
									</div>
									<div class="col-md-8">
										<form:input path="title" class="form-control"
											placeholder="หัวข้อเรื่อง" />
									</div>
								</div>
								<div class="row">
									<div class="col-md-4 header-sher">
										<b>ข้อความ</b>
									</div>
									<div class="col-md-8">
										<form:textarea path="text" class="form-control"
											placeholder="หัวข้อเรื่อง" />
									</div>
								</div>
							</div>

						</div>
					</div>


					<ul class="list-group">
						<li class="list-group-item"><input class="btn btn-success"
							onclick="return validateContactUs(contact)" type="submit"
							value="ส่ง" /></li>
					</ul>
				</div>
			</div>
		</form:form>
	</div>
</div>



<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="nav-header">
					<b>ข้อความตอบกลับ</b>
				</div>
				<br>
			</div>
			<div class="panel-body">
				<c:choose>
					<c:when test="${listMsg != null && fn:length(listMsg) gt 0}">
						<div class="panel-group" id="accordion" role="tablist"
							aria-multiselectable="true">
							<c:forEach items="${listMsg}" var="contactMsg">
								<c:choose>
									<c:when test="${contactMsg.replyMsg != null }">
										<div class="panel panel-success">
									</c:when>
									<c:otherwise>
										<div class="panel panel-warning">
									</c:otherwise>
								</c:choose>

								<div class="panel-heading" role="tab" id="heading${contactMsg.id }">
									<h4 class="panel-title">
										<a role="button" data-toggle="collapse"
											data-parent="#accordion" href="#collapse${contactMsg.id }"
											aria-expanded="false" aria-controls="collapse${contactMsg.id }">
											${contactMsg.datetime } - ${contactMsg.title } </a>
									</h4>
								</div>
								<div id="collapse${contactMsg.id }" class="panel-collapse collapse in"
									role="tabpanel" aria-labelledby="heading${contactMsg.id }" >
									<div class="panel-body">
										<div>${contactMsg.text }</div>
										<c:choose>
											<c:when test="${contactMsg.replyMsg != null }">
												<div class="jumbotron">
													<h3>ข้อความตอบกลับ !</h3>
													<p>${contactMsg.replyMsg.text }</p>
												</div>
											</c:when>
										</c:choose>

									</div>
								</div>
						</div>
						</c:forEach>
			</div>

			</c:when>
			<c:otherwise>
			ไม่มีข้อความ
		</c:otherwise>
			</c:choose>

		</div>
	</div>
</div>
</div>


<jsp:include page="../componant/footer.jsp" flush="true" />