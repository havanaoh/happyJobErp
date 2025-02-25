<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<!-- 갯수가 0인 경우  -->
	<c:if test="${orderCnt eq 0 }">
		<tr>
			<td colspan="10">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>

	<!-- 갯수가 있는 경우  -->
	<c:if test="${orderCnt > 0 }">
		<c:set var="nRow" value="${pageSize*(currentPage-1)}" /> 
		<c:forEach items="${orderList}" var="order">
			<tr>
				    <td>${order.orderEmpName}</a></td>
					<td>${order.orderDate}</td>
					<td>${order.clientName}</td>
					<td>${order.productName}</td>
					<td>${order.deliveryDate}</td>
					<td><fmt:formatNumber value="${order.totalDeliveryCount }" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${order.totalSupplyPrice }" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${order.totalTax }" pattern="#,###" /></td>
					<td>${order.salesArea}</td>
				    <td><a href="javascript:orderDetailModal(${order.id},${order.clientId});"> 수주서 상세 보기 </a></td>
			</tr>
			 <c:set var="nRow" value="${nRow + 1}" /> 
		</c:forEach>
	</c:if>
	
	<!-- 이거 중간에 있으면 table 안먹힘  -->

       <input type="hidden" id="totcnt" name="totcnt" value="${orderCnt}"/>
