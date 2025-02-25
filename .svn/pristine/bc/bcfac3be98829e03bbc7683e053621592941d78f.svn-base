<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title> 근태 현황 조회  </title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" />
<link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.3.2/index.global.min.js"></script>

<!-- fullCalendar css import -->
<link rel="stylesheet" type="text/css" href="/css/fullcalendar/main.css" />
<!-- fullCalendar js import -->
<script src='/js/fullcalendar/main.js'></script>
<script src='/js/fullcalendar/ko.js'></script>
<script>

	document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    var calendar = new FullCalendar.Calendar(calendarEl, {	     
	      selectable: true,
	      initialView: 'dayGridMonth',
	      height: '700px',
	      locale: 'ko',
	      headerToolbar: {
    	      left : 'prev',
    	      center: 'title',
    	      right : 'today next',
    	  },    	 
    	  events: function(info, callback){
	    	  $.ajax({
	    		url: '/personnel/attendanceCalendar.do',
	    		type: 'POST',	    		  
	   			dataType : 'json',	   			
	   			success : function(res){
	   				var reqList = res.attendanceList;
	   				var reqStDate = {};
	   				
	   				for(var i=0; i<reqList.length; i++){
	   					var date = reqList[i].reqSt
	   					var status = reqList[i].reqStatus; 
	   					
	   					if(!reqStDate[date]){
	   						reqStDate[date] = {
	   							"반려":0,
	   							"승인 대기":0,
	   							"승인":0,
	   							"검토 대기":0,
	   						};
	   					}
	   					
	   					if (reqStDate[date][status] !== undefined) {
	   						reqStDate[date][status]++;
                        }
	   				}	   					
	   				var attendanceList = [];
	   					for(var date in reqStDate){
	   						var statusCnt = reqStDate[date];
	   						
	   						for (var status in statusCnt) {
	                            if (statusCnt[status] > 0) {
	                                var statusColor = "";
	                                var statusCode = "";

	                                // 상태에 따라 색상 및 코드 설정
	                                if (status === "승인 대기") {
	                                    statusColor = "#E6B800";
	                                    statusCode = "F";
	                                } else if (status === "승인") {
	                                    statusColor = "#71C379";
	                                    statusCode = "S";
	                                } else if (status === "반려") {
	                                    statusColor = "#E57373";
	                                    statusCode = "N";
	                                } else {
	                                    statusColor = "#5B91D4";
	                                    statusCode = "W";
	                                }

	                                // 각각의 상태에 대해 개별 이벤트로 추가
	                                attendanceList.push({
	                                    title: status + " " + statusCnt[status] + "건",
	                                    start: new Date(date),
	                                    color: statusColor,
	                                    allDay: true,
	                                    extendedProps: {
	                                        statusCnt: statusCnt,
	                                        statusCode: statusCode
	                                    },
	                                });
	                            }
	                        }
	                    }
	                    callback(attendanceList);
	   			}
	    	  });	    	  
	      },
	      eventClick : function(info){	    	  
	    	  var statusCode = info.event.extendedProps.statusCode;
	    	  console.log(info.event.start)
	    	  var reqSt = $.datepicker.formatDate("yy-mm-dd", new Date(info.event.start));
	    	  /* var reqSt = info.event.start.toISOString().split('T')[0]; */
	    	  console.log(reqSt)
	    	  var param = {
	    		  searchStDate: reqSt,
	    		  req_status: statusCode
	    	  }
	    	  var callback = function(res){	    		  
	    		  console.log(res.attendanceList)
	    		  var detail = res.attendanceList;
	    		  
	    		  $("#approveDetail").jsGrid({
	    			width: "100%",
	  				noDataContent: "검색 결과가 없습니다",
	  				data: detail, 
	  				fields:[
	  				        {name: "deptName", title: "부서", type: "text", width: 50, align: "center"},
	  				        {name: "name", title: "사원명", type: "text", width: 50, align: "center"},
	  				        {name: "reqType", title: "신청구분", type: "text", width: 50, align: "center"},
	  				        ], 
	    		  });
	    	  }
	    	  gfModalPop("#approveDetailModal");	    	  
	    	  callAjax("/personnel/approveDetail.do", "post", "json", false, param, callback)
	      },
	      eventDidMount: function(info) {
	            if (info.event.source.id === 'holidaySource') {
	                // 공휴일의 텍스트 색을 빨간색으로 적용
	                info.el.style.color = 'red';
	                info.el.style.fontWeight = 'bold';
	                console.log(info)
	            }
	        },	        
	    });
	    calendar.render()
	  })
		
</script>
</head>
<body> 

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
							<a href="#" class="btn_nav bold">인사/급여</a> 
							<span class="btn_nav bold">근태 현황 조회</span> 
							<a href="#" class="btn_set refresh">새로고침</a>
						</p>						
					<p class="conTitle">
						<span> 근태 현황 조회</span>						
					</p>					 						
					<div id="calendar"></div>										
					</div> <!--// content -->
					
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<div id="approveDetailModal" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>신청 현황</strong>
			</dt>
			<dd class="content">
			
				<div id="approveDetail"></div>
				
				<div class="btn_areaC mt30">					
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>
	
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</body>
<style>	    
.fc-day-sun .fc-col-header-cell-cushion {
	color: red;	
}
.fc-day-sat .fc-col-header-cell-cushion {
	color: blue;	
}
.fc-daygrid-day.fc-day-sun .fc-daygrid-day-number{
	color: red;	
}
.fc-daygrid-day.fc-day-sat .fc-daygrid-day-number{		
	color: blue;	
}
</style>
</html>

