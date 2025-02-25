<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일별 매출현황</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<style>
.dateBtn {
	width:30px;
	height:30px;
	border:none;
	border-radius:20px;
}
</style>
<script type="text/javascript">
	$(function(){
		getToday();
		dailySearch();
		setSelectClient();
	});
	
	function setSelectClient() {
		var callback = function(res) {
			var clientSelect = $("select[name='clientId']");
			
			res.forEach(function(client) {
			    clientSelect.append('<option value="' + client.id + '">' + client.name + '</option>');
			});
		}
		
		callAjax("/business/clientNames", "get", "json", true, null, callback);
	}
	
	function formatDate(date) {
		var year = date.getFullYear();
		var month = String(date.getMonth() + 1).padStart(2, "0");
		var day = String(date.getDate()).padStart(2, "0");
		return year + "-" + month + "-" + day;
	}
	
	function getToday() {
		var today = new Date();
		$("#searchDate").val(formatDate(today));
	}
	
	function getDay(day) {
		var baseDate = new Date($("#searchDate").val());
		baseDate.setDate(baseDate.getDate() + day);
		$("#searchDate").val(formatDate(baseDate));
	}
	
	function dailySearch(currentPage){
		currentPage = currentPage || 1;
		
		var param = {
			clientId : $("#clientId").val(),
			orderDate : $("#searchDate").val(),
			currentPage : currentPage,
			pageSize : 10
		}
		
		var callback = function(res){
			var detail = res.dailyList;
			
			var totalSupplyAmount = res.dailyStatistics.totalSupplyPrice;
			var totalExpenseAmount = res.dailyStatistics.totalExpenseAmount;
			var totalRevenueAmount = 0;
			
			$("#totalSupplyAmount").html(totalSupplyAmount.toLocaleString());
			$("#totalExpenseAmount").html(totalExpenseAmount.toLocaleString());
			
			totalRevenueAmount = totalSupplyAmount-totalExpenseAmount
			
			if (totalRevenueAmount < 0) {
				$("#totalRevenueAmount").css({color:"red"});
				$("#totalRevenueAmount").html("▼ "+ (totalRevenueAmount * (-1)).toLocaleString());
			} else if (totalRevenueAmount > 0) {
				$("#totalRevenueAmount").css({color:"blue"});
				$("#totalRevenueAmount").html("▲ "+totalRevenueAmount.toLocaleString());
			} else {
				$("#totalRevenueAmount").css({color:"black"});
				$("#totalRevenueAmount").html(totalRevenueAmount.toLocaleString());
			}
			
			// -- 그리드 시작
			$("#jsGrid").jsGrid({
				width: "100%",
				height: "373px",
				sorting: true,
				noDataContent: "조회 결과가 없습니다.",
				data: detail,
				fields: [
					{ name: "salesDate", title: "날짜", type: "text", width: 100, align: "center" },
					{ name: "type", title: "구분", type: "text", width: 70, align: "center" },
					{ name: "clientId", title: "기업코드", type: "int", width: 70, align: "center" },
					{ name: "clientName", title: "기업명", type: "text", width: 130, align: "center" },
					{ name: "crebitCode", title: "매출 구분", type: "text", width: 100, align: "center" },
					{ name: "debitCode", title: "매출 상세", type: "text", width: 100, align: "center" },
					{ 
						name: "totalSupplyPrice", 
						title: "수익 금액", 
						type: "int", width: 100, align: "center", 
						itemTemplate: function(value) { return value === 0 ? "" : gfFormatNumberWithComma(value); } 
					},
					{ 
						name: "totalExpenseAmount", 
						title: "지출 금액", 
						type: "int", width: 100, align: "center", 
						itemTemplate: function(value) { return value === 0 ? "" : gfFormatNumberWithComma(value); } 
					},
					{ 
						name: "totalReceivableAmount", 
						title: "당일 미수금 기록", 
						type: "int", width: 100, align: "center", 
						itemTemplate: function(value) { return value === 0 ? "" : gfFormatNumberWithComma(value); } 
					},
				],
				rowClick: function(args) {
					var item = args.item;
					var itemIndex = args.itemIndex;
				}
			}); // -- 그리드 끝
			
			var pageNavi = getPaginationHtml(currentPage, res.dailyListCnt, 10, 5, "dailySearch");
			$("#pageSize").html(pageNavi);
			
			mainChart(res);
		};
		
		callAjax("/sales/dailyList.do", "post", "json", false, param, callback);
	}
	
	var mainChartInstance = null;
	
	function mainChart(data) {
		if (mainChartInstance) {
			mainChartInstance.destroy();
		}
		
		var labels = [];
		var supplyAmount = [];
		var expenseAmount = [];
		var receivableAmount = [];
		
		$.each(data.dailyListChart, function(index, item) {
		    labels.push(item.salesDate);
		    supplyAmount.push(item.totalSupplyPrice); // 매출 데이터
		    expenseAmount.push(item.totalExpenseAmount); // 지출 데이터
		    receivableAmount.push(item.totalReceivableAmount); // 미수금 데이터
		});
		
		var chartData = {
		    labels: labels,
		    datasets: [
		        {
		            label: "매출",
		            data: supplyAmount,
		            borderColor: "#ff8282",
		            backgroundColor: "#ff8282",
		        },
		        {
		            label: "지출",
		            data: expenseAmount,
		            borderColor: "#59a7ff",
		            backgroundColor: "#59a7ff",
		        },
		        { 
					label: "미수금",
					data: receivableAmount,
					borderColor: "#ffc670",
					backgroundColor: "#ffc670",
				},
		    ]
		};

		mainChartInstance = new Chart(document.getElementById("mainChart"), {
		    type: "bar",
		    data: chartData,
		    options: {
		        responsive: true,
		        legend: { display: true, position: 'top' },
		        scales: {
		            xAxes: [{ beginAtZero: true }],
		            yAxes: [{
		                ticks: {
		                    beginAtZero: true,
		                    callback: function(value, index, values) {
		                        return value.toLocaleString();
		                    }
		                }
		            }]
		        }
		    }
		});
	}
	
