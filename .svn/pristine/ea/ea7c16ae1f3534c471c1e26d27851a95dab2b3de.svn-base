<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.searchKeyWord {
	display: flex;
	width: 1020px;
	grid-template-rows: auto auto;
	gap: 10px;
	width: 1020px;
}

.sameBtnCss {
	text-align: center;
	line-height: 31px;
	width: 110px;
	padding-left: 2px;
	color: rgb(255, 255, 255);
	background: url(/images/admin/comm/set_btnBg.png) 0 0px no-repeat;
	background-position: 100% -41px;
}

.cancle {
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

.btnLabel {
	background-color: deepskyblue;
	border: none;
	padding-left: 2px;
	color: rgb(255, 255, 255);
}

.oneLineCss {
	background: #e2e6ed;
}

.addCss {
	margin-top: 15px;
}

.addclient {
	padding-right: 30px;
}

.titleCss {
	font-family: '나눔바른고딕', NanumBarunGothic;
	line-height: 60px;
	font-size: 28px;
	font-weight: bold
}

.sameSelect {
	/* 	appearance: none; /* 표준화된 방식 */ */
	height: 52px !important;
}

.sameLabelCss {
	text-align: center;
	width: 100px;
	height: 52px;
	line-height: 52px;
	width: 100px;
	background: #bbc2cd;
	font-weight: bold;
}

.biz_num {
	width: 300px;
}

.biz_num::placeholder {
	text-align: center;
}

.sameFlexRowCss, .sameItemCss {
	display: flex;
}

.searchWrapper {
	/* border: 1px solid #164960; */
	padding: 30px 30px;
}

.flexItem:nth-child(2) {
	margin-top: 11px;
	text-align: center;
	line-height: 31px;
	width: 110px;
	padding-left: 2px;
	background: #2e9acc;
	color: rgb(255, 255, 255);
	background: url(/images/admin/comm/set_btnBg.png) 0 0px no-repeat;
	background-position: 100% -41px;
}

.items {
	grid-row: span 2;
}

.addclient {
	height: 60px;
	justify-content: space-between;
}

.createPlanModal {
	height: 100vh;
	width: 1020px;
	position: fixed;
	top: 60px;
	position: fixed;
	background: #fff;
	display: none;
	left: 509px;
}

.openTogle {
	display: block;
}

.createPlanArea {
	display: flex;
	flex-direction: column;
	height: 60%;
	justify-content: space-evenly;
	border: 1px solid #164960;
}

.modalWrapper {
	/* padding: 30px 30px; */
	
}

.sameRow {
	display: flex;
	padding-bottom: 10px;
	padding-top: 10px;
	padding-left: 10px;
}

.titleheader {
	color: #fff;
	font-size: 23px;
	font-weight: 700;
	background-color: #3e4463;
}

.updatetitleheader {
	display: none;
	color: #fff;
	font-size: 23px;
	font-weight: 700;
	background-color: #4981cc;
}

.addr {
	width: 300px;
}

.detailcss {
	width: 300px;
}

.row3 {
	flex-direction: column;
}

.row7 {
	width: 100%;
}

.row7 input {
	display: block;
	width: 80%;
}

.row7item {
	width: 100%;
}

.row8 {
	justify-content: center;
}

.row8 .row8item {
	justify-content: space-around;
	width: 50%;
}

.failTogle::placeholder {
	color: red; /* 원하는 색으로 변경 */
}

.btnTogle {
	display: none;
}

.u {
	display: none;
}

.jsgrid-pager {
	display: flex;
	justify-content: center;
	align-items: center;
}

.jsgrid-align-center {
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
								class="btn_nav bold">영업</a> <span class="btn_nav bold">거래처
								조회</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle" style="height: 110px;">
							<span style="display: block;">거래처 조회</span> <span
								style="display: flex; align-items: center; margin: 10px; justify-content: space-evenly">
								업체명: <input type="text" id="client_name" name="client_name"
								style="height: 25px; margin-right: 10px;" size="15" /> <input
								type="text" id="memo" name="memo"
								style="height: 25px; display: none; margin-right: 10px;"
								size="15" /> 날짜: <input type="date" id="cust_update_date"
								name="cust_update_date" style="height: 25px;" /> <a
								class="btnType red" href="javascript:void(0);" name="searchbtn"
								id="searchBtn" onclick="searchFnc(event)"><span>조회</span></a> <a
								class="btnType blue" href="javascript:void(0);" name="modal"
								onclick="addClientFnc(event)"><span>거래처 추가</span></a>
							</span>
						</p>
						<div id="jsGrid"></div>
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3> <jsp:include
						page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	<div class="createPlanModal" id="PlanModalPosition">

		<div class="modalWrapper">
			<div class="createPlanArea">
				<div class="sameRow titleheader">거래처 추가</div>
				<div class="sameRow updatetitleheader">거래처 정보 수정</div>
				<div class="sameRow">

					<div class="sameRow">
						<div class="sameLabelCss">
							<span style="color: #fe1414;">*</span>업체명
						</div>
						<input name="client_name">
					</div>
					<div class="sameRow">
						<div class="sameLabelCss">
							<span style="color: #fe1414;">*</span>회사전화
						</div>
						<select class="sameSelect" name="first" id="phfirst"
							style="height: 52px !important;">
							<option>031</option>
							<option>032</option>
						</select> <input type="text" name="ph" placeholder="하이픈없이숫자만 기입해주세요" />
					</div>


				</div>

				<div class="sameRow">

					<div class="sameRow">
						<div class="sameLabelCss">
							<span style="color: #fe1414;">*</span>담당자
						</div>
						<input name="person">
					</div>

					<div class="sameRow">
						<div class="sameLabelCss">
							<span style="color: #fe1414;">*</span>담당자전화
						</div>

						<select name="first" id="handphfirst"
							style="height: 52px !important;">
							<option>031</option>
							<option>032</option>
						</select> <input type="text" name="person_ph" placeholder="하이픈없이숫자만 기입해주세요" />
					</div>


				</div>

				<!--  우편번호  -->
				<div class="sameRow row3 el_result">
					<div class="sameRow">
						<div class="el_ttl  sameLabelCss">
							<span style="color: #fe1414;">*</span>주소
						</div>
						<button class="el_btn el_btn--outline hp_shrink-0  btnLabel"
							id="search-btn">우편번호 찾기</button>
					</div>

					<div class="sameRow">
						<div class="bl_stack bl_stack--row sameRow">
							<div class="el_ttl  sameLabelCss">
								<span style="color: #fe1414;">*</span>우편번호
							</div>
							<input type="text" name="zip"
								class="el_input hp_txt-center  sameLabelCss" placeholder=""
								disabled id="zonecode" />
						</div>


						<div class="sameRow">
							<input type="text" name="addr" class="el_input sameLabelCss addr"
								placeholder="" disabled id="roadAddress" /> <input type="text"
								name="detail_addr" class="el_input  sameLabelCss detailcss"
								placeholder="상세주소를 입력해주세요." id="roadAddressDetail"
								style="background-color: white" />
						</div>

					</div>
					<!-- <div class="sameRow">
											<input type="text" name="addr"
												class="el_input sameLabelCss addr" placeholder="" disabled
												id="roadAddress" /> <input type="text" name="detail_addr"
												class="el_input  sameLabelCss detailcss"
												placeholder="상세주소를 입력해주세요." id="roadAddressDetail" />
										</div> -->





				</div>

				<div class="sameRow">
					<div class="sameRow">
						<div class="sameLabelCss">
							<span style="color: #fe1414;">*</span>이메일
						</div>

						<input type="text" name="firstEmail" class="firstEmail" /> <input
							type="text" name="emailAddr" class="emailAddr" /> <select
							clss="select-device" name="selectemailaddr"
							style="height: 52px !important;" onchange="emailChangeFnc(event)">
							<option value="naver.com" selected>naver.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="hotmail.com">hotmail.com</option>
							<option value="nate.com">nate.com</option>
							<option value="yahoo.co.kr">yahoo.co.kr</option>
							<option value="empas.com">empas.com</option>
							<option value="dreamwiz.com">dreamwiz.com</option>
							<option value="freechal.com">freechal.com</option>
							<option value="lycos.co.kr">lycos.co.kr</option>
							<option value="korea.com">korea.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="hanmir.com">hanmir.com</option>
							<option value="paran.com">paran.com</option>
							<!-- <option value="text">직접입력</option> -->
						</select>
					</div>
				</div>
				<div class="sameRow">
					<div class="sameRow">
						<div class="sameLabelCss">
							<span style="color: #fe1414;">*</span>사업자 등록번호
						</div>
						<input type="text" name="biz_num" class="biz_num"
							placeholder="하이픈없이 10자리를 입력해주세요" />
					</div>
				</div>
				<div class="sameRow">
					<div class="sameRow">
						<div class="sameLabelCss">
							<span style="color: #fe1414;">*</span>은행
						</div>
						<input type="text" name="iSBN" class="iSBN" readonly="readonly" />
						<input type="text" name="bank_account" class="bankaccount"
							placeholder="계좌 앞자리를 제외한 하이픈 없이 입력해주세요" style="width: 300px;" />
						<select name="selecteISBN" onchange="ibsbnChangeFnc(event)"
							style="height: 52px !important;">
							<option value="110" selected>신한</option>
							<option value="123">하나</option>
							<option value="301">농협</option>
							<option value="001">기업</option>
						</select>
					</div>
				</div>
				<div class="sameRow row7">
					<div class="sameRow row7item">
						<div class="sameLabelCss memoCss">메모</div>
						<input name="memo" placeholder="메모를 입력하세요..." />
					</div>
				</div>
				<div class="sameRow row8">
					<div class="sameRow row8item">
						<div class="cancle" onclick="modalCloseFnc(event)">취소</div>
						<div class="sameBtnCss c" onclick="insertClient(event)">등록</div>
						<div class="sameBtnCss u" onclick="updateClient(event)">수정</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	var insertValues = {
		client_name : '',
		ph : '',
		person : '',
		person_ph : '',
		zip : '',
		addr : '',
		detail_addr : '',
		biz_num : '',
		email : '',
		bank : '',
		bank_account : '',
		memo : '',
		cust_update_date : '',
		selectemailaddr : '',
		firstEmail : '',
		iSBN : ''
	}
	var searchClient = {
		client_name : '',
		cust_update_date : ''
	}

	//기본 세팅 데이터 함수
	initFnc();
	function initFnc() {
		firstEnterenceClientList();
	}

	function firstEnterenceClientList() {
		var callback = function(res) {
			searchUiUpdate(res.clientList);
		}
		var bodyData = searchClient;
		callAjax("/business/searchClientList.do", "post", "json", false,
				bodyData, callback);
	}

	function searchUiUpdate(clientList) {
		var detail = clientList; // 네트워크에서 받아오는 이름 보고 수정할 것	
		console.log(detail);
		$("#jsGrid")
				.jsGrid(
						{
							width : "100%",
							height : "400px",
							sorting : true,
							shrinkToFit : true,
							noDataContent : "검색 결과가 없습니다",
							paging : true,
							pageSize : 5,
							pageButtonCount : 5,
							data : detail, // 서버에서 받아온 데이터						
							fields : [ {
								name : "id",
								title : "번호",
								type : "number",
								align : "center",
								width : 30
							}, {
								name : "cust_update_date",
								title : "날짜",
								type : "number",
								align : "center",
								width : 40
							}, {
								name : "client_name",
								title : "거래처이름",
								type : "text",
								align : "center",
								width : 60
							}, {
								name : "person",
								title : "담당자",
								type : "text",
								align : "center",
								width : 50
							}, {
								name : "ph",
								title : "전화번호",
								type : "text",
								align : "center",
								width : 80
							}, {
								name : "person_ph",
								title : "핸드폰",
								type : "number",
								align : "center",
								width : 80
							}, {
								name : "email",
								title : "이메일",
								type : "text",
								align : "center",
								width : 110
							}, {
								name : "addr",
								title : "주소",
								type : "text",
								align : "center"
							}, {
								name : "memo",
								title : "메모",
								type : "text",
								align : "center"
							}, ],
							rowClick : function(args) {
								for ( var key in insertValues) {
									if (key === 'firstEmail') {
										insertValues.firstEmail = args.item.email
												.split('@')[0]
									} else {
										insertValues[key] = args.item[key]
									}
									$("input[name=" + key + "]").val(
											insertValues[key]);
								}
								var isbn = args.item.bank_account.split("-")[0];
								var emailHosting = args.item.email.split("@")[1];

								$('select option[value=' + isbn + ']').prop(
										'selected', true);
								$(
										'select[name="selectemailaddr"] option[value="'
												+ emailHosting + '"]').prop(
										'selected', true);
								//씨
								$('.c').addClass("btnTogle");
								$('.u').css({
									display : "block"
								})

								$('.titleheader').addClass("btnTogle");
								$('.updatetitleheader').css({
									display : "block"
								})

								insertValues.id = args.item.id
								addClientFnc(event);
							}
						});
	}

	//의심1
	$(document).on("change", "input[name='client_name']", function() {
		var name = $(this).prop("name");
		searchClient.client_name = $(this).val();

	});
	$(document).on("change", "input[name='cust_update_date']", function() {
		var name = $(this).prop("name");
		searchClient.cust_update_date = $(this).val();
	})

	function searchFnc(event) {

		/*  for ( var key in searchClient) {
			if (searchClient[key] === '') {
				alert("날짜와 업체명 모두를\n 기입해주세요");
				return;
			}
		}  */

		var callback = function(res) {
			searchUiUpdate(res.clientList);
		}

		var bodyData = searchClient;
		callAjax("/business/searchClientList.do", "post", "json", false,
				bodyData, callback);
	}

	//모달
	function addClientFnc(event) {

		$(".createPlanModal").addClass("openTogle");
		var defaultValue = $("select[name='selectemailaddr'] option:selected")
				.val();
		var defaultselecteISBN = $("select[name='selecteISBN'] option:selected")
				.val();
		var defaultselecteBank = $("select[name='selecteISBN'] option:selected")
				.text();
		$(".emailAddr").val(defaultValue);
		$(".iSBN").val(defaultselecteISBN);

		insertValues.selectemailaddr = defaultValue;
		insertValues.iSBN = defaultselecteISBN;
		insertValues.bank = defaultselecteBank;
	}

	//모달 닫기
	function modalCloseFnc(event) {
		$('.createPlanModal input').val('');
		$('.searchKeyWord input').val('');
		$(".createPlanModal").removeClass("openTogle");

		$(".c").removeClass("btnTogle");
		$(".u").css({
			display : "none"
		});

		$('.titleheader').removeClass("btnTogle");
		$('.updatetitleheader').css({
			display : "none"
		});
		delete insertValues.id;
		for ( var key in insertValues) {
			insertValues[key] = '';
		}
		for ( var key in searchClient) {
			searchClient[key] = '';
		}
	}
	function insertClient(event) {
		for ( var key in insertValues) {
			if ((key != 'memo' && key != 'cust_update_date' && key != 'firstEmail')
					&& insertValues[key] === '') {
				alert("필수항목을 입력하셔야합니다.\n 빨간색 아이콘이 표기된 \n 것은 필수 입력항목입니다.");
				return;
			}
		}

		var callback = function(res) {
			/* searchUiUpdate(res.clientList); */
			if (res.affectedRow >= 1) {
				alert("거래처 등록을 하였습니다.");
				window.location.replace("/business/client-list");
			}
		}
		var bodyData = insertValues;
		callAjax("/business/insertClientList.do", "post", "json", false,
				bodyData, callback);
	}
	function updateClient(event) {
		for ( var key in insertValues) {
			if ((key != 'memo' && key != 'cust_update_date' && key != 'firstEmail')
					&& insertValues[key] === '') {
				alert("모든 정보를 입력해주세요")
				return;
			}
		}
		var callback = function(res) {
			if (res.affectedRow >= 1) {
				alert("거래처 수정이 완료되었습니다.")
				window.location.replace("/business/client-list");
			}
		}
		var bodyData = insertValues;
		callAjax("/business/updateClientList.do", "post", "json", false,
				bodyData, callback);
	}
	//체인지
	function emailChangeFnc(e) {
		insertValues.email = '';
		$('.firstEmail').val('');
		var message = e.target.value;
		if (message === "text") {
			return;
		}
		$(".emailAddr").val(e.target.value);
	}
	function ibsbnChangeFnc(e) {
		insertValues.bank_account = '';
		$(".bankaccount").val('');
		var value = e.target.value;
		$(".iSBN").val(value);
		$("select[name='selecteISBN']").val(value);
		insertValues.iSBN = value;
	}

	// 모달창 의 체인지 이벤트 위임
	$(document).on("change", ".createPlanModal input", function() {
		var name = $(this).prop("name");
		var value = $(this).val();
		if (!Vail(name, value)) {
			return;
		}
		insertValues[name] = $(this).val();
	});
	$(document).on(
			"change",
			".createPlanModal select",
			function() {
				var name = $(this).prop("name");
				insertValues[name] = $(this).val();
				if (name === 'selecteISBN') {
					insertValues.bank = $(
							"select[name='selecteISBN'] option:selected")
							.text();
				}
			});
	//주소
	// findAddr() 함수 정의
	var elZonecode = document.querySelector("#zonecode");
	var elRoadAddress = document.querySelector("#roadAddress");
	var elRoadAddressDetail = document.querySelector("#roadAddressDetail");
	var elResults = document.querySelectorAll(".el_result input");

	// 주소검색창 열기 함수
	var onClickSearch = function() {
		new daum.Postcode({
			oncomplete : function(data) {
				insertValues.zip = data.zonecode;
				insertValues.addr = data.address;
				elZonecode.setAttribute("value", data.zonecode);
				elRoadAddress.setAttribute("value", data.address);
				$("input[name='zip']").val(data.zonecode);
				$("input[name='addr']").val(data.address);
			},
		}).open();
	};
	var register = function() {
		console.log("왓");
		console.log(elResults);
		elResults[0].innerHTML = elZonecode.getAttribute("value");
		elResults[1].innerHTML = elRoadAddress.getAttribute("value");
		elResults[2].innerHTML = elRoadAddressDetail.getAttribute("value");
	};
	// 이벤트 추가
	document.querySelector("#search-btn").addEventListener("click", function() {
		onClickSearch();
	});
	elRoadAddressDetail.addEventListener("change", function(e) {
		elRoadAddressDetail.setAttribute("value", e.target.value);
		register();
	});

	function Vail(name, value) {
		switch (name) {
		case 'memo':
			return true;
		case 'client_name':
			return true;
		case 'person':
			return true;
		case 'ph':
			phVail(name, value);
			return;
		case 'person_ph':
			handphVail(name, value);
			return;
		case 'firstEmail':
			if (insertValues.selectemailaddr !== '') {
				emailVail(name, value);
			} else {
				alert("먼저 이메일 주소를 입력해주세요");
			}
			return;
		case 'biz_num':
			bizNumVail(name, value);
			return;
		case 'detail_addr':
			if (insertValues.zip === '' || insertValues.addr === '') {
				alert('먼저 상단에 보이시는 ] /n 우편번호 찾기 버튼은을 클릭하신후 /n 상세주소를 입력해주세요');
				insertValues.detail_addr = ''
				$("input[name='detail_addr']").val('');
				return;
			}
			detailAddrVail(name, value);
			return;
		case 'bank_account':
			bankVail(name, value)
			return;
		}
	}

	function phVail(name, value) {
		// value가 숫자만 포함되어 있는지 확인
		if (!/^\d+$/.test(value)) {
			failMessage(name)
			insertValues.ph = ''
			return false; // 숫자 이외의 문자가 포함되었으면 종료
		}
		// 숫자만 있을 경우 길이가 7자리 또는 8자리인지 확인
		if (value.length === 7 || value.length === 8) {
			var lastFistIndx = value.length - 4;
			var firstLastIndx = lastFistIndx;
			insertValues.ph = $("#phfirst").val() + "-"
					+ value.slice(0, firstLastIndx) + "-"
					+ value.slice(lastFistIndx, value.length);
			//	$("#phfirst").val()+"-"
			return true; // 유효한 경우
		} else {
			failMessage(name)
			insertValues.ph = ''
			return false; // 유효하지 않은 경우
		}
	}
	function handphVail(name, value) {
		console.log(value);

		// value가 숫자만 포함되어 있는지 확인
		if (!/^\d+$/.test(value)) {
			alert("dd");
			failMessage(name);
			insertValues.person_ph = ''
			return false; // 숫자 이외의 문자가 포함되었으면 종료
		}
		// 숫자만 있을 경우 길이가 7자리 또는 8자리인지 확인
		if (value.length === 7 || value.length === 8) {
			//handphfirst
			var lastFistIndx = value.length - 4;
			var firstLastIndx = lastFistIndx;

			insertValues.person_ph = $("#handphfirst").val() + "-"
					+ value.slice(0, firstLastIndx) + "-"
					+ value.slice(lastFistIndx, value.length);
			return true; // 유효한 경우
		} else {
			failMessage(name)
			insertValues.person_ph = ''
			return false; // 유효하지 않은 경우
		}
	}
	function emailVail(name, value) {

		var regex = /^[A-Za-z][A-Za-z0-9]*$/;
		if (!regex.test(value)) {
			failMessage(name);
			insertValues.firstEmail = '';
			insertValues.email = '';
			return;
		}
		insertValues.email = value + '@' + insertValues.selectemailaddr;
	}
	function bizNumVail(name, value) {
		var regex = /^[0-9]{10}$/;

		if (!regex.test(value)) {
			failBizNumMessage(name)
			insertValues.biz_num = '';
			return;
		}

		var fisrt = value.slice(0, 3);
		var center = value.slice(3, 5);
		var last = value.slice(5, 10);
		insertValues.biz_num = fisrt + "-" + center + "-" + last;
	}

	function detailAddrVail(name, value) {

		var addressRegex = /^[A-Za-z0-9가-힣\s,.-]+$/;
		if (!addressRegex.test(value)) {
			failMessage(name)
			insertValues.detail_addr = ''
			return; // 유효하지 않음
		}
		insertValues.detail_addr = value;
	}

	$("input[name='biz_num']").on("input", function(event) {
		// 숫자 이외의 문자 제거하고, 다시 값 설정
		var currentValue = $(this).val();
		$(this).val(currentValue.replace(/[^0-9]/g, ''));
	});
	$("input[name='bank_account']").on("input", function(event) {
		// 숫자 이외의 문자 제거하고, 다시 값 설정
		var currentValue = $(this).val();
		$(this).val(currentValue.replace(/[^0-9]/g, ''));
	});

	function bankVail(name, value) {

		var regex;

		if (insertValues.iSBN === '110' || insertValues.iSBN === '123') {
			regex = /^[0-9]{9,10}$/;
		}
		if (insertValues.iSBN === '301') {
			regex = /^[0-9]{11}$/;
		}
		if (insertValues.iSBN === '001') {
			regex = /^[0-9]{7,9}$/;
		}
		if (!regex.test(value)) {
			failBanckMessage(name);
			insertValues.bank_account = ''
			return;
		}
		if (insertValues.iSBN === '110' || insertValues.iSBN === '123') {
			var lastStartIdx = value.length - 6;
			var firstLastIdx = lastStartIdx;

			insertValues.bank_account = insertValues.iSBN + "-"
					+ value.slice(0, firstLastIdx) + "-"
					+ value.slice(lastStartIdx, value.length);
		}
		if (insertValues.iSBN === '301') {
			insertValues.bank_account = insertValues.iSBN + "-"
					+ value.slice(0, 4) + "-" + value.slice(4, value.length);
		}

		//     3자리-4자리  
		//또는    3자리-2자리-4자리
		if (insertValues.iSBN === '001') {
			if (value.length == 7) {
				insertValues.bank_account = insertValues.iSBN + "-"
						+ value.slice(0, 3) + "-"
						+ value.slice(3, value.length);
			} else {
				insertValues.bank_account = insertValues.iSBN + "-"
						+ value.slice(0, 3) + "-" + value.slice(3, 5) + "-"
						+ value.slice(3, value.length);
			}
		}
	}
	//실패처리
	function failMessage(name) {
		console.log("실패 메시지 키:  " + name);
		switch (name) {
		case 'ph':
			failPhMessage(name)
			return;
		case 'person_ph':
			failPersonPhMessage(name)
			return;
		case 'firstEmail':
			failEmailMessage(name)
			return;
		case 'biz_num':
			if (insertValues.emailAddr !== '') {
				failBizNumMessage(name)
			}
		case 'detail_addr':
			failDetailAddrMessage(name)
			return;
		case 'bank_account':
			failBanckMessage(name);
			return;
		}
	}

	function failPhMessage(name) {
		alert("앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이")
		$("input[name='ph']").val('');
		$("input[name='ph']").attr("placeholder", "하이픈없이숫자만 입력해주세요!");
		$("input[name='ph']").addClass("failTogle");
	}

	function failPersonPhMessage(name) {
		alert("앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이\n앞자리 031 010 이런거  없이 그리고 하이픈 없이")

		$("input[name='person_ph']").val('');
		$("input[name='person_ph']").attr("placeholder", "하이픈없이숫자만 입력해주세요!");
		$("input[name='person_ph']").addClass("failTogle");
	}
	function failEmailMessage(name) {
		alert("\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음\n@ 필요없음")
		$("input[name='firstEmail']").val('');
		$("input[name='firstEmail']").attr("placeholder", "이메일 형식에 맞지 않습니다.");
		$("input[name='firstEmail']").addClass("failTogle");
	}
	function failBizNumMessage(name) {
		alert("열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자\n열개의숫자")

		$("input[name='biz_num']").val('');
		$("input[name='biz_num']").attr("placeholder",
				" 총 10개의 숫자를 하이픈없이 입력해주세요");
		$("input[name='biz_num']").addClass("failTogle");
	}
	function failDetailAddrMessage(name) {
		$("input[name='detail_addr']").val('');
		$("input[name='detail_addr']").attr("placeholder",
				" 건물명  동(몇차) 호수 로 입력해주세요 ex: XXX건물 1동 401호");
		$("input[name='detail_addr']").addClass("failTogle");
	}

	function failBanckMessage(name) {
		$("input[name='bank_account']").val('');
		$("input[name='bank_account']").attr("placeholder",
				"계좌 앞자리를 제외한 하이픈 없이 입력해주세요.");
		$("input[name='bank_account']").addClass("failTogle");
	}
</script>
</html>