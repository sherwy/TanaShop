
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Add Product" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<script language="JavaScript" type="text/javascript"
	src="/Tools/cbrte/html2xhtml.min.js"></script>
<script language="JavaScript" type="text/javascript"
	src="/Tools/cbrte/richtext.js"></script>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<b>เพิ่มสินค้า</b>
<br>
<div class="form-group">
	<script language="JavaScript">
		initRTE("/Tools/cbrte/images/", "/Tools/cbrte/", "", true);
		function validateAddProd(frm) {
			updateRTEs();
			if (frm.productName.value == "") {
				alert("กรุณากรอกชื่อสินค้า");
				frm.productName.focus();
				return false;
			}
			if (frm.productDetailText.value == "") {
				alert("กรุณากรอกรายละเอียดสินค้า");
				frm.productDetail.focus();
				return false;
			}

			if (frm.price.value == "") {
				alert("กรุณากรอกราคาสินค้า");
				frm.price.focus();
				return false;
			} else {
				var reg = /\d+(\.\d+)?/
				if (!reg.test(frm.price.value)) {
					alert("กรุณากรอกราคาสินค้าที่เป็นตัวเลขจำนวนเต็มหรือทศนิยมเท่านั้น");
					frm.price.focus();
					return false;
				}
			}

			if (frm.amount.value == "") {
				alert("กรุณากรอกจำนวนสินค้า");
				frm.amount.focus();
				return false;
			} else {
				var reg = /^(\d)+$/
				if (!reg.test(frm.amount.value)) {
					alert("กรุณากรอกจำนวนสินค้าที่เป็นตัวเลขเท่านั้น");
					frm.amount.focus();
					return false;
				}
			}

			if (frm.file.value == "") {
				alert("กรุณาเลือกรุปสินค้าอย่างน้อย 1 รูป");
				frm.amount.focus();
				return false;
			} else {
				for (var i = 0; i < $('input[name=file]').get(0).files.length; i++) {
					var fileName = $('input[name=file]').get(0).files[i].name;
					var reg = /^.+(\.jpg|\.JPG|\.jpeg|\.JPEG|\.png|\.PNG)$/
					if (!reg.test(fileName)) {
						alert("กรุณาเลือกรูปภาพที่มีนามสกุล .jpg , .jpeg หรือ .png เท่านั้น");
						return false;
					}
				}
			}

		}
	</script>

	<form:form action="/addProduct" method="POST" modelAttribute="product"
		enctype="multipart/form-data">
		<table class="table table-bordered">
			<tr>
				<td><form:label path="productName">ชื่อสินค้า</form:label></td>
				<td><form:input path="productName" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="productDetail">รายละเอียดสินค้า</form:label></td>
				<td>
					<noscript>
						<p>
							<b>Javascript must be enabled to use this form.</b>
						</p>
					</noscript> <script language="JavaScript" type="text/javascript">
						//build new richTextEditor
						var rte1 = new richTextEditor('productDetailText');
						rte1.html = '';

						//enable all commands for demo
						rte1.cmdFormatBlock = true;
						rte1.cmdFontName = true;
						rte1.cmdFontSize = true;
						rte1.cmdIncreaseFontSize = true;
						rte1.cmdDecreaseFontSize = true;

						rte1.cmdBold = true;
						rte1.cmdItalic = true;
						rte1.cmdUnderline = true;
						rte1.cmdStrikethrough = true;
						rte1.cmdSuperscript = true;
						rte1.cmdSubscript = true;

						rte1.cmdJustifyLeft = true;
						rte1.cmdJustifyCenter = true;
						rte1.cmdJustifyRight = true;
						rte1.cmdJustifyFull = true;

						rte1.cmdInsertHorizontalRule = true;
						rte1.cmdInsertOrderedList = true;
						rte1.cmdInsertUnorderedList = true;

						rte1.cmdOutdent = true;
						rte1.cmdIndent = true;
						rte1.cmdForeColor = true;
						rte1.cmdHiliteColor = true;
						rte1.cmdInsertLink = true;
						rte1.cmdInsertImage = true;
						rte1.cmdInsertSpecialChars = true;
						rte1.cmdInsertTable = true;
						rte1.cmdSpellcheck = true;

						rte1.cmdCut = true;
						rte1.cmdCopy = true;
						rte1.cmdPaste = true;
						rte1.cmdUndo = true;
						rte1.cmdRedo = true;
						rte1.cmdRemoveFormat = true;
						rte1.cmdUnlink = true;

						//rte1.toggleSrc = false;

						rte1.build();
					</script> <form:hidden path="productDetail" />
				</td>
			</tr>
			<tr>
				<td><form:label path="price">ราคาสินค้าต่อหน่วย</form:label></td>
				<td><form:input path="price" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="amount">จำนวนสินค้า</form:label></td>
				<td><form:input path="amount" class="form-control" /></td>
			</tr>
			<tr>
				<td><form:label path="imgUrl">รูปภาพสินค้า</form:label></td>
				<td><input name="file" type="file" class="form-control"
					multiple /> <form:hidden path="imgUrl" value="" /></td>
			</tr>
			<tr>
				<td><form:label path="category">หมวดหมู่สินค้า</form:label></td>
				<td><form:select path="category" class="form-control">
						<c:choose>
							<c:when test="${listCategory != null }">
								<c:forEach items="${listCategory }" var="category">
									<option value="${category.categoryId }">${category.categoryName }</option>
									<c:forEach items="${category.listChildCategory }"
										var="categoryChild">
										<option value="${categoryChild.categoryId }">&nbsp;
											-${categoryChild.categoryName }</option>
									</c:forEach>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<option value="null">ไม่มีหมวดหมู่</option>
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
									onclick="return validateAddProd(product)" value="Add Product" />
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