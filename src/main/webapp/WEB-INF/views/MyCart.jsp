
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Index" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<b>ตะกร้าสินค้า</b>
<br />

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

								<c:set var="imgSplit" value="${fn:split(orderLine.pk.product.imgUrl,',')}" />
								<c:forEach items="${imgSplit }" var="img">
									<img
										src="/Images/Products/${orderLine.pk.product.productId }_${orderLine.pk.product.productName}/${img}"
										width="100px" height="100px" />

								</c:forEach>
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
					<td colspan="5">ราคารวม</td>
					<td><input type="text" disabled id="testAmount"
						class="form-control" value="0" /></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="7"><c:choose>
							<c:when test="${haveConfirmOrder == true }">
								<a href="<c:url value='#' />" class="btn btn-danger" disabled
									role="button">มีรายการค้างชำระเงินอยู่</a>

								<a href="<c:url value='/confirmPayment' />"
									class="btn btn-primary" role="button">ไปยังรายการแจ้งชำระเงิน</a>
							</c:when>
							<c:otherwise>
								<input type="submit" class="btn btn-primary"
									value="ยืนยันตะกร้า" />
							</c:otherwise>
						</c:choose></td>
				</tr>
			</table>
			
			เลือกวิธีการจัดส่งสินค้า
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
			</table>
		</form:form>
	</c:when>
	<c:otherwise>
ไม่มีสินค้าในตะกร้า
</c:otherwise>
</c:choose>
<script>
$(document).ready(function(){
	$('input').change(function(){
		var totalAmount = 0;
		
		<c:forEach items="${order.listProduct}" var="orderLine" varStatus="status">
			var amount${status.index} = $('input#listProduct${status.index}\\.amount').val();
			var total${status.index} = (parseInt(${orderLine.pk.product.price}) *  parseInt(amount${status.index}));
			totalAmount += parseInt(total${status.index});
		</c:forEach>
		$('span#ems_price').text((totalAmount+parseInt(50)));
		$('span#register_price').text((totalAmount+parseInt(30)));
		$('input#testAmount').val(totalAmount);
	});
});


</script>
<jsp:include page="../componant/footer.jsp" flush="true" />