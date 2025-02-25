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
		departmentSearch();
		registerBtnEvent();
		 
	});
	
	function registerBtnEvent() {
		$("#searchBtn").click(function(e){
			e.preventDefault();
			departmentSearch();
		});
		
		$("a[name=btn]").click(function(e){
			e.preventDefault();
			
			// 버튼 id 속성(정보)
			var btnId = $(this).attr("id")
			
			switch(btnId){
				case "btnSaveDepartment" :
			        departmentSave();
					break;
				case "btnUpdateDepartment" :
					departmentUpdate();
					break;
				case "btnClose" :
					gfCloseModal();
					break;
			}
		});
		
	}
	
	function departmentSearch(currentPage) {
		currentPage = currentPage || 1;
		    
		var param = {
				searchDepartmentName: $("#searchDepartmentName").val(),
				currentPage: currentPage,
				pageSize: 5
		}
		
		var callback = function(res) {			
			$("#resultList").html(res);
			
			var pageNavi = getPaginationHtml(currentPage, $("#totcnt").val(), 5, 10, "departmentSearch");
			$("#pageSize").html(pageNavi);
		}
		
		callAjax("/system/departmentList", "post", "text", false, param, callback);
	}
	
	function departmentDetailModal(code) {
		$("#btnSaveDepartment").hide();
		$("#btnUpdateDepartment").show();
		$("#btnDeleteDepartment").show();
		
		var param = {
				detailCode: code
		}
		
		var callback = function(res) {
			
			var detail = res.detail;
			
			$("#oldDepartmentCode").val(detail.detailCode);
			
			$("#departmentCode").val(detail.detailCode);
			$("#departmentName").val(detail.detailName);
			
			gfModalPop("#departmentInsertModal");
		}
		
		callAjax("/system/departmentDetail", "post", "json", false, param, callback);
	}
	
	function insertModal() {
		$("#btnSaveDepartment").show();
		$("#btnUpdateDepartment").hide();
		$("#btnDeleteDepartment").hide();
		$("#departmentCode").val("");
		$("#departmentName").val("");
		
		gfModalPop("#departmentInsertModal");
	}
	
	function departmentSave() {
		if($("#departmentCode").val() =="" || $("#departmentName").val() ==""){
			alert("필수 입력값을 입력해주세요.");
			return;
		}
		var param = {
				detailCode: $("#departmentCode").val(),
				detailName: $("#departmentName").val()
		}
		

		var callback = function(res){
			if(res) {
				alert(res.message);
				gfCloseModal();
				departmentSearch();
			} else {
				alert("서버 응답이 없습니다. 다시 시도해주세요.");
			}
		}
		
		callAjax("/system/departmentSave", "post", "json", false, param, callback);
	}
	
	function departmentUpdate() {
		if($("#departmentCode").val() =="" || $("#departmentName").val() ==""){
			alert("필수 입력값을 입력해주세요.");
			return;
		}
		var param = {
				oldDetailCode: $("#oldDepartmentCode").val(),
				newDetailCode: $("#departmentCode").val(),
				detailName: $("#departmentName").val()
		}
						
		var callback = function(res){			
			if(res) {
				alert(res.message);
				gfCloseModal();
				departmentSearch();
			} else {
				alert("서버 응답이 없습니다. 다시 시도해주세요.");
			}
		}
		
		callAjax("/system/departmentUpdate", "post", "json", false, param, callback);
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
							<span class="btn_nav bold">부서 관리</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						
						<p class="conTitle" style="height: 110px">
							<span style="display: block;">부서 관리</span>
							<span class="fr" style="margin-top: 0px;">
								부서명
	                          	<input type="text" id="searchDepartmentName" name="searchDepartmentName" style="height: 25px; margin-right: 10px;"/> 
								<a class="btnType red" href="" name="searchBtn"  id="searchBtn"><span>조회</span></a>
						  		<a class="btnType blue" href="javascript:insertModal();" name="modal"><span>등록</span></a>
							</span>
						</p>
						
						<div class=departmentList">
							<table class="col">
								<caption>caption</caption>
									<colgroup>
										<col width="50%">
										<col width="50%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">부서코드</th>
											<th scope="col">부서명</th>
										</tr>
									</thead>
									<tbody id="resultList"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pageSize">
							</div>
						</div>
					</div>
				</li>
			</ul>
		</div>
		
	</div>
	
	<div id="departmentInsertModal" class="layerPop layerType2" style="width: 1000px;"> 
		<input type="hidden" id="oldDepartmentCode" />
		<dl>
			<dt>
				<strong>부서 관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="col">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row">부서코드 <span class="font_red">*</span></th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="departmentCode" id="departmentCode" /> </td>							
						</tr>
						<tr>
							<th scope="row">부서명 <span class="font_red">*</span></th>
							<td colspan="2"><input type="text" class="inputTxt p100" name="departmentName" id="departmentName" /> </td>
						</tr>						
					</tbody>
				</table>
				
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveDepartment" name="btn"><span>등록</span></a>
					<a href="" class="btnType blue" id="btnUpdateDepartment" name="btn" style="display:none"><span>수정</span></a>
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
   
</body>
</html>