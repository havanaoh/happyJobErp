<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>급여 관리</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" />
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script>

<script type="text/javascript">

	$(function() {
		salarySearch();
	});
	
	function salarySearch(currentPage) {
		$("#jsGridDetailContainer").hide();
		currentPage = currentPage || 1;
		
		var param = {
			searchEmployeeName : $("#searchEmployeeName").val(),
			department : $("#departmentGroup").val(),
			jobGrade : $("#jobGradeGroup").val(),
			searchPaymentMonth : $("#searchPaymentMonth").val(),
			searchPaymentStatus : $("#searchPaymentStatus").val(),
			currentPage : currentPage,
			pageSize : 5,
		}
		
		var callback = function(res){
			var detail = res.salaryList;
			var salaryCnt = res.salaryCnt;
			
			$("#jsGrid").jsGrid({
				width: "100%",
				height: "250px",
				sorting: true,
				noDataContent: "검색 결과가 없습니다",
				data: detail, // 서버에서 받아온 데이터
				fields: [
					{ 
						name: "paymentDate", 
						title: "해당년월", 
						type: "text", 
						width: 80, 
						align: "center",
						itemTemplate: function(value) {
							if(!value) return "";
							return value.substring(0, 7);
						}
					},
					{ name: "departmentDetailName", title: "부서명", type: "text", width: 80, align: "center" },
					{ name: "jobGradeDetailName", title: "직급", type: "text", width: 80, align: "center" },
					{ name: "employeeName", title: "사원명", type: "text", width: 60, align: "center" },
					{ name: "employeeNumber", title: "사번", type: "number", width: 60, align: "center" },
					{ name: "salary", title: "연봉", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "baseSalary", title: "기본급", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "nationalPension", title: "국민연금", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "healthInsurance", title: "건강보험", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "industrialAccident", title: "산재보험", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "employmentInsurance", title: "고용보험", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "additionalAmount", title: "비고금액", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "totalSalary", title: "실급여", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ 	
						name: "severancePay", 
						title: "퇴직금", 
						type: "text", 
						width: 90, 
						align: "center",
						itemTemplate: function(value) {
					        return value === 0 ? "-" : formatNumberWithComma(value);
					    }
					},
					{ 
						title: "지급", 
						type: "text",
						width: 70, 
						align: "center",
						itemTemplate: function(_, item) {
							console.log("item: ", item)
							return $("<button>")
								.text(item.paymentStatus === 1 ? "지급완료" : "미지급")
								.prop("disabled", item.paymentStatus === 1)
								.on("click", function() {
									if(item.paymentStatus === 0) {
										
										var dateObj = new Date(item.paymentDate);
										var selectedMonth = dateObj.getFullYear() + '-' + (dateObj.getMonth() + 1).toString().padStart(2, '0');
									    var today = new Date();
									    var currentMonth = today.getFullYear() + "-" + String(today.getMonth() + 1).padStart(2, '0');

									    // 선택한 월이 현재 월보다 미래이면 지급 불가
									    if (selectedMonth > currentMonth) {
									        alert("선택한 월은 아직 지급할 수 없습니다.");
									        return;
									    }
									    
										if(!confirm("지급처리 하시겠습니까?")) {
											$("#jsGrid").jsGrid("refresh");
											return;
										}
										
										paymentStatusUpdate(item.salaryId, item.baseSalary);
										$("jsGrid").jsGrid("refresh");
										
										
									}
								});
						}
					},
				],
				rowClick: function(args) {
					var item = args.item;					
					
					salaryDetailModal(1, item.employeeNumber);
					$("#jsGridDetail").show();
				}
			});
			var pageNavi = getPaginationHtml(currentPage, salaryCnt, 5, 10, "salarySearch");
			$("#pageSize").html(pageNavi);
			
		};
		callAjax("/personnel/salaryList.do", "post", "json", false, param, callback);
	}
	
	function paymentStatusUpdate(salaryId, baseSalary, paymentDate) {
		var param = {
				salaryId : salaryId,
				baseSalary : baseSalary
		}	
		
		var callback = function(res) {
			if(res.result === "success") {
				alert("지급 완료 되었습니다.");
				$("#jsGridDetail").hide();
				salarySearch();
			} else {
	            alert("지급 처리에 실패했습니다.");
	        }
		}
		callAjax("/personnel/paymentStatusUpdate.do", "post", "json", false, param, callback);
	}
	
	function allPaymentStatusUpdate() {
		if(!$("#searchPaymentMonth").val()) {
			alert("지급할 월을 선택하신 후, 일괄 지급을 진행해 주세요.");
			return;
		}
		
		var selectedMonth = $("#searchPaymentMonth").val();
	    var today = new Date();
	    var currentMonth = today.getFullYear() + "-" + String(today.getMonth() + 1).padStart(2, '0');

	    // 선택한 월이 현재 월보다 미래이면 지급 불가
	    if (selectedMonth > currentMonth) {
	        alert("선택한 월은 아직 지급할 수 없습니다.");
	        return;
	    }
		
		var param = {
				paymentStatus : 1
		}
		
		var callback = function(res) {
			
			if(res.countUnpaidStatus === 0) {
				alert("처리할 미지급 급여가 없습니다.");
				return;
			};
						
			confirm("일괄지급 처리하시겠습니까?");
			if(res.result === "success") {
				alert("일괄지급 처리되었습니다.");
				salarySearch();
			} else {
	            alert("일괄지급 처리에 실패했습니다.");
	            return;
	        }
		}
		
		callAjax("/personnel/allPaymentStatusUpdate.do", "post", "json", false, param, callback);
	}
	
	function salaryDetailModal(currentPage, employeeNumber) {
		currentPage = currentPage || 1;
		
		var param = {
				employeeNumber : employeeNumber,
				currentPage : currentPage,
				pageSize : 5
		}
		
		var callback = function(res) {
			var detail = res.salaryDetail;
			var salaryDetailCnt = res.salaryDetailCnt;
			
			$("#jsGridDetail").jsGrid({
				width: "100%",
				height: "250px",
				sorting: true,
				noDataContent: "검색 결과가 없습니다",
				data: detail,
				fields: [
					{ 
						name: "paymentDate", 
						title: "해당년월", 
						type: "text", 
						width: 80, 
						align: "center",
						itemTemplate: function(value) {
							if(!value) return "";
							return value.substring(0, 7);
						}
					},
					{ name: "departmentDetailName", title: "부서명", type: "text", width: 80, align: "center" },
					{ name: "jobGradeDetailName", title: "직급", type: "text", width: 80, align: "center" },
					{ name: "employeeName", title: "사원명", type: "text", width: 60, align: "center" },
					{ name: "employeeNumber", title: "사번", type: "number", width: 60, align: "center" },
					{ name: "salary", title: "연봉", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "baseSalary", title: "기본급", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "nationalPension", title: "국민연금", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "healthInsurance", title: "건강보험", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "industrialAccident", title: "산재보험", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "employmentInsurance", title: "고용보험", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "additionalAmount", title: "비고금액", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "totalSalary", title: "실급여", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{ name: "severancePay", title: "퇴직금", type: "number", width: 90, align: "center", 
						itemTemplate: function(value) {
					        return value === 0 ? "-" : formatNumberWithComma(value);
					    }
					},
				],
			});
			
			var pageNavi = getPaginationHtml(currentPage, salaryDetailCnt, 5, 10, "salaryDetailModal", [employeeNumber]);
			$("#detailPageSize").html(pageNavi);
			
			// jsGridDetailContainer 보이게 하기
		    $("#jsGridDetailContainer").show();
		}
		callAjax("/personnel/salaryDetail.do", "post", "json", false, param, callback);
	}
	
	// 3자리마다 콤마를 추가하는 함수
	function formatNumberWithComma(value) {
	    if (typeof value === "number") {
	        return value.toLocaleString(); // 숫자 값을 3자리마다 콤마로 변환
	    } 
	    return value; // 숫자가 아닌 경우 그대로 반환
	}
	
	// 급여계산 - 현재 날짜에서 3개월 이후까지
	$(document).ready(function() {
	    var inputMonth = $("#saveSalary");
	
	    // 현재 날짜 가져오기
	    var today = new Date();
	    var year = today.getFullYear();
	    var month = today.getMonth() + 1;
	    
	    var minMonth = year + "-" + (month < 10 ? "0" + month : month);
	    
	    // 3개월 후 계산
	    var futureDate = new Date(year, today.getMonth() + 3, 1);
	    var maxYear = futureDate.getFullYear();
	    var maxMonth = futureDate.getMonth() + 1;
	    var maxMonthFormatted = maxYear + "-" + (maxMonth < 10 ? "0" + maxMonth : maxMonth);
	
	    // min, max 속성 설정
	    inputMonth.attr("min", minMonth);
	    inputMonth.attr("max", maxMonthFormatted);
	});
	
	function salarySave() {
		if (!$("#saveSalary").val()) {
		    alert("급여를 계산할 월을 선택해 주세요.");
		    return;
		}
		
		var param = {
			paymentDate : $("#saveSalary").val()
		}
		
		var callback = function(res) {
			if(res.result === "success") {
				alert("급여계산이 완료되었습니다.");
				salarySearch();
			}
		}
		
		callAjax("/personnel/salarySave.do", "post", "json", false, param, callback);
	}

</script>
</head>

<body>
	<input type="hidden" id="currentPage" value="1">
	<input type="hidden" name="action" id="action" value=""> 
	
	<div id="wrap_area">
		<h2 class="hidden">header 영역</h2> 
		<input type="hidden" id="employeeId" name="employeeId">
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
							<span class="btn_nav bold">급여 관리</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						
						<div class="searchTitle">
							<p class="divTitle">
								<span >급여 관리</span> 
								<span class="fr" style="font-size: 13px;">
	                          		<input type="month" id="saveSalary" name="saveSalary" style="height: 25px; margin-right: 10px;"/>
	                          		<a class="btnType" href="javascript:salarySave();" name=""  id="" ><span style="display: block;">급여계산</span></a>
	                          	</span>
							</p>
							<table class="searchTable">
								<tbody>
									<colgroup>
									<col width="8%" />
									<col width="20%" />
									<col width="8%" />
									<col width="20%" />
									<col width="8%" />
									<col width="10%" />
									<col width="15%" />
									<col width="2%" />
									<col width="15%" />
								</colgroup>
								</tbody>
								<tr>
									<td>사원명</td>
									<td>
                          				<input type="text" id="searchEmployeeName" name="searchEmployeeName" style="height: 25px; margin-right: 10px;"/>                          		
									</td>
									<td>급여년월</td>
									<td>
										<input type="month" id="searchPaymentMonth" name="searchPaymentMonth" style="height: 25px; margin-right: 10px;"/>
									</td>
								</tr>
								<tr>
									<td>부서</td>
									<td>
										<select class="departmentGroup" id="departmentGroup" style="width: 100px">
	                          				<option value="">전체</option>
	                          				<c:forEach items="${departmentGroupList}" var="list">
												<option value= "${list.departmentDetailName}" > ${list.departmentDetailName} </option>
											</c:forEach>
	                          			</select>
	                          		</td>
	                          		<td>직급</td>
	                          		<td>
	                          			<select class="jobGradeGroup" id="jobGradeGroup" style="width: 100px">
	                          				<option value="">전체</option>
	                          				<c:forEach items="${jobGradeGroupList}" var="list">
												<option value= "${list.jobGradeDetailName}" > ${list.jobGradeDetailName} </option>
											</c:forEach>
	                          			</select>
	                          		</td>
	                          		<td>지급여부</td>
	                          		<td>
	                          			<select class="searchPaymentStatus" id="searchPaymentStatus" style="width: 100px">
	                          				<option value="">전체</option>
	                          				<option value="1">지급</option>
	                          				<option value="0">미지급</option>                          			
	                          			</select>
	                          		</td>
	                          		<td rowspan="2" style="text-align:right; margin: 10px;">
	                          			<a class="btnType red" href="javascript:salarySearch();" name="searchbtn"  id="searchBtn"><span>검색</span></a>
	                          		</td>
	                          		<td></td>
	                          		<td rowspan="2" style="text-align:right; margin: 10px;">
	                          			<a class="btnType red" href="javascript:allPaymentStatusUpdate();" name="paymentbtn"  id="paymentBtn"><span>일괄지급</span></a>
	                          		</td>
								</tr>							
							</table>
						</div>					

						<div id="jsGrid"></div>
												
						<!-- 페이징 처리  -->
						<div class="paging_area" id="pageSize">		
						</div> 
						<div id="jsGridDetailContainer" style="display: none; border: 1px solid #ccc; padding: 10px; position: relative;">
							<div id="jsGridDetail"></div>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="detailPageSize"></div>
							<div class="btn_areaC mt30">
	    						<a href=""	class="btnType gray"  id="btnClose" name="btn" ><span>닫기</span></a>
	    					</div>
						</div>
					</div> <!--// content -->
					
					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>