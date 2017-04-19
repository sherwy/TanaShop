<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Register" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="nav-header">
	<b>รายชื่อลูกค้า</b>
</div>
<br>
<table id="listUser" class="table table-striped">
	<thead>
		<tr>
			<td>รหัสสมาชิก</td>
			<td>ชื่อลูกค้า</td>
			<td>รายการที่สั่งซื้อสมบูรณ์ทั้งหมด</td>
			<td>เงินที่ได้รับ</td>
			<td></td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${listUser}" var="user" varStatus="i">
					<tr>
						<td>${user.accountId }</td>
						<td>${user.firstName} ${user.lastName }</td>
						<td>${mapSuccessOrder.get(user.accountId+='')}</td>
						<td>${mapTotalPrice.get(user.accountId+='')}</td>
						<td><a href="/UserDetail/${user.accountId }" data-balloon="ดูข้อมูลลูกค้า"
										data-balloon-pos="down"><span 
								class="glyphicon glyphicon-zoom-in"></span></a></td>
						<td>${order.calPrice() }</td>
						<td></td>
					</tr>
		</c:forEach>
	</tbody>
</table>
<script>
	$(function() {
		$("#listUser").dataTable({
			responsive : true,
			ajax : '/api/data',
			scrollY : 200,
			deferRender : true,
			scroller : true
		});
	})
</script>
<jsp:include page="../componant/footer.jsp" flush="true" />