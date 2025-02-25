<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>지출결의서 검토/조회</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" />
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script>

<script type="text/javascript">
$(function(){
	expenseSearch();
	searchBtnEvent();
});

function searchBtnEvent(){
	// 조회버튼
	$("#searchBtn").click(function(e){
		e.preventDefault();
		expenseSearch();
	});
	
	$("#searchGroup").click(function(e){
		e.preventDefault();
		
		var searchGroup = $(this).val();
		var param = {
				group_code : searchGroup,
		}
		
		var callback = function(res){
			$('#searchDetail').empty();
			var details = res.searchAccount;
			$('#searchDetail').append('<option value="">' + "전체" + '</option>');	
			details.forEach(function(detail) {
			    $('#searchDetail').append('<option value="' + detail.detail_code + '">' + detail.detail_name + '</option>');
			  });
		}
		
		callAjax("/account/expenseSearchDetail.do", "post", "json", false, param, callback);
	})	
	
	// 모달 버튼 등록
	$("a[name=btn]").click(function(e){
		e.preventDefault();
		
		// 버튼 id 속성(정보)
		var btnId = $(this).attr("id")
		
		switch(btnId){
			// id가 btnSaveExpense이면 저장			
			case "btnUpdateExpense" :
				expenseUpdate();
				break;
			case "btnOutputExpense" :
				expenseOutput();
				break;		
			case "btnClose" :
				gfCloseModal();
				break;
		}
	})
} 


function expenseSearch(currentPage){
	
	currentPage = currentPage || 1;
	
	var param = {			
			searchStDate : $("#searchStDate").val(),
			searchEdDate : $("#searchEdDate").val(),
			searchGroup : $("#searchGroup").val(),
			searchDetail : $("#searchDetail").val(),
			searchApproval : $("#searchApproval").val(),
			currentPage : currentPage,
			pageSize : 5
	}
	
	if(param.searchStDate > param.searchEdDate){
		alert("시작일은 종료일보다 먼저여야 합니다.");
		return;
	}
	
	var callback = function(res){
		var detail = res.expense;
		var expenseCnt= res.expenseCnt;
		
		$("#jsGrid").jsGrid({
			width: "100%",
			height: "250px",
			sorting: true,
			data: detail, // 서버에서 받아온 데이터
			fields: [
				{ name: "id", title: "결의번호", type: "text", width: 40, align: "center" },
				{ name: "req_date", title: "신청일자", type: "text", width: 70, align: "center" },
				{ name: "use_date", title: "사용일자", type: "text", width: 70, align: "center" },
				{ name: "emp_no", title: "사번", type: "text", width: 50, align: "center" },
				{ name: "name", title: "사원명", type: "text", width: 50, align: "center" },
				{ name: "group_name", title: "계정대분류명", type: "text", width: 100, align: "center" },
				{ name: "detail_name", title: "계정과목", type: "text", width: 80, align: "center" },
				{ name: "use_department", title: "사용부서", type: "text", width: 60, align: "center" },
				{ name: "expense_payment", title: "결의금액", type: "text", width: 80, align: "center", 
					itemTemplate: function(value) {
			        	return formatNumberWithComma(value);
			    	}
				},
				{ name: "is_approval", title: "승인여부", type: "text", width: 60, align: "center",
					itemTemplate: function(value) {
				        if (value === "W") {
				            return "검토 대기"; 
				        } else if (value === "N") {
				            return "반려"; 
				        } else if (value === "F") {
				            return "승인 대기";
				        }  else if (value === "S") {
				            return "승인";
				        }		
					}
				},
			],
			rowClick: function(args) {
				var item = args.item;
				var itemIndex = args.itemIndex;
				var isapproval;
				var approvalDate;
				if (item.approval_date === ""|| !item.approval_date) {
					approvalDate = ""; 
		        } 
				if (item.is_approval === "W") {
					isapproval = "검토 대기"; 
					$("#btnUpdateExpense").show();
					$(".view_isApproval").hide();
					$(".checkApproval").show();
					$(".crebitClass").show();
					$(".crebitSuccess").hide();
					$("#btnOutputExpense").hide();
					$("#view_approval_date").val('');	
		        } else if (item.is_approval === "N") {
		        	isapproval =  "반려"; 
		        	$("#btnUpdateExpense").hide();
		        	$(".view_isApproval").show();
					$(".checkApproval").hide();
					$("#view_isApproval").val(isapproval);		
					$(".crebitClass").hide();
					$(".crebitSuccess").hide();
					$("#.btnOutputExpense").hide();
					$("#view_approval_date").val('');	
		        } else if (item.is_approval === "F") {
		        	isapproval =  "승인 대기";
		        	$("#btnUpdateExpense").hide();
		        	$(".view_isApproval").show();
					$(".checkApproval").hide();
					$("#view_isApproval").val(isapproval);	
					$(".crebitClass").hide();
					$(".crebitSuccess").show();
					$("#crebitApproval").val(item.crebit_name);	
					$("#btnOutputExpense").hide();
					$("#view_approval_date").val('');	
		        }  else if (item.is_approval === "S") {
		        	isapproval =  "승인";
		        	$("#btnUpdateExpense").hide();
		        	$(".view_isApproval").show();
					$(".checkApproval").hide();
					$("#view_isApproval").val(isapproval);	
					$(".crebitClass").hide();
					$(".crebitSuccess").show();
					$("#crebitApproval").val(item.crebit_name);	
					$("#view_approval_date").val(item.approval_date);	
					$("#btnOutputExpense").show();
					$("#view_approval_date").val(item.approval_date);	
		        }
				
				$("#view_exp_id").val(item.id);	
				$("#view_request_date").val(item.req_date);	
				$("#view_use_date").val(item.use_date);	
				$("#view_emp_no").val(item.emp_no);	
				$("#view_emp_name").val(item.name);	
				$("#view_use_dept").val(item.use_department);	
				$("#view_accountGroup").val(item.group_name);	
				$("#view_accountDetail").val(item.detail_name);	
				$("#view_clientId").val(item.client_name);	
				$("#view_exp_pay").val(formatNumberWithComma(item.expense_payment));	
				$("#view_content").val(item.expense_content);	
				
				gfModalPop("#expenseModal");
			}
		}); 				
		var pageNavi = getPaginationHtml(currentPage, expenseCnt, 5, 10, "expenseSearch");
		$("#pageSize").html(pageNavi);		
	} ;	
	callAjax("/account/expenseList.do", "post", "json", false, param, callback);
}

