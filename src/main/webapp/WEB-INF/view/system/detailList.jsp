<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<p class="conTitle" style="height: 110px">
							<span style="display: block;">상세코드 관리</span>
							<span class="fr" style="margin-top: 0px;">								
						  		<a class="btnType blue" href="javascript:insertDetailModal();" name="modal"><span>등록</span></a>
							</span>
						</p>
						
        <input type="hidden" id="detail_totcnt" name="detail_totcnt" value="${detailCnt}"/>
        
						<div class=groupList">
							<table class="col">
								<caption>caption</caption>
									<colgroup>
										<col width="20%">
										<col width="20%">
										<col width="20%">
										<col width="20%">
										<col width="20%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">공통코드</th>
											<th scope="col">상세코드</th>
											<th scope="col">상세코드명</th>
											<th scope="col">비고</th>
											<th scope="col">보기</th>
										</tr>
									</thead>
									<!-- 갯수가 0인 경우  -->
		<c:if test="${detailCnt eq 0 }">
			<tr>
				<td colspan="4">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<!-- 갯수가 있는 경우  -->
		<c:if test="${detailCnt > 0 }">
			<c:set var="nRow" value="${pageSize*(currentPage-1)}" /> 
			<c:forEach items="${detailList}" var="detail">
				<tr>
					    <td>${detail.groupCode}</td>	
					    <td>${detail.detailCode}</td>					
						<td>${detail.detailName}</td>
						<td>${detail.note}</td>
						<td><a href="javascript:detailDetailModal('${detail.detailCode}');">수정</a></td>
				</tr>
				 <c:set var="nRow" value="${nRow + 1}" /> 
			</c:forEach>
		</c:if>
		
		<!-- 이거 중간에 있으면 table 안먹힘  -->

									
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="detail_pageSize">
							</div>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>