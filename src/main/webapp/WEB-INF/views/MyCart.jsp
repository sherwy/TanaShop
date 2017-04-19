
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="nav-header">
	<b>ตะกร้าสินค้า</b>
</div>
<br />
<script>
	function validateCart(frm){
		if(frm.otherAmount.value == ""){
			alert("กรุณาเลือกชนิดการจัดส่ง");
			return false;
		}
		var reg = /^[0-9]+$/;
		<c:forEach items="${order.listProduct}" var="orderLine" varStatus="status">
		var itemsAmount${status.index} = document.getElementById("listProduct${status.index}.amount").value;
			if(itemsAmount${status.index} > ${orderLine.pk.product.amount}){
				alert("จำนวนสินค้า (${orderLine.pk.product.productName}) ที่คุณเลือกได้เกินจำนวนกับของในคลัง (${orderLine.pk.product.amount} ชิ้น) กรุณาเลือกใหม่");
				document.getElementById("listProduct${status.index}.amount").value = '0';
				return false;
			}else if(itemsAmount${status.index} <= 0){
				alert("จำนวนสินค้า (${orderLine.pk.product.productName}) ที่คุณเลือก ต้องมีจำนวนต้งแต่ 1 ชิ้นขึ้นไป");
				document.getElementById("listProduct${status.index}.amount").value = '0';
				return false;
			}else if(!reg.test($('#listProduct${status.index}\\.amount').val())){
				alert("จำนวนสินค้าต้องเป็นตัวเลขเท่านั้น");
				document.getElementById("listProduct${status.index}.amount").value = '0';
				return false;
			}
		</c:forEach>
	}
</script>
<c:choose>
	<c:when test="${order!=null}">

		<form:form action="/confirmCart" method="POST"
			modelAttribute="orderList">


			<table class="table table-striped">
				<tr>
					<td>รหัสสินค้า</td>
					<td>รูปภาพ</td>
					<td>ชื่อสินค้า</td>
					<td>ราคาต่อหน่วย</td>
					<td>รายละเอียด</td>
					<td>จำนวน</td>
					<td></td>
				</tr>
				<form:hidden path="orderId" value="${order.orderId }" />
				<c:forEach items="${order.listProduct}" var="orderLine"
					varStatus="status">

					<tr>
						<td><form:label
								path="listProduct[${status.index }].pk.product.productId">${orderLine.pk.product.productId }</form:label>
							<form:hidden
								path="listProduct[${status.index }].pk.product.productId"
								value="${orderLine.pk.product.productId }" /></td>
						<td><form:label
								path="listProduct[${status.index }].pk.product.imgUrl"
								value="${orderLine.pk.product.imgUrl}">

								<c:set var="prodImgUrl"
									value="${fn:split(orderLine.pk.product.imgUrl, ',')}" />
								<c:if test="${fn:length(prodImgUrl) gt 0}">

									<a href="#popup_${ orderLine.pk.product.productId}"><img
										src="/Images/Products/${orderLine.pk.product.productId }/${prodImgUrl[0] }"
										width="200px" class="zoomImg" /></a>
								</c:if>
								<form:hidden
									path="listProduct[${status.index }].pk.product.imgUrl"
									value="${orderLine.pk.product.imgUrl}" />
							</form:label></td>
						<td><form:label
								path="listProduct[${status.index }].pk.product.productName">${orderLine.pk.product.productName}</form:label>
							<form:hidden
								path="listProduct[${status.index }].pk.product.productName"
								value="${orderLine.pk.product.productName}" /></td>
						<td><form:label
								path="listProduct[${status.index }].pk.product.price">${orderLine.pk.product.price}</form:label>
							<form:hidden
								path="listProduct[${status.index }].pk.product.productName"
								value="${orderLine.pk.product.productName}" /></td>
						<td><form:label
								path="listProduct[${status.index }].pk.product.productDetail">${orderLine.pk.product.productDetail}</form:label>
							<form:hidden
								path="listProduct[${status.index }].pk.product.productDetail"
								value="${orderLine.pk.product.productDetail}" /></td>
						<td><form:input type="number"
								path="listProduct[${status.index }].amount" min="1"
								max="${ orderLine.pk.product.amount}" value="1"
								class="form-control" /></td>
						<td><a
							href="<c:url value='/RemoveOutOfCart/${orderLine.pk.product.productId}' />"
							class="btn btn-danger" role="button">Delete</a></td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="2">สรุปรายการสินค้า</td>
					<td>${fn:length(order.listProduct)}รายการ</td>
					<td><div id="itemsAmount">0 ชิ้น</div></td>
					<td colspan="2"><div id="priceAmount">ราคาทั้งหมด 0 บาท</div></td>
				</tr>

			</table>

			<div class="nav-header">
				<b>เลือกวิธีจัดส่งสินค้า</b>
			</div>
			<table class="table table-striped">
				<tr>
					<td></td>
					<td>รูปแบบการัจดส่ง</td>
					<td>ราคา</td>
					<td>ระยะเวลา</td>
					<td>รวม</td>
				</tr>
				<tr>
					<td><form:radiobutton path="otherAmount" value="50" /></td>
					<td>ส่งแบบด่วนพิเศษ</td>
					<td>50</td>
					<td>ระยะเวลา 1-3 วัน</td>
					<td><span id="ems_price"></span></td>
				</tr>
				<tr>
					<td><form:radiobutton path="otherAmount" value="30" /></td>
					<td>ส่งแบบพัสดุธรรมดา</td>
					<td>30</td>
					<td>ระยะเวลา 3-7 วัน</td>
					<td><span id="register_price"></span></td>
				</tr>
				<tr>
					<td colspan="5">
						<div class="row">
							<div class="col-md-2"></div>
							<c:choose>
								<c:when test="${haveConfirmOrder == true }">
									<div class="col-md-4">
										<a href="<c:url value='#' />" class="btn btn-danger" disabled
											role="button">มีรายการค้างชำระเงินอยู่</a>
									</div>
									<div class="col-md-4">
										<a href="<c:url value='/confirmPayment' />"
											class="btn btn-primary" role="button">ไปยังรายการแจ้งชำระเงิน</a>
									</div>
								</c:when>
								<c:when test="${fn:length(order.listProduct) le 0}">
									<div class="col-md-8">
										<a href="#"
											class="btn btn-danger" role="button">กรุณาเลือกสินค้าก่อนทำรายการ</a>
									</div>
								</c:when>
								<c:otherwise>
									<div class="col-md-8">
										<input type="submit" class="btn btn-primary"
											value="ยืนยันตะกร้า" onclick="return validateCart(orderList)" />
									</div>

								</c:otherwise>
							</c:choose>

							<div class="col-md-2"></div>
						</div>
					</td>
				</tr>
			</table>
		</form:form>
	</c:when>
	<c:otherwise>
