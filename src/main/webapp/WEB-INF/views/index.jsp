
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.tana.entities.*"%>
<%@ page import="com.tana.utilities.*"%>

<%@ page import="java.util.*"%>
<%@page import="com.google.gson.Gson"%>
<%
	String generalDetailJson = JsonReader.readUrl("http://localhost:8081/rest/generalDetailShop");
	Gson gson = new Gson();
	GeneralDetail general = gson.fromJson(generalDetailJson, GeneralDetail.class);
	Account user = (Account) session.getAttribute("user");
	if (user != null) {
		HashMap<String,String> prodInCart = JsonReader.getCart(user.getAccountId()+"");
		request.setAttribute("prodInCart",prodInCart);
	}

%>
<div class="row about-shop">
	<div class="panel panel-default">
		<div class="panel-body">
			<b class="header">เกี่ยวกับร้าน - <%=general.getShopName()%></b>
			<p><%=general.getShopDetail()%></p>
			<p><%=general.getShopDescription()%></p>
			<p><%=general.getShopTelephone()%>
		</div>
	</div>
</div>
<c:set var="prodInCart" value="${requestScope.prodInCart }"/>
<div class="row">
	<b style="font-size: 36px;">สินค้าใหม่</b> <a class="viewAll-sher"
		href="/listProduct/new"> <span class="glyphicon glyphicon-search"></span>
		ดูทั้งหมด
	</a>
	<div class="ca-container">
		<div class="ca-wrapper">
			<c:choose>
				<c:when test="${listNewProd != null }">
					<c:forEach items="${listNewProd }" var="newProd" varStatus="index">
						<c:if test="${fn:length(listNewProd) gt 2}">
							<div class="ca-item ca-item-${index.index }">
						</c:if>

						<div class="card">
							<div class="card-icon">ใหม่</div>
							<div class="img-card"
								<c:set var="newProdUrl" value="${fn:split(newProd.imgUrl, ',')}" />
								<c:if test="${fn:length(newProdUrl) gt 0}">
								
							style=" background-image : url('/Images/Products/${newProd.getProductId() }/${newProdUrl[0] }')";
									</c:if>>
								<div class="card-viewDetail">
									<a href="#popup_${newProd.productId }" class="button-sher"><span
										class="glyphicon glyphicon-search"></span></a>
								</div>
							</div>
							<div class="card-price">
								<b>${newProd.price} ฿</b>
							</div>
							<c:set var="prodId" value="${newProd.productId}" scope="request" />

							<%
								if (user != null && UserRole.USER.isRole(user)) {
							%>
							<c:choose>
								<c:when test="${prodInCart.containsKey(newProd.productId += '')}">
									<div class="add-to-cart">
										<a href="#" data-balloon="สินค้าอยู๋ในตะกร้าแล้ว"
											data-balloon-pos="right"><span
											class="glyphicon glyphicon-ok success"></span></a>
									</div>
								</c:when>
								<c:otherwise>
									<div class="add-to-cart">
										<a href="/addToCart/${newProd.productId}"
											data-balloon="เพิ่มลงตะกร้า" data-balloon-pos="right"><span
											class="glyphicon glyphicon-plus fail"></span></a>
									</div>
								</c:otherwise>
							</c:choose>
							<%
								}
							%>
							
							<div class="card-content">
								<div class="card-title">
									<h4>
										<b>${newProd.productName }</b>
									</h4>

								</div>
								<div class="card-detail">
									<div class="row">
										<div class="col-md-6" style="text-align: right">
											<b>จำนวนสินค้าคงเหลือ</b>
										</div>
										<div class="col-md-6">${newProd.amount }</div>
									</div>
									<div class="row">
										<div class="col-md-6" style="text-align: right">
											<b>ประเภทสินค้า</b>
										</div>
										<div class="col-md-6">${newProd.category.categoryName }</div>
									</div>

								</div>
							</div>
							
						</div>

						<c:if test="${fn:length(listNewProd) gt 2}">
		</div>
		</c:if>
		</c:forEach>
		</c:when>
		</c:choose>
	</div>
</div>
<hr />
</div>
<div class="row">
	<b style="font-size: 36px;">สินค้าแนะนำ</b> <a class="viewAll-sher"
		href="/listProduct/recommended"> <span
		class="glyphicon glyphicon-search"></span> ดูทั้งหมด
	</a>
	<div class="ca-container">
		<div class="ca-wrapper">
			<c:choose>
				<c:when test="${listRecommendedProd != null }">
					<c:forEach items="${listRecommendedProd }" var="recProd"
						varStatus="index">
						<c:if test="${fn:length(listRecommendedProd) gt 2}">
							<div class="ca-item ca-item-${index.index }">
						</c:if>
						<div class="card">
							<div class="card-icon">แนะนำ</div>
							<div class="img-card"
								<c:set var="recProdUrl" value="${fn:split(recProd.imgUrl, ',')}" />
								<c:if test="${fn:length(recProdUrl) gt 0}">
								
							style=" background-image : url('/Images/Products/${recProd.getProductId() }/${recProdUrl[0] }')";
									</c:if>>
								<div class="card-viewDetail">
									<a href="#popup_${recProd.productId }" class="button-sher"><span
										class="glyphicon glyphicon-search"></span></a>
								</div>
							</div>
							<div class="card-price">
								<b>${recProd.price} ฿</b>
							</div>
							<%
								if (user != null && UserRole.USER.isRole(user)) {
							%>
							<c:choose>
								<c:when test="${prodInCart.containsKey(recProd.productId += '')}">
									<div class="add-to-cart">
										<a href="#" data-balloon="สินค้าอยู๋ในตะกร้าแล้ว"
											data-balloon-pos="right"><span
											class="glyphicon glyphicon-ok success"></span></a>
									</div>
								</c:when>
								<c:otherwise>
									<div class="add-to-cart">
										<a href="/addToCart/${recProd.productId}"
											data-balloon="เพิ่มลงตะกร้า" data-balloon-pos="right"><span
											class="glyphicon glyphicon-plus fail"></span></a>
									</div>
								</c:otherwise>
							</c:choose>
							<%
								}
							%>
							<div class="card-content">
								<div class="card-title">
									<h4>
										<b>${recProd.productName }</b>
									</h4>

								</div>
								<div class="card-detail">
									<div class="row">
										<div class="col-md-6" style="text-align: right">
											<b>จำนวนสินค้าคงเหลือ</b>
										</div>
										<div class="col-md-6">${recProd.amount }</div>
									</div>
									<div class="row">
										<div class="col-md-6" style="text-align: right">
											<b>ประเภทสินค้า</b>
										</div>
										<div class="col-md-6">${recProd.category.categoryName }</div>
									</div>

								</div>
							</div>

						</div>
						<c:if test="${fn:length(listRecommendedProd) gt 2}">
		</div>
		</c:if>
		</c:forEach>

		</c:when>
		</c:choose>
	</div>
