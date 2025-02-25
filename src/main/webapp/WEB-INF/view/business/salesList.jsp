<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<title>영업 실적</title>
<style>
.searchWrapper {
	display: flex;
	height: 31px;
	justify-content: space-between;
}

.quantityMemoWrapper {
	display: flex;
	height: 32px;
	justify-content: end;
}

.oneLineCss {
    border: 1px solid #e2e6ed;
}

.titleCss {
	font-family: '나눔바른고딕', NanumBarunGothic;
	line-height: 60px;
	font-size: 28px;
	font-weight: bold
}

.crud {
	display: flex;
	justify-content: space-between;
}

.searchWrapper select {
	height: 100%;
}

#findSearch, .createPlanBtn {
	text-align: center;
	line-height: 31px;
	width: 110px;
	border: 1px solid #bbc2cd;
	padding-left: 2px;
	background: #2e9acc;
	color: rgb(255, 255, 255);
	background: url(/images/admin/comm/set_btnBg.png) 0 0px no-repeat;
	background-position: 100% -41px;
}

#searchListPosition {
	margin-top: 20px;
}

.createPlanWrapper {
	display: flex;
}

#PlanModalPosition {
	width: 1020px;
	height: 700px;
	display: none;
	background: #e2e6ed;
	top: 60px;
	background: white;
}

.modalArea {
	display: flex;
	flex-direction: column;
}

.planinfoArea {
	width: 90%;
	margin: 0 auto;
}

.row1 {
	align-items: center;
	height: 100px;
	display: flex;
	justify-content: space-between;
}

.modalTitleArea {
	width: 100%;
	display: flex;
	justify-content: space-between;
	color: #fff;
	font-size: 23px;
	font-weight: 700;
	background-color: #4981cc;
	height: 38px;
	line-height: 38px;
	padding-bottom: 10px;
    padding-top: 10px;
    padding-left: 10px;
    padding-right: 10px;
}

.row1 div {
	font-family: '나눔바른고딕', NanumBarunGothic;
	font-size: 20px;
	font-weight: 700;
}

.row2 {
	display: grid;
	grid-template-columns: 50% 50%;
	margin-bottom: 20px;
	border: 3px solid #bbc2cd;
}

.row2_compo {
	display: flex;
}

.samLabelCss {
	background-color: #e9e9e9;
	width: 62px;
	line-height: 50px;
	text-align: center;
}

.samInputLabelCss {
	width: 166px;
}

.row3 {
	height: 400px;
	display: flex;
	flex-direction: column;
	justify-content: space-evenly;
	border: 3px solid #bbc2cd;
}

.crud {
	justify-content: space-around;
}

.crud div {
	border: 1px solid #bbc2cd;
	background: #2e9acc;
	color: rgb(255, 255, 255);
	text-align: center;
	width: 100px;
	font-size: 20px;
	padding: 10px 10px;
}

.sameLabelCsscreate {
	width: 180px;
	line-height: 72px;
	text-align: center;
	background: #2e9acc;
	color: rgb(255, 255, 255);

	/* border: 1px solid #bbc2cd; */
}

.sameLabelquantity, .sameLabelmemo {
	width: 51px;
	line-height: 32px;
	background: #2e9acc;
	color: rgb(255, 255, 255);
	text-align: center;
}

.u, .d {
	display: none;
}

.udTogle {
	display: block;
}

