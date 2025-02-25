<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회계전표 조회</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" />
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery.print/1.6.0/jQuery.print.min.js"></script>
<script type="text/javascript">
$(function(){
	voucherFields();
	searchBtnEvent();
});

function printArea(){
	
    var printArea = $("#voucherTable");
    printArea.print();
}

function searchBtnEvent(){
	// 조회버튼
	$("#searchBtn").click(function(e){
		e.preventDefault();
		voucherSearch();
	});
	
	
	// 모달 버튼 등록
	$("a[name=btn]").click(function(e){
		e.preventDefault();		
		
		var btnId = $(this).attr("id")
		
		switch(btnId){	
			case "btnPrintVoucher" :
				printArea();
				break;
			case "btnClose" :
				gfCloseModal();
				break;
		}
	})
} 

function voucherFields(detail){
	$("#jsGrid").jsGrid({
		width: "100%",
		height: "250px",
		sorting: true,
		noDataContent: "검색하세요.",
		data: detail,
		fields: [
			{ name: "voucher_no", title: "전표번호", type: "text", width: 90, align: "center" },
			{ name: "voucher_date", title: "일자", type: "text", width: 50, align: "center" },
			{ name: "account_type", title: "구분", type: "text", width: 40, align: "center" },
			{ name: "client_name", title: "거래처", type: "text", width: 80, align: "center" },
			{ name: "debit_name", title: "차변계정과목", type: "text", width: 100, align: "center" },
			{ name: "crebit_name", title: "대변계정과목", type: "text", width: 80, align: "center" },
			{ name: "voucher_amount", title: "장부금액", type: "text", width: 80, align: "center" },
		],		
		rowClick: function(args) {
			var item = args.item;
			var itemIndex = args.itemIndex;
			if(item.account_type ==='비용'){
				$("#view_order_id").val('-');	
				$("#view_exp_id").val(item.exp_id);
			}else if(item.account_type==='매출'){
				$("#view_order_id").val(item.order_id);	
				$("#view_exp_id").val('-');
			}
			$("#view_voucher_no").val(item.voucher_no);
			$("#view_voucher_date").val(item.voucher_date);
			$("#view_account_type").val(item.account_type);	
			$("#view_client_name").val(item.client_name);	
			$("#view_emp_name").val(item.emp_name);	
			$("#view_crebit_name").val(item.crebit_name);	
			$("#view_debit_name").val(item.debit_name);	
			$('[name="view_voucher_amount"]').val(item.voucher_amount);	
			
			
			gfModalPop("#voucherModal");
		}
	})		
}

function voucherSearch(currentPage){
	
	currentPage = currentPage || 1;
	
	var param = {			
			searchStDate : $("#searchStDate").val(),
			searchEdDate : $("#searchEdDate").val(),
			searchType : $("#searchType").val(),
			searchClientName : $("#searchClientName").val(),
			searchDebitName : $("#searchDebitName").val(),
			searchCrebitName : $("#searchCrebitName").val(),
			currentPage : currentPage,
			pageSize : 5
	}
	
	if(param.searchStDate > param.searchEdDate){
		alert("시작일은 종료일보다 먼저여야 합니다.");
		return;
	}
	
	var callback = function(res){
		var detail = res.voucher;
		var voucherCnt= res.voucherCnt;
		
		voucherFields(detail);			
				
		var pageNavi = getPaginationHtml(currentPage, voucherCnt, 5, 10, "voucherSearch");
		$("#pageSize").html(pageNavi);		
	};	
	callAjax("/account/voucherList.do", "post", "json", false, param, callback);
}

