<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="จัดการหมวดหมู่สินค้า" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="nav-header">
	<b>หมวดหมู่สินค้า</b>
	<button type="button" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#addCategory">+
		เพิ่มหมวดหมู่สินค้า</button>
</div>
<br>

<script>
	function confirmation() {
		var isConfirm = confirm("คุณต้องการยืนยันลบหมวดหมู่ใช่ไหม ?");
		return isConfirm;
	}
	$(document).ready(
			function() {
				<c:forEach items="${listCategory}" var="category">
				$('#editCategory_${category.categoryId} #categoryDetail').val(
						'${category.categoryDetail}')
				<c:forEach items="${category.listChildCategory}" var="childCategory">
				$('#editCategory_${childCategory.categoryId} #categoryDetail')
						.val('${childCategory.categoryDetail}')

				</c:forEach>
				</c:forEach>
			});
	function validateCategory(frm) {
		if (frm.categoryName.value == "") {
			alert("กรุณากรอกชื่อหมวดหมู่");
			frm.categoryName.focus();
			return false;
		}
		if (frm.categoryDetail.value == "") {
			alert("กรุณากรอกรายละเอียดหมวดหมู่");
			frm.categoryDetail.focus();
			return false;
		}
	}
</script>

<div class="form-sher">
	<table class="table table-striped">
		<tr>
			<td>ลำดับ</td>
			<td>ชื่อหมวดหมู่</td>
			<td>จำนวนสินค้า</td>
			<td></td>
		</tr>
		<c:forEach items="${listCategory }" var="category" varStatus="index">
			<tr>
				<td>${index.index+1 }</td>
				<td><b>${category.categoryName }</b></td>
				<td>${fn:length(category.listProduct) }</td>
				<td><a href="#" data-balloon="แก้ไขหมวดหมู่สินค้านี้"
					data-toggle="modal" data-balloon-pos="down"
					data-target="#editCategory_${category.categoryId }"><span
						class="glyphicon glyphicon-wrench"></span></a> <a
					href="/deleteCategory/${category.categoryId }"
					data-balloon="ลบหมวดหมู่" data-balloon-pos="down" onclick="return confirmation()" class="fail"><span
						class="glyphicon glyphicon-trash"></span></a></td>
			</tr>
			<c:forEach items="${category.listChildCategory }" var="childCategory">
				<tr>
					<td></td>
					<td>${childCategory.categoryName }</td>
					<td>${fn:length(childCategory.listProduct) }</td>
					<td><a href="#" data-balloon="แก้ไขหมวดหมู่สินค้านี้"
						data-toggle="modal" data-balloon-pos="down"
						data-target="#editCategory_${childCategory.categoryId }"><span
							class="glyphicon glyphicon-wrench"></span></a> <a
						href="/deleteCategory/${childCategory.categoryId }"
						data-balloon="ลบหมวดหมู่"  onclick="return confirmation()"  data-balloon-pos="down" class="fail"><span
							class="glyphicon glyphicon-trash"></span></a></td>
				</tr>

			</c:forEach>
		</c:forEach>
	</table>
</div>