</div>
</div>
<hr />
<div class="row">
	<b style="font-size: 36px;">สินค้าทั้งหมด</b> <a class="viewAll-sher"
		href="/listProduct/all"> <span class="glyphicon glyphicon-search"></span>
		ดูทั้งหมด
	</a>
	<div class="ca-container">
		<div class="ca-wrapper">
			<c:choose>
				<c:when test="${listAllProd != null }">
					<c:forEach items="${listAllProd }" var="prod" varStatus="index">
						<c:if test="${fn:length(listAllProd) gt 2}">
							<div class="ca-item ca-item-${index.index }">
						</c:if>
						<div class="card">

							<div class="img-card"
								<c:set var="prodUrl" value="${fn:split(prod.imgUrl, ',')}" />
								<c:if test="${fn:length(prodUrl) gt 0}">
								
							style=" background-image : url('/Images/Products/${prod.getProductId() }/${prodUrl[0] }')";
									</c:if>>
								<div class="card-viewDetail">
									<a href="#popup_${prod.productId }" class="button-sher"><span
										class="glyphicon glyphicon-search"></span></a>
								</div>
							</div>
							<div class="card-price">
								<b>${prod.price} ฿</b>
							</div>
							<%
								if (user != null && UserRole.USER.isRole(user)) {
							%>

							<c:choose>
								<c:when test="${prodInCart.containsKey(prod.productId += '')}">
									<div class="add-to-cart">
										<a href="#" data-balloon="สินค้าอยู๋ในตะกร้าแล้ว"
											data-balloon-pos="right"><span
											class="glyphicon glyphicon-ok success"></span></a>
									</div>
								</c:when>
								<c:otherwise>
									<div class="add-to-cart">
										<a href="/addToCart/${prod.productId}"
											data-balloon="เพิ่มลงตะกร้า" data-balloon-pos="right"><span
											class="glyphicon glyphicon-plus fail"></span></a>
									</div>
								</c:otherwise>
							</c:choose>

							<%
								}
							%>
							<div class="card-content">
								<div class="card-title">
									<h4>
										<b>${prod.productName }</b>
									</h4>

								</div>
								<div class="card-detail">
									<div class="row">
										<div class="col-md-6" style="text-align: right">
											<b>จำนวนสินค้าคงเหลือ</b>
										</div>
										<div class="col-md-6">${prod.amount }</div>
									</div>
									<div class="row">
										<div class="col-md-6" style="text-align: right">
											<b>ประเภทสินค้า</b>
										</div>
										<div class="col-md-6">${prod.category.categoryName }</div>
									</div>

								</div>
							</div>

						</div>
						<c:if test="${fn:length(listAllProd) gt 2}">
		</div>
		</c:if>
		</c:forEach>

		</c:when>
		</c:choose>
	</div>
</div>
</div>

<c:forEach items="${listAllProd }" var="prod">
	<div id="popup_${prod.productId }" class="overlay">
		<div class="popup">
			<h2>${prod.productName }</h2>
			<a class="close" href="#">ปิด</a>
			<div class="row">
				<div class="col-md-8">

					<div class="gallery cf">
						<c:set var="prodUrl" value="${fn:split(prod.imgUrl, ',')}" />
						<c:forEach items="${prodUrl }" var="url" varStatus="index">
							<div>
								<img src="/Images/Products/${prod.getProductId() }/${url}" />
							</div>
						</c:forEach>

					</div>
				</div>

				<div class="col-md-4">
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
							<b>รายละเอียดสินค้า</b>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">${prod.productDetail }</div>

					</div>


				</div>
			</div>

		</div>
	</div>
	<script type="text/javascript">
		$('#carousel_${prod_productId }').elastislide();
	</script>

</c:forEach>



<script type="text/javascript" src="/Tools/js/jquery.mousewheel.js"></script>
<script type="text/javascript" src="/Tools/js/jquery.contentcarousel.js"></script>
<script type="text/javascript" src="/Tools/js/jquery.easing.1.3.js"></script>
<script type="text/javascript">
	$('.ca-container').contentcarousel();
</script>

<jsp:include page="../componant/footer.jsp" flush="true" />