<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> 승진내역 관리 </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" />
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script>

<script type="text/javascript">
	$(function(){
		promotionSearch();
		registerBtnEvent();
	})
	
	function registerBtnEvent() {
		$("a[name=btn]").click(function(e){
			e.preventDefault();
			
			var btnId = $(this).attr("id")
			
			switch(btnId) {
				case "btnClose" :
					 $("#jsGridDetailContainer").hide();
					break;
			}
		})
	}
	
	function promotionSearch(currentPage) {
		
		 $("#jsGridDetailContainer").hide();
		 
		 currentPage = currentPage || 1;
		 
		var param = {
			searchId : $("#searchId").val(),
			searchName : $("#searchName").val(),
			searchRegDateStart : $("#searchRegDateStart").val(),
			searchRegDateEnd : $("#searchRegDateEnd").val(),
 			department : $("#departmentGroup").val(),
			jobGrade : $("#jobGradeGroup").val(),
			currentPage : currentPage,
			pageSize : 5
		}
		
		var callback = function(res) {
			var detail = res.promotionList;
			var promotionCnt = res.promotionCnt;
			
			$("#jsGrid").jsGrid({
				width: "100%",
				height: "250px",
				sorting: true,
				noDataContent: "검색 결과가 없습니다",
				data: detail,
				fields: [
					{name: "employeeNumber", title:"사번", type: "number", width: 50, align: "center"},
					{name: "employeeName", title:"사원명", type: "text", width: 50, align: "center"},
					{name: "departmentCode", title:"부서코드", type: "text", width: 50, align: "center"},
					{name: "departmentDetailName", title:"부서명", type: "text", width: 50, align: "center"},
					{name: "newJobGrade", title:"직급", type: "text", width: 50, align: "center"},
					{name: "createdAt", title:"발령일자", type: "text", width: 50, align: "center"},
				],
				rowClick: function(args) {
					var item = args.item;
					
					promotionDetailModal(1, item.employeeNumber);
				}
			});		
			
			
			var pageNavi = getPaginationHtml(currentPage, promotionCnt, 5, 10, "promotionSearch");
			$("#pageSize").html(pageNavi);
		};
		
		callAjax("/personnel/promotionList.do", "post", "json", false, param, callback);
	}
	
	function promotionDetailModal(currentPage, employeeNumber) {
		
		currentPage = currentPage || 1;
		
		var param = {
			employeeNumber : employeeNumber,
			currentPage : currentPage,
			pageSize : 5
		}
		
		var callback = function(res){
			var detail = res.promotionDetailList;
			var firstdata = detail[0];
			var promotionDetailCnt = res.promotionDetailCnt;
			
			$("#employeeNumber").val(firstdata.employeeNumber);
			$("#employeeName").val(firstdata.employeeName);
			$("#departmentDetailName").val(firstdata.departmentDetailName);
			$("#recentJobGradeName").val(firstdata.recentJobGrade);
				
			$("#jsGridDetail").jsGrid({
				width: "100%",
				height: "250px",
				sorting: true,
				noDataContent: "검색 결과가 없습니다",
				data: detail,
				fields: [
					{name: "createdAt", title: "발령일자", type:"text", width: 50, align: "center" },
					{name: "jobGrade", title: "발령내용", type:"text", width: 50, align: "center" },
				]
			});
			
			var pageNavi = getPaginationHtml(currentPage, promotionDetailCnt, 5, 10, "promotionDetailModal", [employeeNumber]);
			$("#detailPageSize").html(pageNavi);
			
			// jsGridDetailContainer 보이게 하기
		    $("#jsGridDetailContainer").show();			
		}		
		
	    callAjax("/personnel/promotionDetail.do", "post", "json", false, param, callback);
	}
	
	
</script>
</head>
<body>

	<div id="wrap_area">
		<h2 class="hidden">hearder 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
		
		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">
						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav bold">인사/급여</a> 
							<span class="btn_nav bold">승진내역 관리</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle" style="height: 110px">
							<span style="text-align: left; display: block;">승진내역 관리</span> 
							<span>					
 	                         	 부서
 	                         	 <select class="departmentGroup" id="departmentGroup" style="width: 100px">
									<option value="">전체</option>	
									<c:forEach items="${departmentGroupList}" var="list">
										<option value= "${list.departmentDetailName}" > ${list.departmentDetailName} </option>
									</c:forEach>
								</select>
						 	</span>
						 	<span>					
 	                         	 직급
 	                         	 <select class="jobGradeGroup" id="jobGradeGroup" style="width: 100px">
									<option value="">전체</option>	
									<c:forEach items="${jobGradeGroupList}" var="list">
										<option value= "${list.jobGradeDetailName}" > ${list.jobGradeDetailName} </option>
									</c:forEach>
									</select>
						 	</span>
							<span>					
                            	사번
                          	<input type="text" id="searchId" name="searchId" style="height: 25px; margin-right: 10px;"/>
                            	이름
                          	<input type="text" id="searchName" name="searchName" style="height: 25px; margin-right: 10px;"/>
                          
						  
							</span>
							<div style="display: flex; align-item: center; gap: 10px; justify-content: space-between; margin: 10px;">
								<span class="fr" style="display:flex; align-items: center; gap: 10px; margin-left: auto">
	                            	기간별 조회
	                          		<input type="date" id="searchRegDateStart" name="searchRegDateStart" style="height: 25px; margin-right: 10px;"/>
	                            
	                          		<input type="date" id="searchRegDateEnd" name="searchRegDateEnd" style="height: 25px; margin-right: 10px;"/>
	                          
							  		<a class="btnType red" href="javascript:promotionSearch();" name="searchbtn"  id="searchBtn"><span>검색</span></a>
	
								</span>
							</div>
						</p> 

					    <div id="jsGrid"></div>
					    <!-- 페이징 처리  -->
						<div class="paging_area" id="pageSize"></div>

    					<div id="jsGridDetailContainer" style="display: none; border: 1px solid #ccc; padding: 10px; position: relative;">
    						<span>
    							사번
    							<input type="text" id="employeeNumber" name="employeeNumber" style="height: 25px; margin-right: 10px;" readonly>
    							사원명
    							<input type="text" id="employeeName" name="employeeName" style="height: 25px; margin-right: 10px;" readonly>
    							부서명
    							<input type="text" id="departmentDetailName" name="departmentDetailName" style="height: 25px; margin-right: 10px;" readonly>
    						</span>
    						<span class="fr">
    							현재 직급
    							<input type="text" id="recentJobGradeName" name="recentJobGradeName" style="height: 25px; margin-right: 10px;" readonly>
    						</span>
    						<div id="jsGridDetail" style="margin: 10px;"></div>
    						<!-- 페이징 처리  -->
							<div class="paging_area" id="detailPageSize"></div>
    						<div class="btn_areaC mt30">
    							<a href=""	class="btnType gray"  id="btnClose" name="btn" ><span>닫기</span></a>
    						</div>
						</div>
					
					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>