function expenseOutput(){
	var param = {			
			checkApproval: $('input:radio[name="checkApproval"]:checked').val(),
			exp_id: $("#view_exp_id").val()
	}
	
	var opener = window.open("outputExpense",'지출결의서');
	opener.onload = function() {
		$(opener.document).find('#exp_id').text($('#view_exp_id').val());
		$(opener.document).find('#request_date').text($('#view_request_date').val());
		$(opener.document).find('#use_date').text($('#view_use_date').val());
		$(opener.document).find('#emp_name').text($('#view_emp_name').val());
		$(opener.document).find('#use_dept').text($('#view_use_dept').val());
		$(opener.document).find('#accountGroup').text($('#view_accountGroup').val());
		$(opener.document).find('#accountDetail').text($('#view_accountDetail').val());
		$(opener.document).find('#exp_pay').text(formatNumberWithComma($('#view_exp_pay').val()));
		$(opener.document).find('#expenseContent').text($('#view_content').val());
		$(opener.document).find('#sign_name').text($('#view_emp_name').val());
	}
}


function expenseUpdate(){
	var param = {			
			checkApproval: $('input:radio[name="checkApproval"]:checked').val(),
			exp_id: $("#view_exp_id").val(),
			detail_code: $("#crebitDetail").val()
	}
	
	var callback = function(res){
		if(res.result === "success"){
			alert("저장되었습니다.");
			gfCloseModal();
			expenseSearch();
		}else{
			alert("저장이 실패했습니다.");
		}
	}
	
	callAjax("/account/expenseUpdate.do", "post", "json", false, param, callback);
}


function download(){
	var expenseSeq = $("#view_exp_id").val();
	
	var hiddenInput = "<input type='hidden' name='expenseSeq' value='" + expenseSeq + "'/>";
	$("<form action='expenseDownload.do' method='post' id='fileDownload'> " + hiddenInput + " </form>").appendTo('body').submit().remove();
	
}

function formatNumberWithComma(value) {
    if (typeof value === "number") {
        return value.toLocaleString(); // 숫자 값을 3자리마다 콤마로 변환
    } 
    return value; // 숫자가 아닌 경우 그대로 반환
}
</script>
<style type="text/css">
textarea {
    resize: none;
  }
