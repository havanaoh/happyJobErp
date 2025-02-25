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
		orderSearch();
		loadClientOptions(false);
		loadProductOptions();
		registerBtnEvent();
		
		 $("#manufacturerSelect").change(function() {
		        var selectedManufacturerId = $(this).val();
		        loadMajorCategoryOptions(selectedManufacturerId);
		        });
		 
		 $("#orderProductSelect").change(function() {
			 var selectedProduct = $(this).find("option:selected");
						 
			 var unitPrice = selectedProduct.data("unit-price");
			 
			 
			 $("#orderUnitPriceInput").val(unitPrice);
		 });
		 
		 $("#subCategorySelect").change(function() {
			 loadOrderProductOptions($(this).val());
		 });
		 
		 $("#majorCategorySelect").change(function() {
			 loadMajorCategoryOptions($(this).val());
		 });
		 
	});
	
	function estimateSearch(currentPage) {
		currentPage = currentPage || 1;
		    
		var param = {
				currentPage: currentPage,
				pageSize: 5
		}
		
		var callback = function(res) {
			$("#estimateList").html(res);
			var pageNavi = getPaginationHtml(currentPage, $("#esti_totcnt").val(), 5, 10, "estimateSearch");
			$("#esti_pageSize").html(pageNavi);
		}
		
		callAjax("/business/orderEstimateList", "post", "text", false, param, callback);
	}
	
	function registerBtnEvent() {
		$("#searchBtn").click(function(e){
			e.preventDefault();
			orderSearch();
		});
		
		$("#btnInsertOrder").click(function(e) {
			e.preventDefault();
			$("#orderEmpty").hide();
	        addOrderRow();
	    });
		
		$(document).on("click", ".deleteRow", function() {
	        removeOrderRow(this);
	    });
		
	    $("#btnDeleteOrder").click(function(e) {
	        e.preventDefault();
	        $("#orderInsertList").empty();
	    });
	    
	    $("#btnSaveOrder").click(function(e) {
	        e.preventDefault();
	        saveOrder();
	    });
	    $("#esti_btn").click(function(e) {
	    	$("#esti_list").show();
	    	$("#esti_btn").hide();
	    });
	    
	    
	}
	
	function orderSearch(currentPage) {
		currentPage = currentPage || 1;
		    
		var param = {
				searchOrderDate: $("#searchOrderDate").val(),
				searchDeliveryDate: $("#searchDeliveryDate").val(),
				searchClientId: $("select[name='client']").val(),
				searchProductId: $("select[name='product']").val(),
				currentPage: currentPage,
				pageSize: 5
		}
		
		var callback = function(res) {
			$("#resultList").html(res);
			var pageNavi = getPaginationHtml(currentPage, $("#totcnt").val(), 5, 10, "orderSearch");
			$("#pageSize").html(pageNavi);
		}
		
		callAjax("/business/orderList", "post", "text", false, param, callback);
	}
	
	function loadClientOptions(isInsertModal) {
		
		var callback = function(res) {		
			
	        var clientSelect = isInsertModal ? $("#insertClientSelect") : $("#searchClientSelect");
			clientSelect.empty();
			
			if(!isInsertModal) {
			clientSelect.append('<option value="">전체</option>')
			} else {
			clientSelect.append('<option value="">거래처를 선택하세요</option>')
			}
			
			res.forEach(function(client) {
			    clientSelect.append('<option value="' + client.id + '">' + client.name + '</option>');
			});
		};
		
		callAjax("/business/clientNames", "get", "json", true, null, callback);
	}
	
	function loadProductOptions() {
		
		var callback = function(res) {
			var productSelect = $("select[name='product']");
			productSelect.empty().append('<option value="">전체</option>');

			res.forEach(function(product) {
				productSelect.append('<option value="' + product.id + '">' + product.name + '</option>');
			});
		};
		
		callAjax("/business/productNames", "get", "json", true, null, callback);
	}
	
	function loadManufacturerOptions() {
		
		var callback = function(res) {
			var manufacturerSelect = $("select[name='manufacturer']");
			manufacturerSelect.empty();
	        manufacturerSelect.append('<option value="">제조업체를 선택하세요</option>');

			res.forEach(function(mf) {
				manufacturerSelect.append('<option value="' + mf.id + '">' + mf.name + '</option>');
			});
		};
		
		callAjax("/business/manufacturerNames", "get", "json", true, null, callback);
	}
	
	function loadMajorCategoryOptions(manufacturerId) {
	    if (!manufacturerId) {
	        $("#majorCategorySelect").empty().append('<option value="">제조업체를 선택하세요</option>');
	        
			$("#subCategorySelect").empty().append('<option value="">대분류를 선택하세요</option>');
	        return;
	    }
	    
		param = {
				manufacturerId: manufacturerId
		}
		
		var callback = function(res) {
			
			
			var majorCategorySelect = $("select[name='majorCategory']");
			majorCategorySelect.empty();
			
			res.forEach(function(mc) {
				majorCategorySelect.append('<option value="' + mc.industryCode + '">' + mc.groupName + '</option>');
			});
			
			loadSubCategoryOptions(res[0].industryCode)
		};
		
		callAjax("/business/majorCategoryNames", "post", "json", true, param, callback);
	}
	
	function loadSubCategoryOptions(industryCode) {
	    if (!industryCode) {
	        $("#subCategorySelect").empty().append('<option value="">대분류를 선택하세요</option>');
	        return;
	    }
	    
		param = {
				industryCode: industryCode
		}
		
		var callback = function(res) {		
			
			var subCategorySelect = $("select[name='subCategory']");
			subCategorySelect.empty();
			
			res.forEach(function(sc) {
				subCategorySelect.append('<option value="' + sc.subCode + '">' + sc.subName + '</option>');
			});
			
			loadOrderProductOptions(res[0].subCode);
		};
		
		callAjax("/business/subCategoryNames", "post", "json", true, param, callback);
	}
	
	function loadOrderProductOptions(subCode) {
		if(!subCode) {
			$("#orderProductSelect").empty().append('<option value="">소분류를 선택하세요</option>');
			$("#orderUnitPriceInput").val("");
	        return;
		}
		
		param = {
				subCode: subCode
		}
		
		var callback = function(res) {
			
			var orderProductSelect = $("select[name='orderProduct']");
			orderProductSelect.empty();
			
			res.forEach(function(op) {
				orderProductSelect.append('<option value="' + op.productId + '" data-unit-price= "' + op.unitPrice + '">' + op.productName+ '</option>');
			});
			
			$("#orderUnitPriceInput").val(res[0].unitPrice);
		};
		
		callAjax("/business/orderProductNames", "post", "json", true, param, callback);
	}
		
	function insertModal() {
		loadClientOptions(true);
		loadManufacturerOptions();
		$("#majorCategorySelect").empty().append('<option value="">제조업체를 선택하세요</option>');
		$("#subCategorySelect").empty().append('<option value="">대분류를 선택하세요</option>');
		$("#orderProductSelect").empty().append('<option value="">소분류를 선택하세요</option>');
		$("#orderUnitPriceInput").val("");
		estimateSearch();
		$("#esti_btn").show();
		$("#esti_list").hide();
		
		$("#orderEmpty").show();
		$("#clientSelect").show();
		$("#deliveryDateInput").show();
		$("#salesAreaSelect").show();
		$("#addInput").remove();
		$("#orderInsertList").empty();

		gfModalPop("#orderInsertModal");
	}
	
	function convertNumberToKorean(num) {
	    const han1 = ["", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구"];
	    const han2 = ["", "십", "백", "천"];
	    const han3 = ["", "만", "억", "조"];
	    
	    let result = "";
	    let unitIndex = 0;
	    
	    while (num > 0) {
	        let part = num % 10000;
	        let partStr = "";
	        let digitIndex = 0;

	        while (part > 0) {
	            let digit = part % 10;
	            if (digit > 0) {
	                partStr = han1[digit] + han2[digitIndex] + partStr;
	            }
	            part = Math.floor(part / 10);
	            digitIndex++;
	        }

	        if (partStr !== "") {
	            result = partStr + han3[unitIndex] + " " + result;
	        }

	        num = Math.floor(num / 10000);
	        unitIndex++;
	    }


	    return result.trim() + "원정";
	}
	
	function orderDetailModal(id, clientId) {
		var param = {
				orderId: id,
				clientId: clientId
		}
		
		var callback = function(res) {
			var detailList = res.orderDetail;
			var order = res.order;
			var client = res.client;
			

			// client
			$("#clientNumber").text(client.bizNum);
			$("#clientName").text(client.clientName);
			$("#clientAddress").text(client.addr);
			$("#clientPerson").text(client.person);
			$("#clientTel").text(client.ph);
			
			// my
			$("#myNumber").text("01-1234-4567891");
			$("#myName").text("ERP HAPPY JOB");
			$("#myAddress").text("서울시 구로구 디지털로 285 에이스트원타워 1차 401호");
			$("#myPerson").text(order.orderEmpName);
			$("#myTel").text("02-857-7819");
			
			//
	        var totalAmount = order.totalSupplyPrice + order.totalTax;
	        var totalAmountKorean = convertNumberToKorean(totalAmount); 
        
			$("#commentOrder").text(order.orderDate);
			$("#commentDelivery").text(order.deliveryDate);
			$("#totalMoneyText").text(totalAmountKorean); 
		 	$("#totalMoney").text(gfFormatNumberWithComma(totalAmount));  
			
			// orderdetail
	        var detailHtml = "";
	        
	        if (detailList && detailList.length > 0) {
	            detailList.forEach(function(detail) {
	                detailHtml += "<tr>" +
	                    "<td>" + order.estimateId + "</td>" +
	                    "<td>" + detail.productName + "</td>" +
	                    "<td>" + detail.quantity + "</td>" +
	                    "<td>" + gfFormatNumberWithComma(detail.supplyPrice) + "</td>" +
	                    "<td>" + gfFormatNumberWithComma(Math.floor(detail.supplyPrice * 0.1)) + "</td>" +
	                    "<td>" + gfFormatNumberWithComma(Math.floor(detail.supplyPrice * detail.quantity * 1.1)) + "</td>" +
	                "</tr>";
	            });
	        } else {
	            detailHtml = "<tr><td colspan='6'>데이터가 없습니다.</td></tr>";
	        }
	        
	        $("#orderDetailList").html(detailHtml);

			gfModalPop("#detailModal");

		}
		
		callAjax("/business/orderDetail", "post", "json", false, param, callback);
	}
	
	// 행 추가 기능
	function addOrderRow() {
		
		var manufacturerId = $("#manufacturerSelect").val();
	    var manufacturerText = $("#manufacturerSelect option:selected").text();

	    var majorCategoryId = $("#majorCategorySelect").val();
	    var majorCategoryText = $("#majorCategorySelect option:selected").text();

	    var subCategoryId = $("#subCategorySelect").val();
	    var subCategoryText = $("#subCategorySelect option:selected").text();

	    var productId = $("#orderProductSelect").val()
	    var productText = $("#orderProductSelect option:selected").text();
	    
	    var unitPrice = $("#orderUnitPriceInput").val();
	    var quantity = $("#orderQuantityInput").val();
	    var supplyPrice = $("#orderSupplyPriceInput").val();

	    // 값이 비어 있으면 추가하지 않음
	    if (!manufacturerId || !majorCategoryId || !subCategoryId || !productId || !unitPrice || !quantity || !supplyPrice) {
	        alert("모든 값을 입력하세요.");
	        return;
	    }

	    var newRow = "<tr data-manufacturer-id='" + manufacturerId + "' data-major-category-id='" + majorCategoryId +
	    	"' data-sub-category-id='" + subCategoryId + "' data-product-id='" + productId + "'>" +
			"<td>" + productText + "</td>" +
			"<td>" + unitPrice + "</td>" +
			"<td>" + quantity + "</td>" +
			"<td>" + supplyPrice + "</td>" +
			"<td><button class='deleteRow'>삭제</button></td>" +
			"</tr>";

	    $("#orderInsertList").append(newRow);
	}

	// 행 삭제 기능
	function removeOrderRow(button) {
	    $(button).closest("tr").remove();
	}
	
	function saveOrder() {
		var clientId = "";
	    var orderDeliveryDate = "";
	    var orderSalesArea = "";
	    var estimateIdInput = "";
		if ($('#insertClientSelect').is(':hidden')) {  // 요소가 숨겨져 있으면
			clientId = $("#insertClientInput").val();
		    orderDeliveryDate = $("#estimateDeliveryDateInput").val();
		    orderSalesArea = $("#estimateSalesAreaSelect").val();
		    estimateIdInput = $("#estimateIdInput").val();
	    }else{
	    	clientId = $("#insertClientSelect").val();
		    orderDeliveryDate = $("#orderDeliveryDateInput").val();
		    orderSalesArea = $("#orderSalesAreaSelect").val();
	    }
	    
	    
	    if (!clientId) {
	        alert("거래처를 선택하세요.");
	        return;
	    }

	    if (!orderDeliveryDate) {
	        alert("납기일을 입력하세요.");
	        return;
	    }
	    
		var orderData = [];
		
		$("#orderInsertList tr").each(function() {
	        var row = $(this);
	        var rowData = {
	            productId: row.data("product-id"),
	            unitPrice: row.find("td").eq(1).text(),
	            quantity: row.find("td").eq(2).text(),
	            supplyPrice: row.find("td").eq(3).text()
	        };
	        orderData.push(rowData);
	    });
		
		if (orderData.length === 0) {
		        alert("저장할 수주가 없습니다.");
		        return;
	    }
		
		var param = {
				estimateId: estimateIdInput,
			    clientId: clientId,
			    orderDeliveryDate: orderDeliveryDate,
			    orderSalesArea: orderSalesArea,
			    orderList: orderData
		};
		
		$.ajax({
	        url: "/business/saveOrder",
	        type: "POST",
	        dataType: "json",
	        contentType: "application/json",  // JSON 요청을 위한 설정
	        data: JSON.stringify(param),  // JSON 문자열로 변환하여 전송
	        success: function (res) {	        	
	            if (res.result === "success") {
	                alert("수주서가 저장되었습니다.");
	                $("#orderInsertList").empty();
					gfCloseModal();	                
					orderSearch();
	            } else {
	                alert("저장 중 오류가 발생했습니다.");
	            }
	        },
	        error: function (xhr, status, err) {
	            alert("A system error has occurred.");
	        }
	    });
	    
	}
	
	function orderListAddrow(id,clientId){
		
		$("#clientSelect").hide();
		$("#deliveryDateInput").hide();
		$("#salesAreaSelect").hide();
		$("#addInput").remove();
		$("#orderInsertList").empty();
		
		var param = {
				estimateId: id,
				clientId: clientId
		}
		var callback = function(res) {
			var detailList = res.estimateDetail;
			var estimate = res.estimate;
			var client = res.client;
			
			var clientName = client.clientName;
			
			
		    
		    var esti_input = "<div id='addInput' style='margin-bottom:10px'><input type='hidden' id='insertClientInput' readonly value='"+clientId+"'>"+
		    	"<input type='hidden' id='estimateIdInput' readonly value='"+id+"'>"+
		    	"거래처<input type='text' id='insertClientName' style='width: 200px; height: 30px;' readonly value='"+clientName+"'>"+
		    	"납기기한<input type='text' style='width: 100px; height: 30px;' id='estimateDeliveryDateInput' readonly value='"+estimate.deliveryDate+"'>"+
		    	"영역구분<input type='text' style='width: 50px; height: 30px;' id='estimateSalesAreaSelect' readonly value='"+estimate.salesArea+"'></div>";
		    $("#insertClientInfo").append(esti_input);
			var newRow = "";
			
			if (detailList && detailList.length > 0) {
	            detailList.forEach(function(detail) {
	            	newRow += "<tr data-esti-id='" + detail.estimateId + "' data-product-id='" + detail.productId + "'>" +
	    			"<td>" + detail.productName + "</td>" +
	    			"<td>" + detail.unitPrice + "</td>" +
	    			"<td>" + detail.quantity + "</td>" +
	    			"<td>" + detail.supplyPrice + "</td>" +
	    			"<td><button class='deleteRow'>삭제</button></td>" +
	    			"</tr>";
	            });
	        }

	    	$("#orderInsertList").append(newRow);
	    	
		}
		callAjax("/business/estimateDetail", "post", "json", false, param, callback);
	}
</script>
<style>
#esti_btn{
      border: none;
      background-color: transparent;
      padding: 0;
      font-size: 15px;
      cursor: pointer;
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
					<!-- lnb --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3>
					<div class="content">
						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a>
							<a href="#" class="btn_nav bold">영업 관리</a> 
							<span class="btn_nav bold">수주 정보 조회</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						
						<p class="conTitle" style="height: 120px">
							<span>수주 작성/조회</span>
							<span class="fr">
								수주일
	                          	<input type="date" id="searchOrderDate" name="searchOrderDate" style="height: 25px; margin-right: 10px;"/> 
								납기일
								<input type="date" id="searchDeliveryDate" name="searchDeliveryDate" style="height: 25px; margin-right: 10px;"/>
								거래처
								<select id="searchClientSelect" name="client">
								</select>
								제품
								<select name="product">
								</select>
								<a class="btnType red" href="" name="searchBtn"  id="searchBtn"><span>조회</span></a>
						  		<a class="btnType blue" href="javascript:insertModal();" name="modal"><span>작성</span></a>
							</span>
						</p>
						
						<div class=orderList">
							<table class="col">
								<caption>caption</caption>
									<colgroup>
										<col width="9%">
										<col width="9%">
										<col width="9%">
										<col width="9%">
										<col width="9%">
										<col width="5%">
										<col width="5%">
										<col width="5%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">수주직원</th>
											<th scope="col">수주일</th>
											<th scope="col">거래처</th>
											<th scope="col">제품명</th>
											<th scope="col">납기일</th>
											<th scope="col">총 납품<br>개수</th>
											<th scope="col">총 공급<br>가액</th>
											<th scope="col">총 세액</th>
											<th scope="col">영역구분<br>(scm/영업)</th>
											<th scope="col">수주상세조회</th>
										</tr>
									</thead>
									<tbody id="resultList"></tbody>
							</table>
						</div>
					</div>
					<!-- 페이징 처리  -->
							<div class="paging_area" id="pageSize">
							</div>
				</li>
			</ul>
			
		</div>
	</div>
	
	<div id="orderInsertModal" class="layerPop layerType2" style="width: 1080px;"> 
		<!-- <input type="hidden" id="noticeSeq"/> -->
		<dl>
			<dt>
				<strong>수주서 작성</strong>
			</dt>
			<dd class="content">
				<div id="insertClientInfo"  style='margin-bottom:10px'>
						<span id="clientSelect">거래처 <select id="insertClientSelect" name="client"></select>	</span>
						<span id="deliveryDateInput">납기일
							<input type="date" name="orderDeliveryDate" id="orderDeliveryDateInput" style="height: 30px;"></input></span>
						<span id="salesAreaSelect">
						영역구분<select name="orderSalesArea" id="orderSalesAreaSelect">
							<option>SCM</option>
							<option>영업</option>
						</select></span>
				</div>
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="30%">
						<col width="20%">
						<col width="15%">					
						<col width="20%">
						<col width="15%">
					</colgroup>
					<thead>
						<tr>
				             <th scope="col">제품명</th>
				             <th scope="col">제품단가</th>
				             <th scope="col">수량</th>
				             <th scope="col">공급가액</th>
				             <th scope="col">삭제</th>
						</tr>
					</thead>
					<tbody id="orderEmpty">
						<tr>
						<td colspan='5'>등록버튼을 클릭하면 여기에 등록됩니다.</td>
						</tr>
					</tbody>
					<tbody id="orderInsertList">
					</tbody>
				</table>
				
				<table class="row" style="margin:10px 0">
					<tbody>
					<tr id="insertOrderInfo">
						<th>제조업체</th><td> <select name="manufacturer" id="manufacturerSelect"></select></td>
						<th>대분류</th> <td><select name="majorCategory" id="majorCategorySelect"></select></td>
						<th>소분류</th> <td> <select name="subCategory" id="subCategorySelect"></select></td>
					</tr>
					<tr id="insertProductInfo">
						<th>제품</th><td> <select name="orderProduct" id="orderProductSelect"></select></td>
						<th>제품단가</th><td> <input name="orderUnitPrice" id="orderUnitPriceInput" style="width: 100px; height: 30px;" readonly></input></td>
						<th>수량 </th><td><input name="orderQuantity" id="orderQuantityInput" style="width: 100px; height: 30px;"></input></td>
						<th>공급가액 </th><td><input name="orderSupplyPrice" id="orderSupplyPriceInput" style="width: 100px; height: 30px;"></input></td>
					</tr>
					</tbody>
				</table>
					<div id="insertOrderBtn">
						<a href="" class="btnType blue" id="btnInsertOrder" name="btn"><span>등록</span></a>
						<a href="" class="btnType blue" id="btnDeleteOrder" name="btn"><span>전체삭제</span></a>
					</div>	
				
				<button id="esti_btn" style="margin-top:30px">견적서 보기<strong> ∨</strong></button>

				<div id="esti_list" style="margin-top:30px">
				<table class="col">					
					<colgroup>
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="15%">					
						<col width="15%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr>
				             <th scope="col">견적일</th>
				             <th scope="col">거래처</th>
				             <th scope="col">제품명</th>
				             <th scope="col">제품단가</th>
				             <th scope="col">수량</th>
				             <th scope="col">공급가액</th>
				             <th scope="col">등록</th>
						</tr>
					</thead>
					<tbody id="estimateList">
					</tbody>
				</table>
				<div class="paging_area" id="esti_pageSize">
							</div>
				</div>
				
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveOrder" name="btn"><span>저장</span></a> 
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	<form id="orderForm" action="" method="">
      <input type="hidden" id="orderId" name="orderId">
      <!-- 수정시 필요한 num 값을 넘김  -->
      <div id="detailModal" class="layerPop layerType2" style="width: 1000px; ">
         <dl>
            <dt>
               <strong>수주서 상세조회</strong>
            </dt>
            <dd class="content">
               <!-- s : 여기에 내용입력 -->
				<div id="info" style="display: flex;">
					<div id="clientInfo" style="flex: 1 1 50%;">
						<table class="col">
						<thead>
							<tr>
							<th><strong>공급 받는 자</strong></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><strong>사업자번호:</strong> <span id="clientNumber"></span></td>							
							</tr>
							<tr>
								<td><strong>회사명:</strong> <span id="clientName"></span></td>
							</tr>
							<tr>
								<td><strong>주소:</strong> <span id="clientAddress"></span></td>
							</tr>
							<tr>
								<td><strong>담당자:</strong> <span id="clientPerson"></span></td>
							</tr>
							<tr>
								<td><strong>TEL:</strong> <span id="clientTel"></span></td>
							</tr>
						</tbody>
						</table>
					</div>
					
					<div id="myInfo" style="flex: 1 1 50%;">
						<table class="col">
						<thead>
							<tr>
							<th><strong>공급 하는 자</strong></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><strong>사업자번호: </strong> <span id="myNumber"></span></td>							
							</tr>
							<tr>
								<td><strong>회사명: </strong> <span id="myName"></span></td>
							</tr>
							<tr>
								<td><strong>주소:</strong> <span id="myAddress"></span></td>
							</tr>
							<tr>
								<td><strong>담당자:</strong> <span id="myPerson"></span></td>
							</tr>
							<tr>
								<td><strong>TEL:</strong> <span id="myTel"></span></td>
							</tr>
						</tbody>
						</table>
					</div>
				</div>
					<div id="comment" style="background-color: white;">
					<p>수주일 : <span id=commentOrder></span></p>
					<p style="margin-bottom: 20px;">납기일 : <span id=commentDelivery></span></p>
					<p>1. 귀사의 일이 번창하시길 기원합니다.</p>
					<p>2. 하기와 같이 수주내용을 보내드리오니 확인해주시기 바랍니다.</p>
					</div>
					<div id="totalMoneyDiv" style="background-color: white; margin: 20px 0; width: 100%; height: 50px; font-family: 나눔바른고딕; font-size: 30px; padding: 20px; box-sizing: border-box;">
						<strong>총 액:</strong> <span id="totalMoneyText"></span>   (￦ <span id="totalMoney"></span> 원)
					</div>
					<table class="col">
						<caption>caption</caption>
						<colgroup>
							<col width="5%">
							<col width="30%">
							<col width="10%">
							<col width="20%">
							<col width="10%">
							<col width="25%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">견적서no</th>
								<th scope="col">제품이름</th>
								<th scope="col">납품개수</th>
								<th scope="col">제품단가</th>
								<th scope="col">세액</th>
								<th scope="col">총액</th>
							</tr>
						</thead>
						<tbody id="orderDetailList">
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

               <div class="btn_areaC mt30">
                  <a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
               </div>
            </dd>
         </dl>
         <a href="" class="closePop"><span class="hidden">닫기</span></a>
      </div>
   </form>
   
</body>
</html>