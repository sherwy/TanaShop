
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Add Product" />
</jsp:include>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<b>Add Product</b>
<br>
<form:form action="/addProduct" method="POST" modelAttribute="product"  enctype="multipart/form-data">
	<table>
		<tr>
			<td><form:label path="productName" >Product Name</form:label></td>
			<td><form:input path="productName" /></td>
		</tr>
		<tr>
			<td><form:label path="productDetail" >Product Detail</form:label></td>
			<td><form:textarea  path="productDetail" /></td>
		</tr>
		<tr>
			<td><form:label path="price" >Product Price</form:label></td>
			<td><form:input path="price" /></td>
		</tr>
		<tr>
			<td><form:label path="imgUrl" >Product Image</form:label></td>
			<td>
				<input name="file" type="file"/>
				<form:hidden path="imgUrl" value=""/>
			</td>
		</tr>

		<tr>
			<td colspan="2"><input class="btn btn-primary" type = "submit" value = "Submit"/></td>
		</tr>
	</table>
</form:form>

<jsp:include page="../componant/footer.jsp" flush="true" />