</script>
</head>
<body>
<input type="hidden" id="currentPage" value="1">
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
						<a href="#" class="btn_nav bold">매출 관리</a> 
						<span class="btn_nav bold">미수금 조회</span> 
						<a href="#" class="btn_set refresh">새로고침</a>
					</p>
					
					<div class="searchTitle">
						<p class="divTitle">
							<span>일별 매출현황</span> 
						</p>
						<table class="searchTable">
							<colgroup>
								<col width="8%" />
								<col width="24%" />
								<col width="8%" />
								<col width="40%" />
								<col width="20%" />
							</colgroup>
							<tbody>
								<tr>
									<td>거래처명</td>
									<td>
										<select id="clientId" name="clientId">
											<option value="">전체</option>
										</select>
									</td>
									<td>기간</td>
									<td>
										<input type="date" id="searchDate" name="searchDate" /> 
										<button class="dateBtn" onclick="getDay(-1)">◀</button>
										<a href="javascript:getToday();" class="btnType blue" id="dateBtn" name="btn">
											<span>오늘</span>
										</a> 
										<button class="dateBtn" onclick="getDay(1)">▶</button>
									</td>
									<td style="text-align:right;">
										<a href="javascript:dailySearch();" class="btnType gray" name="btn" id="searchBtn"><span>조회</span></a>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div class="contentContainer" style="width:100%;padding:10px 50px;">
						<div class="contentLeft" style="width:50%; float:left;">
							<div class="chartContainer" style="width:400px; height:200px; display:flex; align-items:center;">
								<canvas id="mainChart"></canvas>
							</div>
						</div>
						
						<div class="contentRight" style="width:50%; float:right;">
							<div class="tableContainer" style="width:400px; height:200px; display:flex; align-items:center;">
								<table class="row" style="width:400px; text-align:center;">
									<colgroup>
										<col width="50%" />
										<col width="50%" />
									</colgroup>
									<tbody>
										<tr>
					                        <th scope="row"></th>
					                        <th scope="row">금액 합계 (단위: 원)</th>
					                     </tr>
										<tr>
					                        <th scope="row">매출총액 ①</th>
					                        <td><span id="totalSupplyAmount"></span></td>
					                     </tr>
										<tr>
					                        <th scope="row">지출총액 ②</th>
					                        <td><span id="totalExpenseAmount"></span></td>
					                     </tr>
					                     <!-- <tr>
					                        <th scope="row">미수금총액 ③</th>
					                        <td><span id="totalReceivableAmount"></span></td>
					                     </tr> -->
					                     <tr>
					                        <th scope="row">손익총계 (①-②)</th>
					                        <td><span id="totalRevenueAmount"></span></td>
					                     </tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<div style="margin-top:220px;margin-bottom:5px;">※ 검색일자를 기준으로 최근 5일간의 데이터입니다.</div>
					<div id="jsGrid"></div>
					<div class="paging_area" id="pageSize"></div>
	
				</div> <!--// content -->

				<h3 class="hidden">풋터 영역</h3>
				<jsp:include page="/WEB-INF/view/common/footer.jsp" />
			</li>
		</ul>
	</div>
</div>

</body>
</html>
