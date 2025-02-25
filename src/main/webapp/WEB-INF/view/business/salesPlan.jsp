<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<title>영업 계획</title>
<style>
.category-container, .search-container {
	display: flex;
	align-items: center;
	gap: 10px; /* 간격 조정 */
}

p.conTitle>div {
	display: flex;
	align-items: center;
	gap: 10px; /* div 사이 간격 */
}

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

.crud {
	display: flex;
	justify-content: space-between;
}

.searchWrapper select {
	height: 100%;
}

.oneLineCss {
	background: #e2e6ed;
}

 #findSearch {
display: inline-block;
    padding-right: 10px;
    min-width: 80px;
    height: 31px;
    line-height: 31px;
    font-family: '나눔바른고딕', NanumBarunGothic;
    font-size: 15px;
    color: #fff;
    text-align: center;
    font-weight: 400;
    background: url(/images/admin/comm/set_btnBg.png) 100% 0px no-repeat;
} 

.titleCss {
	font-family: '나눔바른고딕', NanumBarunGothic;
	line-height: 60px;
	font-size: 28px;
	font-weight: bold
}

/* .createPlanBtn, #findSearch {
	height: 31px;
	display: inline-block;
	padding-left: 10px;
	background: url(/images/admin/comm/set_btnBg.png) 0 0px no-repeat;
	background-position: 100% -41px;
} */

/* .c , .u .d{
	height: 31px;
	display: inline-block;
	padding-left: 10px;
	background: url(/images/admin/comm/set_btnBg.png) 0 0px no-repeat;
	background-position: 100% -41px;
} */
/* .createPlanBtn {
	margin-top: 15px;
} */
#searchListPosition {
	margin-top: 20px;
}

.createPlanWrapper {
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
	background-color: #3e4463;
	height: 38px;
	line-height: 38px;
	padding-bottom: 10px;
	padding-top: 10px;
	padding-left: 10px;
	padding-right: 10px;
}


#PlanModalPosition {
	width: 1020px;
	height: 666px;
	display: none;
	/* background: white; */
	top: 60px;
}

.modalArea {
	display: flex;
	flex-direction: column;
}


.planinfoArea {
	/* width: 90%;
	margin: 0 auto; */
}

.row1 {
	align-items: center;
	height: 60px;
	display: flex;
	justify-content: space-between;
	background-color: #3e4463;
	font-size: 17px;
	color: #fff;
}

.row1time {
	padding-left: 10px;
}

.closeModal {
	padding-right: 10px;
}

.row1 div {
	font-family: '나눔바른고딕', NanumBarunGothic;
	font-size: 20px;
	font-weight: 500;
}

.row2 {
	background: #e2e6ed;
	margin-top: 15px;
	height: 100px;
	display: grid;
	grid-template-columns: 50% 50%;
	grid-template-rows: 50% 50%;
	margin-bottom: 80px;
	border: 3px solid #bbc2cd;
}

.row2_compo {
	display: flex;
}

.samLabelCss {
	text-align: center;
	color: #333;
	background: #bbc2cd;
	width: 62px;
	line-height: 50px;
	color: #333;
}

.samInputLabelCss {
	width: 166px;
}

.row3 {
	background: #e2e6ed;
	height: 65px;
	display: flex;
	flex-direction: column;
	justify-content: space-evenly;
	border: 3px solid #bbc2cd;
}

.row4 {
	justify-content: space-evenly;
	display: flex;
	    margin-bottom: 40px;
}

.modalborder {
	margin-top: 150px;
	background-color: white;
	border: 1px solid black;
}

/* .item:nth-child(1) {
	margin-top: -163px;
}

.item:nth-child(2) {
	margin-top: -40px;
}

.item:nth-child(1), .item:nth-child(2) {
	margin-bottom: -121px; /* 1번과 2번 항목 사이 간격을 더 크게 설정 */
}
.item:nth-child(3), .item:nth-child(4) {
	margin-bottom: -47px; /* 1번과 2번 항목 사이 간격을 더 크게 설정 */
}