<c:forEach items="${listCategory }" var="category" varStatus="index">
	<div class="modal fade" id="editCategory_${category.categoryId }"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<form:form action="/editCategory" method="POST"
			modelAttribute="category">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">ปิด</span>
						</button>
						<h4 class="modal-title">
							<b>เพิ่มหมวดหมู่สินค้า</b>
							<form:hidden path="categoryId" />
						</h4>
					</div>
					<div class="modal-body">
						<div class="form-sher">
							<div class="row">
								<div class="col-md-4 header-sher">
									<form:label path="categoryName">ชื่อหมวดหมู่</form:label>
								</div>
								<div class="col-md-6">
									<form:input path="categoryName" class="form-control"
										placeholder="ชื่อหมวดหมู่" value="${ category.categoryName}" />
								</div>
							</div>

							<div class="row">
								<div class="col-md-4 header-sher">
									<form:label path="parentCategory">หมวดหมู่หลัก</form:label>
								</div>
								<div class="col-md-4">
									<form:select path="parentCategory" class="form-control">
										<form:option value="">-- ไม่มีหมวดหมู่หลัก --</form:option>
										<c:choose>
											<c:when test="${listCategory != null }">
												<c:forEach items="${listCategory }" var="categoryList">
													<option value="${categoryList.categoryId }">${categoryList.categoryName }</option>
												</c:forEach>
											</c:when>
										</c:choose>
									</form:select>
								</div>
							</div>

							<div class="row">
								<div class="col-md-4 header-sher">
									<form:label path="categoryDetail">รายละเอียดหมวดหมู่</form:label>
								</div>
								<div class="col-md-6">
									<form:textarea path="categoryDetail"
										placeholder="รายละเอียดหมวดหม" class="form-control"></form:textarea>
								</div>
							</div>
						</div>

					</div>
					<div class="modal-footer">
						<input type="submit" onclick="return validateCategory(category)"
							class="btn btn-success" value="บันทึก" />
					</div>
				</div>
			</div>
		</form:form>
	</div>

	<c:forEach items="${category.listChildCategory }" var="childCategory">
		<div class="modal fade" id="editCategory_${childCategory.categoryId }"
			tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<form:form action="/editCategory" method="POST"
				modelAttribute="category">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">ปิด</span>
							</button>
							<h4 class="modal-title">
								<b>แก้ไขหมวดหมู่สินค้า</b>
								<form:hidden path="categoryId" />
							</h4>
						</div>
						<div class="modal-body">
							<div class="form-sher">
								<div class="row">
									<div class="col-md-4 header-sher">
										<form:label path="categoryName">ชื่อหมวดหมู่</form:label>
									</div>
									<div class="col-md-6">
										<form:input path="categoryName" class="form-control"
											placeholder="ชื่อหมวดหมู่"
											value="${ childCategory.categoryName}" />
									</div>
								</div>

								<div class="row">
									<div class="col-md-4 header-sher">
										<form:label path="parentCategory">หมวดหมู่หลัก</form:label>
									</div>
									<div class="col-md-4">
										<form:select path="parentCategory" class="form-control">
											<form:option value="">-- ไม่มีหมวดหมู่หลัก --</form:option>
											<c:choose>
												<c:when test="${listCategory != null }">
													<c:forEach items="${listCategory }" var="categoryList">
														<c:choose>
															<c:when
																test="${categoryList.categoryId ==  childCategory.parentCategory.categoryId}">
																<option value="${categoryList.categoryId }" selected>${categoryList.categoryName }</option>
															</c:when>
															<c:otherwise>
																<option value="${categoryList.categoryId }">${categoryList.categoryName }</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</c:when>
											</c:choose>
										</form:select>
									</div>
								</div>

								<div class="row">
									<div class="col-md-4 header-sher">
										<form:label path="categoryDetail">รายละเอียดหมวดหมู่</form:label>
									</div>
									<div class="col-md-6">
										<form:textarea path="categoryDetail"
											placeholder="รายละเอียดหมวดหม" class="form-control"></form:textarea>
									</div>
								</div>
							</div>

						</div>
						<div class="modal-footer">
							<input type="submit" onclick="return validateCategory(category)"
								class="btn btn-success" value="บันทึก" />
						</div>
					</div>
				</div>
			</form:form>
		</div>
	</c:forEach>
</c:forEach>


<div class="modal fade" id="addCategory" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<form:form action="/addCategory" method="POST"
		modelAttribute="category">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">ปิด</span>
					</button>
					<h4 class="modal-title">
						<b>เพิ่มหมวดหมู่สินค้า</b>
					</h4>
				</div>
				<div class="modal-body">

					<div class="form-sher">
						<div class="row">
							<div class="col-md-4 header-sher">
								<form:label path="categoryName">ชื่อหมวดหมู่</form:label>
							</div>
							<div class="col-md-6">
								<form:input path="categoryName" class="form-control"
									placeholder="ชื่อหมวดหมู่" />
							</div>
						</div>

						<div class="row">
							<div class="col-md-4 header-sher">
								<form:label path="parentCategory">หมวดหมู่หลัก</form:label>
							</div>
							<div class="col-md-4">
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
							<div class="col-md-4 header-sher">
								<form:label path="categoryDetail">รายละเอียดหมวดหมู่</form:label>
							</div>
							<div class="col-md-6">
								<form:textarea path="categoryDetail"
									placeholder="รายละเอียดหมวดหม" class="form-control"></form:textarea>
							</div>
						</div>
					</div>

				</div>


				<div class="modal-footer">
					<input type="submit" onclick="return validateCategory(category)"
						class="btn btn-success" value="เพิ่มหมวดหมู่" />
				</div>
			</div>
		</div>
	</form:form>
</div>
<jsp:include page="../componant/footer.jsp" flush="true" />