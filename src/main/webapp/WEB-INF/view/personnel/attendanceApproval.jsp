<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 근태 조회  및 승인</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" />
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script>

<script type="text/javascript">
	var userIdx = "${sessionScope.user_idx}";
	var userType = "${sessionScope.userType}";	
	$(function(){
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
				case "btnFirstApprove" :
					attendanceFirstApprove();
					break;
				case "btnSecondApprove" :					
					attendanceSecondApprove();
					break;
				case "btnAttendanceReject" :
					attendanceReject();
					break;
				case "btnClose" :
					gfCloseModal();
					window.location.reload();
					break;
			}
		});
	} 
	
	function attendanceReqeustListSearch(currentPage){		
		currentPage = currentPage || 1;
		
		var param = {
				searchNumber: $("#searchNumber").val(),
				searchName: $("#searchName").val(),
				searchStDate : $("#searchStDate").val(),
				searchEdDate : $("#searchEdDate").val(),
				searchReqStatus : $("#searchReqStatus").val(),
				currentPage : currentPage,
				pageSize : 5
		}
		// 요청이 끝나고 실행되는 함수
		var callback = function(res){
			var detail = res.attendanceList;
			var attendanceRequestCnt = res.attendanceRequestCnt;
			$("#requestList").jsGrid({
				width: "100%",
				height: "auto",
		        sorting: true,
		        noDataContent: "검색 결과가 없습니다",
		        rownumbers : true,
				data: detail, // 서버에서 받아온 데이터
				fields: [
					{ name: "id", title: "번호", type: "number", width: 50, align: "center" },
					{ name: "reqType", title: "연자종류", type: "text", width: 80, align: "center" },
					{ name: "number", title: "사번", type: "text", width: 80, align: "center" },
					{ name: "name", title: "사원명", type: "text", width: 100, align: "center" },
					{ name: "reqSt", title: "시작일", type: "text", width: 80, align: "center" },
					{ name: "reqEd", title: "종료일", type: "text", width: 80, align: "center" },
					{ name: "appType", title: "결재자", type: "text", width: 80, align: "center" },
					{ name: "reqStatus", title: "승인상태", type: "text", width: 100, align: "center"},					
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
	
	function attendanceDetailModal(itemIndex){		
		var param = {
				id : itemIndex
		}		
		var callback = function(res){
			var detail = res.detail;
			console.log(detail.attAppId)
			$("#viewDeptName").val(detail.deptName);
			$("#viewEmpName").val(detail.name);
			$("#viewNumber").val(detail.number);
			$("#viewReqType").val(detail.reqType);
			$("#viewReqSt").val(detail.reqSt);
			$("#viewReqEd").val(detail.reqEd);
			$("#viewReqTel").val(detail.reqTel);
			$("#viewReqReason").val(detail.reqReason);
			$("#viewReqdate").val(detail.reqdate);
			$("#reqStatus").val(detail.reqStatus);
			$("#attAppId").val(detail.attAppId);
			$("#approReason").val(detail.appReason);
			$("#reqId").val(itemIndex);
			
			if(detail.reqStatus === '승인'){
				$("#btnFirstApprove").hide();
				$("#btnSecondApprove").hide();
				$("#btnAttendanceReject").hide();
			}else if(detail.reqStatus === '반려'){
				$("#btnFirstApprove").hide();
				$("#btnSecondApprove").hide();
				$("#btnAttendanceReject").hide();
			}else if(detail.reqStatus === '취소'){
				$("#btnFirstApprove").hide();
				$("#btnSecondApprove").hide();
				$("#btnAttendanceReject").hide();
			}else if(detail.reqStatus === '승인 대기'){
				$("#btnFirstApprove").hide();				
			}else if(detail.reqStatus === '검토 대기'){
				$("#btnSecondApprove").hide();
			}
			
			gfModalPop("#attendanceDetailModal");
		}
		
		callAjax("/personnel/attendanceDetail.do", "post", "json", false, param, callback);
	}
	
	function attendanceFirstApprove(){
		var reqStatus = $("#reqStatus").val()		
		var param = {
				reqId: $("#reqId").val(),
				userIdx: userIdx,
				appReason: $("#appReason").val()
		}		
		var callback = function(res){
			if(res.result === "success"){
				alert("승인되었습니다.");
				gfCloseModal();
				attendanceReqeustListSearch();
			}
		}
		callAjax("/personnel/attendanceFirstApprove.do", "post", "json", false, param, callback);
	}
	
	function attendanceSecondApprove(){
		var reqStatus = $("#reqStatus").val();
		var attAppId = $("#attAppId").val();		
		var param = {
				reqId: $("#reqId").val(),
				userIdx: userIdx,
		}		
		var callback = function(res){
			if(res.result === "success"){
				alert("승인되었습니다.");
				gfCloseModal();
				attendanceReqeustListSearch();
			}
		}
		callAjax("/personnel/attendanceSecondApprove.do", "post", "json", false, param, callback);
	}
	
	function attendanceReject(){
		var reqStatus = $("#reqStatus").val();
		var attAppId = $("#attAppId").val();
		
		if (reqStatus === '승인 대기'){
			var approReason = $("#approReason").val().trim();
			if (approReason === ""){
				alert("반려 사유는 비워둘 수 없습니다.");
				return;
			} 
			param = {
					id: attAppId,
					reqId: $("#reqId").val(),
					userIdx: userIdx,
					appReason: $("#approReason").val()
			}			
			var callback = function(res){				
				if(res.result === "success"){
					alert("반려되었습니다.");					
				}else if(res.result === "fail"){
					alert("반려에 실패했습니다.");				
				}
				gfCloseModal();
				attendanceReqeustListSearch();
			}
			callAjax("/personnel/attendanceApproveReject.do", "post", "json", false, param, callback)
		} else if (reqStatus === '검토 대기'){			
			var approReason = $("#approReason").val().trim();
			if (approReason === ""){
				alert("반려 사유는 비워둘 수 없습니다.");
				return;
			} 
			param = {
				reqId: $("#reqId").val(),
				userIdx: userIdx,
				appReason: $("#approReason").val()
			} 
			
			var callback = function(res){				
				if(res.result === "success"){
					alert("반려되었습니다.");				
				}else if(res.result === "fail"){
					alert("반려에 실패했습니다.");				
				}
				gfCloseModal();
				attendanceReqeustListSearch();
			}			
			callAjax("/personnel/attendanceReject.do", "post", "json", false, param, callback)			
		} 		
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
							<span class="btn_nav bold">근태 조회 및 승인</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						
					<p class="conTitle" style="height: 110px;">
						<span style="display: block;">근태 조회 및 승인</span> 
						<span class="fr">					
                          	기간
                          <input type="date" id="searchStDate" name="searchStDate" style="height: 25px;"/> 
                          ~ 
                          <input type="date" id="searchEdDate" name="searchEdDate" style="height: 25px;"/>
                          	사번
                          	<input type="text" id="searchNumber" name="searchNumber" style="height: 25px; margin-right: 10px;" size="15"/>
                          	사원명
                          	<input type="text" id="searchName" name="searchName" style="height: 25px; margin-right: 10px;" size="15"/>
                          	승인 상태
                          	<select id="searchReqStatus" name="searchReqStatus" size="1">
                          	<option value="">전체</option>
                          	<option value="검토 대기">검토 대기</option>
							<option value="승인 대기">승인 대기</option>
							<option value="승인">승인</option>
							<option value="반려">반려</option>							
                          	</select>
						  <a class="btnType red" href="" name="searchbtn"  id="searchBtn"><span>검색</span></a>
						</span>
					</p>						
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
	<div id="attendanceDetailModal" class="layerPop layerType2" style="width: 600px;"> 
		<input type="hidden" id="reqId"/>
		<input type="hidden" id="reqStatus"/>
		<input type="hidden" id="attAppId"/>
		<dl>
			<dt>
				<strong>연차 신청 상세 보기</strong>
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
								name="viewReqType" id="viewReqType" readonly/></td>
						</tr>
						<tr>
							<th scope="row">기간</th>
							<td colspan="3">								
                          		<input type="date" id="viewReqSt" name="viewReqSt" style="height: 30px; width: 120px;" readonly/> 
                          		~ 
                          		<input type="date" id="viewReqEd" name="viewReqEd" style="height: 30px; width: 120px;" readonly/>
							</td>
						</tr>
						<tr>
							<th scope="row">신청사유</th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="viewReqReason" id="viewReqReason" readonly></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row">사유</th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="approReason" id="approReason"></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row">비상연락처</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="viewReqTel" id="viewReqTel" readonly/></td>
						</tr>
						<tr>					
							<th scope="row">신청일</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="viewReqdate" id="viewReqdate" readonly/></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<c:if test="${userType eq 'A'}"> 
					<a href="" class="btnType blue" id="btnFirstApprove" name="btn"><span>승인</span></a>
					</c:if>
					<c:if test="${userType eq 'C'}">
					<a href="" class="btnType blue" id="btnSecondApprove" name="btn"><span>승인</span></a>
					</c:if> 
					<a href="" class="btnType blue" id="btnAttendanceReject" name="btn"><span>반려</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>
	
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
</body>
</html>
