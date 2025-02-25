<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 근태 조회  </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" />
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script>

<script type="text/javascript">
	var userIdx = "${sessionScope.user_idx}";
	var leftAttCnt;
	var attId;	
	$(function(){
		document.getElementById('reqdate').value = new Date().toISOString().substring(0, 10);		
		attendanceSearch();
		attendanceReqeustListSearch();
		registerBtnEvent();
	});
	
	function registerBtnEvent(){
		// 조회버튼
		$("#searchBtn").click(function(e){
			e.preventDefault();
			attendanceReqeustListSearch();
		});		
		
		// 모달 버튼 등록
		$("a[name=btn]").click(function(e){
			e.preventDefault();
			// 버튼 id 속성(정보)
			var btnId = $(this).attr("id")			
			switch(btnId){
				// id가 btnSaveNotice이면 저장				
				case "btnSaveAttendance" :					
					attendanceRequest();
					break;
				case "btnUpdateAttendance" :
					attendanceRequestUpdate();
					break;
				case "btnCancleAttendance" :
					attendanceRequestCancle();
					break;
				case "btnClose" :
					gfCloseModal();
					window.location.reload();
					break;
			}
		});
	} 
	
	function attendanceSearch(){
		var param = {
			userIdx : userIdx
		}
		var callback = function(res){			
			var detail = res.attendanceCnt;
			if (detail.length > 0) {
				attId = detail[0].id;				
				leftAttCnt = detail[0].leftAttCnt;
			}
			$("#attendanceCnt").jsGrid({
				width: "100%",
				noDataContent: "인사 관리팀으로 문의 해주세요.",
				data: detail, // 서버에서 받아온 데이터
				fields:[
				        {name: "attCnt", title: "총연차", type: "number", width: 50, align: "center"},
				        {name: "useAttCnt", title: "사용연차", type: "number", width: 50, align: "center"},
				        {name: "leftAttCnt", title: "남은연차", type: "number", width: 50, align: "center"},
				        ],				       
			});			
		}		
		callAjax("/personnel/attendanceCnt.do", "post", "json", false, param, callback);
	}
	
	function attendanceReqeustListSearch(currentPage){		
		currentPage = currentPage || 1;
		var param = {
				userIdx : userIdx,
				searchStDate : $("#searchStDate").val(),
				searchEdDate : $("#searchEdDate").val(),
				searchReqStatus : $("#searchReqStatus").val(),
				searchReqType : $("#searchReqType").val(),
				currentPage : currentPage,
				pageSize : 5
		}
		var callback = function(res){
			var detail = res.attendanceList;
			var attendanceRequestCnt = res.attendanceRequestCnt;			
			$("#requestList").jsGrid({
				width: "100%",
				height: "auto",
		        sorting: true,		        
		        noDataContent: "검색 결과가 없습니다.",		        
				data: detail, // 서버에서 받아온 데이터
				fields: [
					{ name: "id", title: "번호", type: "number", width: 50, align: "center" },
					{ name: "reqType", title: "연자종류", type: "text", width: 80, align: "center" },
					{ name: "number", title: "사번", type: "text", width: 80, align: "center" },
					{ name: "name", title: "사원명", type: "text", width: 100, align: "center" },
					{ name: "reqSt", title: "시작일", type: "text", width: 80, align: "center" },
					{ name: "reqEd", title: "종료일", type: "text", width: 80, align: "center" },
					{ name: "appType", title: "결재자", type: "text", width: 80, align: "center" },
					{ name: "reqStatus", title: "승인상태", type: "text", width: 100, align: "center" },
					{ title: "반려", type: "text", width: 100, align: "center" ,
						itemTemplate: function(_, item) {
						    if (!item.appReason || item.appReason.trim() === "") {
						        return "-";  // 버튼을 숨기기 위해 빈 문자열 반환
						    } else {
						        return $("<button>").text("반려사유").on("click", function(event) {
						            // event.stopPropagation()으로 rowClick 이벤트 전파를 막음
						            event.stopPropagation(); 
						            var itemId = item.id;
						            attendanceRejectReasonModal(itemId);
						        });
						    }
						}
					}
				],
				rowClick: function(args) {
					var item = args.item;
					var itemIndex = args.item.id;
					
					attendanceDetailModal(itemIndex);
				}
			});
			var pageNavi = getPaginationHtml(currentPage, attendanceRequestCnt, 5, 10, "attendanceReqeustListSearch");
			$("#pageSize").html(pageNavi);
		};		
		callAjax("/personnel/attendanceList.do", "post", "json", false, param, callback);
	}	
	
	function validateAttendanceRequest(startDate, endDate, reqReason, reqTel, reqType, isUpdate) {
		isUpdate = isUpdate || false; // 
		
	    if (!startDate || !endDate) {
	        alert("신청 일자를 선택해 주세요.");
	        return false;
	    }
	    var stDate = new Date(startDate);
	    var edDate = new Date(endDate);
	    var reqDay = (edDate - stDate) / (1000 * 60 * 60 * 24) + 1;
	    if (reqDay < 1) {
	        alert("시작일이 종료일보다 나중일 수 없습니다.");
	        return false;
	    }
	    if (reqDay > leftAttCnt) {
	        alert("신청 가능한 연차 일수가 부족합니다.");
	        return false;
	    }
	    if (stDate.getDay() === 6 || stDate.getDay() === 0 || edDate.getDay() === 6 || edDate.getDay() === 0) {
	        alert("주말에는 신청할 수 없습니다.");
	        return false;
	    }
	    var weekdays = 0;
	    var currentDate = new Date(stDate);
	    while (currentDate <= edDate) {
	        if (currentDate.getDay() !== 6 && currentDate.getDay() !== 0) {
	            weekdays++;
	        }
	        currentDate.setDate(currentDate.getDate() + 1);
	    }	    
	    if (!isUpdate) reqDay = weekdays;
	    if (reqReason.trim() === "") {
	        alert("신청 사유는 비워둘 수 없습니다.");
	        return false;
	    }
	    if (reqTel.trim() === "") {
	        alert("전화번호를 입력해주세요.");
	        return false;
	    }
	    var telPattern = /^010-\d{4}-\d{4}$/;
	    if (!telPattern.test(reqTel)) {
	        alert("전화번호 형식이 올바르지 않습니다.");
	        return false;
	    }
	    if (reqType === "반차") {
	        if (startDate !== endDate) {
	            alert("반차 신청은 같은 날짜만 선택 가능합니다.");
	            return false;
	        }
	        if (stDate.getDay() === 6 || stDate.getDay() === 0) {
	            alert("주말에는 신청할 수 없습니다.");
	            return false;
	        }
	        reqDay = 0.5;
	    }
	    return reqDay;
	}
	
	function attendanceRequest(){		
		var startDate = $("#reqSt").val();
	    var endDate = $("#reqEd").val();
	    var reqReason = $("#reqReason").val();
	    var reqTel = $("#reqTel").val();
	    var reqType = $("#reqType").val();

	    var reqDay = validateAttendanceRequest(startDate, endDate, reqReason, reqTel, reqType);
	    if (!reqDay) return;
	    
	    var param = {
	    		attId: attId,
	            empId: userIdx,
	            name: $("#empName").val(),
	            number: $("#number").val(),
	            reqType: reqType.trim(),
	            reqSt: startDate,
	            reqEd: endDate,
	            reqReason: reqReason,
	            reqTel: reqTel,
	            reqdate: $("#reqdate").val(),
	            reqDay: reqDay,
		}	   
	    
		var callback = function(res){
			if(res.result === "success"){
				alert("저장되었습니다.");				
			} else if(res.result === "fail"){
				alert("이미 신청된 날짜입니다");				
			}
			gfCloseModal();
			attendanceReqeustListSearch();
		}		
		callAjax("/personnel/attendanceRequest.do", "post", "json", false, param, callback);
	}
	
	function checkRemainingAttendance(leftAttCnt) {		
	    if (leftAttCnt <= 0) {
	        alert("남은 연차가 없습니다.");
	        return false;
	    }
	    return true;
	}
	
	function insertModal(){		
	    if (!checkRemainingAttendance(leftAttCnt)) {	    	
	        return;  
	    }	    
	    $("#reqSt").val("");
	    $("#reqEd").val("");
	    $("#reqReason").val("");
	    $("#reqTel").val("");
		gfModalPop("#attendanceRequestModal");		
	}
	
	function attendanceDetailModal(itemIndex){		
		var param = {
				id : itemIndex
		}
		var callback = function(res){
			console.log(res)
			var detail = res.detail;
			$("#viewDeptName").val(detail.deptName);
			$("#viewEmpName").val(detail.name);
			$("#viewNumber").val(detail.number);
			$("#viewReqType").val(detail.reqType);
			$("#viewReqSt").val(detail.reqSt);
			$("#viewReqEd").val(detail.reqEd);
			$("#viewReqTel").val(detail.reqTel);
			$("#viewReqReason").val(detail.reqReason);
			$("#viewReqdate").val(detail.reqdate);
			$("#reqId").val(itemIndex);
			$("#reqStatus").val(detail.reqStatus);
			$("#candate").val(detail.candate);
			
			if(detail.reqStatus == '승인'){
				$("#btnUpdateAttendance").hide();				
			}else if(detail.reqStatus == '취소'){
				$("#btnUpdateAttendance").hide();
				$("#btnCancleAttendance").hide();
			}else if(detail.reqStatus == '승인 대기'){
				$("#btnUpdateAttendance").hide();
			}else if(detail.reqStatus == '반려'){
				$("#btnUpdateAttendance").hide();
				$("#btnCancleAttendance").hide();
			}
			
			if(detail.candate == null || detail.candate == ''){
				$("#candate").closest("tr").hide();
			}
			gfModalPop("#attendanceDetailModal");
		}		
		callAjax("/personnel/attendanceDetail.do", "post", "json", false, param, callback);
	}
	
	function attendanceRejectReasonModal(itemId){
		var param = {
				id : itemId
		}		
		var callback = function(res){			
			var detail = res.detail;			
			$("#viewAppType").val(detail.appType);
			$("#appReason").val(detail.appReason);			
			
			gfModalPop("#attendanceRejectReasonModal");
		}		
		callAjax("/personnel/attendanceDetail.do", "post", "json", false, param, callback);
	}	
	
	function attendanceRequestUpdate(){
		var startDate = $("#viewReqSt").val();
	    var endDate = $("#viewReqEd").val();
	    var reqReason = $("#viewReqReason").val();
	    var reqTel = $("#viewReqTel").val();
	    var reqType = $("#viewReqType").val();

	    if (reqType === "반차") {
	        alert("반차는 수정 불가 합니다.");
	        return;
	    }

	    var reqDay = validateAttendanceRequest(startDate, endDate, reqReason, reqTel, reqType, true);
	    if (!reqDay) return;
	    
	    var param = {
	            reqId: $("#reqId").val(),
	            reqSt: startDate,
	            reqEd: endDate,
	            reqReason: reqReason,
	            reqTel: reqTel,
	    };	
		var callback = function(res){
			if(res.result === "success"){
				alert("수정되었습니다.");
				gfCloseModal();
				attendanceReqeustListSearch();
			}
		};
		callAjax("/personnel/attendanceUpdate.do", "post", "json", false, param, callback);
	}
	
	function attendanceRequestCancle(){
		var reqStatus = $("#reqStatus").val();
		var param = {
				reqId: $("#reqId").val()
		}
		
		var callback = function(res){
			if(res.result === "success"){
				alert("취소되었습니다.");				
			}else if(res.result === "fail"){
				alert("수정 실패하였습니다.");				
			}
			gfCloseModal();
			attendanceReqeustListSearch();
		}
		callAjax("/personnel/attendanceCancle.do", "post", "json", false, param, callback);
	}
