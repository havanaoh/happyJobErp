<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>인사 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link type="text/css" rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.css" />
<link type="text/css" rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid-theme.min.css" />
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.3/jsgrid.min.js"></script>

<!-- 우편번호 조회 -->

<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${CTX_PATH}/js/popFindZipCode.js"></script>

<script type="text/javascript">
	$(function() {
		employeeSearch();
		registerBtnEvent();
		filePreview();
	});

	// 사원 데이터 불러오는 함수
	function employeeSearch(currentPage, emplStatus) {
		
		currentPage = currentPage || 1;

		var param = {
			searchId : $("#searchId").val(),
			searchName : $("#searchName").val(),
			searchRegDateStart : $("#searchRegDateStart").val(),
			searchRegDateEnd : $("#searchRegDateEnd").val(),
			department : $("#searchDepartmentGroup").val(),
			jobGrade : $("#searchJobGradeGroup").val(),
			currentPage : currentPage,
			pageSize : 5,
			emplStatus : emplStatus
		}

		var callback = function(res) {
			var detail = res.employeeList;
			var employeeCnt = res.employeeCnt;

			$("#jsGrid")
					.jsGrid(
							{
								width : "100%",
								height : "400px",
								sorting : true,

								noDataContent : "검색 결과가 없습니다",
								data : detail, // 서버에서 받아온 데이터
								fields : [
										{
											name : "number",
											title : "사번",
											type : "number",
											width : 60,
											align : "center"
										},
										{
											name : "employeeName",
											title : "사원명",
											type : "text",
											width : 80,
											align : "center"
										},
										{
											name : "departmentCode",
											title : "부서코드",
											type : "text",
											width : 80,
											align : "center"
										},
										{
											name : "departmentDetailName",
											title : "부서명",
											type : "text",
											width : 80,
											align : "center"
										},
										{
											name : "jobGradeDetailName",
											title : "직급",
											type : "text",
											width : 80,
											align : "center"
										},
										{
											name : "regDate",
											title : "입사일자",
											type : "text",
											width : 80,
											align : "center"
										},
										{
											name : "emplStatus",
											title : "휴직",
											type : "text",
											width : 50,
											align : "center",
											itemTemplate : function(value) {
												return value === "O" ? "Y"
														: "N";
											}
										},
										{
											name : "resignationDate",
											title : "퇴직일자",
											type : "text",
											width : 80,
											align : "center"
										},
										{
											title : "퇴직처리",
											type : "text",
											width : 80,
											align : "center",
											itemTemplate : function(_, item) {
												return $("<button>")
													.text("퇴직처리")
													.prop("disabled", item.emplStatus === "F")
													.on("click", function() {
														if (item.resignationDate) {
															alert("이미 퇴직처리되었습니다.");
															$("#jsGrid").jsGrid("refresh");
																	return;
															}
														if (!confirm(item.number + " 퇴직처리 하시겠습니까?")) {
																$("#jsGrid").jsGrid("refresh");
																return;
															}
														resignationProcessModal(
															item.number,
															item.employeeName,
															item.regDate,
															item.employeeId,
															item.salary);
															$("#jsGrid").jsGrid("refresh");
														})
											}
										},

								],
								rowClick : function(args) {
									var item = args.item;

									employeeDetailModal(item.employeeId,
											item.jobGradeCode,
											item.departmentCode);
								}
							});

			var pageNavi = getPaginationHtml(currentPage, employeeCnt, 5, 10,
					"employeeSearch", [ emplStatus ]);
			$("#pageSize").html(pageNavi);
		};

		callAjax("/personnel/employeeList.do", "post", "json", false, param,
				callback);
	}

	// 상세보기 모달
	function employeeDetailModal(employeeId, jobGradeCode, departmentCode) {
		$("#preview").html("");
		$("#btnSaveEmployee").hide();
		$("#btnUpdatefile").show();

		var param = {
			employeeId : employeeId,
			jobGradeCode : jobGradeCode,
			departmentCode : departmentCode
		};

		var callback = function(res) {
			var detail = res.detail;

			// 퇴직자(F)면 수정 불가
			if (detail.emplStatus === "F") {
				$("#btnUpdateEmployee").hide();
			} else {
				$("#btnUpdateEmployee").show();
			}

			$("#employeeId").val(detail.employeeId);
			$("#number").val(detail.number);
			$("#employeeName").val(detail.employeeName);
			$("#registrationNumber").val(detail.registrationNumber);
			$("input[name='sex']").each(function() {
				if ($.trim($(this).val()) === $.trim(detail.sex)) {
					$(this).prop("checked", true);
				}
			});
			$("#birthday").val(detail.birthday);
			$("#email").val(detail.email);
			$("#number").val(detail.number);
			$("#hp").val(detail.hp);
			$("#address").val(detail.address);
			$("#addressDetail").val(detail.addressDetail);
			$("#bank").val(detail.bank);
			$("#bankAccount").val(detail.bankAccount);
			$("#finalEducation").val(detail.finalEducation);
			$("#departmentCode").val(detail.departmentCode);
			$("#jobGradeCode").val(detail.jobGradeCode);
			$("#regDate").val(detail.regDate);
			$("#resignationDate").val(detail.resignationDate);
			$("#zipCode").val(detail.zipCode);
			$("#empMemo").val(detail.empMemo);

			if (!detail.resignationDate || detail.resignationDate === null) {
				$("#detailSeverancePay").val(""); // 퇴직일자가 없으면 퇴직금 필드를 비움
			} else {
				if (detail.severancePay) {
					$("#detailSeverancePay").val(
							formatNumberWithComma(detail.severancePay)); // 3자리 콤마 추가
				} else {
					$("#detailSeverancePay").val(formatNumberWithComma(0.00)); // 0.00 형식 유지
				}
			}

			$("#departmentGroup option").each(
					function() {
						if ($.trim($(this).text()) === $
								.trim(detail.departmentDetailName)) {
							$(this).prop("selected", true);
							// 선택된 부서에 따른 직무 목록 업데이트
							updateJobRoleList(detail.departmentDetailName);
						}
					});

			$("#jobGradeGroup option").each(
					function() {
						if ($.trim($(this).text()) === $
								.trim(detail.jobGradeDetailName)) {
							$(this).prop("selected", true);
						}
					});

			setTimeout(function() {
				$("#jobRoleGroup option").each(
						function() {
							if ($.trim($(this).text()) === $
									.trim(detail.jobRoleDetailName)) {
								$(this).prop("selected", true);
							}
						});
			}, 100);

			$("#workingYear").val(detail.workingYear);

			$("input[name='emplStatus']").each(function() {
				if ($.trim($(this).val()) === $.trim(detail.emplStatus)) {
					$(this).prop("checked", true);
				}
			});

			var salaryList = res.salaryClassList;
			switch (detail.workingYear) {
			case 1:
				$("#salary").val(salaryList.year1);
				break;
			case 2:
				$("#salary").val(salaryList.year2);
				break;
			case 3:
				$("#salary").val(salaryList.year3);
				break;
			case 4:
				$("#salary").val(salaryList.year4);
				break;
			case 5:
				$("#salary").val(salaryList.year5);
				break;
			default:
				$("#salary").val(salaryList.year5);
				break;
			}
			formatSalary();

			detailImgPreview(detail);
			console.log("detailImgPreview(detail)", detail);

			gfModalPop("#employeeDetailModal");

		};

		callAjax("/personnel/employeeDetail.do", "post", "json", false, param,
				callback);
	};

	function updateJobRoleList(departmentDetailName) {
		
		var param = {
			departmentDetailName : departmentDetailName
		};

		var callback = function(res) {
			var jobRoleGroupList = res.jobRoleGroupList;
			var jobRoleGroupSelect = $("#jobRoleGroup");

			jobRoleGroupSelect.empty().append('<option value="">-</option>');

			if (jobRoleGroupList && jobRoleGroupList.length > 0) {
				jobRoleGroupList
						.forEach(function(item) {
							jobRoleGroupSelect
									.append('<option value="' + item.jobRoleDetailName + '">'
											+ item.jobRoleDetailName
											+ '</option>');
							console.log(item.jobRoleDetailName);
						});
			}
		};
		callAjax("/personnel/getJobRolesByDepartment.do", "post", "json",
				false, param, callback);
	}

	// 버튼의 이벤트를 등록
	function registerBtnEvent() {
		// 모달 버튼 등록
		$("a[name=btn]").click(function(e) {
			e.preventDefault();

			// 버튼 id 속성(정보)
			var btnId = $(this).attr("id")

			switch (btnId) {
			// id가 btnSaveNotice이면 저장
			case "btnUpdateEmployee":
				employeeUpdate();
				break;
			case "btnSaveEmployee":
				employeeSave();
				break;
			case "btnUpdatefile":
				employeeFileUpdate();
				break;
			case "btnClose":
				gfCloseModal();
				break;
			case "btnSalaryClass":
				salaryClassModal();
				break;
			}
		});
	}

	// 파일 미리보기
	function filePreview() {
		$("#fileInput").change(
				function(e) {
					e.preventDefault();

					var file = $(this)[0].files[0];

					if (file) {
						var fileInfo = $("#fileInput").val();
						var fileInfoSplit = fileInfo.split(".");
						var fileLowerCase = fileInfoSplit[1]
								.toLowerCase();

						var imgPath = "";
						var previewHtml = "";

						// 파일이 이미지일 경우
						if (fileLowerCase === "jpg"
								|| fileLowerCase === "gif"
								|| fileLowerCase === "png") {
							imgPath = window.URL.createObjectURL(file);

							previewHtml = "<img src='" + imgPath + "' id='imgFile' style='width:100px; height: 100px'>";
						}

						$("#preview").html(previewHtml);
					}
				})
	}

	// 상세조회 파일 미리보기
	function detailImgPreview(detailValue) {
		console.log("detailValue: ", detailValue);
		if (detailValue.profileFileName) {
			var ext = detailValue.profileFileExt.toLowerCase();
			var imgPath = "";
			var previewHtml = "<a href='javascript:download()'>";

			if (ext === "jpg" || ext === "gif" || ext == "png") {
				imgPath = detailValue.profileLogicalPath;
				previewHtml += "<img src='" + imgPath + "' id='imgFile' style='width:100px; height: 100px'>";
			}

			previewHtml += "</a>";

			$("#preview").html(previewHtml);

		}
	}

	function download() {
		var employeeId = $("#employeeId").val();

		var hiddenInput = "<input type='hidden' name='employeeId' value='" + employeeId + "'/>";
		$(
				"<form action='employeeDownload.do' method='post' id='fileDownload'> "
						+ hiddenInput + " </form>").appendTo('body').submit()
				.remove();
	}

	function employeeUpdate() {
	    var emplStatus = $("input[name='emplStatus']:checked").val();
	    var employeeNumber = $("#number").val();
	    var employeeName = $("#employeeName").val();
	    var regDate = $("#regDate").val();
	    var employeeId = $("#employeeId").val();
	    var salary = $("#salary").val();

	    var getForm = document.getElementById("employeeForm");
	    getForm.enctype = 'multipart/form-data';

	    var fileData = new FormData(getForm);
	    fileData.append("departmentDetailName", $("#departmentGroup").val());
	    fileData.append("jobGradeDetailName", $("#jobGradeGroup").val());
	    fileData.append("finalEducation", $("#finalEducation").val());
	    fileData.append("bank", $("#bank").val());
	    fileData.append("emplStatus", emplStatus);
	    
	    var updateEmployee = function () {
	        callAjaxFileUploadSetFormData("/personnel/employeeUpdate.do", "post", "json", false, fileData, function (res) {

	            if (res.result === "success") {
	                alert("수정되었습니다.");
	                gfCloseModal();
	                employeeSearch();
	            } else {
	                alert("수정 실패");
	            }
	        });
	    };

	    if (emplStatus === "F") {
	    	alert("퇴직처리하시겠습니까?");
	        resignationProcessModal(employeeNumber, employeeName, regDate, employeeId, salary);

	        // 퇴직 처리가 완료된 후 실행
	        $("#confirmResignation").off("click").on("click", function () {
	            emplStatusUpdate(employeeId, function (success) {
	                if (success) {
	                    updateEmployee(); // 퇴직 처리 후 업데이트 실행
	                }
	            });
	        });

	    } else {
	        updateEmployee();
	    }
	}

	// 호봉 모달
	function salaryClassModal() {
		var modalId = "#employeeDetailModal";

		// salaryClassModal을 열기 전에 employeeDetailModal이 열려 있으면 다시 표시
		var isEmployeeModalVisible = $(modalId).is(":visible");

		gfModalPop("#salaryClassModal");

		// 기존 모달 다시 표시 (숨겨지지 않도록 처리)
		if (isEmployeeModalVisible) {
			$("#employeeDetailModal").show();
		}

	}

	// 신규 등록 모달
	function insertModal() {
		$("#preview").html("");
		// 신규 등록 모달에 대한 조건
		$("#btnSaveEmployee").show();
		$("#btnUpdateEmployee").hide();				

		$("#employeeId").hide();
		$("#number").val("");
		$("#employeeName").val("");
		$("#registrationNumber").val("");
		$("#birthday").val("");
		$("#email").val("");
		$("#number").val("");
		$("#hp").val("");
		$("#address").val("");
		$("#addressDetail").val("");
		$("#bank").val("");
		$("#bankAccount").val("");
		$("#finalEducation").val("");
		$("#departmentCode").val("");
		$("#jobGradeCode").val("");
		$("#regDate").val("");
		$("#resignationDate").val("");
		$("#jobRoleDetailName").val("");

		$("#departmentGroup").val("");
		$("#jobGradeGroup").val("");

		$("#workingYear").val("");
		$("#salary").val("");
		$("#empMemo").val("");
		// 라디오버튼 기본값 설정
		$("input[name='sex'][value='남자']").prop("checked", true);
		$("input[name='emplStatus'][value='W']").prop("checked", true);

		// 라디오 버튼 기본값 설정 + 비활성화
		$("input[name='emplStatus'][value='W']").prop("checked", true).prop(
				"disabled", true);
		$("input[name='emplStatus'][value='F']").prop("disabled", true);
		$("input[name='emplStatus'][value='O']").prop("disabled", true);

		gfModalPop("#employeeDetailModal");
	}

	function employeeSave() {
		var getForm = document.getElementById("employeeForm");

		// 유효성 검사 수행
		if (!validateEmployeeForm()) {
			return false;
		}

		// data 형태 지정
		getForm.entype = 'multipart/form-data';

		var fileData = new FormData(getForm);

		// radio button 요소 값 추가
		var selectSex = $("input[name='sex']:checked").val();
		fileData.append("sex", selectSex);

		var selectEmplStatus = $("input[name='emplStatus']:checked").val();
		fileData.append("emplStatus", selectEmplStatus);

		// select 요소 값 추가
		var departmentGroup = $("#departmentGroup").val();
		fileData.append("departmentDetailName", departmentGroup);

		var jobGradeGroup = $("#jobGradeGroup").val();
		fileData.append("jobGradeDetailName", jobGradeGroup);

		var jobRoleGroup = $("#jobRoleGroup").val();
		fileData.append("jobRoleDetailName", jobRoleGroup);

		var finalEducation = $("#finalEducation").val();
		fileData.append("finalEducation", finalEducation);

		var bank = $("#bank").val();
		fileData.append("bank", bank);

		var fullDate = $("#regDate").val(); // "YYYY-MM-DD" 형식으로 가져옴
		var paymentDate = fullDate ? fullDate.substring(0, 7) : ""; // "YYYY-MM" 형식으로 변환
		fileData.append("paymentDate", paymentDate); // 변환된 값만 전송

		var callback = function(res) {
			if (res.result === "success") {
				alert("저장되었습니다.");
				gfCloseModal();
				employeeSearch();
			}
		}

		callAjaxFileUploadSetFormData("/personnel/employeeSave.do", "post",
				"json", false, fileData, callback);
	}

	function validateEmployeeForm() {
		var employeeName = $("#employeeName").val().trim();
		var sex = $("input[name='sex']:checked").val();
		var emplStatus = $("input[name='emplStatus']:checked").val();
		var birthday = $("#birthday").val().trim();
		var registrationNumber = $("#registrationNumber").val().trim();
		var email = $("#email").val().trim();
		var number = $("#number").val().trim();
		var hp = $("#hp").val();
		var address = $("#address").val().trim();
		var addressDetail = $("#addressDetail").val().trim();
		var bank = $("#bank").val();
		var bankAccount = $("#bankAccount").val().trim();
		var finalEducation = $("#finalEducation").val();
		var departmentCode = $("#departmentGroup").val();
		var jobGradeCode = $("#jobGradeGroup").val();
		var regDate = $("#regDate").val().trim();

		// 직원명 확인
		if (employeeName === "") {
			alert("이름을 입력하세요.");
			$("#employeeName").focus();
			return false;
		}

		// 주민번호 확인
		if (registrationNumber === "") {
			alert("주민번호를 입력하세요.");
			$("#registrationNumber").focus();
			return false;
		}

		// 성별 확인
		if (!sex || sex === "") {
			alert("성별을 선택하세요.");
			return false;
		}

		// 생일 확인
		if (birthday === "") {
			alert("생년월일을 입력하세요.");
			$("#birthday").focus();
			return false;
		}

		// 최종학력 확인
		if (finalEducation === "") {
			alert("최종학력을 선택하세요.");
			$("#finalEducation").focus();
			return false;
		}

		// 이메일 확인
		var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		if (email === "") {
			alert("이메일을 입력하세요.");
			$("#email").focus();
			return false;
		} else if (!emailPattern.test(email)) {
			alert("올바른 이메일 형식을 입력하세요.");
			$("#email").focus();
			return false;
		}

		// 연락처 확인
		if (hp === "") {
			alert("연락처를 입력하세요.");
			$("#hp").focus();
			return false;
		}

		// 주소 확인
		if (address === "") {
			alert("주소를 입력하세요.");
			$("#address").focus();
			return false;
		}

		// 상세주소 확인
		if (addressDetail === "") {
			alert("상세주소를 입력하세요.");
			$("#addressDetail").focus();
			return false;
		}

		// 은행명 확인
		if (bank === "") {
			alert("은행명을 선택하세요.");
			$("#bank").focus();
			return false;
		}

		// 계좌 확인
		if (bankAccount === "") {
			alert("계좌를 입력하세요.");
			$("#bankAccount").focus();
			return false;
		}

		// 부서코드 확인
		if (departmentCode === "") {
			alert("부서를 선택하세요.");
			$("#departmentGroup").focus();
			return false;
		}

		// 직급코드 확인
		if (jobGradeCode === "") {
			alert("직급을 선택하세요.");
			$("#jobGradeGroup").focus();
			return false;
		}

		// 재직상태 확인
		if (!emplStatus || emplStatus === "") {
			alert("재직상태를 선택하세요.");
			return false;
		}

		// 입사일 확인
		if (regDate === "") {
			alert("입사일을 입력하세요.");
			$("#regDate").focus();
			return false;
		}

		return true;

	}

	// 퇴직처리 모달
	function resignationProcessModal(employeeNumber, employeeName, regDate,
			employeeId, salary) {
		$("#resignationProcessNumber").val(employeeNumber);
		$("#resignationProcessEmployeeName").val(employeeName);
		$("#resignationProcessRegDate").val(regDate);
		$("#resignationProcessEmployeeId").val(employeeId);
		$("#resignationProcessSalary").val(salary);
		$("#resignationProcessResignationDate").val("");
		$("#resignationReason").val("");
		$("#resignationProcessSeverancePay").val("");

		console.log("employeeId", employeeId);

		gfModalPop("#resignationProcessModal");
	}

	// 퇴직 버튼 처리
	function emplStatusUpdate(employeeId, callback) {
	    var resignationDate = $("#resignationProcessResignationDate").val().trim();
	    var resignationProcessRegDate = $("#resignationProcessRegDate").val().trim();
	
	    if (!resignationDate || resignationDate === "") {
	        alert("퇴직일을 입력하세요.");
	        return false;
	    }
	
	    if (resignationDate < resignationProcessRegDate) {
	        alert("입사일보다 퇴직일이 이전일 수 없습니다.");
	        return false;
	    }
	
	    var resignationReason = $("#resignationReason").val().trim();
	    if (!resignationReason || resignationReason === "") {
	        alert("퇴직사유를 입력하세요.");
	        return false;
	    }
	
	    var severancePay = $("#resignationProcessSeverancePay").val().trim();
	    if (!severancePay || severancePay === "") {
	        alert("퇴직금을 입력하세요.");
	        return false;
	    }
	
	    var param = {
	        employeeId: $("#resignationProcessEmployeeId").val(),
	        emplStatus: "F",
	        resignationDate: resignationDate,
	        resignationReason: resignationReason,
	        severancePay: $("#severancePayValue").val(),
	        salary: $("#resignationProcessSalary").val()
	    };
	
	    callAjax("/personnel/emplStatusUpdate.do", "post", "json", false, param, function (res) {
	        console.log("퇴직 처리 응답:", res);
	
	        if (res.result === "success") {
	            alert("퇴직처리 되었습니다.");
	            $("#resignationProcessModal").hide();
	            if (callback) callback(true); // 퇴직 성공 → 직원 정보 수정 실행
	            employeeSearch();
	        } else {
	            alert("퇴직 처리에 실패했습니다.");
	            if (callback) callback(false);
	        }
	    });
	}


	function change_btn(e) {
		var btns = document.querySelectorAll(".button");
		btns.forEach(function(btn, i) {
			if (e.currentTarget == btn) {
				if (btn.classList.contains("active")) {
					btn.classList.remove("active");
				} else {
					btn.classList.add("active");
				}
			} else {
				btn.classList.remove("active");
			}
		});
	}

	$(document).ready(function() {
		// 버튼 클릭 시 필터 적용 및 토글 기능 추가
		$("#emplStatusForm a").click(function() {
			var selectedStatus = $(this).attr("data-status"); // 클릭된 버튼의 상태 값 가져오기

			// 현재 선택된 버튼인지 확인 (isSelected: true = 선택됨, false = 해제됨)
			var isSelected = $(this).hasClass("selected");

			// 모든 버튼 스타일 초기화
			$("#emplStatusForm a").removeClass("selected");

			if (isSelected) {
				// 현재 선택된 상태에서 다시 클릭하면 선택 해제 → null 전달
				employeeSearch(1, null);
			} else {
				// 새로운 상태로 검색 실행
				$(this).addClass("selected"); // 현재 버튼만 활성화
				employeeSearch(1, selectedStatus);
			}
		});

		$.fn_modal_ready();

		// 부서 드롭박스 변경 이벤트 리스너 추가
		$("#departmentGroup").change(function() {
			var selectedDepartmentCode = $(this).val();			
			updateJobRoleList(selectedDepartmentCode);
		})
	});

	$.fn_modal_ready = function() {
		$('.closePop2').click(function(e) {
			e.preventDefault();

			$('#mask').hide();
			$('#salaryClassModal').hide();
		});
	}

	function closeSalaryClassModal() {
		$("#salaryClassModal").hide();
	}

	// 우편번호 api
	function execDaumPostcode(q) {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('zipCode').value = data.zonecode;
				document.getElementById("address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("addressDetail").focus();
			}
		}).open({
			q : q
		});
	}

	/** 휴대폰 번호 필터링 */
	function formatPhoneNumber() {
		var searchWord_std = document.getElementById("hp");

		// 숫자로만 이루어진 문자열인지 확인
		var phoneNumber = searchWord_std.value.replace(/[^0-9]/g, "");

		// 처음 3자리가 허용된 번호인지 확인
		if (phoneNumber.length == 3) {
			var prefix = phoneNumber.substring(0, 3);
			if ([ "010", "019", "011", "016", "017" ].indexOf(prefix) === -1) {
				alert("정확한 전화번호를 입력해주세요. 사용 가능한 번호는 010, 011, 016, 017, 019로 시작하는 번호입니다.");
				$("#hp").val("").focus();
				return; // 허용되지 않은 번호이면 함수를 종료
			}
		}
		// 휴대폰 번호 형식에 맞게 하이픈 추가
		if (phoneNumber.length >= 3 && phoneNumber.length <= 7) {
			phoneNumber = phoneNumber.replace(/(\d{3})(\d{1,4})/, "$1-$2");
		} else if (phoneNumber.length >= 8) {
			phoneNumber = phoneNumber.replace(/(\d{3})(\d{3,4})(\d{0,4})/,
					"$1-$2-$3");
		}

		// 13자리까지만 입력받기 (한국기준)
		if (phoneNumber.length > 13) {
			phoneNumber = phoneNumber.substring(0, 13);
		}

		// 입력된 내용을 변경된 번호로 업데이트
		searchWord_std.value = phoneNumber;
	}

	/** 주민번호 필터링 */
	function formatRegistrationNumber() {
		var searchWord_std = document.getElementById("registrationNumber");

		// 숫자로만 이루어진 문자열인지 확인
		var registrationNumber = searchWord_std.value.replace(/[^0-9]/g, "");

		// 주민번호 형식에 맞게 하이픈 추가
		if (registrationNumber.length >= 6) {
			registrationNumber = registrationNumber.replace(/(\d{6})(\d{1,7})/,
					"$1-$2");
		}

		// 13자리까지만 입력받기 (한국기준)
		if (registrationNumber.length > 14) {
			registrationNumber = registrationNumber.substring(0, 14);
		}

		// 입력된 내용을 변경된 번호로 업데이트
		searchWord_std.value = registrationNumber;
	}

	/* 퇴직금 필터링 */
	// 포맷팅만 담당하는 함수 (화면 표시용)
	function formatSeverancePay() {
		var searchWord_std = document
				.getElementById("resignationProcessSeverancePay");

		// 콤마 제거 후 숫자만 추출
		var numericValue = searchWord_std.value.replace(/[^0-9]/g, "");

		// 3자리마다 콤마 추가하여 포맷팅
		var formattedValue = numericValue.replace(/\B(?=(\d{3})+(?!\d))/g, ",");

		// 입력 필드에 포맷팅된 값 표시
		searchWord_std.value = formattedValue;

		// 콤마 없는 원래 값을 hidden 필드에 저장 (실제 DB 저장용)
		document.getElementById("severancePayValue").value = numericValue;
	}

	// 3자리마다 콤마를 추가하는 함수 (소수점 포함)
	function formatNumberWithComma(value) {
		if (!value)
			return "0.00"; // 값이 없으면 기본값 반환

		// 숫자로 변환 (문자열도 처리 가능)
		let
		num = parseFloat(value);

		if (isNaN(num))
			return "0.00"; // 변환 실패 시 기본값 반환

		// toLocaleString()을 사용하여 천 단위 콤마 추가 (소수점 포함)
		return num.toLocaleString("en-US", {
			minimumFractionDigits : 2,
			maximumFractionDigits : 2
		});
	}

	/* 연봉 필터링 */
	function formatSalary() {
		var salaryField = document.getElementById("salary");

		// 값이 존재하는 경우에만 필터링
		if (salaryField.value) {
			// 숫자만 남기기 (숫자 이외의 문자는 모두 제거)
			var salary = salaryField.value.replace(/[^0-9]/g, "");

			// 숫자를 3자리마다 콤마 추가하여 포맷팅
			salary = salary.replace(/\B(?=(\d{3})+(?!\d))/g, ",");

			// 업데이트된 값 적용
			salaryField.value = salary;
		}
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
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">
						<p class="Location">
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav bold">인사/급여</a> <span class="btn_nav bold">인사
								관리</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" style="height: 110px">
							<span style="text-align: left; display: block;">인사 관리</span> <span>
								부서 <select class="departmentGroup" id="searchDepartmentGroup"
								style="width: 100px">
									<option value="">전체</option>
									<c:forEach items="${departmentGroupList}" var="list">
										<option value="${list.departmentDetailName}">
											${list.departmentDetailName}</option>
									</c:forEach>
							</select>
							</span> <span> 직급 <select class="jobGradeGroup"
								id="searchJobGradeGroup" style="width: 100px">
									<option value="">전체</option>
									<c:forEach items="${jobGradeGroupList}" var="list">
										<option value="${list.jobGradeDetailName}">
											${list.jobGradeDetailName}</option>
									</c:forEach>
							</select>
							</span> <span> 사번 <input type="text" id="searchId"
								name="searchId" style="height: 25px; margin-right: 10px;" /> 이름
								<input type="text" id="searchName" name="searchName"
								style="height: 25px; margin-right: 10px;" />


							</span>
						<div
							style="display: flex; align-item: center; gap: 10px; justify-content: space-between; margin: 10px;">
							<span style="display: flex; align-items: center; gap: 10px;">
								<form id="emplStatusForm"
									style="display: flex; align-items: center; gap: 10px;">
									<a class="red button" href="javascript:void(0);"
										id="workingBtn" onclick="change_btn(event)" data-status="W">
										<span>재직자</span>
									</a> <a class="red button" href="javascript:void(0);" id="firedBtn"
										onclick="change_btn(event)" data-status="F"> <span>퇴직자</span>
									</a>
								</form>
							</span> <span class="fr"
								style="display: flex; align-items: center; gap: 10px;">

								입사일 조회 <input type="date" id="searchRegDateStart"
								name="searchRegDateStart"
								style="height: 25px; margin-right: 10px;" /> <input type="date"
								id="searchRegDateEnd" name="searchRegDateEnd"
								style="height: 25px; margin-right: 10px;" /> <a
								class="btnType red" href="javascript:employeeSearch();"
								name="searchbtn" id="searchBtn"><span>검색</span></a> <a
								class="btnType blue" href="javascript:insertModal();"
								name="modal"><span>사원 등록</span></a>
							</span>
						</div>
						</p>


						<div id="jsGrid"></div>

						<!-- 페이징 처리  -->
						<div class="paging_area" id="pageSize"></div>
					</div>

					<h3 class="hidden">풋터 영역</h3> <jsp:include
						page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	<!-- 사원 상세 모달 -->
	<form id="employeeForm" action="" method="">
		<input type="hidden" id="employeeId" name="employeeId">

		<div id="employeeDetailModal" class="layerPop layerType2"
			style="width: 700px;">
			<dl>
				<dt>
					<strong>사원 상세 정보</strong>
				</dt>

				<dd class="content">
					<table class="row">
						<tbody>
							<tr>
								<td rowspan="2" colspan="2">
									<div id="preview"></div>
								</td>
								<th scope="row">사번</th>
								<td colspan=3><input type="text" class="inputTxt p100"
									name="number" id="number" placeholder="자동 입력됨" readonly /></td>
								<th scope="row">이름 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="employeeName" id="employeeName" /></td>
							</tr>
							<tr>
								<th scope="row">주민번호 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									placeholder="숫자만 입력" name="registrationNumber"
									id="registrationNumber"
									oninput="javascript:formatRegistrationNumber()" /></td>
								<th scope="row">성별 <span class="font_red">*</span></th>
								<td colspan="3"><label> <input type="radio"
										name="sex" value="남자" checked="checked"> 남자
								</label> <label> <input type="radio" name="sex" value="여자">
										여자
								</label></td>
							</tr>
							<tr>
								<td colspan="2"><input type="file" class="inputTxt p100"
									name="fileInput" id="fileInput" /></td>
								<th scope="row">생년월일 <span class="font_red">*</span></th>
								<td colspan="3"><input type="date" class="inputTxt p100"
									name="birthday" id="birthday" /></td>
								<th scope="row">최종학력 <span class="font_red">*</span></th>
								<td colspan="3"><select class="finalEducation"
									id="finalEducation" style="width: 100px">
										<option value="">선택 필수</option>
										<option value="초졸">초졸</option>
										<option value="중졸">중졸</option>
										<option value="고졸">고졸</option>
										<option value="대졸">대졸</option>
										<option value="석사">석사</option>
										<option value="박사">박사</option>
								</select></td>
							</tr>
						</tbody>
					</table>
					<table class="row">
						<tbody>
							<tr>
								<th scope="row">이메일<span class="font_red">*</span></th>
								<td colspan=3><input type="email" class="inputTxt p100"
									name="email" id="email" /></td>
								<th scope="row">연락처 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" name="hp" id="hp"
									placeholder="숫자만 입력" class="inputTxt p100"
									oninput="javascript:formatPhoneNumber()" /></td>
							</tr>
							<tr>
								<th scope="row">우편번호 <span class="font_red">*</span></th>
								<td colspan="2"><input type="text" class="inputTxt p100"
									name="zipCode" id="zipCode" /></td>

								<td><input type="button" value="우편번호 찾기"
									onclick="execDaumPostcode()"
									style="width: 130px; height: 28px;" /></td>
								<th scope="row" rowspan="2">은행계좌 <span class="font_red">*</span></th>
								<td colspan="3"><select class="bank" id="bank"
									style="width: 100px">
										<option value="">선택 필수</option>
										<option value="기업">기업</option>
										<option value="하나">하나</option>
										<option value="농협">농협</option>
										<option value="우리">우리</option>
										<option value="신한">신한</option>
										<option value="카카오뱅크">카카오뱅크</option>
										<option value="국민">국민</option>
										<option value="수협">수협</option>
										<option value="케이뱅크">케이뱅크</option>
										<option value="산업">산업</option>
								</select></td>
							</tr>
							<tr>
								<th scope="row" rowspan="2">주소 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="address" id="address" placeholder="주소" /></td>

								<td colspan="3"><input type="text" class="inputTxt p100"
									name="bankAccount" id="bankAccount" placeholder="계좌번호" /></td>
							</tr>
							<tr>
								<td colspan="5"><input type="text" class="inputTxt p100"
									name="addressDetail" id="addressDetail" placeholder="상세주소" /></td>
							</tr>
						</tbody>
					</table>
					<table class="row">
						<tbody>
							<tr>
								<th scope="row">부서<span class="font_red">*</span></th>
								<td colspan=3><select class="departmentGroup"
									id="departmentGroup" style="width: 100px">
										<option value="">전체</option>
										<c:forEach items="${departmentGroupList}" var="list">
											<option value="${list.departmentDetailName}">
												${list.departmentDetailName}</option>
										</c:forEach>
								</select></td>
								<th scope="row">부서코드</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="departmentCode" id="departmentCode" placeholder="자동 입력됨"
									readonly /></td>
								<th scope="row">직무</th>
								<td colspan="3"><select class="jobRoleGroup"
									id="jobRoleGroup" style="width: 100px">
										<option value="">-</option>
								</select></td>
							</tr>
							<tr>
								<th scope="row">직급 <span class="font_red">*</span></th>
								<td colspan="3"><select class="jobGradeGroup"
									id="jobGradeGroup" style="width: 100px">
										<option value="">전체</option>
										<c:forEach items="${jobGradeGroupList}" var="list">
											<option value="${list.jobGradeDetailName}">
												${list.jobGradeDetailName}</option>
										</c:forEach>
								</select></td>
								<th scope="row">직급코드</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="jobGradeCode" id="jobGradeCode" placeholder="자동 입력됨"
									readonly /></td>
								<th scope="row">재직구분 <span class="font_red">*</span></th>
								<td colspan="3"><label> <input type="radio"
										name="emplStatus" value="W" checked="checked"> 재직
								</label> <label> <input type="radio" name="emplStatus" value="F">
										퇴직
								</label> <label> <input type="radio" name="emplStatus" value="O">
										휴직
								</label></td>
							</tr>
							<tr>
								<th scope="row">입사일 <span class="font_red">*</span></th>
								<td colspan="3"><input type="date" class="inputTxt p100"
									name="regDate" id="regDate" /></td>
								<th scope="row">퇴직일</th>
								<td colspan="3"><input type="date" class="inputTxt p100"
									name="resignationDate" id="resignationDate" readonly /></td>
								<th scope="row">근무연차</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="workingYear" id="workingYear" placeholder="자동 입력됨"
									readonly /></td>
							</tr>
							<tr>
								<th scope="row">연봉</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="salary" id="salary" oninput="formatSalary()"
									placeholder="자동 입력됨" /> <a class="btnType red"
									href="javascript:salaryClassModal();" name="btn"
									id="btnSalaryClass"><span>호봉</span></a></td>
								<th scope="row">퇴직금</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="detailSeverancePay" id="detailSeverancePay"
									placeholder="퇴직시 자동 입력됨" readonly /></td>
								<th scope="row">비고</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="empMemo" id="empMemo" /></td>
							</tr>
						</tbody>
					</table>
					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnUpdateEmployee" name="btn"><span>수정</span></a>
						<a href="" class="btnType blue" id="btnSaveEmployee" name="btn"><span>등록</span></a>
						<a href="javascript:gfCloseModal();" class="btnType gray"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop" data-modal-target="detailModal"><span
				class="hidden">닫기</span></a>

		</div>
		<!-- 호봉 모달 -->
		<div id="salaryClassModal" class="layerPop layerType2"
			style="width: 600px;">
			<dl>
				<dt>
					<strong>호봉</strong>
				</dt>
				<dd class="content2">
					<table class="row">
						<caption>caption</caption>
						<tbody>
							<tr>
								<th scope="row">직급명</th>
								<th scope="row">1년차</th>
								<th scope="row">2년차</th>
								<th scope="row">3년차</th>
								<th scope="row">4년차</th>
								<th scope="row">5년차</th>
							</tr>


							<tr>
								<c:forEach items="${salaryClassList}" var="list">
									<tr>
										<td>${list.detailName}</td>
										<td>${list.year1}</td>
										<td>${list.year2}</td>
										<td>${list.year3}</td>
										<td>${list.year4}</td>
										<td>${list.year5}</td>
									</tr>
								</c:forEach>
							</tr>
						</tbody>
					</table>


				</dd>
			</dl>
			<a href="" class="closePop2" data-modal-target="salaryModal"><span
				class="hidden">닫기</span></a>
		</div>
	</form>

	<!-- 퇴직처리 모달 -->
	<div id="resignationProcessModal" class="layerPop layerType2"
		style="width: 600px;">
		<input type="hidden" id="resignationProcessEmployeeId"
			name="employeeId"> <input type="hidden"
			id="resignationProcessSalary" name="salary"> <input
			type="hidden" id="severancePayValue" name="severancePayValue"
			value="0">
		<dl>
			<dt>
				<strong>퇴직처리</strong>
			</dt>
			<dd class="content">
				<table class="row">
					<caption>caption</caption>

					<tbody>
						<tr>
							<th scope="row">사번</th>
							<td colspan=3><input type="text" class="inputTxt p100"
								name="number" id="resignationProcessNumber" readonly /></td>
							<th scope="row">이름</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								name="employeeName" id="resignationProcessEmployeeName" readonly /></td>
						</tr>
						<tr>
							<th scope="row">입사일</th>
							<td colspan="3"><input type="date" class="inputTxt p100"
								name="regDate" id="resignationProcessRegDate" readonly /></td>
							<th scope="row">퇴직일<span class="font_red">*</span></th>
							<td colspan="3"><input type="date" class="inputTxt p100"
								name="resignationDate" id="resignationProcessResignationDate" /></td>
						</tr>
						<tr>
							<th scope="row">퇴직사유<span class="font_red">*</span></th>
							<td colspan="7"><input type="text" class="inputTxt p100"
								name="resignationReason" id="resignationReason" /></td>
						</tr>
						<tr>
							<th scope="row">퇴직금<span class="font_red">*</span></th>
							<td colspan="7"><input type="text" class="inputTxt p100"
								placeholder="숫자만 입력" name="severancePay"
								id="resignationProcessSeverancePay"
								oninput="javascript:formatSeverancePay()" /></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_areaC mt30">
					<a class="btnType blue" href="javascript:emplStatusUpdate()"
						name="modal"><span>퇴직</span></a>
				</div>
			</dd>
		</dl>

		<a href="" class="closePop"><span class="hidden">닫기</span></a>

	</div>

</body>

<style>
.button.active span {
	background: #2E9ACC;
}

.button.active {
	background: #2E9ACC;
}

.button {
	display: inline-block;
	padding-left: 10px;
	background: url(/images/admin/comm/set_btnBg.png) 0 0px no-repeat;
}

.button span {
	display: inline-block;
	padding-right: 10px;
	min-width: 80px;
	height: 31px;
	line-height: 31px;
	font-family: '나눔바른고딕', NanumBarunGothic;
	font-size: 15px;
	color: #fff;
	text-align: center;
	font-weight: 400;
	background: url(/images/admin/comm/set_btnBg.png) 100% 0px no-repeat;
}
</style>
</html>