<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="Register" />
</jsp:include>
<%@ page language="java" contentType="text/html; charset=TIS-620"
	pageEncoding="UTF-8"%>

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

<div class="row">
		<div class="col-md-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<div class="nav-header">
						<b>เกี่ยวกับเรา</b>
					</div>
					<br>
				</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-6">
							<img width="400px"
								src="/Images/AboutUs/<%= general.getImgUrl() %>" />
						</div>
						<div class="col-md-6">
							<div class="row">
								<div class="col-md-4">
									<b>ชื่อร้าน</b>
								</div>
								<div class="col-md-8"><%= general.getShopName() %></div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<b>ข้อมูลร้านค้า</b>
								</div>
								<div class="col-md-8">
								<p><%= general.getShopDetail() %></p>
								<p><%= general.getShopDescription() %></p>
								</div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<b>อีเมล</b>
								</div>
								<div class="col-md-8"><%= general.getEmail() %></div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<b>ที่อยู่ร้านค้า</b>
								</div>
								<div class="col-md-8"><%= general.getAddress() %></div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

<jsp:include page="../componant/footer.jsp" flush="true" />