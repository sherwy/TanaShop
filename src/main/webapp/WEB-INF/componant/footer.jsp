

</div>
</div>

<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.tana.utilities.*"%>
<%@page import="com.tana.entities.*"%>
<%
	String generalDetailJson = JsonReader.readUrl("http://localhost:8081/rest/generalDetailShop");
	Gson gson = new Gson();
	GeneralDetail general = gson.fromJson(generalDetailJson, GeneralDetail.class);
	Account user = (Account) session.getAttribute("user");
%>
<div class="row footerBlock">
	<div class="col-md-3"></div>
	<div class="col-md-3"><b>ติดต่อ Tel : </b><%= general.getShopTelephone() %></div>
	<div class="col-md-3"><b>Email : </b><%= general.getEmail() %></div>
	<div class="col-md-3"><a href="https://twitter.com/meraincat"><img src="/Images/icon/twitter.png" width="100px"/></a></div>
</div>
<div class="col-md-3"></div>
<div class="row footerBlock">
	<div class="col-md-12">
		<div class="collapse navbar-collapse" id="menunav-all">
			<ul class="nav navbar-nav menuNavBlock ">

				<%
					if (user == null || user.getRole().equals(UserRole.ADMIN.getRole())) {
				%>
				<li class="menuNav"><a href="/index">หน้าแรก</a></li>
				<li class="menuNav"><a href="/howTo">วิธีการสั่งซื้อ</a></li>
				<li class="menuNav"><a href="/aboutUs">เกี่ยวกับเรา</a></li>
				<li class="menuNav"><a href="#">ติดต่อเรา</a></li>
				<%
					} else if (user != null && user.getRole().equals(UserRole.USER.getRole())) {
				%>

				<li class="menuNav"><a href="/index">หน้าแรก</a></li>
				<li class="menuNav"><a href="/howTo">วิธีการสั่งซื้อ</a></li>
				<li class="menuNav"><a href="/myCart">ตะกร้าสินค้า</a></li>
				<li class="menuNav"><a href="/confirmPayment">แจ้งการชำระเงิน</a></li>
				<li class="menuNav"><a href="/aboutUs">เกี่ยวกับเรา</a></li>
				<li class="menuNav"><a href="#">ติดต่อเรา</a></li>

				<%
					}
				%>
			</ul>
		</div>
	</div>
</div>
</div>

<script type="text/javascript" charset="utf8"
	src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>

<script src="/Tools/js/jquery.contentcarousel.js"></script>
<script src="/Tools/js/bootstrap.js"></script>
</body>
</html>