ไม่มีสินค้าในตะกร้า
</c:otherwise>
</c:choose>


<c:forEach items="${order.listProduct}" var="orderLine"
	varStatus="status">
	<div id="popup_${orderLine.pk.product.productId }" class="overlay">
		<div class="popup">
			<h2>${orderLine.pk.product.productName }</h2>
			<a class="close" href="#">ปิด</a>
			<div class="row">
				<div class="col-md-12">
					<div class="gallery cf">
						<c:set var="prodUrl"
							value="${fn:split(orderLine.pk.product.imgUrl, ',')}" />
						<c:forEach items="${prodUrl }" var="url" varStatus="index">
							<div>
								<img
									src="/Images/Products/${orderLine.pk.product.productId }/${url}" />
							</div>
						</c:forEach>
					</div>
				</div>
			</div>

		</div>
	</div>
</c:forEach>

<script>
$(document).ready(function(){
	$('input').change(function(){
		var totalAmount = 0;
		var itemsAmount = 0;
		<c:forEach items="${order.listProduct}" var="orderLine" varStatus="status">
			var amount${status.index} = $('input#listProduct${status.index}\\.amount').val();
			var total${status.index} = (parseInt(${orderLine.pk.product.price}) *  parseInt(amount${status.index}));
			totalAmount += parseInt(total${status.index});
			itemsAmount += parseInt(amount${status.index});
		</c:forEach>
		$('span#ems_price').text((totalAmount+parseInt(50)));
		$('span#register_price').text((totalAmount+parseInt(30)));
		$('div#priceAmount').text('ราคาทั้งหมด ' + totalAmount + ' บาท');
		$('div#itemsAmount').text(itemsAmount + ' ชิ้น');
	});
});


</script>
<jsp:include page="../componant/footer.jsp" flush="true" />