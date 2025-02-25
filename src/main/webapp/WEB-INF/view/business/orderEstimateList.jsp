<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<!-- 갯수가 0인 경우  -->
	<c:if test="${estimateCnt eq 0 }">
		<tr>
			<td colspan="10">견적서 데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>

	<!-- 갯수가 있는 경우  -->
	<c:if test="${estimateCnt > 0 }">
		<c:set var="nRow" value="${pageSize*(currentPage-1)}" /> 
		<c:forEach items="${estimateList}" var="estimate">
			<tr>
					<td>${estimate.estimateDate}</td>
				    <td>${estimate.clientName}</td>
					<td>${estimate.productName}</td>
					<td>${estimate.totalSupplyPrice}</td>
					<td>${estimate.totalDeliveryCount}</td>
					<td>${estimate.totalSupplyPrice}</td>
					<td><a href="javascript:orderListAddrow(${estimate.id},${estimate.clientId});">등록</a></td>
			</tr>
			 <c:set var="nRow" value="${nRow + 1}" /> 
		</c:forEach>
	</c:if>
	
	<!-- 이거 중간에 있으면 table 안먹힘  -->

       <input type="hidden" id="esti_totcnt" name="totcnt" value="${estimateCnt}"/>
