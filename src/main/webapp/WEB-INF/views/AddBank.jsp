<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Register" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="nav-header">
	<b>บัญชีธนาคาร</b>
	<button type="button" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#addBankAccount">+ เพิ่มบัญชีธนาคาร
	</button>
</div>
<br>
<script>
	function validateAddBank(frm) {
		if (frm.bankAccountName.value == "") {
			alert("กรุณากรอกชื่อบัญชี");
			frm.bankAccountName.focus();
			return false;
		}
		if (frm.branch.value == "") {
			alert("กรุณากรอกสาขา");
			frm.branch.focus();
			return false;
		}
		if (frm.bankAccountNumber.value == "") {
			alert("กรุณากรอกเลขบัญชี");
			frm.bankAccountNumber.focus();
			return false;
		} else {
			var reg = /^[0-9]+$/
			if (!reg.test(frm.bankAccountNumber.value)) {
				alert("กรุณากรอกเลขบัญชีทีเป็นตัวเลข");
				frm.bankAccountNumber.focus();
				return false;
			}
		}

	}
</script>

<div class="form-sher">
	<table class="table table-striped">
		<tr>
			<td>ลำดับ</td>
			<td>ธนาคาร</td>
			<td>เลขบัญชี</td>
			<td>สาขา</td>
			<td>ชื่อบัญชี</td>
			<td>ประเภท</td>
			<td></td>
		</tr>
		<c:forEach items="${listAllBank }" var="bank" varStatus="index">
			<tr>
				<td>${index.index+1 }</td>
				<td>${bank.bankName }</td>
				<td>${bank.bankAccountNumber }</td>
				<td>${bank.branch }</td>
				<td>${bank.bankAccountName }</td>
				<td>${bank.bankAccountType }</td>
				<td><a href="#popup_${bank.id }" data-balloon="แก้ไขบัญชีธนาคารนี้" data-toggle="modal"
						data-balloon-pos="down" data-target="#editBank_${bank.id }"><span class="glyphicon glyphicon-wrench"></span></a></td>
				
			</tr>
		</c:forEach>
	</table>
</div>

<c:forEach items="${listAllBank }" var="bank" varStatus="index">
	<div class="modal fade" id="editBank_${bank.id }" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<form:form action="/editBank" method="POST" modelAttribute="bankAccount">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">ปิด</span>
					</button>
					<h4 class="modal-title">
						<form:hidden path="id" value="${bank.id }"/>
						<b>แก้ไขบัญชีธนาคาร (${bank.bankAccountNumber })</b>
					</h4>
				</div>
				<div class="modal-body">

					<div class="form-sher">
						<div class="row">
							<div class="col-md-4 header-sher">
								<form:label path="bankName">เลือกธนาคาร</form:label>
							</div>
							<div class="col-md-4">
								<form:select path="bankName" class="form-control">
									<c:forEach items="${listBank }" var="bankName">
										<c:choose>
											<c:when test="${bank.bankName == bankName.bankName }">
												<option value="${bank.bankName }" selected>${bank.bankName }</option>
											</c:when>
											<c:otherwise>
												<option value="${bank.bankName }">${bank.bankName }</option>
											</c:otherwise>
										</c:choose>
										
									</c:forEach>
								</form:select>
							</div>
						</div>

						<div class="row">
							<div class="col-md-4 header-sher">
								<form:label path="bankAccountName" >ชื่อบัญชี</form:label>
							</div>
							<div class="col-md-4">
								<form:input path="bankAccountName" value="${bank.bankAccountName }" placeholder="ชื่อบัญชี" class="form-control" />
							</div>
						</div>

						<div class="row">
							<div class="col-md-4 header-sher">
								<form:label path="bankAccountNumber" >เลขบัญชี</form:label>
							</div>
							<div class="col-md-4">
								<form:input path="bankAccountNumber" value="${bank.bankAccountNumber }" class="form-control" placeholder="เลขบัญชี"/>
							</div>
						</div>
						
						<div class="row">
							<div class="col-md-4 header-sher">
								<form:label path="branch" >สาขา</form:label>
							</div>
							<div class="col-md-4">
								<form:input path="branch" value="${bank.branch }" class="form-control" placeholder="สาขา"/>
							</div>
						</div>

						<div class="row">
							<div class="col-md-4 header-sher">
								<form:label path="bankAccountType">ประเภท</form:label>
							</div>
							<div class="col-md-4">
								<form:select path="bankAccountType" class="form-control">
									<c:forEach items="${listBankType }" var="bankType">
										<c:choose>
											<c:when test="${bank.bankAccountType == bankType.bankType }">
												<option value="${bankType.bankType }" selected>${bankType.bankType }</option>
											</c:when>
											
											<c:otherwise>
												<option value="${bankType.bankType }">${bankType.bankType }</option>
											</c:otherwise>
										</c:choose>
										
									</c:forEach>
								</form:select>
							</div>
						</div>
					</div>

				</div>
				<div class="modal-footer">
					<input type="submit" onclick="return validateAddBank(bankAccount)"
						class="btn btn-success" value="บันทึก" />
				</div>
			</div>
		</div>
	</form:form>
</div>
</c:forEach>

<div class="modal fade" id="addBankAccount" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<form:form action="/addBank" method="POST" modelAttribute="bankAccount">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">ปิด</span>
					</button>
					<h4 class="modal-title">
						<b>เพิ่มบัญชี</b>
					</h4>
				</div>
				<div class="modal-body">

					<div class="form-sher">
						<div class="row">
							<div class="col-md-4 header-sher">
								<form:label path="bankName">เลือกธนาคาร</form:label>
							</div>
							<div class="col-md-4">
								<form:select path="bankName" class="form-control">
									<c:forEach items="${listBank }" var="bank">
										<option value="${bank.bankName }">${bank.bankName }</option>
									</c:forEach>
								</form:select>
							</div>
						</div>

						<div class="row">
							<div class="col-md-4 header-sher">
								<form:label path="bankAccountName" >ชื่อบัญชี</form:label>
							</div>
							<div class="col-md-4">
								<form:input path="bankAccountName" placeholder="ชื่อบัญชี" class="form-control" />
							</div>
						</div>

						<div class="row">
							<div class="col-md-4 header-sher">
								<form:label path="bankAccountNumber" >เลขบัญชี</form:label>
							</div>
							<div class="col-md-4">
								<form:input path="bankAccountNumber" class="form-control" placeholder="เลขบัญชี"/>
							</div>
						</div>
						
						<div class="row">
							<div class="col-md-4 header-sher">
								<form:label path="branch" >สาขา</form:label>
							</div>
							<div class="col-md-4">
								<form:input path="branch" class="form-control" placeholder="สาขา"/>
							</div>
						</div>

						<div class="row">
							<div class="col-md-4 header-sher">
								<form:label path="bankAccountType">ประเภท</form:label>
							</div>
							<div class="col-md-4">
								<form:select path="bankAccountType" class="form-control">
									<c:forEach items="${listBankType }" var="bankType">
										<option value="${bankType.bankType }">${bankType.bankType }</option>
									</c:forEach>
								</form:select>
							</div>
						</div>
					</div>

				</div>
				<div class="modal-footer">
					<input type="submit" onclick="return validateAddBank(bankAccount)"
						class="btn btn-success" value="เพิ่มบัญชีธนาคาร" />
				</div>
			</div>
		</div>
	</form:form>
</div>
<jsp:include page="../componant/footer.jsp" flush="true" />