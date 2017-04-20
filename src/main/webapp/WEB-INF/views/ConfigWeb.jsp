
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Edit General Detail" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="nav-header">
	<b>ปรับแต่งร้าน</b>
</div>
<br>
<div class="form-group">

	<form:form action="/configWeb" method="POST"
		modelAttribute="configWeb"  enctype="multipart/form-data">
		<div class="form-sher">
			
				
					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="footerColor">สีของส่วนล่าง</form:label>
						</div>
						<div class="col-md-6">
							<form:input path="footerColor" type="color" class="form-control" />
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="bannerImg">รูปภาพแบนเนอร์</form:label>
						</div>
						<div class="col-md-3">
							<input name="fileBN" id="file" type="file" class="form-control"
								value="" />
							<form:hidden path="bannerImg"  />
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 header-sher">
							<form:label path="bgImg">รูปภาพพื้นหลัง</form:label>
						</div>
						<div class="col-md-3">
							<input name="fileBG" id="file" type="file" class="form-control"
								value="" />
							<form:hidden path="bgImg"  />
						</div>
					</div>
					
				


			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<p class="text-center">
						<input class="btn btn-primary" type="submit"
							value="บันทึก" />
					</p>
				</div>
				<div class="col-md-4"></div>
			</div>
		</div>
	</form:form>
</div>

<jsp:include page="../componant/footer.jsp" flush="true" />