* /

.textArea {
	resize: none;
	border: none;
	border: 2px solid #ccc;
	font-family: Arial, sans-serif;
	font-size: 14px;
	padding: 10px;
	word-wrap: break-word;
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
	line-height: 31px;
	text-align: center;
	color: rgb(255, 255, 255);
	background: url(/images/admin/comm/set_btnBg.png) 0 0px no-repeat;
}

/* .sameLabelCsscreate{
    text-align: center;
    line-height: 31px;
    width: 110px;
    border: 1px solid #bbc2cd;
    padding-left: 2px;
    background: #2e9acc;
    color: rgb(255, 255, 255);
    height: 31px;
    display: inline-block;
    padding-left: 10px;
    background: url(/images/admin/comm/set_btnBg.png) 0 0px no-repeat;
    background-position: 100% -41px;

} */
.sameLabelquantity, .sameLabelmemo {
	height: 31px;
	display: inline-block;
	padding-left: 10px;
	background: url(/images/admin/comm/set_btnBg.png) 0 0px no-repeat;
	background-position: 100% -41px;
	width: 58px;
	line-height: 32px;
	/* background: #2e9acc; */
	color: rgb(255, 255, 255);
	text-align: center;
}

.u, .d {
	display: none;
}

.delete{
background: #3e4463;
}


.udTogle {
	display: block;
}

.cTogle {
	display: none;
}