.cTogle {
	display: none;
}
</style>
</head>
<body>
	<div id="wrap_area">
		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">
						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a>
							<a href="#"class="btn_nav bold">영업</a>
							<span class="btn_nav bold">영업실적 조회</span>
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						
						<div class="searchTitle">
							<p class="divTitle">
								<span>영업 실적</span> 
							</p>
							<table class="searchTable">
								<tbody>
									<tr>
										<td><div id="manu"></div></td>
										<td><div id="mainCate"></div></td>
										<td><div id="subCate"></div></td>
										<td><div id="productList"></div></td>
										<td><input type="date" name="target_date" /></td>
										<td>
				                       		<div id="findSearch">조회</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>

						<div class="searchListWrapper" id="searchListPosition">
							<div id="jsGrid"></div>
						</div>

						<!-- 모달 태그 시작  -->
						<div class="createPlanModal" id="PlanModalPosition">

							<div class="planinfoArea row1">
								<div class="modalTitleArea">
									<div>영업 달성</div>
									<div class="closeModal">close</div>
								</div>
							</div>

							<div class="planinfoArea row2">
								<div class="row2_compo">
									<div class="samLabelCss">사번:</div>
									<input class="samInputLabelCss" name="emp_id" type="text" readonly />
									<div class="samLabelCss">직원이름</div>
									<input class="samInputLabelCss" name="name" type="text" readonly >
								</div>

								<div class="row2_compo">
									<div id="clientList"></div>
									<div class="samLabelCss">거래처</div>
									<input class="samInputLabelCss" name="client_name" type="text" readonly>
									<div class="samLabelCss">목표날짜:</div>
									<input class="samInputLabelCss" name="target_date" type="date" readonly>
								</div>
							</div>

							<div class="planinfoArea row3">
								<canvas id="myChart" width="400" height="200"></canvas>
							</div>
						</div>
					</div>
				</div>
				<!--// content -->

				<h3 class="hidden">풋터 영역</h3>
				<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
			</li>
		</ul>
	</div>
</div>

