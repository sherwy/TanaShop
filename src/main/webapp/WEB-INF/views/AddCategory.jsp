
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Add Category" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<b>Add Category</b>
<br>
<div class="form-group">
	<form:form action="/addCategory" method="POST"
		modelAttribute="category" enctype="multipart/form-data">
		<table class="table table-bordered">
			<tr>
				<td><form:label path="categoryName">ชื่อหมวดหมู่</form:label></td>
				<td><form:input path="categoryName" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="parentCategory">หมวดหมู่หลัก</form:label></td>
				<td><form:select path="parentCategory" class="form-control" >
						<form:option value="">-- ไม่มีหมวดหมู่หลัก --</form:option>
						<c:choose>
							<c:when test="${listCategory != null }">
								<c:forEach items="${listCategory }" var="category">
									<option value="${category.categoryId }">${category.categoryName }</option>
								</c:forEach>
							</c:when>
						</c:choose>
					</form:select></td>
			</tr>
			<tr>
				<td colspan="2"><input class="btn btn-success" type="submit"
					value="Add Category" /></td>
			</tr>
		</table>
	</form:form>
</div>
<jsp:include page="../componant/footer.jsp" flush="true" />