
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Add Product" />
</jsp:include>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<b>Add Product</b>
<br>
<div class="form-group">
	<form:form action="/addProduct" method="POST" modelAttribute="product"
		enctype="multipart/form-data">
		<table class="table table-bordered">
			<tr>
				<td><form:label path="productName">Product Name</form:label></td>
				<td><form:input path="productName"  class="form-control"/></td>
			</tr>
			<tr>
				<td><form:label path="productDetail">Product Detail</form:label></td>
				<td><form:textarea path="productDetail"  class="form-control"/></td>
			</tr>
			<tr>
				<td><form:label path="price">Product Price</form:label></td>
				<td><form:input path="price"  class="form-control"/></td>
			</tr>
			<tr>
				<td><form:label path="imgUrl">Product Image</form:label></td>
				<td><input name="file" type="file" class="form-control"/> <form:hidden
						path="imgUrl" value="" /></td>
			</tr>

			<tr>
				<td colspan="2">
					<div class="row">
						<div class="col-md-4"></div>
						<div class="col-md-4">
							<p class="text-center">
								<input class="btn btn-success" type="submit" value="Add Product" />
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