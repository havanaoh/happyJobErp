<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>견적서 등록 및 조회</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
	$(function() {
		estimateSearch();
		loadClientOptions(false);
		loadProductOptions();
		registerBtnEvent();
		
		 $("#manufacturerSelect").change(function() {
		        var selectedManufacturerId = $(this).val();
		        loadMajorCategoryOptions(selectedManufacturerId);
		        });
		 
		 $("#estimateProductSelect").change(function() {
			 var selectedProduct = $(this).find("option:selected");
						 
			 var unitPrice = selectedProduct.data("unit-price");
			 
			 console.log("unitPrice : " ,unitPrice);
			 console.log("selectedProduct : " ,selectedProduct);
			 
			 $("#estimateUnitPriceInput").val(unitPrice);
		 });
		 
		 $("#subCategorySelect").change(function() {
			 loadEstimateProductOptions($(this).val());
		 });
		 
		 $("#majorCategorySelect").change(function() {
			 loadMajorCategoryOptions($(this).val());
		 });
		 
	});
	
	function registerBtnEvent() {
		$("#searchBtn").click(function(e){
			e.preventDefault();
			estimateSearch();
		});
		
		$("#btnInsertEstimate").click(function(e) {
			e.preventDefault();
			$("#estimateEmpty").hide();
	        addEstimateRow();
	    });
		
		$(document).on("click", ".deleteRow", function() {
	        removeEstimateRow(this);
	    });
		
	    $("#btnDeleteEstimate").click(function(e) {
	        e.preventDefault();
	        $("#estimateInsertList").empty();
	    });
	    
	    $("#btnSaveEstimate").click(function(e) {
	        e.preventDefault();
	        saveEstimate();
	    });
	}
	
	function estimateSearch(currentPage) {
		currentPage = currentPage || 1;
		    
		var param = {
				searchEstimateDate: $("#searchEstimateDate").val(),
				searchDeliveryDate: $("#searchDeliveryDate").val(),
				searchClientId: $("select[name='client']").val(),
				searchProductId: $("select[name='product']").val(),
				currentPage: currentPage,
				pageSize: 5
		}
		
		var callback = function(res) {
			$("#resultList").html(res);
			var pageNavi = getPaginationHtml(currentPage, $("#totcnt").val(), 5, 10, "estimateSearch");
			$("#pageSize").html(pageNavi);
		}
		
		callAjax("/business/estimateList", "post", "text", false, param, callback);
	}
	
	function loadClientOptions(isInsertModal) {
		
		var callback = function(res) {
			console.log(res);
			
			/* var clientSelect = $("select[name='client']"); */
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
			console.log(res);
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
			
			loadEstimateProductOptions(res[0].subCode);
		};
		
		callAjax("/business/subCategoryNames", "post", "json", true, param, callback);
	}
	
	function loadEstimateProductOptions(subCode) {
		if(!subCode) {
			$("#estimateProductSelect").empty().append('<option value="">소분류를 선택하세요</option>');
			$("#estimateUnitPriceInput").val("");
	        return;
		}
		
		param = {
				subCode: subCode
		}
		
		var callback = function(res) {
			
			var estimateProductSelect = $("select[name='estimateProduct']");
			estimateProductSelect.empty();
			
			res.forEach(function(op) {
				estimateProductSelect.append('<option value="' + op.productId + '" data-unit-price= "' + op.unitPrice + '">' + op.productName+ '</option>');
			});
			
			$("#estimateUnitPriceInput").val(res[0].unitPrice);
		};
		
		callAjax("/business/estimateProductNames", "post", "json", true, param, callback);
	}
		
	function insertModal() {
		loadClientOptions(true);
		loadManufacturerOptions();
		$("#estimateEmpty").show();
		$("#majorCategorySelect").empty().append('<option value="">제조업체를 선택하세요</option>');
		$("#subCategorySelect").empty().append('<option value="">대분류를 선택하세요</option>');
		$("#estimateProductSelect").empty().append('<option value="">소분류를 선택하세요</option>');
		$("#estimateUnitPriceInput").val("");

		gfModalPop("#estimateInsertModal");
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
	
	function estimateDetailModal(id, clientId) {
		var param = {
				estimateId: id,
				clientId: clientId
		}
		
		var callback = function(res) {
			var detailList = res.estimateDetail;
			var estimate = res.estimate;
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
			$("#myPerson").text(estimate.estimateEmpName);
			$("#myTel").text("02-857-7819");
			
			//
	        var totalAmount = estimate.totalSupplyPrice + estimate.totalTax;
	        var totalAmountKorean = convertNumberToKorean(totalAmount); 
        
			$("#commentEstimate").text(estimate.estimateDate);
			$("#commentDelivery").text(estimate.deliveryDate);
			$("#totalMoneyText").text(totalAmountKorean); 
		 	$("#totalMoney").text(gfFormatNumberWithComma(totalAmount));  
			
			// estimatedetail
	        var detailHtml = "";
	        
	        if (detailList && detailList.length > 0) {
	            detailList.forEach(function(detail) {
	                detailHtml += "<tr>" +
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
	        
	        $("#estimateDetailList").html(detailHtml);

			gfModalPop("#detailModal");

		}
		
		callAjax("/business/estimateDetail", "post", "json", false, param, callback);
	}
	
	// 행 추가 기능
	function addEstimateRow() {
		var manufacturerId = $("#manufacturerSelect").val();
	    var manufacturerText = $("#manufacturerSelect option:selected").text();

	    var majorCategoryId = $("#majorCategorySelect").val();
	    var majorCategoryText = $("#majorCategorySelect option:selected").text();

	    var subCategoryId = $("#subCategorySelect").val();
	    var subCategoryText = $("#subCategorySelect option:selected").text();

	    var productId = $("#estimateProductSelect").val()
	    var productText = $("#estimateProductSelect option:selected").text();
	    
	    var unitPrice = $("#estimateUnitPriceInput").val();
	    var quantity = $("#estimateQuantityInput").val();
	    var supplyPrice = $("#estimateSupplyPriceInput").val();

	    // 값이 비어 있으면 추가하지 않음
	    if (!manufacturerId || !majorCategoryId || !subCategoryId || !productId || !unitPrice || !quantity || !supplyPrice) {
	        alert("모든 값을 입력하세요.");
	        return;
	    }

	    var newRow = "<tr data-manufacturer-id='" + manufacturerId + "' data-major-category-id='" + majorCategoryId +
	    	"' data-sub-category-id='" + subCategoryId + "' data-product-id='" + productId + "'>" +
			"<td>" + manufacturerText + "</td>" +
			"<td>" + majorCategoryText + "</td>" +
			"<td>" + subCategoryText + "</td>" +
			"<td>" + productText + "</td>" +
			"<td>" + unitPrice + "</td>" +
			"<td>" + quantity + "</td>" +
			"<td>" + supplyPrice + "</td>" +
			"<td><button class='deleteRow'>삭제</button></td>" +
			"</tr>";

	    $("#estimateInsertList").append(newRow);
	}

	// 행 삭제 기능
	function removeEstimateRow(button) {
	    $(button).closest("tr").remove();
	}
	
	function saveEstimate() {
	    var clientId = $("#insertClientSelect").val();
	    var estimateDeliveryDate = $("#estimateDeliveryDateInput").val();
	    var estimateSalesArea = $("#estimateSalesAreaSelect").val();
	    
	    if (!clientId) {
	        alert("거래처를 선택하세요.");
	        return;
	    }

	    if (!estimateDeliveryDate) {
	        alert("납기일을 입력하세요.");
	        return;
	    }
	    
		var estimateData = [];
		
		$("#estimateInsertList tr").each(function() {
	        var row = $(this);
	        var rowData = {
	            manufacturerId: row.data("manufacturer-id"),
	            majorCategoryId: row.data("major-category-id"),
	            subCategoryId: row.data("sub-category-id"),
	            productId: row.data("product-id"),
	            unitPrice: row.find("td").eq(4).text(),
	            quantity: row.find("td").eq(5).text(),
	            supplyPrice: row.find("td").eq(6).text()
	        };
	        estimateData.push(rowData);
	    });
		
		if (estimateData.length === 0) {
		        alert("저장할 견적이 없습니다.");
		        return;
	    }
		
		var param = {
			    clientId: clientId,
			    estimateDeliveryDate: estimateDeliveryDate,
			    estimateSalesArea: estimateSalesArea,
			    estimateList: estimateData
		};
		
		$.ajax({
	        url: "/business/saveEstimate",
	        type: "POST",
	        dataType: "json",
	        contentType: "application/json",  // JSON 요청을 위한 설정
	        data: JSON.stringify(param),  // JSON 문자열로 변환하여 전송
	        success: function (res) {	        	
	            if (res.result === "success") {
	                alert("견적서가 저장되었습니다.");
	                $("#estimateInsertList").empty();
					gfCloseModal();	             
					estimateSearch();
	            } else {
	                alert("저장 중 오류가 발생했습니다.");
	            }
	        },
	        error: function (xhr, status, err) {
	            alert("A system error has occurred.");
	        }
	    });
	    
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
							<a href="#" class="btn_nav bold">영업 관리</a> 
							<span class="btn_nav bold">견적서 등록 및 조회</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						
						<p class="conTitle" style="height: 120px">
							<span>견적서 등록/조회</span>
							<span class="fr">
								견적일
	                          	<input type="date" id="searchEstimateDate" name="searchEstimateDate" style="height: 25px; margin-right: 10px;"/> 
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
						
						<div class=estimateList">
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
											<th scope="col">견적직원</th>
											<th scope="col">견적일</th>
											<th scope="col">거래처</th>
											<th scope="col">제품명</th>
											<th scope="col">납기일</th>
											<th scope="col">총 납품<br>개수</th>
											<th scope="col">총 공급<br>가액</th>
											<th scope="col">총 세액</th>
											<th scope="col">영역구분<br>(scm/영업)</th>
											<th scope="col">견적상세조회</th>
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
	
	<div id="estimateInsertModal" class="layerPop layerType2" style="width: 1000px;"> 
		<!-- <input type="hidden" id="noticeSeq"/> -->
		<dl>
			<dt>
				<strong>견적서 작성</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<div id="insertClientInfo">
						거래처 <select id="insertClientSelect" name="client"></select>	
						납기일<input type="date" name="estimateDeliveryDate" id="estimateDeliveryDateInput" style="height: 30px;"></input>
						영역구분<select name="estimateSalesArea" id="estimateSalesAreaSelect">
							<option>SCM</option>
							<option>영업</option>
						</select>
				</div>
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="10%">
						<col width="10%">					
						<col width="10%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr>
				             <th scope="col">제조업체</th>
				             <th scope="col">대분류</th>
				             <th scope="col">소분류</th>
				             <th scope="col">제품명</th>
				             <th scope="col">제품단가</th>
				             <th scope="col">수량</th>
				             <th scope="col">공급가액</th>
				             <th scope="col">삭제</th>
						</tr>
					</thead>
					<tbody id="estimateEmpty">
						<tr>
						<td colspan='8'>등록버튼을 클릭하면 여기에 등록됩니다.</td>
						</tr>
					</tbody>
					<tbody id="estimateInsertList">
					</tbody>
				</table>
				
				<table class="row" style="margin: 10px 0;">
					<tr id="insertEstimateInfo">
						<th>제조업체</th> <td><select name="manufacturer" id="manufacturerSelect"></select></td>
						<th>대분류</th> <td> <select name="majorCategory" id="majorCategorySelect"></select></td>
						<th>소분류</th> <td> <select name="subCategory" id="subCategorySelect"></select></td>
					</tr>
				
					<tr id="insertProductInfo">
						<th>제품</th> <td> <select name="estimateProduct" id="estimateProductSelect"></select>
						<th>제품단가</th> <td> <input name="estimateUnitPrice" id="estimateUnitPriceInput" style="width: 100px; height: 30px;" readonly></input></td>
						<th>수량</th> <td> <input name="estimateQuantity" id="estimateQuantityInput" style="width: 100px; height: 30px;"></input></td>
						<th>공급가액</th> <td> <input name="estimateSupplyPrice" id="estimateSupplyPriceInput" style="width: 100px; height: 30px;"></input></td>
					</tr>
				</table>
					<div id="insertEstimateBtn">
						<a href="" class="btnType blue" id="btnInsertEstimate" name="btn"><span>등록</span></a>
						<a href="" class="btnType blue" id="btnDeleteEstimate" name="btn"><span>전체삭제</span></a>
					</div>
				

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveEstimate" name="btn"><span>저장</span></a> 
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	<form id="estimateForm" action="" method="">
      <input type="hidden" id="estimateId" name="estimateId">
      <!-- 수정시 필요한 num 값을 넘김  -->
      <div id="detailModal" class="layerPop layerType2" style="width: 1000px; ">
         <dl>
            <dt>
               <strong>견적서 상세조회</strong>
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
					<p>견적일 : <span id=commentEstimate></span></p>
					<p style="margin-bottom: 20px;">납기일 : <span id=commentDelivery></span></p>
					<p>1. 귀사의 일이 번창하시길 기원합니다.</p>
					<p>2. 하기와 같이 견적내용을 보내드리오니 확인해주시기 바랍니다.</p>
					</div>
					<div id="totalMoneyDiv" style="background-color: white; margin: 20px 0; width: 100%; height: 50px; font-family: 나눔바른고딕; font-size: 30px; padding: 20px; box-sizing: border-box;">
						<strong>총 액:</strong> <span id="totalMoneyText"></span>   (￦ <span id="totalMoney"></span> 원)
					</div>
					<table class="col">
						<caption>caption</caption>
						<colgroup>
							<col width="30%">
							<col width="10%">
							<col width="20%">
							<col width="10%">
							<col width="25%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">제품이름</th>
								<th scope="col">납품개수</th>
								<th scope="col">제품단가</th>
								<th scope="col">세액</th>
								<th scope="col">총액</th>
							</tr>
						</thead>
						<tbody id="estimateDetailList">
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