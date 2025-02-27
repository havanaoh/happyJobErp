<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<!-- 갯수가 0인 경우  -->
	<c:if test="${estimateCnt eq 0 }">
		<tr>
			<td colspan="10">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>

	<!-- 갯수가 있는 경우  -->
	<c:if test="${estimateCnt > 0 }">
		<c:set var="nRow" value="${pageSize*(currentPage-1)}" /> 
		<c:forEach items="${estimateList}" var="estimate">
			<tr>
				    <td>${estimate.estimateEmpName}</a></td>
					<td>${estimate.estimateDate}</td>
					<td>${estimate.clientName}</td>
					<td>${estimate.productName}</td>
					<td>${estimate.deliveryDate}</td>
					<td>${estimate.totalDeliveryCount}</td>
					<td><fmt:formatNumber value="${estimate.totalSupplyPrice }" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${estimate.totalTax}" pattern="#,###" /></td>
					<td>${estimate.salesArea}</td>
				    <td><a href="javascript:estimateDetailModal(${estimate.id},${estimate.clientId});"> 견적서 상세 보기 </a></td>
			</tr>
			 <c:set var="nRow" value="${nRow + 1}" /> 
		</c:forEach>
	</c:if>
	
	<!-- 이거 중간에 있으면 table 안먹힘  -->

       <input type="hidden" id="totcnt" name="totcnt" value="${estimateCnt}"/>
