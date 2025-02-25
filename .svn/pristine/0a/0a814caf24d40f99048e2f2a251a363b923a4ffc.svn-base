package kr.happyjob.study.personnel.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import kr.happyjob.study.login.model.LgnInfoModel;
import kr.happyjob.study.personnel.model.AttendanceModel;
import kr.happyjob.study.personnel.model.AttendanceRequestModel;
import kr.happyjob.study.system.model.NoticeModel;

public interface AttendanceService {
	List<AttendanceModel> attendanceCnt(Map<String, Object> paramMap) throws Exception;
		
	List<AttendanceRequestModel> attendanceRequestList(Map<String, Object> paramMap) throws Exception;
	
	List<AttendanceRequestModel> approveDetailList(Map<String, Object> paramMap) throws Exception;
	
	LgnInfoModel userInfo(Map<String, Object> paramMap) throws Exception;

	AttendanceRequestModel attendanceRequestDetail(Map<String, Object> paramMap) throws Exception;

	int attendanceRequest(Map<String, Object> paramMap) throws Exception;

	int attendanceRequestUpdate(Map<String, Object> paramMap) throws Exception;

	int attendanceRequestCancle(Map<String, Object> paramMap) throws Exception;

	int attendanceFirstApprove(Map<String, Object> paramMap) throws Exception;

	int attendanceReject(Map<String, Object> paramMap) throws Exception;

	int attendanceApproveReject(Map<String, Object> paramMap) throws Exception;

	int attendanceSecondApprove(Map<String, Object> paramMap) throws Exception;

	int attendanceRequestCnt(Map<String, Object> paramMap) throws Exception;

	List<AttendanceRequestModel> attendanceRequestCalendar(Map<String, Object> paramMap) throws Exception;

	
			
}
