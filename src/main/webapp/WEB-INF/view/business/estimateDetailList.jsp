<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


 
<c:forEach items="${detailList}" var="detail">
	<tr>
		<td>${detail.productName}</td> 
		<td>${detail.quantity}</td>
		<td>${detail.supplyPrice}</td>
		<td>${detail.supplyPrice * quantity * 0.1}</td>
		<td>${detail.supplyPrice * quantity}</td>
		<!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
	</tr>
</c:forEach>
	
	<!-- 이거 중간에 있으면 table 안먹힘  -->