function formatNumberWithComma(value) {
    if (typeof value === "number") {
        return value.toLocaleString(); // 숫자 값을 3자리마다 콤마로 변환
    } 
    return value; // 숫자가 아닌 경우 그대로 반환
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
							<span class="btn_nav bold">회계전표 조회</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>
					<p class="conTitle" style="width: 95%; height: 60px; display: flex; flex-wrap: wrap; margin-bottom: 10px;">
						 <span style="text-align: left;">회계전표 조회</span>
					</p>
					<p style="width: 100%; height: 60px; display: flex; flex-wrap: wrap; background:#f9fafb; ">						 
						<span style="text-align: left; display: block; flex: 1 1 30%; margin: 10px 0 10px 20px;">일자 
 	                         <input type="date" id="searchStDate" name="searchStDate" style="height: 25px; margin-right: 10px;"/> 
                           
                          	<input type="date" id="searchEdDate" name="searchEdDate" style="height: 25px; margin-right: 10px;"/>
						 </span>    
						 <span style=" display: block; flex: 1 1 30%;  margin: 10px 0 10px 0px;">					
 	                         	 구분
 	                         	 <select class="searchType" id="searchType" style="width: 60px">
									<option value="sales">매출</option>
									<option value="expense">비용</option>									
								 </select>
						 </span>
						 <span style="display: block; flex: 1 1 30%;  margin: 10px 20px 10px 0px;">					
 	                         	  거래처명
 	                        <select class="searchClientName" id="searchClientName" name="searchClientName" style="width: 100px">
 	                        	<option value= "" >전체 </option>		
								<c:forEach items="${clientList}" var="list">
									<option value= ${list.clientName} > ${list.clientName} </option>
								</c:forEach>							
							</select>
						 </span>   	
					</p>			
					<p style="width: 100%; height: 60px; display: flex; flex-wrap: wrap; background:#f9fafb; margin-bottom:10px; ">		
						<span style="display: block; flex: 1 1 30%; margin: 10px 0px 10px 20px;">					
 	                         	 차변 계정과목명
 	                         	 <input type="text" class="searchDetailName" id="searchDebitName" style=" height: 25px; width: 80px"/>
						 </span>
						 <span style=" display: block; flex: 1 1 30%; margin: 10px 0px 10px 0px;">					
 	                         	 대변 계정과목명
 	                         	 <input type="text" class="searchDetailName" id="searchCrebitName" style="height: 25px; width: 80px"/>
									
						 </span>		
						 <span style="text-align: right; display: block; flex: 1 1 30%; margin: 10px 20px 10px 0px;">		
						  <a class="btnType red" href="" name="searchbtn"  id="searchBtn" ><span >조회</span></a>
						  </span>	
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
	<div id="voucherModal" class="layerPop layerType2" style="width: 1080px;"> 			
		<dl>
			<dt>
				<strong>회계전표 상세</strong>
			</dt>
			<dd class="content" id="voucherTable">
				<table class="row" >				

					<tbody>
						<tr>
							<th scope="row">전표번호</th>
							<td><input type="text" class="inputTxt p100"
								name="view_voucher_no" id="view_voucher_no"  readonly /></td>
							<th scope="row">구분</th>
							<td><input type="text" class="inputTxt p100"
								name="account_type" id="view_account_type"  readonly /></td>
							<th scope="row">담당자</th>
							<td><input type="text" class="inputTxt p100"
								name="emp_name" id="view_emp_name"  readonly /></td>
							<th scope="row">일자 </th>
							<td><input type="text" class="inputTxt p100"
								name="view_voucher_date" id="view_voucher_date" readonly /></td>
						</tr>
						<tr>
							<th scope="row">거래처</th>
							<td><input type="text" class="inputTxt p100"
								name="view_client_name" id="view_client_name"  readonly /></td>
							<th scope="row">주문번호</th>
							<td><input type="text" class="inputTxt p100"
								name="view_order_id" id="view_order_id"  readonly /></td>
							<th scope="row">지출번호</th>
							<td><input type="text" class="inputTxt p100"
								name="view_exp_id" id="view_exp_id" readonly /></td>
						</tr>
						<tr id="writer">
							<th scope="row" colspan='4'>계정과목</th>
							<th scope="row" colspan='2'>차변</th>
							<th scope="row" colspan='2'>대변</th>
						</tr>						
						<tr>
							<td colspan='4'><input type="text" class="inputTxt p100"
								name="view_debit_name" id="view_debit_name" readonly /></td>
							<td colspan='2'><input type="text" class="inputTxt p100"
								name="view_voucher_amount"  readonly /></td>
							<td colspan='2'><input type="text" class="inputTxt p100"
								name="view__amount" value="0"  readonly /></td>
						</tr>	
						<tr>
							<td colspan='4'><input type="text" class="inputTxt p100"
								name="view_crebit_name" id="view_crebit_name" readonly /></td>
							<td colspan='2'><input type="text" class="inputTxt p100"
								name="view__amount" value="0"  readonly /></td>
							<td colspan='2'><input type="text" class="inputTxt p100"
								name="view_voucher_amount"  readonly /></td>
						</tr>				
						<tr>
                        	<th scope="row" colspan='4'>합계</th>
                        	<th scope="row" colspan='2'>
                        	<input type="text" class="inputTxt p100"
								name="view_voucher_amount"   readonly />
                        	</th>
                        	<th scope="row" colspan='2'>
                        	<input type="text" class="inputTxt p100"
								name="view_voucher_amount"  readonly />
                        	</th>
                     	</tr>						
					</tbody>
				</table>				
			</dd>
			<div class="btn_areaC mt30" style="margin-bottom: 20px;">
					<a href="" class="btnType blue" id="btnPrintVoucher" name="btn"><span>인쇄</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>


		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</body>
</html>