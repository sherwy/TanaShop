
<jsp:include page="../componant/header.jsp" flush="true">
	<jsp:param name="title" value="List Order" />
</jsp:include>
	
	
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table>
<tr>      
        <td>#</td>
        <td>Order Id</td>
        <td>Order Status</td>
        <td>Date</td>
        <td>Owner</td>
    </tr>
<c:forEach items="${listOrder}" var="order"  varStatus = "i" >
    <tr>      
        <td>${i.index }</td>
        <td>${order.orderId}</td>
        <td>${order.orderStatus}</td>
        <td>${order.datetime}</td>
        <td>${order.customer.firstName } ${order.customer.lastName }</td>
    </tr>
</c:forEach>
</table>


<jsp:include page="../componant/footer.jsp" flush="true" />