
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Add Category" />
</jsp:include>
<script type="text/javascript"
	src="/Tools/cbrte/html2xhtml.min.js"></script>
<script type="text/javascript"
	src="/Tools/cbrte/richtext.js"></script>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<b>เพิ่มหมวดหมู่สินค้า</b>
<br>
<div class="form-group">
	<form:form action="/addCategory" method="POST"
		modelAttribute="category" enctype="multipart/form-data">

		<div class="form-sher">
			<div class="row">
				<div class="col-md-2 header-sher">
					<form:label path="categoryName">ชื่อหมวดหมู่</form:label>
				</div>
				<div class="col-md-6">
					<form:input path="categoryName" class="form-control" />
				</div>
			</div>

			<div class="row">
				<div class="col-md-2 header-sher">
					<form:label path="parentCategory">หมวดหมู่หลัก</form:label>
				</div>
				<div class="col-md-3">
					<form:select path="parentCategory" class="form-control">
						<form:option value="">-- ไม่มีหมวดหมู่หลัก --</form:option>
						<c:choose>
							<c:when test="${listCategory != null }">
								<c:forEach items="${listCategory }" var="category">
									<option value="${category.categoryId }">${category.categoryName }</option>
								</c:forEach>
							</c:when>
						</c:choose>
					</form:select>
				</div>
			</div>

			<div class="row">
				<div class="col-md-2 header-sher">
					<label>รายละเอียดหมวดหมู่</label>
				</div>
				<div class="col-md-10">
					<script type="text/javascript">
						function submitForm() {
							updateRTEs();
						}

						initRTE("/Tools/cbrte/images/", "/Tools/cbrte/", "",
								true);
					</script>
					<noscript>
						<p>
							<b>Javascript must be enabled to use this form.</b>
						</p>
					</noscript>
					<script  type="text/javascript">
						var rte1 = new richTextEditor('categoryDetail');
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
					</script>
				</div>

				<div class="row">
					<div class="col-md-12">
						<input class="btn btn-success" type="submit" value="Add Category"
							onClick="submitForm()" />
					</div>
				</div>

			</div>
		</div>

	</form:form>
</div>
<jsp:include page="../componant/footer.jsp" flush="true" />