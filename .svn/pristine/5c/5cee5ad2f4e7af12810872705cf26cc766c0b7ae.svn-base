package kr.happyjob.study.personnel.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.personnel.model.EmployeeModel;
import kr.happyjob.study.personnel.model.GroupListModel;
import kr.happyjob.study.personnel.model.SalaryModel;
import kr.happyjob.study.personnel.service.GroupListService;
import kr.happyjob.study.personnel.service.SalaryService;

@Controller
@RequestMapping("/personnel/")
public class SalaryController {
	
	@Autowired
	private SalaryService salaryService;
	@Autowired
	GroupListService groupListService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
		
	@RequestMapping("salary-manage")
	public String salaryManageInit(Model model) throws Exception {
		List<GroupListModel> departmentGroupList = groupListService.departmentGroupList();
		List<GroupListModel> jobGradeGroupList = groupListService.jobGradeGroupList();
		
		model.addAttribute("departmentGroupList", departmentGroupList);
		model.addAttribute("jobGradeGroupList", jobGradeGroupList);
		
		return "personnel/salaryManage";
	}
	
	@RequestMapping("salary-list")
	public String salaryListInit(Model model) throws Exception {
		return "personnel/salaryList";
	}
	
	@RequestMapping("salaryList.do")
	@ResponseBody
	public Map<String, Object> getSalaryList(@RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("paramMap ======= " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<SalaryModel> salaryList = salaryService.salaryList(paramMap);
		int salaryCnt = salaryService.salaryListCnt(paramMap);
		
		resultMap.put("salaryList", salaryList);
		resultMap.put("salaryCnt", salaryCnt);
		
		return resultMap;
	}
	
	@RequestMapping("salaryDetail.do")
	@ResponseBody
	public Map<String, Object> getSalaryDetailList(@RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("paramMap ======= " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<SalaryModel> salaryDetail = salaryService.salaryDetail(paramMap);
		int salaryDetailCnt = salaryService.salaryDetailCnt(paramMap);
		
		resultMap.put("salaryDetail", salaryDetail);
		resultMap.put("salaryDetailCnt", salaryDetailCnt);
		
		return resultMap;
	}
	
	@RequestMapping("paymentStatusUpdate.do")
	@ResponseBody
	public Map<String, String> paymentStatusUpdate (@RequestParam Map<String, Object> paramMap, HttpServletRequest req) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		
		int result = salaryService.paymentStatusUpdate(paramMap);
		
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	@RequestMapping("allPaymentStatusUpdate.do")
	@ResponseBody
	public Map<String, Object> allPaymentStatusUpdate (@RequestParam Map<String, Object> paramMap, HttpServletRequest req) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		int countUnpaidStatus = salaryService.countUnpaidSalaries(paramMap);
		int result = salaryService.allPaymentStatusUpdate(paramMap);
		
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		resultMap.put("countUnpaidStatus", countUnpaidStatus);
		
		return resultMap;
	}
	
	@RequestMapping("salaryListDetail.do")
	@ResponseBody
	public Map<String, Object> salaryListDetail(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		String loginId = (String) session.getAttribute("loginId");
		
		paramMap.put("loginId", loginId);
		
		SalaryModel detailValue = salaryService.salaryListDetail(paramMap);
		
		resultMap.put("salaryListDetail", detailValue);
		
		return resultMap;
	}
	
	@RequestMapping("salarySave.do")
	@ResponseBody
	public Map<String, Object> salarySave(@RequestParam Map<String, Object> paramMap) throws Exception {		
		Map<String, Object> resultMap = new HashMap<>();
		
		List<EmployeeModel> getUnpaidEmployeeId = salaryService.getUnpaidEmployeeId(paramMap);
		for(EmployeeModel emp : getUnpaidEmployeeId) {
			paramMap.put("employeeId", emp.getEmployeeId());
			int salary = salaryService.getEmployeeSalary(paramMap);
			paramMap.put("salary", salary);
			
			int result = salaryService.mergeSalary(paramMap);
			
			if (result > 0){
				resultMap.put("result", "success");
			} else {
				resultMap.put("result", "fail");
			}
		}
	
		return resultMap;
	}
}
