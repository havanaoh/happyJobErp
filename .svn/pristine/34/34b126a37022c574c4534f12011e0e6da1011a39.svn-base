<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>지출결의서</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery.print/1.6.0/jQuery.print.min.js"></script>
<script type="text/javascript">
function printArea(){
	
    var printArea = $("#voucherTable");
    printArea.print();
}



</script>
<style>
table, td, th {
 border : 1px solid black; 
 border-collapse : collapse; 
}
@media print {
  @page { margin: 0; }
  body { margin: 1.6cm; }
}
#exp_title{
	margin: 30px 0;
	font-size: 25px;
	font-weight: 700;
	text-align: center;
}
</style>
</head>
<body>
	
	<div id="expense" style="width: 1080px;">		
		<dl>
			<dd class="content" id="voucherTable">	
			<p id="exp_title">지출결의서</p>			
				<table class="row" >				
					<tbody>
						<tr>
							<th scope="row" colspan="2">결의번호</th>
							<td id="exp_id" colspan="2"></td>
							<th scope="row" colspan="2">사원명</th>
							<td id="emp_name" colspan="2"></td>
							<th scope="row" colspan="2">부서명</th>
							<td id="use_dept" colspan="2"></td>
								
						</tr>
						<tr>
							<th scope="row" colspan="3">신청일자</th>
							<td id="request_date" colspan="3"></td>
								<th scope="row" colspan="3">사용일자 </th>
							<td id="use_date" colspan="3"></td>							
						</tr>
						<tr id="writer">
							<th scope="row" colspan="3">계정대분류명</th>
							<td id="accountGroup" colspan="3">							
							</td>
							<th scope="row" colspan="3">계정과목명</th>
							<td id="accountDetail" colspan="3">
							</td>							
						</tr>
						<tr>
							<th scope="row" colspan="6">결의금액</th>
							<td id="exp_pay" colspan="6"></td>							
						<tr>
                        	<th scope="row"  colspan="12">비고</th>
                     	</tr>
						<tr>							
							<td colspan="12" id="expenseContent">								
							</td>
						</tr>
					</tbody>
				</table>

				<div class="btn_areaC mt30">
					<p><span>위 금액을 영수(청구)합니다.</span></p>
					<p><span>영수자 <span id="sign_name"></span>  (인)</span></p>
				</div>
			</dd>
			<div class="btn_areaC mt30">
					<a href="javascript:printArea()" class="btnType blue" id="btnPrintVoucher" name="btn"><span>인쇄</span></a> 
					<a href="javascript:window.close()"	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
		</dl>
	</div>
	
	
</body>
</html>