.jsgrid-align-center{
    overflow: overlay;
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
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav bold">영업</a> <span class="btn_nav bold">영업계획</span>
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" style="height: 130px">
							<span style="text-align: left;">영업 계획</span> <span class="fr">
								<a href="#" id="createPlanBtn" class="createPlanBtn btnType red">
									<span>영업계획추가</span>
							</a>

							</span> 
							<span class="category-container fr"
								style="display: inline-block; width: 100%;"> <span
								id="manu" style="display: inline-block;">메뉴</span> <span
								id="mainCate" style="display: inline-block;">메인 카테고리</span> <span
								id="subCate" style="display: inline-block;">서브 카테고리</span> <span
								id="productList" style="display: inline-block;">상품 목록</span> <input
								type="date" name="target_date">
								 <span  id="findSearch" href="#" class="btnType red" style="margin: 10px;">조회</span>

							<!-- 	 <a id="findSearch" href="#" class="btnType red" style="margin: 10px;"> <span>조회</span></a> -->
							</span>
						</p>
						
						<!-- 		<div class="oneLineCss">
							<div class="createPlanWrapper">
								<div class="createPlanBtn">영업계획추가</div>
								
							</div>
							<div class="searchWrapper">
								<div id="manu"></div>

								<div id="mainCate"></div>

								<div id="subCate"></div>
								<div id="productList"></div>
								<input type="date" name="target_date">
								<div id="findSearch">조회</div>
							</div>
						</div> -->

						<div class="searchListWrapper" id="searchListPosition">
							<div id="jsGrid"></div>
						</div>

						<!-- 모달 태그 시작  -->
						<div class="createPlanModal" id="PlanModalPosition">
							<div class="modalborder">
								<div class="planinfoArea  row1">
									<div class="modalTitleArea">
										<div class="row1time">일일 영업계획 등록하기</div>
										<div class="closeModal row1time">close</div>
									</div>
								</div>

								<div class="planinfoArea row2">
									<div class="row2_compo">
										<div class="samLabelCss">직원아이디:</div>
										<input class="samInputLabelCss" name="emp_id" type="text"
											value="${user_idx}" readonly="readonly" />
									</div>
									
									
									<div class="row2_compo">
										<div class="samLabelCss"><span style="color: #fe1414;">*</span>거래처:</div>
										<div id="clientList"></div>
										<!-- <div class="samLabelCss">선택:</div> -->
										<input class="samInputLabelCss" name="client_name" type="text"  readonly="readonly">
																													
									</div>
									<div class="row2_compo">
										<div class="samLabelCss">직원이름</div>
										<input class="samInputLabelCss" name="name" value="${userNm}"
											type="text" readonly="readonly">
									</div>

									<div class="row2_compo">
										<div class="samLabelCss"><span style="color: #fe1414;">*</span>목표날짜:</div>
										<input class="samInputLabelCss" name="target_date" type="date">
									</div>
								</div>
								<div class="planinfoArea row3">
									<div class="searchWrapper item">
										<div class="sameLabelCsscreate"><span style="color: #fe1414;">*</span>제조업체</div>
										<div class="sameLabelCsscreate"><span style="color: #fe1414;">*</span>대분류</div>
										<div class="sameLabelCsscreate"><span style="color: #fe1414;">*</span>소분류</div>
										<div class="sameLabelCsscreate"><span style="color: #fe1414;">*</span>제품명</div>
									</div>
									<div class="searchWrapper item">
										<div class="createManu"></div>
										<div class="createMainCate" id="mainCate"></div>
										<div class="createSubCate" id="subCate"></div>
										<div class="createProductList" id="productList"></div>
									</div>



									<!-- <div class="crud">

									<div class="c" onclick="insertPlanFnc(event)">등록</div>
									<div class="u" onclick="updatePlanFnc(event)">수정</div>
									<div class="d" onclick="deletePlanFnc(event)">삭제</div>

								</div> -->
								
								</div>
								
								<div class="row4">
									<div class="quantityMemoWrapper item">
										<div class="sameLabelquantity"><span style="color: #fe1414;">*</span>목표수량:</div>
										<input type="text" name="goal_quanti">
									</div>


									<div class="quantityMemoWrapper item">
										<div class="sameLabelmemo">비고:</div>
										<input type="text" name="plan_memo">

									</div>
								</div>

								<!-- 선택자 때문에 실행 오류가 생기면 위에것을 주석 해제할것  -->
								<div class="crud">

									<div class="c" onclick="insertPlanFnc(event)">등록</div>
									<div class="u" onclick="updatePlanFnc(event)">수정</div>
									<div class="d delete" onclick="deletePlanFnc(event)" style="background-color: ">삭제</div>

								</div>
							</div>
						</div>
					</div>

					<h3 class="hidden">풋터 영역</h3> <jsp:include
						page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	<!-- 

<div class="searchWrapper">
		<div id="manu"></div>

		<div id="mainCate"></div>

		<div id="subCate"></div>
		<div id="productList"></div>
		<input type="date" name="target_date">
		<div id="findSearch">조회</div>
	</div>
	<div class="searchListWrapper" id="searchListPosition"></div>


  -->

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
		// 그다음 페이지 최초진입 제품리스트 
		var firstProductName;

		function enterenceInit() {
			enterenceManu();
			enterenceMainCate();
			enterenceSubCate();
			enterenceProductList();			
			//searchDate();
			//영업계획 작성/삭제/수정시 필요한 독립적인 데이터로 한번만 호출하면 된다.
			//enterenceClientList();
			searchUiUpdate();
			
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
				$("input[name='client_name']").val(clientList[0].client_name);
				//여기   client_id
				planParams.client_id=clientList[0].client_id;
				
				var clientListChangeCss = {
					height : '50px'
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
							
							
							//여기서 수정/삭제 를 위한 파람을 수정하자..
							console.log(planUpdateParams)
							
							
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
				firstProductName = productList[0].name

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
			console.log("산업코드 변경: " + groupCode);
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
				//하하
				var productList = res.productList;
				productName = productList[0].name;
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
		//	searchDate(productName);
		}

		//이제 소분류가 변하면 제품도 변해야한다.
		function subCateChange(industry_code) {

			console.log("소분류가 변함:   " + industry_code);
			var callback = function(res) {

				var productList = res.productList;
				firstProductName = productList[0].name

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

		//	searchDate();
		}

		//대분류가 변하면 소/제품리스트가 변한다. 현재 대분류는 하나로 잠시 나중에 만든다. 아니면 필요없으면 지우던지.
		function mainCateChange(groupCode) {
			console.log("대분류가변함");
		}

		$(document).on("change", "#productListChange", function() {

			if ($(".createPlanModal").css("display") === 'none') {
				productName = $('#productListChange option:selected').text();
				//searchDate(productName);
			}

		})

		$("#findSearch").click(function() {
			productName = $('#productListChange option:selected').text();
			searchDate(productName);

		});

		//잠시 대기...
		function searchDate(productName) {

			//searchPlanList.do

			var callback = function(res) {

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
				alert("날짜를 선택해주세요");
				return;
				
			/* 	var date = new Date();
				var formattedDate = date.toISOString().split('T')[0]; // '2024-10-01' 형식으로 변환					
				targetDate = formattedDate; */
			}

			if (productName === '' || productName == undefined) {

			}

			var bodyData = {
				group_code : groupCode,
				product_code : productCode,
				target_date : targetDate,
				product_name : productName
			}

			if (productName === '' || productName == undefined) {
				bodyData.enterence = "yes";
				bodyData.product_name = firstProductName;
			}

			console.log(bodyData);

			callAjax("/business/sales-plan/searchPlanList.do", "post", "json",
					false, bodyData, callback);
		}

		function searchUiUpdate(searchPlanList) {
			console.log(searchPlanList);
			
			var detail = searchPlanList; // 네트워크에서 받아오는 이름 보고 수정할 것				
			$("#jsGrid").jsGrid({
				width : "100%",
				height : "400px",
			    sorting: true,
		        paging: true,				
		        noDataContent: "검색 결과가 없습니다",
		        rownumbers : true,
				data: detail, // 서버에서 받아온 데이터
				fields : [

				{
					name : "target_date",
					title : "목표날짜",
					type : "number",
					width : 50,
					align : "center"
				}, {
					name : "client_name",
					title : "거래처이름",
					type : "text",
					width : 80,
					align : "center"
				}, {
					name : "name",
					title : "재조업체",
					type : "text",
					width : 80,
					align : "center"
				}, {
					name : "group_name",
					title : "대분류",
					type : "text",
					width : 100,
					align : "center"
				}, {
					name : "detail_name",
					title : "소분류",
					type : "text",
					width : 80,
					align : "center"
				}, {
					name : "product_name",
					title : "제품명",
					type : "text",
					width : 80,
					align : "center"
				}, {
					name : "goal_quanti",
					title : "목표수량",
					type : "number",
					width : 80,
					align : "center"
				},/*  {
																name : "perform_qut",
																title : "실적수량",
																type : "text",
																width : 100,
																align : "center"
															}, */
				{
					name : "plan_memo",
					title : "비고란",
					type : "text",
					width : 80,
					align : "center"
				}

				],

				rowClick : function(args) {

					var item = args.item;
					var itemIndex = args.itemIndex;

					var plan_num = item.plan_num
					planParams.plan_num = plan_num;
					console.log(item);

					for ( var key in item) {

						planUpdateParams[key] = item[key];

					}
					console.log(planUpdateParams)

					uiDataUpdate(item)

				}
			});

		}
		// 원래의 기본값을 기억
		var originalSelectedOption = $("select[name='client_id'] option:selected").val();
		var updatePlanMessage = '';

		function uiDataUpdate(item) {
			
			
			var togleStyle = {
				position : "absolute",
				display : "block"
			/* 	top : modalTop */
			}
			
			
			enterenceClientList();
			
			$("#PlanModalPosition").css(togleStyle);
			$("input[name='goal_quanti']").val(item.goal_quanti);
			$("input[name='plan_memo']").val(item.plan_memo);
			$("input[name='emp_id']").val(item.emp_id);
			$("input[name='name']").val(item.emp_name);
			$("input[name=target_date]").val(item.target_date);

			//	$("input[name='client_name'] option:selected").val();			
		/* 	var selectedOption = $("select[name='client_id'] option:selected"); */
		
			var client_name =item.client_name;
			//alert(client_name);			
			
			$("input[name='client_name']").val(item.client_name);
			
			$("select[name='client_id'] option").each(function() {
		        // 텍스트 값이 item.clinent_name와 일치하는 옵션을 찾기
		        if ($(this).text() === client_name) {
		            $(this)
		                .prop("selected", true)          // 해당 옵션을 선택 상태로 설정
		                .data("data", client_name)      // data 속성 설정
		                .text(client_name)              // 텍스트 설정
		                .val(client_name);              // 값 설정
		        }
		    });
			$(".u,.d").addClass("udTogle");
			$(".c").addClass("cTogle");
			updatePlanMessage = "update";
			

		}

		var createEmp_id = "${user_idx}";

		window.onload = function() {

			$(".createPlanBtn")
					.click(
							function() {

								$(".samInputLabelCss[name='emp_id']").val(
										createEmp_id);
								$(".samInputLabelCss[name='emp_id']").text(
										createEmp_id);
								planParams.emp_id = createEmp_id;

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
								
								
								
								
								//클라이언트리스트
								enterenceClientList();
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
				/* $("input[name='name']").val(''); */
				$("input[name=target_date]").val('');
				$("input[name='client_name']").val('');			

			})
		}

		$(document)
				.on(
						'change',
						'select',
						function() {
							if ($(".createPlanModal").css("display") === 'block') {

								var name = $(this).prop("name");
								console.log("????:  " + name);

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
									planParams.product_name = $(
											'option:selected', this).attr(
											'data-product_name');

								}
								planParams=planUpdateParams;
								//	console.log(planParams);
								//planUpdateParams = planParams;
								
							}
						});

		$(document).on('change', 'input', function() {
			var name = $(this).prop("name");
			var value = $(this).val();
			planParams[name] = value;
			//console.log(planParams);
			planUpdateParams = planParams;

		});

		function insertPlanFnc(event) {
			console.log(planParams);
			for ( var key in planParams) {

				if (key == "plan_memo" && planParams[key] === '') {
					continue;
				}

				console.log("key::  " + key + " planParams[key]: "
						+ planParams[key]);
				
				
				if (planParams[key] === '' && key != 'plan_num') {
					alert("필수항목을 입력하셔야합니다.\n 빨간색 아이콘이 표기된 \n 것은 필수 입력항목입니다.")
					return;
				}

			}

			console.log(planParams);

			var callback = function(res) {
				console.log(res)

				if (res.statusCode == -1) {
					alert("입력된 사원번호가 틀렸습니다.");
					return;
				}

				if (res.affectedRow <= 0) {
					alert("잠시후 다시 시도해주세요");
					return;
				}

				alert("계획작성이 완료되었습니다.");

				//이제 이벤트를 등록				
				window.location.replace('/business/sales-plan');

			}
			var bodyData = planParams;
			callAjax("/business/sales-plan/insertPlan.do", "post", "json",
					false, bodyData, callback);
		}

		function updatePlanFnc(event) {
			console.log(planUpdateParams);		
			

			var callback = function(res) {
				console.log(res)

				if (res.statusCode == -1) {
					alert("본인의 계획만 수정이 가능합니다.");
					return;
				}
				if (res.affectedRow <= 0) {
					alert("잠시후 다시 시도해주세요");
					return;
				}

				alert("계획수정");

				//이제 이벤트를 등록				
				window.location.replace('/business/sales-plan');

			}
			
			var bodyData = planUpdateParams;
			 callAjax("/business/sales-plan/updatePlan.do", "post", "json",
					false, bodyData, callback);
		}

		function deletePlanFnc(event) {

			var callback = function(res) {
				
				if (res.statusCode <= 0) {
					alert("본인의 계획만 삭제가능합니다.");
					return;
				}

				alert("삭제하였습니다.");

				//이제 이벤트를 등록				
				window.location.replace('/business/sales-plan');

			}
			
			var bodyData = planUpdateParams;;
			callAjax("/business/sales-plan/deletePlan.do", "post", "json",
					false, bodyData, callback);
		}

		enterenceInit();
	</script>

</body>
</html>