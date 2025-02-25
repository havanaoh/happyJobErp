<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>계정과목 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" />
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script>

<script type="text/javascript">
$(function(){
	accountSearch();
	searchBtnEvent();
});

function searchBtnEvent(){
	// 조회버튼
	$("#searchBtn").click(function(e){
		e.preventDefault();
		accountSearch();
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
		
		callAjax("/account/accountSearchDetail.do", "post", "json", false, param, callback);
	})
	
	// 모달 버튼 등록
	$("a[name=btn]").click(function(e){
		e.preventDefault();
		
		// 버튼 id 속성(정보)
		var btnId = $(this).attr("id")
		
		switch(btnId){
			// id가 btnSaveAccount이면 저장
			case "btnSaveAccount" :
				accountSave();
				break;
			case "btnUpdateAccount" :
				accountUpdate();
				break;
			case "btnDeleteAccount" :
				accountDelete();
				break;
			case "btnSavefile" :
				accountFileSave();
				break;
			case "btnUpdatefile" :
				accountFileUpdate();
				break;
			case "btnDeletefile" :
				accountDelete();
				break;
			case "btnClose" :
				gfCloseModal();
				break;
		}
	})
} 

function accountSearch(currentPage){
	
	currentPage = currentPage || 1;
	
	var param = {
			searchGroup : $("#searchGroup").val(),
			searchDetail : $("#searchDetail").val(),
			searchCode_type : $("#searchCode_type").val(),
			searchUse_yn : $("#searchUse_yn").val(),
			currentPage : currentPage,
			pageSize : 5
	}
	
	var callback = function(res){
		var detail = res.account;
		var accountCnt= res.accountCnt;
		
		$("#jsGrid").jsGrid({
			width: "100%",
			height: "250px",
			sorting: true,
			data: detail, // 서버에서 받아온 데이터
			fields: [
				{ name: "group_code", title: "계정대분류코드", type: "text", width: 40, align: "center" },
				{ name: "group_name", title: "계정대분류명", type: "text", width: 70, align: "center" },
				{ name: "detail_code", title: "계정세부코드", type: "text", width: 40, align: "center" },
				{ name: "detail_name", title: "계정세부명", type: "text", width: 70, align: "center" },
				{ name: "code_type", title: "구분", type: "text", width: 40, align: "center" },
				{ name: "content", title: "상세내용", type: "text", width: 120, align: "center" },
				{ name: "use_yn", title: "사용여부", type: "text", width: 30, align: "center" },
			],
			rowClick: function(args) {
				var item = args.item;
				var itemIndex = args.itemIndex;
								
				$("#tr_use_yn").show();
				$("#updateAccountGroup").show();
				$("#insertAccountGroup").hide();
				$("#btnSaveAccount").hide();
				$("#btnUpdateAccount").show();
				$("#btnDeleteAccount").show();	
				
				$("#updateAccountGroup").val(item.group_name);
				$("#accountDetail").val(item.detail_name);
				$("#accountContent").val(item.content);
				$("#use_yn").val(item.use_yn);
				$("#code_type").val(item.code_type);
				$("#detail_code").val(item.detail_code);		
				$("#group_code").val(item.group_code);	
				
				gfModalPop("#accountInsertModal");
			}
		}); 
		
		
		
		var pageNavi = getPaginationHtml(currentPage, accountCnt, 5, 10, "accountSearch");
		$("#pageSize").html(pageNavi);
		
	} ;
	
	callAjax("/account/accountList.do", "post", "json", false, param, callback);
}

// 신규 등록 모달
function insertModal(){
	// 신규 등록 모달에 대한 조건
	$("#tr_use_yn").hide();
	$("#updateAccountGroup").hide();
	$("#insertAccountGroup").show();
	$("#btnSaveAccount").show();
	$("#btnUpdateAccount").hide();
	$("#btnDeleteAccount").hide();
	$("#code_type").val("수입");
	$("#accountDetail").val("");
	$("#accountContent").val("");
	
	gfModalPop("#accountInsertModal");
}


function accountSave(){
	var param = {
			group_code: $("#insertAccountGroup").val(),
			detail_name: $("#accountDetail").val(),
			use_Yn: $("#use_yn").val(),
			code_type: $("#code_type").val(),
			content: $("#accountContent").val(),
	}
	
	
        if (param.detail_name === null || param.detail_name === "") {
            alert("필수 입력 항목을 입력해주세요.");
            return;  // 유효성 검사 실패 시 함수 종료
        }
   
	
	var callback = function(res){
		if(res.result === "success"){
			alert("저장되었습니다.");
			gfCloseModal();
			accountSearch();
		}
	}
	
	callAjax("/account/accountSave.do", "post", "json", false, param, callback);
}

