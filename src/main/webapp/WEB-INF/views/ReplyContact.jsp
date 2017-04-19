<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="รายการติดต่อจากลูกค้า" />
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
<script>
	function validateContact(frm) {
		if (frm.text.value == "") {
			alert("กรุณากรอกข้อความ");
			frm.text.focus();
			return false;
		}
	}
</script>




<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<div class="nav-header">
					<b>รายการติดต่อจากลูกค้า</b>
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

								<div class="panel-heading" role="tab"
									id="heading${contactMsg.id }">
									<h4 class="panel-title">
										<a role="button" data-toggle="collapse"
											data-parent="#accordion" href="#collapse${contactMsg.id }"
											aria-expanded="false"
											aria-controls="collapse${contactMsg.id }">
											${contactMsg.datetime } - ${contactMsg.title } </a>
									</h4>
								</div>
								<div id="collapse${contactMsg.id }"
									class="panel-collapse collapse in" role="tabpanel"
									aria-labelledby="heading${contactMsg.id }">
									<div class="panel-body">
										<div>
											by <b>${contactMsg.msgOwner.firstName }
												${contactMsg.msgOwner.lastName }</b>
										</div>
										<div>${contactMsg.text }</div>
										<c:choose>
											<c:when test="${contactMsg.replyMsg != null }">
												<div class="jumbotron">
													<h3>ข้อความตอบกลับ !</h3>
													<p>${contactMsg.replyMsg.text }</p>
												</div>
											</c:when>
											<c:otherwise>
												<br />
												<a href="#" data-balloon="ตอบกลับ" data-toggle="modal"
													data-target="#reply_${contactMsg.id }"
													data-balloon-pos="down"><span
													class="glyphicon glyphicon-envelope"></span></a>
											</c:otherwise>
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
<c:forEach items="${listNonReplyMsg }" var="contact" varStatus="index">
	<div class="modal fade" id="reply_${contact.id }" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
		<form:form action="/replyContact" method="POST" modelAttribute="reply">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">ปิด</span>
						</button>
						<h4 class="modal-title">
							<b>ตอบกลับ</b>
							<form:hidden path="issueMsg.id" value="${contact.id }" />
						</h4>
					</div>
					<div class="modal-body">
						<div class="form-sher">
							<div class="row">
								<div class="col-md-4 header-sher">
									<form:label path="text">ข้อความ</form:label>
								</div>
								<div class="col-md-6">
									<form:textarea path="text" placeholder="ข้อความ"
										class="form-control" />
								</div>
							</div>

						</div>
					</div>
					<div class="modal-footer">
						<input type="submit" onclick="return validateContact(reply)"
							class="btn btn-success" value="ตอบกลับ" />
					</div>
				</div>
			</div>
		</form:form>
	</div>
</c:forEach>
<jsp:include page="../componant/footer.jsp" flush="true" />