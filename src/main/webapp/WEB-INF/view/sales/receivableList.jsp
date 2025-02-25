<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>미수금 조회</title>
<style>
.infoTitle {
	height: 50px;
    font-family: '나눔바른고딕', NanumBarunGothic;
    font-weight: bold;
    font-size: 17px;
    display: flex;
	align-items: center;
	margin-left: 20px;
}
</style>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	$(function(){
		receivableSearch();
	});
	
	function receivableSearch(currentPage){
		currentPage = currentPage || 1;
		
		var param = {
			productName : $("#productName").val(),
			clientName : $("#clientName").val(),
			searchStDate : $("#searchStDate").val(),
			searchEdDate : $("#searchEdDate").val(),
			deliveryStatus : $("#deliveryStatus").val(),
			receivableStatus : $("#selectReceivableStatus").val(),
			currentPage : currentPage,
			pageSize : 10
		}
		
		var callback = function(res){
			var detail = res.receivableList;
			
			// -- 그리드
			$("#mainGrid").jsGrid({
				width: "100%",
				height: "373px",
				sorting: true,
				noDataContent: "조회 결과가 없습니다.",
				data: detail,
				fields: [
					{ name: "orderId", title: "주문번호", type: "number", width: 60, align: "center" },
					{ name: "departmentName", title: "처리부서", type: "text", width: 70, align: "center" },
					{ name: "clientName", title: "거래처", type: "text", width: 100, align: "center" },
					{ name: "productName", title: "제품명", type: "text", width: 180, align: "center" },
					{ name: "orderDate", title: "수주일자", type: "text", width: 90, align: "center" },
					{ name: "deliveryDate", title: "배송일자", type: "text", width: 90, align: "center" },
					{ 
						name: "receivableAmount", 
						title: "미수금", 
						type: "number", 
						width: 80, 
						align: "center", 
						itemTemplate: function(value) { return gfFormatNumberWithComma(value); }
					},
					{ 
						name: "receivableStatus", 
						title: "수금상태", 
						type: "text", 
						width: 70, 
						align: "center", 
						itemTemplate: function(value) { return formatStatus(value, "receivableStatus"); }
					},
					{ 
						name: "managerName", 
						title: "처리자", 
						type: "text", 
						width: 80, 
						align: "center",
						itemTemplate: function(value) { return (value == null || value == "") ? "자동 처리" : value; } 
					},
				],
				rowClick: function(args) {
					var item = args.item;
					var itemIndex = args.itemIndex;
					
					receivableDetailModal(item.orderId, 1);
				}
			}); // -- 그리드 끝
			
			var pageNavi = getPaginationHtml(currentPage, res.receivableCnt, 10, 5, "receivableSearch");
			$("#pageSize").html(pageNavi);
		};
		
		callAjax("/sales/receivableList.do", "post", "json", false, param, callback);
	}
	
	function receivableDetailModal(orderId, currentPage) {
		gfModalPop("#receivableModal");
		$("#inputDepositAmount").val("");
		
		currentPage = currentPage || 1;
		
		var param = {
			orderId: orderId,
			currentPage : currentPage,
			pageSize : 5
		}
		
		var callback = function(res) {
			var detail = res.detail;
			var detailList = res.detailList;
			var receivableStatusText = "미수금";

			if (detail.receivableStatus === "Y") {
				$("#receivableStatusText").css("color", "blue");
				$("#totalReceivableAmount").css("color", "black");
				receivableStatusText = "수금완료";
				
				$("#depositTr").hide();
				$("#btnDeposit").hide();
			} else {
				$("#receivableStatusText").css("color", "red");
				$("#totalReceivableAmount").css("color", "red");
				
				if(res.userType == "B"){
					$("#btnDeposit").show();
					$("#depositTr").show();
				}
			}
			
/* 			var formatVal = (!isNaN(value) && value !== null && value !== "") ? Number(value).toLocaleString() : value; */
			$.each(detail, function(key, value){
				$("input[name=" + key + "]").val(value);
			});
			
			if(detail.managerName == "" || detail.managerName == null) {
				$("#managerName").val("자동 처리");
			}
			
			$("#receivableStatusText").val(receivableStatusText);
			
			// -- 그리드
			$("#modalGrid").jsGrid({
				width: "100%",
				height: "200px",
				sorting: true,
				noDataContent: "조회 결과가 없습니다.",
				data: detailList,
				fields: [
					{ name: "productId", title: "", type: "number", visible: false },
					{ name: "receivableId", title: "번호", type: "number", width: 50, align: "center" },
					{ name: "productName", title: "제품명", type: "text", width: 150, align: "center" },
					{ 
						name: "quantity", 
						title: "수량", 
						type: "number", 
						width: 80, 
						align: "center",
						itemTemplate: function(value) { return gfFormatNumberWithComma(value); }
					},
					{ 
						name: "supplyPrice", 
						title: "공급가", 
						type: "number", 
						width: 80, 
						align: "center",
						itemTemplate: function(value) { return gfFormatNumberWithComma(value); } 
					},
					{ 
						name: "unitPrice", 
						title: "제품 단가", 
						type: "number", 
						width: 80, 
						align: "center",
						itemTemplate: function(value) { return gfFormatNumberWithComma(value); } 
						},
					{ 
						name: "totalSupplyPrice", 
						title: "공급 합계", 
						type: "number", 
						width: 100, 
						align: "center",
						itemTemplate: function(value) { return gfFormatNumberWithComma(value); } 
					},
				]
			}); // -- 그리드 끝
			
			var pageNavi = getPaginationHtml(currentPage, res.detailListCnt, 5, 10, "receivableDetailModal");
			$("#modalPageSize").html(pageNavi);
		}
		
		callAjax("/sales/receivableDetail.do", "post", "json", false, param, callback);
	}
	
	function insertDeposit() {
		var beforeDepositAmount = parseInt($("#depositAmount").val());
		var inputDepositAmount = parseInt($("#inputDepositAmount").val()); // 입력한 금액
		var unpaidAmount = parseInt($("#totalReceivableAmount").val());
		var receivableId = $("#receivableId").val();
		var receivableStatus = $("#receivableStatus").val();
		
		if (depositAmount == 0) {
			alert("입금할 금액을 입력해 주세요.");
			return;
		} else if (depositAmount < 0) {
			alert("양수를 입력해 주세요.");
			return;
		} else if (unpaidAmount == 0) {
			alert("입금할 금액이 없습니다. ");
			return;
		} else if (inputDepositAmount > unpaidAmount) {
			alert("입금할 금액이 미납액보다 클 수 없습니다. ");
			return;
		} 
		
		var param = {
			orderId : $("#orderId").val(),
			clientId: $("#clientId").val(),
			empId : $("#empId").val(),
			paymentAmount: $("#depositAmount").val(),
			unpaidAmount : unpaidAmount - inputDepositAmount,
			depositAmount : inputDepositAmount,
			clientName : $("#detailClientName").val(),
			orderDate : $("#orderDate").val(),
			managerName : $("#managerName").val()
		}
		
		var callback = function(res) {
			if(res.result === "success") {
				alert("입금 처리가 완료되었습니다.");
				gfCloseModal();
				receivableSearch();
			} else {
				alert("오류가 발생했습니다.");
			}
		}
		
		callAjax("/sales/insertReceivableHistory.do", "post", "json", false, param, callback);
	}
	
	function formatStatus(value, name) {
	    if (name === "deliveryStatus") {
	        return value === "Y" ? "납품완료" : "납품전";
	    } else if (name === "receivableStatus") {
	        return value === "Y" ? "수금완료" : "미수금";
	    }
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
						<a href="#" class="btn_nav bold">매출 관리</a> 
						<span class="btn_nav bold">미수금 조회</span> 
						<a href="#" class="btn_set refresh">새로고침</a>
					</p>
					
					<div class="searchTitle">
						<p class="divTitle">
							<span>미수금 조회 및 영업수주 입금 처리</span> 
						</p>
						<table class="searchTable">
							<tbody>
								<tr>
									<td>수주일자</td>
									<td>
			                       		<input type="date" id="searchStDate" /> 
										<input type="date" id="searchEdDate" />
									</td>
									<td>수금상태</td>
									<td>
										<select id="selectReceivableStatus" >
											<option value="">전체</option>
											<option value="N">미수금</option>
											<option value="Y">수금완료</option>
										</select>
									</td>
									<td rowspan="2" style="text-align:right;">
										<a class="btnType gray" href="javascript:receivableSearch();" name="searchbtn" id="searchBtn"><span>조회</span></a>
									</td>
								</tr>
								<tr>
									<td>제품명</td>
									<td>
										<input type="text" id="productName" />
									</td>
									<td>거래처</td>
									<td>
										<input type="text" id="clientName" />
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div id="mainGrid"></div>
					<div class="paging_area" id="pageSize"></div>
	
				</div> <!--// content -->

				<h3 class="hidden">풋터 영역</h3>
				<jsp:include page="/WEB-INF/view/common/footer.jsp" />
			</li>
		</ul>
	</div>
</div>

<div id="receivableModal" class="layerPop layerType2" style="width: 1000px;">
<input type="hidden" id="orderId" name="orderId" />
<input type="hidden" id="clientId" name="clientId" />
<input type="hidden" id="empId" name="empId" />
<input type="hidden" id="unpaidAmount" name="unpaidAmount" />
<input type="hidden" id="receivableStatus" name="receivableStatus" />
	<dl>
		<dt>
			<strong>미수금 조회</strong>
		</dt>
		<dd class="content">
			<table class="row" style="margin-bottom:10px;">
				<tbody>
					<tr>
						<th scope="row">수주일자</th>
						<td><input type="text" class="inputTxt p100" name="orderDate" id="orderDate" disabled /></td>
						<th scope="row">납품일자</th>
						<td><input type="text" class="inputTxt p100" name="deliveryDate" disabled /></td>
					</tr>
					<tr>
						<th scope="row">처리부서</th>
						<td><input type="text" class="inputTxt p100" name="departmentName" disabled /></td>
						<th scope="row">전표번호</th>
						<td><input type="text" class="inputTxt p100" name="voucherNo" disabled /></td>
					</tr>
				</tbody>
			</table>
		
			<div id="modalGrid"></div>
			<div class="paging_area" id="modalPageSize"></div>
			
			<table class="row" style="margin-top:10px;">
				<tbody>	
					<tr>
						<th scope="row">총 납품개수</th>
						<td><input type="text" class="inputTxt p100" name="totalDeliveryCount" disabled /></td>
						<th scope="row">총 공급가</th>
						<td><input type="text" class="inputTxt p100" name="totalSupplyPrice" disabled /></td>
					</tr>
					<tr>
						<th scope="row">총 세액</th>
						<td><input type="text" class="inputTxt p100" name="totalTax" disabled /></td>
						<th scope="row">총 금액 (공급가+세액)</th>
						<td><input type="text" class="inputTxt p100" name="depositAmount" id="depositAmount" disabled /></td>
					</tr>
					<tr>
						<th scope="row">수납상태</th>
						<td><input type="text" class="inputTxt p100" id="receivableStatusText" disabled /></td>
						<th scope="row">미납액</th>
						<td><input type="text" class="inputTxt p100" id="totalReceivableAmount" name="totalReceivableAmount" disabled /></td>
					</tr>
					<tr id="depositTr" style="display:none;">
						<th scope="row">입금액</th>
						<td><input type="text" class="inputTxt p100" id="inputDepositAmount" placeholder="금액을 입력하세요" /></td>
						<td colspan="2" style="background-color:#f3f3f3"></td>
					</tr>
				</tbody>
			</table>
			
			<div class="infoTitle">거래처 정보</div>
			<table class="row">
				<tbody>
					<tr>
						<th scope="row">거래처명</th>
						<td><input type="text" class="inputTxt p100" name="clientName" id="detailClientName" disabled /></td>
						<th scope="row">담당자</th>
						<td><input type="text" class="inputTxt p100" name="person" disabled /></td>
						<th scope="row">연락처</th>
						<td><input type="text" class="inputTxt p100" name="personPh" disabled /></td>
					</tr>
				</tbody>
			</table>
			
			<div class="infoTitle">처리자</div>
			<table class="row" style="width:350px;">
				<tbody>
					<tr>
						<th scope="row">처리자</th>
						<td>
							<input type="text" class="inputTxt p100" id="managerName" name="managerName" disabled />
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="btn_areaC mt30" style="margin-top:30px;">
				<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				<a href="javascript:insertDeposit();" class="btnType blue" id="btnDeposit" name="btn" style="display:none; margin-left:10px;"><span>직접 입금</span></a> 
			</div>
		</dd>
	</dl>

	<a href="" class="closePop"><span class="hidden">닫기</span></a>
</div>

</body>
</html>

