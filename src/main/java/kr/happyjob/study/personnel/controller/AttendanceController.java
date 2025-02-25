package kr.happyjob.study.personnel.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.login.model.LgnInfoModel;
import kr.happyjob.study.personnel.model.AttendanceModel;
import kr.happyjob.study.personnel.model.AttendanceRequestModel;
import kr.happyjob.study.personnel.service.AttendanceService;

@Controller
@RequestMapping("/personnel/")
public class AttendanceController {
	
	@Autowired
	private AttendanceService attendanceService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("attendance-request")
	public String attendanceRequest(Model model, HttpSession session) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		
		LgnInfoModel LgnInfo = attendanceService.userInfo(paramMap);
		model.addAttribute("lgnInfo", LgnInfo);
		return "personnel/attendanceRequest";
	}
	
	@RequestMapping("attendanceCnt.do")
	@ResponseBody
	public Map<String, Object> attendanceCnt(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception{
		Map<String, Object> resultMap = new HashMap<>();
		
		int user_idx = (int) session.getAttribute("user_idx"); 
		String loginId = (String) session.getAttribute("loginId");
		
		paramMap.put("user_idx", user_idx);
		paramMap.put("loginId", loginId);
		
		List<AttendanceModel> attendanceCnt = attendanceService.attendanceCnt(paramMap);
		resultMap.put("attendanceCnt", attendanceCnt);
		
		return resultMap;
	}
	
	@RequestMapping("attendanceList.do")
	@ResponseBody
	public Map<String, Object> attendanceList(@RequestParam Map<String, Object> paramMap) throws Exception{		
		Map<String, Object> resultMap = new HashMap<>();
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<AttendanceRequestModel> attendanceList = attendanceService.attendanceRequestList(paramMap);
		int attendanceRequestCnt = attendanceService.attendanceRequestCnt(paramMap);
		
		resultMap.put("attendanceRequestCnt", attendanceRequestCnt);
		resultMap.put("attendanceList", attendanceList);
		
		return resultMap;
	}
	
	@RequestMapping("attendanceDetail.do")
	@ResponseBody
	public Map<String, Object> attendanceDetail(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		AttendanceRequestModel detailValue = attendanceService.attendanceRequestDetail(paramMap);
		
		resultMap.put("detail", detailValue);
		
		return resultMap;
	}
	
	@RequestMapping("attendanceRequest.do")
	@ResponseBody
	public Map<String, Object> attendanceRequest(@RequestParam Map<String, Object> paramMap) throws Exception{
		logger.info("attendanceRequest paramMap ======= " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<>();
		int result = attendanceService.attendanceRequest(paramMap);
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}				
		return resultMap; 
	}
	
	@RequestMapping("attendanceUpdate.do")
	@ResponseBody
	public Map<String, String> attendanceRequestUpdate(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		
		int result = attendanceService.attendanceRequestUpdate(paramMap);
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	@RequestMapping("attendanceCancle.do")
	@ResponseBody
	public Map<String, String> attendanceRequestCancle(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		
		int result = attendanceService.attendanceRequestCancle(paramMap);
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}		
		return resultMap;
	}
	
	
	@RequestMapping("attendance-approval")
	public String attendanceApproval() throws Exception {
		return "personnel/attendanceApproval";
	}
	
	@RequestMapping("attendanceFirstApprove.do")
	@ResponseBody
	public Map<String, Object> attendanceFirstApprove(@RequestParam Map<String, Object> paramMap) throws Exception{
		Map<String, Object> resultMap = new HashMap<>();
		int result = attendanceService.attendanceFirstApprove(paramMap);
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}				
		return resultMap; 
	}
	
	@RequestMapping("attendanceReject.do")
	@ResponseBody
	public Map<String, String> attendanceReject(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		
		int result = attendanceService.attendanceReject(paramMap);		
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	@RequestMapping("attendanceApproveReject.do")
	@ResponseBody
	public Map<String, String> attendanceApproveReject(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		
		int result = attendanceService.attendanceApproveReject(paramMap);
		System.out.println("result???????????????????????????????" + result);
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	@RequestMapping("attendanceSecondApprove.do")
	@ResponseBody
	public Map<String, Object> attendanceSecondApprove(@RequestParam Map<String, Object> paramMap) throws Exception{
		Map<String, Object> resultMap = new HashMap<>();
		int result = attendanceService.attendanceSecondApprove(paramMap);		
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}				
		return resultMap; 
	}
	
	@RequestMapping("attendance-list")
	public String attendanceCalendar() throws Exception {
		return "personnel/attendanceList";
	}
	
	@RequestMapping("approveDetail.do")
	@ResponseBody
	public Map<String, Object> approveDetailList(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception{
		Map<String, Object> resultMap = new HashMap<>();
		
		List<AttendanceRequestModel> attendanceList = attendanceService.approveDetailList(paramMap);
		resultMap.put("attendanceList", attendanceList);		
		return resultMap;
	}
	
	@RequestMapping("attendanceCalendar.do")
	@ResponseBody
	public Map<String, Object> attendanceCalendar(@RequestParam Map<String, Object> paramMap) throws Exception{		
		Map<String, Object> resultMap = new HashMap<>();		
		
		List<AttendanceRequestModel> attendanceCalendar = attendanceService.attendanceRequestCalendar(paramMap);		
		resultMap.put("attendanceList", attendanceCalendar);
		
		return resultMap;
	}
	
	
}
