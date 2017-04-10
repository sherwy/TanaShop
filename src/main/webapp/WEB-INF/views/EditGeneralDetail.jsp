
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Edit General Detail" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<div class="form-group">
	<form:form action="/editGeneralDetail" method="POST"
		modelAttribute="generalDetail">
		<table class="table table-bordered">
			<tr>
				<td><form:label path="shopName">ชื่อร้าน</form:label></td>
				<td><form:input path="shopName" class="form-control" value="${detail.shopName }" /></td>
			</tr>
			<tr>
				<td><form:label path="shopDescription">รายละเอียดร้านค้า</form:label></td>
				<td><form:textarea path="shopDescription" class="form-control" value="${detail.shopDescription}"/></td>
			</tr>
			<tr>
				<td><form:label path="shopDetail">ข้อมูลร้านค้า</form:label></td>
				<td><form:textarea path="shopDetail" class="form-control" value="${detail.shopDetail}"/></td>
			</tr>
			<tr>
				<td><form:label path="shopTelephone">เบอร์โทรศัพท์</form:label></td>
				<td><form:input path="shopTelephone" class="form-control"  value="${detail.shopTelephone}"/></td>
			</tr>
			<tr>
				<td><form:label path="email">อีเมล</form:label></td>
				<td><form:input path="email" class="form-control" value="${detail.email}"/></td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="row">
						<div class="col-md-4"></div>
						<div class="col-md-4">
							<p class="text-center">
								<input class="btn btn-primary"
									onclick="#" type="submit"
									value="บันทึก" />
							</p>
						</div>
						<div class="col-md-4"></div>
					</div>
				</td>
			</tr>
		</table>
	</form:form>
</div>

<jsp:include page="../componant/footer.jsp" flush="true" />