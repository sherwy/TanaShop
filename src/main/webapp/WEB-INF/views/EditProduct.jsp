
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Add Product" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<b>แก้ไขสินค้า</b>
<br>
<div class="form-group">
	<form:form action="/editProduct" method="POST" modelAttribute="product"
		enctype="multipart/form-data">
		<table class="table table-bordered">

			<tr>
				<td><form:label path="productName">ชื่อสินค้า</form:label></td>
				<td><form:hidden path="productId" value="${product.productId }" />
					<form:input path="productName" class="form-control"
						value="${product.productName }" /></td>
			</tr>
			<tr>
				<td><form:label path="productDetail">รายละเอียดสินค้า</form:label></td>
				<td><form:textarea path="productDetail" class="form-control"
						value="${product.productDetail }" /></td>
			</tr>
			<tr>
				<td><form:label path="price">ราคาสินค้าต่อหน่วย</form:label></td>
				<td><form:input path="price" class="form-control"
						value="${product.price }" /></td>
			</tr>
			<tr>
				<td><form:label path="imgUrl">รูปภาพสินค้า</form:label></td>
				<td><input name="file" type="file" class="form-control"
					value="/Images/Products/${product.imgUrl}" multiple/> <form:hidden
						path="imgUrl" value="" /></td>
			</tr>

			<tr>
				<td><form:label path="category">หมวดหมู่สินค้า</form:label></td>
				<td><form:select path="category" class="form-control">
						<c:choose>
							<c:when test="${listCategory != null }">
								<c:forEach items="${listCategory }" var="categoryQuery">

									<option value="${categoryQuery.categoryId }"
										<c:choose> <c:when test="${category.categoryId == categoryQuery.categoryId}"> selected</c:when></c:choose>>${categoryQuery.categoryName }</option>

									<c:forEach items="${categoryQuery.listChildCategory }"
										var="categoryQueryChild">
										<option value="${categoryQueryChild.categoryId }"
											<c:choose> <c:when test="${category.categoryId == categoryQuery.categoryId}"> selected</c:when></c:choose>>&nbsp;
											-${categoryQueryChild.categoryName }</option>
									</c:forEach>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<option value="null">No category</option>
							</c:otherwise>
						</c:choose>

					</form:select></td>
			</tr>


			<tr>
				<td colspan="2">
					<div class="row">
						<div class="col-md-4"></div>
						<div class="col-md-4">
							<p class="text-center">
								<input class="btn btn-success" type="submit"
									value="Edit Product" />
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