</script>
</head>
<body>
	<input type="hidden" id="currentPage" value="1">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="attId" id="attId" >
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
							<span class="btn_nav bold">근태 신청</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						
					<p class="conTitle" style="height: 110px;">
						<span style="display: block;">근태 신청</span> 
						<span class="fr">					
                          	기간
                          <input type="date" id="searchStDate" name="searchStDate" style="height: 25px; margin-right: 10px;"/> 
                          ~ 
                          <input type="date" id="searchEdDate" name="searchEdDate" style="height: 25px; margin-right: 10px;"/>
                          	 연차 타입
                          	 <select id="searchReqType" name="searchReqType" size="1">
                          	 <option value="">전체</option>
							 <option value="연차">연차</option>
							 <option value="반차">반차</option>
                          	 </select>
                          	승인 상태
                          	<select id="searchReqStatus" name="searchReqStatus" size="1">
                          	<option value="">전체</option>
                          	<option value="검토 대기">검토 대기</option>
							<option value="1차 승인">승인 대기</option>
							<option value="승인">승인</option>
							<option value="반려">반려</option>
							<option value="취소">취소</option>
                          	</select>
						  <a class="btnType red" href="" name="searchbtn"  id="searchBtn"><span>검색</span></a>
						  <a class="btnType blue" href="javascript:insertModal();" name="modal"><span>등록</span></a>
						</span>
					</p> 
																		
						<div id="attendanceCnt"></div>
						
						<br>
						
						<div id="requestList"></div>
						<div class="paging_area" id="pageSize">
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>


	<!-- 모달팝업 -->
	<div id="attendanceRequestModal" class="layerPop layerType2" style="width: 600px;">	
			
		<dl>
			<dt>
				<strong>연차 신청</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row">근무부서</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="deptName" id="deptName" value="${lgnInfo.detail_name}" readonly/></td>
						</tr>
						<tr>
							<th scope="row">성명 </th>
							<td><input type="text" class="inputTxt p100" name="empName" id="empName" value="${lgnInfo.usr_nm}" readonly/></td>
						</tr>
						<tr>
							<th scope="row">사번</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="number" id="number"  value="${lgnInfo.usr_idx}" readonly/></td>
						</tr>
						<tr>
						    <th scope="row">연/반차<span class="font_red">*</span></th>
						    <td colspan="3">
						        <select id="reqType" name="reqType" size="1">
						            <option value="연차">연차</option>
						            <option value="반차">반차</option>
						        </select>
						    </td>
						</tr>
						<tr>
							<th scope="row">기간<span class="font_red">*</span></th>
							<td colspan="3">								
                          		<input type="date" id="reqSt" name="reqSt" style="height: 30px; width: 120px;"  /> 
                          		~ 
                          		<input type="date" id="reqEd" name="reqEd" style="height: 30px; width: 120px;"/>
							</td>
						</tr>
						<tr>
							<th scope="row">신청사유<span class="font_red">*</span></th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="reqReason" id="reqReason"></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row">비상연락처<span class="font_red">*</span></th>
							<td colspan="3"><input type="tel" class="inputTxt p100"
								name="reqTel" id="reqTel" placeholder="010-0000-0000"/></td>
						</tr>
						<tr>					
							<th scope="row">신청일</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="reqdate" id="reqdate" disabled /></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveAttendance" name="btn"><span>연차 신청</span></a>
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>
	
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!-- 모달팝업 -->
	<div id="attendanceDetailModal" class="layerPop layerType2" style="width: 600px;"> 
		<input type="hidden" id="reqId"/>
		<input type="hidden" id="reqStatus"/>
		<dl>
			<dt>
				<strong>연차 신청 상세</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<tbody>
						<tr>
							<th scope="row">근무부서</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="viewDeptName" id="viewDeptName" readonly/></td>
						</tr>
						<tr>
							<th scope="row">성명 </th>
							<td><input type="text" class="inputTxt p100" name="viewEmpName" id="viewEmpName" readonly /></td>
						</tr>
						<tr>
							<th scope="row">사번</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="viewNumber" id="viewNumber" readonly/></td>
						</tr>
						<tr>
						    <th scope="row">연/반차</th>
						    <td colspan="3"><input type="text" class="inputTxt p100"
								name="viewReqType" id="viewReqType" /></td>
						</tr>
						<tr>
							<th scope="row">기간</th>
							<td colspan="3">								
                          		<input type="date" id="viewReqSt" name="viewReqSt" style="height: 30px; width: 120px;"  /> 
                          		~ 
                          		<input type="date" id="viewReqEd" name="viewReqEd" style="height: 30px; width: 120px;"/>
							</td>
						</tr>
						<tr>
							<th scope="row">신청사유</th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="viewReqReason" id="viewReqReason"></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row">비상연락처</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="viewReqTel" id="viewReqTel" /></td>
						</tr>						
						<tr>					
							<th scope="row">신청일</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="viewReqdate" id="viewReqdate" disabled /></td>
						</tr>												
						<tr>					
							<th scope="row">취소일</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="candate" id="candate" disabled /></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30"> 
					<a href="" class="btnType blue" id="btnUpdateAttendance" name="btn"><span>수정</span></a> 
					<a href="" class="btnType blue" id="btnCancleAttendance" name="btn"><span>신청취소</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>
	
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<div id="attendanceRejectReasonModal" class="layerPop layerType2" style="width: 600px;"> 
		<dl>
			<dt>
				<strong>반려 사유</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row">결재자</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="viewAppType" id="viewAppType" readonly/></td>
						</tr>
						<tr>
							<th scope="row">반려 사유</th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="appReason" id="appReason"></textarea>
							</td>
						</tr>						
					</tbody>
				</table>
				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>
	
		</dl>
	</div>
	
</body>
</html>
