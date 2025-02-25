<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>급여 조회</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" />
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script>

<script type="text/javascript">
	$(function() {
		salaryInfo();
	})
	
	function salaryInfo() {
		var param = {
			searchPaymentMonth : $("#searchPaymentMonth").val(),
		}
		
		var callback = function(res) {
			var detail = res.salaryListDetail;

			$("#employeeName").val(detail.employeeName);
			$("#jobGradeDetailName").val(detail.jobGradeDetailName);
			$("#workingYear").val(detail.workingYear);
			
			if (param.searchPaymentMonth === '') {
	            return; // 데이터가 없으면 종료
	        }
		}
		callAjax("/personnel/salaryListDetail.do", "post", "json", false, param, callback);
	}
	
	function salaryListSearch() {	  

	    var searchPaymentMonth = $("#searchPaymentMonth").val();

	    if (!searchPaymentMonth) {
	       	alert("검색할 기준년월을 입력해주세요.");
	        return;
	    }
	    
		var param = {
			searchPaymentMonth : $("#searchPaymentMonth").val(),
		}
		
		var callback = function(res){
			var detail = res.salaryListDetail;

			$("#employeeName").val(detail.employeeName);
			$("#jobGradeDetailName").val(detail.jobGradeDetailName);
			$("#workingYear").val(detail.workingYear);
			
			if (param.searchPaymentMonth === '') {
	            return; // 데이터가 없으면 종료
	        }
			
			if (!detail || (!detail.nationalPension && !detail.healthInsurance &&
                    !detail.employmentInsurance && !detail.industrialAccident)) {
				        alert("검색결과가 없습니다.");
				        return;
				    }
			
			var gridData = [
			                { deduction: "국민연금", amount: detail.nationalPension },
			                { deduction: "건강보험료", amount: detail.healthInsurance },
			                { deduction: "고용보험", amount: detail.employmentInsurance },
			                { deduction: "산재보험", amount: detail.industrialAccident }
			            ];
			
			$("#jsGrid").jsGrid ({
				width: "100%",
				height: "400px",
				sorting: true,
				noDataContent: "검색 결과가 없습니다",
				data: gridData,
				fields: [
					{name: "deduction", title: "공제항목", type: "text", width: 80, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{name: "amount", title: "금액", type: "number", width: 80, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
				]
			});
			
			var paymentsGridData = [
				                        { payment: "기본급", amount: detail.baseSalary },
				                        { payment: "비고금액", amount: detail.additionalAmount },
				                        { payment: "실급여", amount: detail.totalSalary },
				                        { payment: "연봉", amount: detail.salary },
			                        ]
			
			$("#jsGridPaymentsItem").jsGrid ({
				width: "100%",
				height: "400px",
				sorting: true,
				
				data: paymentsGridData,
				fields: [
					{name: "payment", title: "지급항목", type: "text", width: 80, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					},
					{name: "amount", title: "금액", type: "number", width: 80, align: "center", 
						itemTemplate: function(value) {
				        	return formatNumberWithComma(value);
				    	} 
					}
				]
			});
			$("#premiumRateImg").show();
			
		};
		
		callAjax("/personnel/salaryListDetail.do", "post", "json", false, param, callback);
	}
	
	function premiumRate() {
		gfModalPop("#premiumRateModal");
	}
	
	// 3자리마다 콤마를 추가하는 함수
	function formatNumberWithComma(value) {
	    if (typeof value === "number") {
	        return value.toLocaleString(); // 숫자 값을 3자리마다 콤마로 변환
	    } 
	    return value; // 숫자가 아닌 경우 그대로 반환
	}
</script>
</head>
<body>
	<input type="hidden" id="currentPage" value="1">
	<input type="hidden" name="action" id="action" value=""> 
	
	<div id="wrap_area">
		<h2 class="hidden">header 영역</h2> 
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
							<span class="btn_nav bold">급여 조회</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle">
							<span>급여 내역서</span>
							<span class="fr">
								기준년월
                          		<input type="month" id="searchPaymentMonth" name="searchPaymentMonth" style="height: 25px; margin-right: 10px;"/>
                          		<a class="btnType red" href="javascript:salaryListSearch();" name="searchbtn"  id="searchBtn"><span>검색</span></a>
							</span> 
						</p>
						
						<div id="jsGridContainer" style="border: 1px solid #ccc; padding: 20px; position: relative; text-align: center;">
							<span>
    							사원명
    							<input type="text" id="employeeName" name="employeeName" style="height: 25px; margin-right: 30px;" readonly>
    							직급
    							<input type="text" id="jobGradeDetailName" name="jobGradeDetailName" style="height: 25px; margin-right: 30px;" readonly>
    							근무연차
    							<input type="text" id="workingYear" name="workingYear" style="height: 25px; margin-right: 30px;" readonly>
    						</span>
							<div class="jsgrid-container" style="margin: 10px">
							    <div id="jsGrid"></div>
							    <a id="premiumRateImg" href="javascript:premiumRate();" title="보험료율" name="modal" style="display: none;">
							    	<img src="/images/salary/help_question_icon.png" height="30" width="30"/>
							    </a>
							    <div id="jsGridPaymentsItem" ></div>
							</div>
						</div>
					</div>
					
					<!-- pop up -->
					<div id="premiumRateModal" class="layerPop layerType2" style="width: 600px;">
						
						<dl>
							<dt>
								<strong>보험료율(근로자 부담)</strong>
							</dt>
						</dl>
						<p>- 국민연금: 4.5%</p>
						<p>- 건강보험: 3.43%</p>
						<p>- 고용보험: 0.8%</p>
						<p>- 산재보험: 1.56%</p>
						<a href="" class="closePop"><span class="hidden">닫기</span></a>
					</div>
					
					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>

<style>
.jsgrid-container {
    display: flex;         /* 가로 정렬 */
    justify-content: space-between; /* 좌우 간격 조절 */
    gap: 20px;             /* 두 개의 jsGrid 사이 간격 */
}
</style>