function accountUpdate(){
	var param = {
			detail_name: $("#accountDetail").val(),
			use_Yn: $("#use_yn").val(),
			code_type: $("#code_type").val(),
			content: $("#accountContent").val(),
			detail_code: $("#detail_code").val()
	}
	
	var callback = function(res){
		if(res.result === "success"){
			alert("수정되었습니다.");
			gfCloseModal();
			accountSearch();
		}
	}
	
	callAjax("/account/accountUpdate.do", "post", "json", false, param, callback);
}

function accountDelete(){
	var param = {
			detail_code: $("#detail_code").val()		
	}
	
	var callback = function(res){
		if(res.result === "success"){
			alert("삭제되었습니다.");
			gfCloseModal();
			accountSearch();
		}
	}
	
	callAjax("/account/accountDelete.do", "post", "json", false, param, callback);
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
							<a href="#" class="btn_nav bold">회계</a> 
							<span class="btn_nav bold">계정과목 관리</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						
					<p class="conTitle" style="height: 100px;">
						<span style="display: block;">계정과목 관리</span> 
						<span>					
 	                         	 계정 대분류
 	                         	 <select class="searchGroup" id="searchGroup" style="width: 100px">
									<option value="">전체</option>
									<c:forEach items="${accountGroupList}" var="list">
										<option value= ${list.group_code} > ${list.group_name} </option>
									</c:forEach>	
									</select>
						 </span>
						 <span style="margin: 0 40px;">					
 	                         	 계정과목
 	                         	 <select class="searchDetail" id="searchDetail"" style="width: 100px">
									<option value="">전체</option>
									</select>
						 </span>
						 <span>					
 	                         	 구분
 	                         	 <select class="searchCode_type" id="searchCode_type" style="width: 100px">
									<option value="">전체</option>
									<option value="수입">수입</option>
									<option value="지출">지출</option>
									</select>
						 </span>    
						 <span style="margin: 0 40px;">					
 	                         	  사용여부
 	                         	 <select class="searchUse_yn" id="searchUse_yn" style="width: 100px">
									<option value="">전체</option>
									<option value="Y">Y</option>
									<option value="N">N</option>
									</select>
						 </span>                    
						  <a class="btnType red" href="" name="searchbtn"  id="searchBtn"><span>조회</span></a>
						 
						  
					</p> 
					<div style="text-align: right; display: block; margin-bottom: 10px;">
					<a class="btnType blue" href="javascript:insertModal();" name="modal"><span>등록</span></a>
					</div>
													 
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
	
	<!-- 모달팝업 -->
	<div id="accountInsertModal" class="layerPop layerType2" style="width: 600px;"> 
		<input type="hidden" id="group_code"/> 
		<input type="hidden" id="detail_code"/> 
		<dl>
			<dt>
				<strong>계정과목관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr id="writer">
							<th scope="row">계정대분류명 <span class="font_red">*</span></th>
							<td>
							<input type="text" class="inputTxt p100" name="updateAccountGroup" id="updateAccountGroup" disabled />
							<select class="insertAccountGroup" id="insertAccountGroup" style="width: 100px">
									<c:forEach items="${accountGroupList}" var="list">
										<option value= ${list.group_code} > ${list.group_name} </option>
									</c:forEach>	
							</select>
							</td>
						</tr>
						<tr>
							<th scope="row">계정세부명 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="accountDetail" id="accountDetail" /></td>
						</tr>
						<tr>
							<th scope="row">상세내용</th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="accountContent" id="accountContent">
								</textarea>
							</td>
						</tr>
						<tr id = tr_use_yn>
							<th scope="row">사용여부</th>
							<td colspan="3">
								<select class="use_yn" id="use_yn" style="width: 100px">
									<option value="Y">Y</option>
									<option value="N">N</option>
									</select>
							</td>
						</tr>
						<tr>
							<th scope="row">수입/지출 구분</th>
							<td colspan="3">
								<select class="code_type" id="code_type" style="width: 100px">
									<option value="">전체</option>
									<option value="수입">수입</option>
									<option value="지출">지출</option>
									</select>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveAccount" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnUpdateAccount" name="btn" style="display:none"><span>수정</span></a> 
					<a href="" class="btnType blue" id="btnDeleteAccount" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</body>
</html>