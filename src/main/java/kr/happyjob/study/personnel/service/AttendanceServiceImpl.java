package kr.happyjob.study.personnel.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.happyjob.study.login.model.LgnInfoModel;
import kr.happyjob.study.personnel.dao.AttendanceDao;
import kr.happyjob.study.personnel.model.AttendanceModel;
import kr.happyjob.study.personnel.model.AttendanceRequestModel;

@Service
public class AttendanceServiceImpl implements AttendanceService {
	
	@Autowired
	private AttendanceDao attendanceDao;

	@Override
	public List<AttendanceRequestModel> attendanceRequestList(Map<String, Object> paramMap) throws Exception {		
		return attendanceDao.attendanceRequestList(paramMap);
	}
	
	@Override
	public AttendanceRequestModel attendanceRequestDetail(Map<String, Object> paramMap) throws Exception {		// 
		return attendanceDao.attendanceRequestDetail(paramMap);
	}

	@Override
	@Transactional
	public List<AttendanceModel> attendanceCnt(Map<String, Object> paramMap) throws Exception {
		attendanceDao.attendanceUseCnt(paramMap);		
		return attendanceDao.attendanceCnt(paramMap);
	}

	@Override
	public LgnInfoModel userInfo(Map<String, Object> paramMap) throws Exception {
		return attendanceDao.userInfo(paramMap);
	}

//	@Override
//	public int attendanceRequest(Map<String, Object> paramMap) throws Exception {		
//		return attendanceDao.attendanceRequest(paramMap);
//	}
	
	@Override
	public int attendanceRequest(Map<String, Object> paramMap) throws Exception {
	    LocalDate reqSt = LocalDate.parse((String) paramMap.get("reqSt"));
	    LocalDate reqEd = LocalDate.parse((String) paramMap.get("reqEd"));

	    int empId = Integer.parseInt(paramMap.get("empId").toString());
	    Set<String> validStatuses = new HashSet<>(Arrays.asList("검토 대기", "승인 대기", "승인"));

	    List<AttendanceRequestModel> existRequest = new ArrayList<>(); 	    
	    
	    List<AttendanceRequestModel> requestList = attendanceDao.attendanceRequestCalendar(paramMap);	   
	   
	    for (AttendanceRequestModel request : requestList) {
	        if (request.getEmpId() == empId && validStatuses.contains(request.getReqStatus())) {
	            existRequest.add(request);
	        }
	    }
	    if (isDateOverlap(existRequest, reqSt, reqEd)) {
	        return -1;
	    }	   
	    return attendanceDao.attendanceRequest(paramMap);
	}
	

	@Override
	public List<AttendanceRequestModel> approveDetailList(Map<String, Object> paramMap) throws Exception {
		return attendanceDao.approveDetailList(paramMap);
	}
	@Override
	public int attendanceRequestUpdate(Map<String, Object> paramMap) throws Exception{
		return attendanceDao.attendanceRequestUpdate(paramMap);
	}

	@Override
	public int attendanceRequestCancle(Map<String, Object> paramMap) throws Exception {
		return attendanceDao.attendanceRequestCancle(paramMap);
	}

	@Override
	@Transactional
	public int attendanceFirstApprove(Map<String, Object> paramMap) throws Exception {		
		int insertResult = attendanceDao.attendanceFirstApprove(paramMap);	    
	    int updateResult = attendanceDao.attendanceRequestApproveUpdate(paramMap);
	    
	    return insertResult > 0 ? updateResult : 0;
	}

	@Override
	@Transactional
	public int attendanceReject(Map<String, Object> paramMap) throws Exception {
		int insertResult = attendanceDao.attendanceReject(paramMap);
		int updateResult = attendanceDao.attendanceRequestRejectUpdate(paramMap);		
		return insertResult > 0 ? updateResult : 0;
	}

	@Override
	@Transactional
	public int attendanceApproveReject(Map<String, Object> paramMap) throws Exception {
		int updateAppResult = attendanceDao.attendanceApproveReject(paramMap);
		System.out.println("updateAppResult?????????????????????" + updateAppResult);
		int updateResult = attendanceDao.attendanceRequestRejectUpdate(paramMap);
		System.out.println("updateResult?????????????????????" + updateResult);
		return updateAppResult > 0 ? updateResult : 0;
	}

	@Override
	@Transactional
	public int attendanceSecondApprove(Map<String, Object> paramMap) throws Exception {
		int appUpdate = attendanceDao.attendanceSecondApprove(paramMap);	    
	    int reqUpdate = attendanceDao.attendanceRequestApproveUpdate(paramMap);
		return appUpdate > 0 ? reqUpdate : 0;
	}

	private boolean isDateOverlap(List<AttendanceRequestModel> existRequest, LocalDate reqSt, LocalDate reqEd) {		
		System.out.println("🚀 체크할 기존 신청 목록 크기: ????????" + existRequest.size());
	    for (AttendanceRequestModel request : existRequest) {	        
	        LocalDate existSt = LocalDate.parse(request.getReqSt());
	        LocalDate existEd = LocalDate.parse(request.getReqEd());
	        
	        // 신청하려는 기간(reqSt, reqEd)이 이미 신청된 연차(request)와 겹치는지 확인
	        if ((reqSt.isBefore(existEd) && reqEd.isAfter(existSt)) ||  // 일부 겹침
	             reqSt.isEqual(existSt) || reqEd.isEqual(existEd)) {     // 경계선 동일한 경우
	             System.out.println("🚨 날짜 겹침 발생!");
	             return true;
	        }
	    }
	    return false;
	}

	@Override
	public int attendanceRequestCnt(Map<String, Object> paramMap) throws Exception {
		return attendanceDao.attendanceRequestCnt(paramMap);
	}

	@Override
	public List<AttendanceRequestModel> attendanceRequestCalendar(Map<String, Object> paramMap) throws Exception {		
		return attendanceDao.attendanceRequestCalendar(paramMap);
	}

	
}
