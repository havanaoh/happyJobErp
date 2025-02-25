<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>년도별 매출현황</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<style>
</style>
<script type="text/javascript">
	$(function(){
		setSelectYear();
		annualSearch();
		
		/* $('.yearpicker').datepicker({
			minViewMode: 'years',
			format: 'yyyy'
		}); */
	});
	
	function formatDate(date) {
		var year = date.getFullYear();
		return year;
	}
	
	function annualSearch(){
		var startYear = $("#startYear").val();
		var endYear = $("#endYear").val();
		
		if (endYear - startYear < 0) {
			alert("시작 년도가 끝나는 년도 이후일 수 없습니다.");
			return;
		} else if (endYear - startYear > 5) {
			alert("6년 이내의 데이터만 검색 가능합니다.");
			return;
		}
		
		var param = {
			searchStDate : startYear,
			searchEdDate : endYear
		}
		
		var callback = function(res){
			var detail = res.annualList;
			
			var totalSupplyAmount = 0;
			var totalUnitAmount = 0;
			var totalExpenseAmount = 0;
			var totalReceivableAmount = 0;
			var totalRevenueAmount = 0;
			
			detail.forEach(function(item) {
				totalSupplyAmount += item.totalSupplyPrice || 0;
				totalUnitAmount += item.totalUnitPrice || 0;
				totalExpenseAmount += item.totalExpenseAmount || 0;
				totalReceivableAmount += item.totalReceivableAmount || 0;
			});

			$("#totalSupplyAmount").html((totalSupplyAmount-totalUnitAmount).toLocaleString());
			$("#totalExpenseAmount").html(totalExpenseAmount.toLocaleString());
			$("#totalReceivableAmount").html(totalReceivableAmount.toLocaleString());
			
			totalRevenueAmount = totalSupplyAmount-totalExpenseAmount-totalReceivableAmount
			
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
			
			// -- 그리드
			$("#mainGrid").jsGrid({
				width: "100%",
				height: "200px",
				sorting: true,
				noDataContent: "조회 결과가 없습니다.",
				data: detail,
				fields: [
					{ name: "orderDate", title: "년도", type: "text", width: 80, align: "center" },
					{ name: "orderCount", title: "주문 건수", type: "number", width: 60, align: "center" },
					{ 
						name: "totalSupplyPrice", 
						title: "매출", 
						type: "number", 
						width: 100, 
						align: "center", 
						itemTemplate: function(value) { return gfFormatNumberWithComma(value); } 
					},
					{ 
						name: "totalUnitPrice", 
						title: "매출 원가", 
						type: "number", 
						width: 100, 
						align: "center", 
						itemTemplate: function(value) { return gfFormatNumberWithComma(value); 
					} },
					{ 
						name: "totalExpenseAmount", 
						title: "지출", 
						type: "number", 
						width: 100, 
						align: "center", 
						itemTemplate: function(value) { return gfFormatNumberWithComma(value); } 
					},
					{ 
						name: "totalReceivableAmount", 
						title: "미수금", 
						type: "number", 
						width: 100, 
						align: "center", 
						itemTemplate: function(value) { return gfFormatNumberWithComma(value); } 
					},
				],
			}); // -- 그리드 끝
			
			mainChart(res);
		};
		
		callAjax("/sales/annualList.do", "post", "json", false, param, callback);
	}
	
	function getDetail(type) {
		var url = (type == 'product') ? "/sales/annualTopProduct.do" : "/sales/annualTopClient.do";
		var titleName = (type == 'product') ? "제품명" : "기업명";
		
		gfModalPop("#annualModal");
		
		var param = {
			searchStDate : $("#startYear").val(),
			searchEdDate : $("#endYear").val()
		}
		
		var callback = function(res) {
			var detail = res.detail;
			
			// -- 그리드
			$("#modalGrid").jsGrid({
				width: "100%",
				height: "200px",
				sorting: true,
				noDataContent: "조회 결과가 없습니다.",
				data: detail,
				fields: [
					{ name: "RNUM", title: "순위", type: "number", width: 40, align: "center" },
					{ name: "topTitle", title: titleName, type: "text", width: 80, align: "center" },
					{ 
						name: "totalSupplyPrice", 
						title: "매출액", 
						type: "number", 
						width: 60, 
						align: "center", 
						itemTemplate: function(value) { return gfFormatNumberWithComma(value); }
					},
				]
			}); // -- 그리드 끝
			
			modalChart(res);
		}
		
		callAjax(url, "post", "json", false, param, callback);
	}
	
	function mainChart(data) {
		var labels = [];
		var salesData = [];
		var expenseData = [];
		
		$.each(data.annualList, function(index, item) {
		    labels.push(item.orderDate);
		    salesData.push(item.totalSupplyPrice); // 매출 데이터
		    expenseData.push(item.totalExpenseAmount); // 지출 데이터
		});

		var chartData = {
		    labels: labels,
		    datasets: [
		        {
		            label: "매출",
		            data: salesData,
		            borderColor: "#de4343",
		            backgroundColor: "#e05151",
		            fill: false,
		            borderWidth: 2
		        },
		        {
		            label: "지출",
		            data: expenseData,
		            borderColor: "#468be0",
		            backgroundColor: "#5191e0",
		            fill: false,
		            borderWidth: 2
		        }
		    ]
		};

		new Chart(document.getElementById("mainChart"), {
		    type: "line",
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
	
	function modalChart(data) {
		var labels = [];
		var chartData = [];

		$.each(data.detail, function(index, item) {
		    labels.push(item.topTitle.split(" ")[0]);
		    chartData.push(item.totalSupplyPrice);
		});
		
		new Chart(document.getElementById("modalChart"), {
		    type: "pie",
		    data: {
				labels: labels,
				datasets: [
					{ 
						label: "매출",
						data: chartData,
						backgroundColor: ["#f27777", "#f5a96c", "#f2c64b", "#a8e3bf", "#9bc6fa" ],
					},
				]
			},
		    options: {
		        responsive: true,
		        legend: { display: true, position: 'top' },
		    }
		});
	}
	
	function setSelectYear(){
		var now = new Date();
		var now_year = now.getFullYear();
		
		for(var i = 1980; i <= 2050; i++){
			$(".searchYear").append("<option value='"+ i +"'>"+ i + " 년" +"</option>");
		}
		
		$("#startYear").val(now_year);
		$("#endYear").val(now_year);
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
						<span class="btn_nav bold">년도별 매출현황</span> 
						<a href="#" class="btn_set refresh">새로고침</a>
					</p>
					
					<div class="searchTitle">
						<p class="divTitle">
							<span>년도별 매출현황</span> 
						</p>
						<table class="searchTable">
							<colgroup>
								<col width="5%" />
								<col width="45%" />
								<col width="50%" />
							</colgroup>
							<tbody>
								<tr>
									<td>기간</td>
									<td>
										<select id="startYear" class="searchYear" style="width:100px;">
											<option value="">선택</option>
										</select>
										~
										<select id="endYear" class="searchYear" style="width:100px;">
											<option value="">선택</option>
										</select>
									</td>
									<td style="text-align:right;">
										<a href="javascript:annualSearch();" class="btnType gray" name="btn" id="searchBtn"><span>조회</span></a>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div class="contentContainer" style="width:100%;padding:10px;">
						<div class="contentLeft" style="width:50%; float:left;">
							<div class="chartContainer" style="width:400px; height:300px; display:flex; align-items:center;">
								<canvas id="mainChart"></canvas>
							</div>
						</div>
						
						<div class="contentRight" style="width:50%; float:right;">
							<div class="tableContainer" style="width:400px; height:300px; display:flex; align-items:center;">
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
					                        <th scope="row">매출 순수익 ①</th>
					                        <td><span id="totalSupplyAmount"></span></td>
					                     </tr>
										<tr>
					                        <th scope="row">지출 총액 ②</th>
					                        <td><span id="totalExpenseAmount"></span></td>
					                     </tr>
					                     <tr>
					                        <th scope="row">미수금 총액 ③</th>
					                        <td><span id="totalReceivableAmount"></span></td>
					                     </tr>
					                     <tr>
					                        <th scope="row">손익 총계 (①-②-③)</th>
					                        <td><span id="totalRevenueAmount"></span></td>
					                     </tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<div class="gridSubDiv" style="text-align:right;margin:10px;">
						<a href="javascript:getDetail('product');" class="btnType blue" name="btn" id="searchBtn"><span>매출상위제품</span></a>
						<a href="javascript:getDetail('client');" class="btnType blue" name="btn" id="searchBtn"><span>매출상위기업</span></a>
					</div>
					
					<div id="mainGrid"></div>
	
				</div> <!--// content -->

				<h3 class="hidden">풋터 영역</h3>
				<jsp:include page="/WEB-INF/view/common/footer.jsp" />
			</li>
		</ul>
	</div>
</div>

<div id="annualModal" class="layerPop layerType2" style="width:900px;">
	<dl>
		<dt>
			<strong>매출 상위 제품</strong>
		</dt>
		<dd class="content">
			<div class="contentContainer" style="width:100%;min-height:300px;padding:10px;">
				<div class="contentLeft" style="width:50%; float:left;">
					<div class="chartContainer" style="width:300px; height:300px; display:flex; align-items:center;">
						<canvas id="modalChart"></canvas>
					</div>
				</div>
				
				<div class="contentRight" style="width:50%; float:right;">
					<div class="tableContainer" style="width:400px; height:300px; display:flex; align-items:center;">
						<div id="modalGrid"></div>
					</div>
				</div>
			</div>
			
			<div class="btn_areaC mt30" style="margin-top:30px;">
				<a href="javascript:gfCloseModal();" class="btnType gray" name="btn"><span>닫기</span></a>
			</div>
		</dd>
	</dl>
	<a href="" class="closePop"><span class="hidden">닫기</span></a>
</div>

</body>
</html>
