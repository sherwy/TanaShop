
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>

<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page import="com.tana.entities.*"%>
<%@ page import="com.tana.utilities.*"%>
<%
	Account user = (Account) session.getAttribute("user");
%>
<div class="nav-header">
	<c:choose>
		<c:when test="${titleHeader !=null }">
			<b>รายการสินค้า  -  ${titleHeader }</b>
		</c:when>
		<c:otherwise>
			<b>รายการสินค้า</b>
		</c:otherwise>
	</c:choose>
</div>
<c:choose>
	<c:when test="${listProd != null}">
		<c:forEach items="${listProd }" var="prod">
			<div class="listProd-container">
				<div class="row">
					<div class="col-md-4">

						<c:set var="prodUrl" value="${fn:split(prod.imgUrl, ',')}" />
						<c:choose>
							<c:when test="${fn:length(prodUrl) gt 0}">
								<img
									src="/Images/Products/${prod.getProductId() }/${prodUrl[0] }"
									style="height: 200px" align="middle" />
							</c:when>
							<c:otherwise>
								ไม่มีรูป
							</c:otherwise>
						</c:choose>
					</div>
					<div class="col-md-8">
						<div class="row">
							<div class="col-md-6">
								<b>ชื่อสินค้า</b>
							</div>
							<div class="col-md-6">${prod.productName }</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<b>จำนวนสินค้าคงเหลือ</b>
							</div>
							<div class="col-md-6">${prod.amount }</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<b>ราคาต่อหน่วย</b>
							</div>
							<div class="col-md-6">${prod.price }</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<b>ประเภทสินค้า</b>
							</div>
							<div class="col-md-6">${prod.category.categoryName }</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<b>รายละเอียดสินค้า </b>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">${prod.productDetail }</div>

						</div>
						<%
							if (user != null && UserRole.USER.isRole(user)) {
						%>
						<div class="row">
							<div class="col-md-12">
								<c:choose>
									<c:when test="${prodInCart.containsKey(prod.productId)}">
										<div class="add-to-cart-list ">
											<a href="#" data-balloon="สินค้าอยู๋ในตะกร้าแล้ว"
												data-balloon-pos="down"><span
												class="glyphicon glyphicon-ok success"></span></a>
										</div>
									</c:when>
									<c:otherwise>
										<div class="add-to-cart-list fail">
											<a href="/addToCart/${prod.productId}"
												data-balloon="เพิ่มลงตะกร้า" data-balloon-pos="down"><span
												class="glyphicon glyphicon-plus"></span></a>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<%
							}
						%>
					</div>
				</div>
			</div>
			<hr />
		</c:forEach>
	</c:when>

	<c:otherwise>
	No product.
</c:otherwise>
</c:choose>


<jsp:include page="../componant/footer.jsp" flush="true" />