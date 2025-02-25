package kr.happyjob.study.personnel.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.NoticeModel;
import kr.happyjob.study.login.model.LgnInfoModel;
import kr.happyjob.study.personnel.model.AttendanceModel;
import kr.happyjob.study.personnel.model.AttendanceRequestModel;

public interface AttendanceDao {
		
	List<AttendanceRequestModel> attendanceRequestList(Map<String, Object> paramMap) throws Exception;
	
	List<AttendanceRequestModel> attendanceRequestCalendar(Map<String, Object> paramMap) throws Exception;

	AttendanceRequestModel attendanceRequestDetail(Map<String, Object> paramMap) throws Exception;

	List<AttendanceRequestModel> approveDetailList(Map<String, Object> paramMap)throws Exception;
	
	List<AttendanceModel> attendanceCnt(Map<String, Object> paramMap);
		
	LgnInfoModel userInfo(Map<String, Object> paramMap) throws Exception;

	int attendanceRequest(Map<String, Object> paramMap) throws Exception;
	
	int attendanceRequestUpdate(Map<String, Object> paramMap) throws Exception;

	int attendanceRequestCancle(Map<String, Object> paramMap) throws Exception;

	int attendanceFirstApprove(Map<String, Object> paramMap) throws Exception;

	int attendanceRequestApproveUpdate(Map<String, Object> paramMap) throws Exception;

	int attendanceReject(Map<String, Object> paramMap) throws Exception;
	
	int attendanceRequestRejectUpdate(Map<String, Object> paramMap) throws Exception;

	int attendanceApproveReject(Map<String, Object> paramMap) throws Exception;

	int attendanceSecondApprove(Map<String, Object> paramMap) throws Exception;
	
	int attendanceUseCnt(Map<String, Object> paramMap) throws Exception;
	
	int attendanceRequestCnt(Map<String, Object> paramMap) throws Exception;
	
	
}