</style>
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
							<a href="#" class="btn_nav bold">회계</a> 
							<span class="btn_nav bold">지출결의서</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						
					<p class="conTitle" style="height: 110px">
						<span style="text-align: left; display: block;">지출결의서 검토</span> 
						<span >					
 	                         	 신청일자
 	                         <input type="date" id="searchStDate" name="searchStDate" style="height: 25px; margin-right: 10px;"/> 
                          
                          	<input type="date" id="searchEdDate" name="searchEdDate" style="height: 25px; margin-right: 10px;"/>
						 </span>    
						 <span style="margin: 0 20px;">					
 	                         	  승인여부
 	                         	 <select class="searchApproval" id="searchApproval" style="width: 80px;">
 	                         	 	<option value="">전체</option>
									<option value="W">검토 대기</option>
									<option value="F">승인 대기</option>
									<option value="S">승인</option>
									<option value="N">반려</option>
									</select>
						 </span>  
						<span>					
 	                         	 계정대분류
 	                         	 <select class="searchGroup" id="searchGroup" style="width: 80px;">
									<option value="">전체</option>
									<option value="AC03">온라인지출</option>
									<option value="AC04">영업지출</option>
									</select>
						 </span>
						 <span style="margin: 0 20px;">					
 	                         	 계정과목
 	                         	 <select class="searchDetail" id="searchDetail" style="width: 100px;">
									<option value="">전체</option>
									</select>
						 </span>						                   
						  <a class="btnType red" href="" name="searchbtn"  id="searchBtn"><span>조회</span></a>
						  
					</p> 
																		 
							 <div id="jsGrid"></div>
							 
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pageSize">
							</div>
											
						</div>

		
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
		
	
<!-- 조회모달팝업 -->
	<div id="expenseModal" class="layerPop layerType2" style="width: 1080px;"> 	
	<input type="hidden" id="view_name"/> 		
		<dl>
			<dt>
				<strong>지출결의서</strong>
			</dt>
			<dd class="content">
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row">결의번호</th>
							<td><input type="text" class="inputTxt p100"
								name="exp_id" id="view_exp_id"  readonly /></td>
								<th scope="row">신청일자</th>
							<td><input type="text" class="inputTxt p100"
								name="request_date" id="view_request_date"  readonly /></td>
								<th scope="row">사용일자 </th>
							<td><input type="text" class="inputTxt p100"
								name="use_date" id="view_use_date" readonly /></td>
						</tr>
						<tr>
							<th scope="row">사번</th>
							<td><input type="text" class="inputTxt p100"
								name="emp_no" id="view_emp_no"  readonly /></td>
							<th scope="row">사원명</th>
							<td><input type="text" class="inputTxt p100"
								name="emp_name" id="view_emp_name"  readonly /></td>
							<th scope="row">사용부서</th>
							<td><input type="text" class="inputTxt p100"
								name="use_dept" id="view_use_dept" readonly /></td>
						</tr>
						<tr id="writer">
							<th scope="row">계정대분류명</th>
							<td>
							<input  type="text" class="inputTxt p100"  id="view_accountGroup" readonly />									
							</td>
							<th scope="row">계정과목</th>
							<td>
							<input  type="text" class="inputTxt p100" name ="accountDetail" id="view_accountDetail" readonly />									
							</td>
							<th scope="row">거래처명</th>
							<td>
							<input  type="text" class="inputTxt p100" id="view_clientId" name="clientId" readonly />									
							</td>
						</tr>
						<tr>
							<th scope="row">결의금액</th>
							<td><input type="text" class="inputTxt p100"
								name="exp_pay" id="view_exp_pay" readonly /></td>
							<th scope="row">승인여부</th>
							<td class="view_isApproval">
							<input type="text" class="inputTxt p100"
								name="view_isApproval" id="view_isApproval"  readonly />
							</td>
							<td class="checkApproval">
							<input type="radio" 
								name="checkApproval" value="F"  checked="checked"/> 검토완료
								<input type="radio"  style="margin-left:20px"
								name="checkApproval" value="N" /> 반려
							</td>
							<th scope="row">승인일자</th>
							<td><input type="text" class="inputTxt p100"
								name="approval_date" id="view_approval_date"  readonly /></td>
						</tr>						
						<tr>
                        	<th scope="row">첨부파일</th>
                        	<td><a href='javascript:download()'>다운로드</a></td>                        	
							<th class="crebitClass" scope="row">대변 계정과목 <span class="font_red">*</span></th>
							<td class="crebitClass"><select class="crebitDetail" name ="crebitDetail" id="crebitDetail" style="width: 100px">									
								<c:forEach items="${crebitList}" var="list">
									<option value= ${list.detail_code} > ${list.detail_name} </option>
								</c:forEach>		
									</select>
							</td>
							<th class="crebitSuccess" scope="row">대변 계정과목</th>
							<td class="crebitSuccess">
								<input type="text" class="inputTxt p100" name ="crebitApproval" id="crebitApproval" style="width: 100px" readonly />								
							</td>
                     	</tr>
						<tr>
							<th scope="row">비고</th>
							<td colspan="5">
								<textarea name="expenseContent"
                              id="view_content" cols="40" rows="5" readonly> </textarea>
							</td>
						</tr>
					</tbody>
				</table>

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnOutputExpense" name="btn"><span>지출결의서 출력</span></a> 
					<a href="" class="btnType blue" id="btnUpdateExpense" name="btn"><span>검토완료</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	
	
</body>
</html>