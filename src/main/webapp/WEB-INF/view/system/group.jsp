<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수주 정보 조회</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	$(function() {
		groupSearch();
		registerBtnEvent();
		 
	});
	
	function registerBtnEvent() {
		$("#searchBtn").click(function(e){
			e.preventDefault();
			groupSearch();
		});
		
		$("a[name=btn]").click(function(e){
			e.preventDefault();
			
			// 버튼 id 속성(정보)
			var btnId = $(this).attr("id")
			
			switch(btnId){
				case "btnSaveGroup" :
			        groupSave();
					break;
				case "btnUpdateGroup" :
					groupUpdate();
					break;
				case "btnSaveDetail" :
			        detailSave();
					break;
				case "btnUpdateDetail" :
					detailUpdate();
					break;
				case "btnClose" :
					gfCloseModal();
					break;
			}
		});
		
	}
	
	function groupSearch(currentPage) {
		currentPage = currentPage || 1;
		    
		var param = {
				searchGroupName: $("#searchGroupName").val(),
				searchGroupNote: $("#searchGroupNote").val(),
				currentPage: currentPage,
				pageSize: 5
		}
		
		var callback = function(res) {			
			$("#resultList").html(res);
			
			var pageNavi = getPaginationHtml(currentPage, $("#totcnt").val(), 5, 10, "groupSearch");
			$("#pageSize").html(pageNavi);
		}
		
		callAjax("/system/groupList", "post", "text", false, param, callback);
	}
	
	
	function getDetailList(currentPage, groupCode) {
		currentPage = currentPage || 1;
		$("#hiddenGroupCode").val(groupCode);
		var groupCode = groupCode;
		    
		var param = {
				groupCode: groupCode,
				currentPage: currentPage,
				pageSize: 5
		}
		
		var callback = function(res) {			
			$("#detailList").html(res);
			var pageNavi = getPaginationHtml(currentPage, $("#detail_totcnt").val(), 5, 10, "getDetailList",[ groupCode ]);
			$("#detail_pageSize").html(pageNavi);
		}
		
		callAjax("/system/detailList", "post", "text", false, param, callback);
	}
	
	function groupDetailModal(code) {
		$("#btnSaveGroup").hide();
		$("#btnUpdateGroup").show();
		
		var param = {
				groupCode: code
		}
		
		var callback = function(res) {
			
			var detail = res.detail;
			
			$("#oldGroupCode").val(detail.groupCode);
			
			$("#groupCode").val(detail.groupCode);
			$("#groupName").val(detail.groupName);
			$("#groupUseYn").val(detail.useYn);
			$("#groupNote").val(detail.note);
		   	$("#groupUseYn").val(detail.useYn).closest("tr").show(); 
		   	$('#groupCode').prop('readonly', true);
		   	
			gfModalPop("#groupInsertModal");
		}
		
		callAjax("/system/groupDetail", "post", "json", false, param, callback);
	}
	
	function detailDetailModal(code) {
		$("#btnSaveDetail").hide();
		$("#btnUpdateDetail").show();
		
		var param = {
				detailCode: code
		}
		
		var callback = function(res) {
			
			var detail = res.detail;
			
			$("#oldDetailCode").val(detail.detailCode);
			
			$("#detailCode").val(detail.detailCode);
			$("#detailName").val(detail.detailName);
			$("#detailUseYn").val(detail.useYn);
			$("#detailNote").val(detail.note);
			$("#higher_code").val(detail.higherCode);
		   	$("#detailUseYn").val(detail.useYn).closest("tr").show(); 
			
			gfModalPop("#detailInsertModal");
		}
		
		callAjax("/system/detailDetail", "post", "json", false, param, callback);
	}
	
	function insertModal() {
		$("#btnSaveGroup").show();
		$("#btnUpdateGroup").hide();
		$("#groupCode").val("");
		$("#groupName").val("");
		$("#groupUseYn").closest("tr").hide();		
		$("#groupNote").val("");
		$('#groupCode').prop('readonly', false);
		
		gfModalPop("#groupInsertModal");
	}
	
	function insertDetailModal() {
		$("#btnSaveDetail").show();
		$("#btnUpdateDetail").hide();
		$("#detailCode").val("");
		$("#detailName").val("");
		$("#higher_code").val("");
		$("#detailUseYn").closest("tr").hide();
		$("#detailNote").val("");
		
		gfModalPop("#detailInsertModal");
	}
	
	function groupSave() {
		var param = {
				groupCode: $("#groupCode").val(),
				groupName: $("#groupName").val(),
				groupNote: $("#groupNote").val(),
		}
		
		var callback = function(res){
			if(res) {
				alert(res.message);
				gfCloseModal();
				groupSearch();
			} else {
				alert("서버 응답이 없습니다. 다시 시도해주세요.");
			}
		}
		
		callAjax("/system/groupSave", "post", "json", false, param, callback);
	}
	
	function groupUpdate() {
		var groupUseYn = $("#groupUseYn").val().toUpperCase();
		
		
		var param = {
				oldGroupCode: $("#oldGroupCode").val(),
				newGroupCode: $("#groupCode").val(),
				groupName: $("#groupName").val(),
				groupNote: $("#groupNote").val(),
				groupUseYn: groupUseYn
		}
		
		var callback = function(res){			
			if(res) {
				alert(res.message);
				gfCloseModal();
				groupSearch();
			} else {
				alert("서버 응답이 없습니다. 다시 시도해주세요.");
			}
		}
		
		callAjax("/system/groupUpdate", "post", "json", false, param, callback);
	}
	
	
	
	function detailSave() {
		var groupCode = $("#hiddenGroupCode").val();
		var param = {
				detailCode: $("#detailCode").val(),
				detailName: $("#detailName").val(),
				detailNote: $("#detailNote").val(),
				higher_code: $("#higher_code").val(),
				groupCode: groupCode,
		}
		
		var callback = function(res){
			if(res) {
				alert(res.message);
				gfCloseModal();
				getDetailList(1,groupCode);
			} else {
				alert("서버 응답이 없습니다. 다시 시도해주세요.");
			}
		}
		
		callAjax("/system/detailSave", "post", "json", false, param, callback);
	}
	
	function detailUpdate() {
		var detailUseYn = $("#detailUseYn").val().toUpperCase();
		var groupCode = $("#hiddenGroupCode").val();
		
		var param = {
				oldDetailCode: $("#oldDetailCode").val(),
				newDetailCode: $("#detailCode").val(),
				detailName: $("#detailName").val(),
				detailNote: $("#detailNote").val(),
				higher_code: $("#higher_code").val(),
				detailUseYn: detailUseYn
		}
		
		var callback = function(res){			
			if(res) {
				alert(res.message);
				gfCloseModal();
				getDetailList(1,groupCode);
			} else {
				alert("서버 응답이 없습니다. 다시 시도해주세요.");
			}
		}
		
		callAjax("/system/detailUpdate", "post", "json", false, param, callback);
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
					<!-- lnb --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3>
					<div class="content">
						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a>
							<a href="#" class="btn_nav bold">시스템 관리</a> 
							<span class="btn_nav bold">공통코드 관리</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						
						<p class="conTitle" style="height: 110px">
							<span style="display: block;">공통코드 관리</span>
							<span class="fr" style="margin-top: 0px;">
								공통코드명
	                          	<input type="text" id="searchGroupName" name="searchGroupName" style="height: 25px; margin-right: 10px;"/>
	                          	비고
                          	 	<input type="text" id="searchGroupNote" name="searchGroupNote" style="height: 25px; margin-right: 10px;"/>
								<a class="btnType red" href="" name="searchBtn"  id="searchBtn"><span>조회</span></a>
						  		<a class="btnType blue" href="javascript:insertModal();" name="modal"><span>등록</span></a>
							</span>
						</p>
						
						<div class=groupList">
							<table class="col">
								<caption>caption</caption>
									<colgroup>
										<col width="25%">
										<col width="25%">
										<col width="25%">
										<col width="25%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">공통코드</th>
											<th scope="col">공통코드명</th>
											<th scope="col">비고</th>
											<th scope="col">보기</th>
										</tr>
									</thead>
									<tbody id="resultList"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pageSize">
							</div>
							<input type="hidden" id="hiddenGroupCode" />
							<div id="detailList" style="margin-top: 20px;"> 
							</div>
						</div>	
					</div>
				</li>
			</ul>
		</div>		
	</div>
	
	
	<div id="groupInsertModal" class="layerPop layerType2" style="width: 1000px;"> 
		<input type="hidden" id="oldGroupCode" />
		<dl>
			<dt>
				<strong>공통코드 관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="col">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row"><span class="font_red">*</span>공통코드</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="groupCode" id="groupCode" /> </td>							
						</tr>
						<tr>
							<th scope="row"><span class="font_red">*</span>공통코드명</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="groupName" id="groupName" /> </td>
						</tr>
						<tr>
							<th scope="row">사용여부</th>
							<td colspan="2">
							<select class="inputTxt p100" name="groupUseYn" id="groupUseYn" >
									<option value="Y">Y</option>
									<option value="N">N</option>
									</select>
							</td>
						</tr>
						<tr>
							<th scope="row">비고</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="groupNote" id="groupNote" /> </td>
						</tr>
					</tbody>
				</table>
				
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveGroup" name="btn"><span>등록</span></a>
					<a href="" class="btnType blue" id="btnUpdateGroup" name="btn" style="display:none"><span>수정</span></a> 
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
   
   <div id="detailInsertModal" class="layerPop layerType2" style="width: 1000px;"> 
		<input type="hidden" id="oldDetailCode" />
		<dl>
			<dt>
				<strong>상세코드 관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="col">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row">상세코드</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="detailCode" id="detailCode" /> </td>							
						</tr>
						<tr>
							<th scope="row"> <span class="font_red">*</span>상세코드명</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="detailName" id="detailName" /> </td>
						</tr>
						<tr>
							<th scope="row">상위코드</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="higher_code" id="higher_code" /> </td>
						</tr>
						<tr>
							<th scope="row">사용여부</th>
							<td colspan="2">
							<select class="inputTxt p100" name="detailUseYn" id="detailUseYn" >
									<option value="Y">Y</option>
									<option value="N">N</option>
									</select>
							</td>
						</tr>
						<tr>
							<th scope="row">비고</th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="detailNote" id="detailNote" /> </td>
						</tr>
					</tbody>
				</table>
				
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveDetail" name="btn"><span>등록</span></a>
					<a href="" class="btnType blue" id="btnUpdateDetail" name="btn" style="display:none"><span>수정</span></a> 
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</body>
</html>