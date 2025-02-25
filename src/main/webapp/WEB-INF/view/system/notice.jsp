<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 공지사항  </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	$(function(){
		noticeSearch();
		registerBtnEvent();
		filePreview();
	});

	function filePreview() {
		$("#fileInput").change(function(e){
			e.preventDefault();
		
			// 파일에 대한 정보를 불러옴
			var file = $(this)[0].files[0];
			
			console.log(file);
	
			// 파일이 첨부된 것을 확인한 경우(파일에 대한 데이터가 있는 경우)
			if(file) {
				//타입이 fileㅇ니 input의 값을 가져온다.
				var fileInfo = $("#fileInput").val();
				// 파일의 확장자명을 가져오기 위해 '.'을 기준으로 배열을 만듬
				var fileInfoSplit = fileInfo.split(".");
				// 파일 확장자명을 소문자로 통일
				var fileLowerCase = fileInfoSplit[1].toLowerCase();
				
				// 이미지의 경로
				var imgPath = "";
				// 미리보기 이미지 태그
				var previewHtml = "";
				
				// 파일이 이미지일 경우
				if(fileLowerCase === "jpg" || fileLowerCase === "gif" || fileLowerCase === "png"){
					imgPath = window.URL.createObjectURL(file);
					
					previewHtml = "<img src='" + imgPath + "' id='imgFile' style='width:100px; height: 100px'>";
				}
				
				$("#preview").html(previewHtml);
				
			}
		
		})
	}
	// 버튼의 이벤트를 등록(ex. 검색, 등록, 수정, 삭제)
	function registerBtnEvent(){
		// 조회버튼
		$("#searchBtn").click(function(e){
			e.preventDefault();
			noticeSearch();
		});
		
		// 모달 버튼 등록
		$("a[name=btn]").click(function(e){
			e.preventDefault();
			
			// 버튼 id 속성(정보)
			var btnId = $(this).attr("id")
			
			switch(btnId){
				// id가 btnSaveNotice이면 저장
				case "btnSaveNotice" :
					noticeSave();
					break;
				case "btnUpdateNotice" :
					noticeUpdate();
					break;
				case "btnDeleteNotice" :
					noticeDelete();
					break;
				case "btnSavefile" :
					noticeFileSave();
					break;
				case "btnUpdatefile" :
					noticeFileUpdate();
					break;
				case "btnDeletefile" :
					noticeDelete();
					break;
				case "btnClose" :
					gfCloseModal();
					break;
			}
		});
	} 
	
	function noticeFileSave(){
		var getForm = document.getElementById("noticeForm");
		
		// data 형태 지정
		getForm.entype = 'multipart/form-data';
		
		var fileData = new FormData(getForm);
		
		var callback = function(res){
			if(res.result === "success"){
				alert("저장되었습니다.");
				gfCloseModal();
				noticeSearch();
			}
		}
		
		callAjaxFileUploadSetFormData("/system/noticeFileSave.do", "post", "json", false, fileData, callback);
	}
	
	function noticeFileUpdate(){
		var getForm = document.getElementById("noticeForm");
		
		// data 형태 지정
		getForm.entype = 'multipart/form-data';	
	
		var fileData = new FormData(getForm);
		
		var callback = function(res){
			if(res.result === "success"){
				alert("수정되었습니다.");
				gfCloseModal();
				noticeSearch();
			}
		}
		
		callAjaxFileUploadSetFormData("/system/noticeFileUpdate.do", "post", "json", false, fileData, callback);
	}
	
	// 공지사항 데이터를 불러오는 함수
	function noticeSearch(currentPage){
		currentPage = currentPage || 1;
		
		// 공지사항 데이터를 불러오기 위한 파라미터(검색 조건)
		var param = {
				searchTitle : $("#searchTitle").val(),
				searchStDate : $("#searchStDate").val(),
				searchEdDate : $("#searchEdDate").val(),
				currentPage : currentPage,
				pageSize : 5
		}
		
		// 요청이 끝나고 실행되는 함수
		var callback = function(res){
			console.log(res);
			var detail = res.noticeList;
			var noticeCnt = res.noticeCnt;
			$("#noticeList").jsGrid({				
				width: "100%",
				shrinkToFit : true,
				height: "400px",
				sorting: true,
				
				noDataContent: "검색 결과가 없습니다",
				data: detail, // 서버에서 받아온 데이터
				fields: [
					{ name: "notiSeq", title: "공지 번호", type: "number", align: "center", width: "30px" },
					{ name: "notiTitle", title: "공지 제목", type: "text", align: "center" },
					{ name: "notiDate", title: "공지 날짜", type: "text", align: "center", width: "50px" },
					{ name: "loginId", title: "작성자", type: "text", align: "center", width: "40px" },
					
				],
				rowClick: function(args) {
					var item = args.item;
					console.log("클릭된 정보:", item);
					
					noticeDetailFileModal(item.notiSeq);
				}
			});
			
			var pageNavi = getPaginationHtml(currentPage, noticeCnt, 5, 10, "noticeSearch");
			$("#pageSize").html(pageNavi);
		} ;
		
		callAjax("/system/noticeList.do", "post", "json", false, param, callback);
	}
	
	
	// 상세보기 모달
	function noticeDetailModal(seq){
		var param = {
				noticeSeq : seq
		}
		
		var callback = function(res){
			var detail = res.detail;
			
			$("#loginId").val(detail.loginId);
			$("#noticeTitle").val(detail.notiTitle);
			$("#noticeContent").val(detail.notiContent);
			$("#noticeSeq").val(detail.notiSeq);
			
			// 상세보기 모달에 대한 조건
			$("#btnSaveNotice").hide();
			$("#btnUpdateNotice").show();
			$("#btnDeleteNotice").show();
			$("#writer").show();
			
			gfModalPop("#noticeInsertModal");
		} ;
		
		callAjax("/system/noticeDetail.do", "post", "json", false, param, callback);
	}
	
	// 신규 등록 모달
	function insertModal(){
		// 신규 등록 모달에 대한 조건
		$("#btnSaveNotice").show();
		$("#btnUpdateNotice").hide();
		$("#btnDeleteNotice").hide();
		$("#noticeTitle").val("");
		$("#noticeContent").val("");
		$("#writer").hide();
		
		gfModalPop("#noticeInsertModal");
	}
	
	// 신규 등록 파일모달
	function insertFileModal(){
		// 신규 등록 모달에 대한 조건
		$("#btnSavefile").show();
		$("#btnUpdatefile").hide();
		$("#btnDeletefile").hide();
		$("#fileTitle").val("");
		$("#fileContent").val("");
		$("#fileInput").val("");
		$("#preview").html("");
		
		gfModalPop("#filePopUp");
	}
	
	function noticeDetailFileModal(seq){
		$("#btnSavefile").hide();
		$("#btnUpdatefile").show();
		$("#btnDeletefile").show();
		$("#preview").html("");

		var param = {
				noticeSeq: seq
		}
		
		var callback = function(res){
			
			var detail = res.detail;
			
			$("#fileTitle").val(detail.notiTitle);
			$("#fileContent").val(detail.notiContent);
			$("#noticeSeq").val(detail.notiSeq);
			
			detailImgPreview(detail);
			
			gfModalPop("#filePopUp");
		}
		
		callAjax("/system/noticeFileDetail.do", "post", "json", false, param, callback);
	}
	
	// 상세조회 파일 미리보기
	function detailImgPreview(detailValue){
		if(detailValue.fileName) {
			var ext = detailValue.fileExt.toLowerCase();
			var imgPath = "";
			var previewHtml = "<a href='javascript:download()'>";
			
			if(ext === "jpg" || ext === "gif" || ext == "png") {
				imgPath = detailValue.logicalPath;
				previewHtml += "<img src='" + imgPath + "' id='imgFile' style='width:100px; height: 100px'>";
			}
			
			previewHtml += "</a>";
			
			$("#preview").html(previewHtml);

		}
	}
	
	function download(){
		var noticeSeq = $("#noticeSeq").val();
		
		var hiddenInput = "<input type='hidden' name='noticeSeq' value='" + noticeSeq + "'/>";
		$("<form action='noticeDownload.do' method='post' id='fileDownload'> " + hiddenInput + " </form>").appendTo('body').submit().remove();
		
	}
	
	function noticeSave(){
		var param = {
				title: $("#noticeTitle").val(),
				content: $("#noticeContent").val()
		}
		
		var callback = function(res){
			if(res.result === "success"){
				alert("저장되었습니다.");
				gfCloseModal();
				noticeSearch();
			}
		}
		
		callAjax("/system/noticeSave.do", "post", "json", false, param, callback);
	}
	
	function noticeUpdate(){
		var param = {
				title: $("#noticeTitle").val(),
				content: $("#noticeContent").val(),
				noticeSeq: $("#noticeSeq").val()
		}
		
		var callback = function(res){
			if(res.result === "success"){
				alert("수정되었습니다.");
				gfCloseModal();
				noticeSearch();
			}
		}
		
		callAjax("/system/noticeUpdate.do", "post", "json", false, param, callback);
	}
	
	function noticeDelete(){
		var param = {
			noticeSeq: $("#noticeSeq").val()		
		}
		
		var callback = function(res){
			if(res.result === "success"){
				alert("삭제되었습니다.");
				gfCloseModal();
				noticeSearch();
			}
		}
		
		callAjax("/system/noticeDelete.do", "post", "json", false, param, callback);
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
							<a href="#" class="btn_nav bold">시스템 관리</a> 
							<span class="btn_nav bold">공지 사항</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						
					<p class="conTitle" style="height: 110px;">
						<span style="display: block;">공지사항</span> 
						 <span class="fr" style="margin-top: 0px;">
						  <span >					
 	                         	 제목
                          <input type="text" id="searchTitle" name="searchTitle" style="height: 25px; margin-right: 10px;"/>
                          </span>
                          <span style="margin: 0 20px;">
                          	기간
                          <input type="date" id="searchStDate" name="searchStDate" style="height: 25px; margin-right: 10px;"/> 
                          ~ 
                          <input type="date" id="searchEdDate" name="searchEdDate" style="height: 25px; margin-right: 10px;"/>
						  </span>
						  <span>
						  <a class="btnType red" href="" name="searchbtn"  id="searchBtn"><span>검색</span></a>
						  <a class="btnType blue" href="javascript:insertModal();" name="modal"><span>신규</span></a>
						  <a class="btnType blue" href="javascript:insertFileModal();" name="modal"><span>신규(파일)</span></a>
						  </span>
						</span>
					</p> 
						<div id="noticeList"></div>
						
						<%-- <div class="divNoticeList">
							<table class="col">
								<caption>caption</caption>
		                            <colgroup>
						                   <col width="50px">
						                   <col width="200px">
						                    <col width="60px">
						                   <col width="50px">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">공지 번호</th>
							              <th scope="col">공지 제목</th>
							              <th scope="col">공지 날짜</th>
							              <th scope="col">작성자</th>
							              
									</tr>
								</thead>
								<tbody id="noticeList"></tbody>
							</table> --%>
							
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
	<div id="noticeInsertModal" class="layerPop layerType2" style="width: 600px;"> 
		<!-- <input type="hidden" id="noticeSeq"/> -->
		<dl>
			<dt>
				<strong>공지사항</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr id="writer">
							<th scope="row">작성자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="loginId" id="loginId" disabled /></td>
							<!-- <th scope="row">작성일<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="write_date" id="write_date" /></td> -->
						</tr>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="noticeTitle" id="noticeTitle" /></td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="3">
								<textarea class="inputTxt p100" name="noticeContent" id="noticeContent">
								</textarea>
							</td>
						</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveNotice" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnUpdateNotice" name="btn" style="display:none"><span>수정</span></a> 
					<a href="" class="btnType blue" id="btnDeleteNotice" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

<form id="noticeForm" action="" method="">
      <input type="hidden" id="noticeSeq" name="noticeSeq">
      <!-- 수정시 필요한 num 값을 넘김  -->
      <div id="filePopUp" class="layerPop layerType2" style="width: 600px;">
         <dl>
            <dt>
               <strong>공지사항 관리(파일)</strong>
            </dt>
            <dd class="content">
               <!-- s : 여기에 내용입력 -->
               <table class="row">
                  <caption>caption</caption>
                  <colgroup>
                     <col width="120px">
                     <col width="*">
                     <col width="120px">
                     <col width="*">
                  </colgroup>

                  <tbody>
                     <tr>
                        <th scope="row">제목 <span class="font_red">*</span></th>
                        <td colspan=3><input type="text" class="inputTxt p100"
                           name="fileTitle" id="fileTitle" /></td>
                     </tr>
                     <tr>
                        <th scope="row">내용 <span class="font_red">*</span></th>
                        <td colspan="3"><textarea name="fileContent"
                              id="fileContent" cols="40" rows="5"> </textarea></td>
                     </tr>
                     <tr>
                        <th scope="row">파일</th>
                        <td colspan="3"><input type="file" class="inputTxt p100"
                           name="fileInput" id="fileInput" /></td>
                     </tr>
                     <tr>
                        <th scope="row">미리보기</th>
                        <td>
                           <div id="preview"></div>
                        </td>
                     </tr>
                  </tbody>
               </table>

               <!-- e : 여기에 내용입력 -->

               <div class="btn_areaC mt30">
                  <a href="" class="btnType blue" id="btnSavefile" name="btn"><span>저장</span></a>
                  <a href="" class="btnType blue" id="btnUpdatefile" name="btn"><span>수정</span></a>
                  <a href="" class="btnType blue" id="btnDeletefile" name="btn"><span>삭제</span></a>
                  <a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
               </div>
            </dd>
         </dl>
         <a href="" class="closePop"><span class="hidden">닫기</span></a>
      </div>
   </form>
</body>
</html>