<script>
	var planParams = {
		emp_id : '',
		client_id : '',
		manufacturer_id : '',
		industry_code : '',
		target_date : '',
		goal_quanti : '',
		plan_memo : '',
		detail_code : '',
		product_name : '',
		plan_num : ''
	}

	var planUpdateParams = {
		emp_id : '',
		client_id : '',
		manufacturer_id : '',
		industry_code : '',
		target_date : '',
		goal_quanti : '',
		plan_memo : '',
		detail_code : '',
		product_name : '',
		plan_num : ''
	}

	var groupCode;
	var industry_code;
	var productCode;
	var manuFacturerList;
	var productName;

	var myChart;

	function enterenceInit() {
		enterenceManu();
		enterenceMainCate();
		enterenceSubCate();
		enterenceProductList();
		searchDate();
		//영업계획 작성/삭제/수정시 필요한 독립적인 데이터로 한번만 호출하면 된다.
		enterenceClientList();

	}

	function enterenceClientList() {

		var callback = function(res) {
			var clientList = res.clientList;

			var clientListTag = "<select id='clientListChange' name='client_id' >";
			for ( var key in clientList) {

				clientListTag += "<option  value='"+clientList[key].client_id+"'  data-clinent_name='"+clientList[key].client_name+"'     >"
						+ clientList[key].client_name + "</option>"
			}
			clientListTag += "</select>";
			$("#clientList").html(clientListTag);
			var clientListChangeCss = {
				height : '50px',
				display : 'none'
			};

			$("#clientListChange").css(clientListChangeCss);
			// 리스트면경이벤트 등록
			$("#clientListChange").change(
					function(e) {

						var clinet_name = $(e.target).find(
								'option:selected')
								.attr("data-clinent_name");
						var clinet_id = e.target.value;
						$("input[name='client_name']").attr(
								"data-client_id", clinet_id);
						$("input[name='client_name']").val(clinet_name);
					})

		}

		callAjax("/business/client-list.do", "post", "json", false, {},
				callback);

	}

	//첫페이지 진입 산업코드와 / 산업코드 대표원 세팅 함수
	function enterenceManu() {

		var callback = function(res) {

			console.log(res.manuFacturerList)
			manuFacturerList = res.manuFacturerList
			groupCode = res.unitIndustrycode;

			var manuFacturerTag = "<select id='manuChange' name='manufacturer_id'>";
			for ( var key in manuFacturerList) {
				console.log(key)
				//manufacturer_id
				console.log(manuFacturerList[key])
				manuFacturerTag += "<option name='industry_code' data-manufacturer_id="+manuFacturerList[key].manufacturer_id+"  value='"+manuFacturerList[key].industryCode+"' >"
						+ manuFacturerList[key].industryName + "</option>"

			}
			;

			manuFacturerTag += "</select>";
			$("#manu").html(manuFacturerTag);
			$(".createManu").html(manuFacturerTag);

			//이제 이벤트를 등록

			$("#manuChange , .createManu").change(function(e) {
				groupCode = e.target.value;
				manuChange(groupCode);
			})

		}

		callAjax("/business/sales-plan/getmanufacturer.do", "post", "json",
				false, {
					key : "val1"
				}, callback);

	}

	// 그다음 페이지 최초진입 대분류 세팅함수
	function enterenceMainCate() {

		var callback = function(res) {

			var mainCategory = res.mainCategory;

			var mainCateTag = "<select id='mainCateChange'>";
			for ( var key in mainCategory) {

				mainCateTag += "<option name='industry_code' value='"+mainCategory[key].group_code+"' >"
						+ mainCategory[key].group_name + "</option>"
			}
			mainCateTag += "</select>";
			$("#mainCate").html(mainCateTag);
			$(".createMainCate").html(mainCateTag);

			//이제 이벤트를 등록 허나  현재 대분류는 하나로 잠시 나중에 만든다.
			$("#manuChange, .createMainCate").change(function(e) {
				groupCode = e.target.value;
			})

		}

		callAjax("/business/sales-plan/getMainCategory.do", "post", "json",
				false, {
					group_code : groupCode
				}, callback);

	}

	// 그다음 페이지 최초진입 소분류 세팅함수
	function enterenceSubCate() {
		var callback = function(res) {
			console.log(res)

			var subCategory = res.subCategory;

			var subCateTag = "<select id='subCateChange'>";
			for ( var key in subCategory) {

				subCateTag += "<option name='industry_code' value='"+subCategory[key].detail_code+"' >"
						+ subCategory[key].detail_name + "</option>"
			}
			subCateTag += "</select>";
			$("#subCate").html(subCateTag);
			$(".createSubCate").html(subCateTag);
			//이제 이벤트를 등록	

			$("#subCateChange , .createSubCate").change(function(e) {
				industry_code = e.target.value;

				subCateChange(industry_code);
			})

		}

		callAjax("/business/sales-plan/getSubCategoryList.do", "post",
				"json", false, {
					group_code : groupCode
				}, callback);
	}

	// 그다음 페이지 최초진입 제품리스트 
	function enterenceProductList() {
		var callback = function(res) {

			var productList = res.productList;

			var productListTag = "<select id='productListChange' name='product_code' >";
			for ( var key in productList) {

				productListTag += "<option name='product_code' value='"+productList[key].product_code+"'   data-product_name='"+productList[key].name+"' >"
						+ productList[key].name + "</option>"
			}
			productListTag += "</select>";
			$("#productList").html(productListTag);
			$(".createProductList").html(productListTag);
		}

		var industryCode = $("#subCateChange").val();

		callAjax("/business/sales-plan/getProductList.do", "post", "json",
				false, {
					industry_code : industryCode
				}, callback);

	}

	// 여기서 부터는 제조업체 / 대 /소  가 변하는 함수드를 만든다. 
	function manuChange(groupCode) {
		console.log("변경된 산업코드: " + groupCode);
		$("#mainCate").children().remove();
		$("#subCate").children().remove();
		var callback = function(res) {

			var mainCategory = res.mainCategory;

			var mainCateTag = "<select id='mainCateChange'>";
			for ( var key in mainCategory) {

				mainCateTag += "<option name='industry_code' value='"+mainCategory[key].group_code+"' >"
						+ mainCategory[key].group_name + "</option>"
			}
			mainCateTag += "</select>";
			$("#mainCate").html(mainCateTag);
			$(".createMainCate").html(mainCateTag);
			planParams.industry_code = $("#mainCateChange option:selected")
					.val();
			//이제 이벤트를 등록
		}

		callAjax("/business/sales-plan/getMainCategory.do", "post", "json",
				false, {
					group_code : groupCode
				}, callback);

		var callback = function(res) {
			console.log(res)

			var subCategory = res.subCategory;

			var subCateTag = "<select id='subCateChange'>";
			for ( var key in subCategory) {

				subCateTag += "<option name='industry_code' value='"+subCategory[key].detail_code+"' >"
						+ subCategory[key].detail_name + "</option>"
			}
			subCateTag += "</select>";
			$("#subCate").html(subCateTag);
			$(".createSubCate").html(subCateTag);

			//이제 이벤트를 등록			
			$("#subCateChange , .createSubCate").change(function(e) {
				industry_code = e.target.value;

				subCateChange(industry_code);
			})

		}

		callAjax("/business/sales-plan/getSubCategoryList.do", "post",
				"json", false, {
					group_code : groupCode
				}, callback);

		var callback = function(res) {

			var productList = res.productList;

			var productListTag = "<select id='productListChange' name='product_code' >";
			for ( var key in productList) {

				productListTag += "<option name='product_code' value='"+productList[key].product_code+"'   data-product_name='"+productList[key].name+"' >"
						+ productList[key].name + "</option>"
			}
			productListTag += "</select>";
			$("#productList").html(productListTag);
			$(".createProductList").html(productListTag);

			//디펄트 값 세팅도 하자.
			planParams.product_name = $(
					"select[name='product_code'] option:selected").attr(
					'data-product_name');
			planParams.detail_code = $(
					"select[name='product_code'] option:selected").val();
		}
		var industryCode = $("#subCateChange").val();
		callAjax("/business/sales-plan/getProductList.do", "post", "json",
				false, {
					industry_code : industryCode
				}, callback);
		searchDate();
	}

	//이제 소분류가 변하면 제품도 변해야한다.
	function subCateChange(industry_code) {

		console.log("소분류가 변함:   " + industry_code);
		var callback = function(res) {

			var productList = res.productList;

			var productListTag = "<select id='productListChange' name='product_code'>";
			for ( var key in productList) {

				productListTag += "<option name='product_code' value='"+productList[key].product_code+"'   data-product_name='"+productList[key].name+"' >"
						+ productList[key].name + "</option>"
			}
			productListTag += "</select>";
			$("#productList").html(productListTag);
			$(".createProductList").html(productListTag);
			//디펄트 값 세팅도 하자.
			planParams.product_name = $(
					"select[name='product_code'] option:selected").attr(
					'data-product_name');
			planParams.detail_code = $(
					"select[name='product_code'] option:selected").val();
		}

		var industryCode = $("#subCateChange").val();
		callAjax("/business/sales-plan/getProductList.do", "post", "json",
				false, {
					industry_code : industry_code
				}, callback);

		searchDate();

	}

	//대분류가 변하면 소/제품리스트가 변한다. 현재 대분류는 하나로 잠시 나중에 만든다. 아니면 필요없으면 지우던지.
	function mainCateChange(groupCode) {
		console.log("groupCode: " + groupCode);

	}

	$("#findSearch").click(function() {
		productName = $('#productListChange option:selected').text();
		searchDate(productName, "searchMessage");

	});

	function searchDate(productName, Message) {

		//searchPlanList.do

		var callback = function(res) {
			delete bodyData.enterence;

			console.log("제거후")
			console.log(bodyData.enterence)

			var searchPlanList = res.searchPlanList;
			console.log(res.searchPlanList.length);

			//#searchListPosition

			if (res.searchPlanList.length <= 0) {
				console.log("조회 결과가 없슴")
			}
			searchUiUpdate(searchPlanList);

		}
		var productCode = $("#productListChange").val();

		var targetDate = $("input[name='target_date']").val();
		if (targetDate == undefined || targetDate === '') {
			var date = new Date();
			var formattedDate = date.toISOString().split('T')[0]; // '2024-10-01' 형식으로 변환	
			/* targetDate = '2025-01-24'; */
		}

		if (productName === '' || productName == undefined) {
			productName = '';
		}

		var bodyData = {
			group_code : groupCode,
			product_code : productCode,
			target_date : targetDate,
			product_name : productName
		}

		console.log("Message: " + Message)

		if (Message === 'searchMessage') {

			if ((targetDate == undefined || targetDate === '')) {

				alert("검색 날짜를 입력해주세요");
				return;
			}

		}

		else {
			if (targetDate == undefined || targetDate === '') {
				bodyData.enterence = "yes"
			}
		}

		console.log(bodyData);

		callAjax("/business/sales-plan/searchPlanList.do", "post", "json",
				false, bodyData, callback);
	}

	function searchUiUpdate(searchPlanList) {
		console.log(searchPlanList);

		var detail = searchPlanList; // 네트워크에서 받아오는 이름 보고 수정할 것	

		console.log(detail);
		for (var key in detail) {
			detail[key].reito = (((detail[key].perform_qut / detail[key].goal_quanti)
					.toFixed(2)) * 100) + "%"			
		}
		console.log(detail);

		$("#jsGrid").jsGrid({
			width : "100%",
			height : "300px",
			sorting : true,
			shrinkToFit: true,
			data : detail,
			noDataContent: "조회 결과가 없습니다.",
			fields : [
				{
					name : "target_date",
					title : "목표날짜",
					type : "number",
					align : "center",
					backgroundcolor : "#e9e9e9"
				}, {
					name : "client_name",
					title : "거래처이름",
					type : "text",
					align : "center"
				}, {
					name : "name",
					title : "제조업체",
					type : "text",
					align : "center"
				}, {
					name : "group_name",
					title : "대분류",
					type : "text",
					align : "center"
				}, {
					name : "detail_name",
					title : "소분류",
					type : "text",
					align : "center"
				}, {
					name : "product_name",
					title : "제품명",
					type : "text",
					align : "center"
				}, {
					name : "goal_quanti",
					title : "목표수량",
					type : "number",
					align : "center",
					itemTemplate: function(value) { return gfFormatNumberWithComma(value); }
				}, {
					name : "perform_qut",
					title : "실적수량",
					type : "text",
					align : "center",
					itemTemplate: function(value) { return gfFormatNumberWithComma(value); }
				}, {
					name : "reito",
					title : "실적",
					type : "text",
					align : "center"
				}
			],
			rowClick : function(args) {
				var item = args.item;
				var itemIndex = args.itemIndex;
				var plan_num = item.plan_num
				
				planParams.plan_num = plan_num;
				
				for ( var key in item) {
					planUpdateParams[key] = item[key];
				}

				uiDataUpdate(item)

				//perform_qut
				//goal_quanti
				performReito(item.goal_quanti, item.perform_qut, item.product_name);
			}
		});
	}

	var updatePlanMessage = '';

	function uiDataUpdate(item) {

		var togleStyle = {
			position : "absolute",
			display : "block"
		/* 	top : modalTop */
		}

		$("#PlanModalPosition").css(togleStyle);
		$("input[name='goal_quanti']").val(item.goal_quanti);
		$("input[name='plan_memo']").val(item.plan_memo);
		$("input[name='emp_id']").val(item.emp_id);
		$("input[name='name']").val(item.emp_name);
		$("input[name=target_date]").val(item.target_date);

		var client_name = item.client_name;

		$("input[name='client_name']").val(client_name);

		$(".u,.d").addClass("udTogle");
		$(".c").addClass("cTogle");
		updatePlanMessage = "update";
	}

	window.onload = function() {
		$(".createPlanBtn")
				.click(
						function() {

							planParams.manufacturer_id = $(
									'select[name="manufacturer_id"] option:selected')
									.data('manufacturer_id');
							planParams.industry_code = $('#mainCateChange')
									.val();
							planParams.detail_code = $('#productListChange')
									.val();
							planParams.product_name = $(
									'select[name=product_code] option:selected')
									.attr("data-product_name");

							console.log(planParams);

							var togleStyle = {
								position : "absolute",
								display : "block"
							/* 	top : modalTop */
							}
							$("#PlanModalPosition").css(togleStyle);

						})

		$(".closeModal").click(function() {
			planParams.plan_num = ""

			if (updatePlanMessage === "update") {
				$(".u,.d").removeClass("udTogle");
				$(".c").removeClass("cTogle");
			}

			var togleStyle = {
				position : "",
				display : "none"
			/* 	top : modalTop */
			}

			$("#PlanModalPosition").css(togleStyle);
			$("input[name='goal_quanti']").val('');
			$("input[name='plan_memo']").val('');
			$("input[name='emp_id']").val('');
			$("input[name='name']").val('');
			$("input[name=target_date]").val('');
			$("input[name='client_name']").val('');
			var ctx = document.getElementById('myChart').getContext('2d');
			ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height); // 캔버스 영역을 비움;
			resetChart();
		})
	}

	$(document).on('change', 'select', function() {
		var name = $(this).prop("name");

		if (name === 'manufacturer_id') {
			planParams.manufacturer_id = $(
					'option:selected', this).data(
					'manufacturer_id');
		}
		if (name === 'client_id') {
			planParams.client_id = $('option:selected',
					this).val();
		}

		if (name === 'product_code') {
			console.log("????:  " + name);
			planParams.product_name = $('option:selected',
					this).attr('data-product_name');
		}
		
		planUpdateParams = planParams;
	});

	$(document).on('change', 'input', function() {
		var name = $(this).prop("name");
		var value = $(this).val();
		planParams[name] = value;
		planUpdateParams = planParams;
	});

	enterenceInit();

	function performReito(goal_quanti, perform_qut, product_name) {

		var golquantity = goal_quanti;
		var performQuantity = perform_qut;
		// 성과 비율 계산
		var performanceRate = (performQuantity / golquantity) * 100;

		//간격
		var interver;
		if (perform_qut < 100) {
			interver = 10
		} else if (perform_qut >= 10 && perform_qut < 1000) {
			interver = 100
		} else {
			interver = 1000
		}

		// 비율에 따른 색상 설정
		var color = '';
		if (performanceRate > 70) {
			color = 'rgba(75, 192, 192, 0.2)'; // 높은 성과 (초록색)
		} else if (performanceRate > 30) {
			color = 'rgba(255, 206, 86, 0.2)'; // 중간 성과 (노란색)
		} else {
			color = 'rgba(255, 99, 132, 0.2)'; // 낮은 성과 (빨간색)
		}

		// 차트 그리기
		var ctx = document.getElementById('myChart').getContext('2d');
		myChart = new Chart(ctx, {
			type : 'bar', // 막대그래프 타입
			data : {
				labels : [ product_name + "목표수량", product_name + '실적수량' ], // X축 레이블

				datasets : [ {
					label : '목표수량', // 첫 번째 데이터셋 레이블
					data : [ goal_quanti, 0 ], // 목표수량만 Y축에 표시
					backgroundColor : [ 'rgba(0, 255, 0, 0.5)' ], // 초록색
					borderColor : [ 'rgba(0, 255, 0, 1)' ], // 초록색 테두리
					borderWidth : 1
				},

				{
					label : '실적수량', // 두 번째 데이터셋 레이블
					data : [ 0, performQuantity ], // 실적수량만 Y축에 표시
					backgroundColor : color, // 빨간색
					borderColor : color, // 빨간색 테두리
					borderWidth : 1
				} ]
			},
			options : {
				scales : {
					y : { // 첫 번째 Y축 설정
						id : 'y1', // 첫 번째 Y축의 ID
						beginAtZero : true,
						ticks : {
							min : 0,
							max : goal_quanti
						// 첫 번째 Y축의 최대값	                          
						}
					},
					y2 : { // 두 번째 Y축 설정
						id : 'y2', // 두 번째 Y축의 ID
						position : 'right', // Y축을 오른쪽에 배치
						beginAtZero : true,
						ticks : {
							min : 0,
							max : perform_qut, // 첫 번째 Y축의 최대값
							stepSize : interver,
						}
					}
				}
			}
		});
	}

	function resetChart() {
		if (myChart) {
			myChart.destroy(); // 기존 차트 인스턴스 삭제
		}
	}
</script>
</body>
</html>