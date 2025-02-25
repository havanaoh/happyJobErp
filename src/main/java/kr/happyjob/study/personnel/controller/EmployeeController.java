package kr.happyjob.study.personnel.controller;


import java.io.Console;
import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
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
import kr.happyjob.study.personnel.model.SalaryClassModel;
import kr.happyjob.study.personnel.service.EmployeeService;
import kr.happyjob.study.personnel.service.GroupListService;
import kr.happyjob.study.personnel.service.SalaryService;


@Controller
@RequestMapping("/personnel/")
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	@Autowired
	GroupListService groupListService;
	@Autowired
	SalaryService salaryService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("employee")
	public String initEmployee(Model model) throws Exception {
		List<GroupListModel> departmentGroupList = groupListService.departmentGroupList();
		List<GroupListModel> jobGradeGroupList = groupListService.jobGradeGroupList();	
		List<SalaryClassModel> salaryClassList = employeeService.salaryClassList();		
		
		model.addAttribute("departmentGroupList", departmentGroupList);
		model.addAttribute("jobGradeGroupList", jobGradeGroupList);		
		model.addAttribute("salaryClassList", salaryClassList);
		
		return "personnel/employeeList";
	}
	
	@RequestMapping("employeeList.do")
	@ResponseBody
	public Map<String, Object> getEmployeeList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {		
		Map<String, Object> resultMap = new HashMap<>();
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<EmployeeModel> employeeList = employeeService.employeeList(paramMap);
		int employeeCnt = employeeService.employeeListCnt(paramMap);		
		
		resultMap.put("employeeList", employeeList);
		resultMap.put("employeeCnt", employeeCnt);
				
		return resultMap;
	}
	
	@RequestMapping("employeeDetail.do")
	@ResponseBody
	public Map<String, Object> employeeDetail(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		EmployeeModel detailValue = employeeService.employeeDetail(paramMap);
		
		SalaryClassModel salaryClassList = salaryService.salaryClassList(paramMap);
		
		if ("".equals(paramMap.get("resignationDate"))) {
		    paramMap.put("resignationDate", null);
		}
		
		List<GroupListModel> departmentGroupList = groupListService.departmentGroupList();
		List<GroupListModel> jobGradeGroupList = groupListService.jobGradeGroupList();
		List<GroupListModel> jobRoleGroupList = groupListService.jobRoleGroupList(paramMap);		
		
		resultMap.put("detail", detailValue);
		resultMap.put("jobGradeGroupList", jobGradeGroupList);
	    resultMap.put("departmentGroupList", departmentGroupList);
	    resultMap.put("salaryClassList", salaryClassList);
	    resultMap.put("jobRoleGroupList", jobRoleGroupList);
	    
		return resultMap;
	}

	@RequestMapping("employeeUpdate.do")
	@ResponseBody
	public Map<String, String> employeeUpdate(@RequestParam Map<String, Object> paramMap, HttpServletRequest req) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		
		int result = employeeService.employeeUpdate(paramMap, req);
		
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	@RequestMapping("employeeSave.do")
	@ResponseBody
	public Map<String, String> employeeSave(@RequestParam Map<String, Object> paramMap,
			HttpServletRequest req) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		
		int result = employeeService.employeeSave(paramMap, req);
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	@RequestMapping("emplStatusUpdate.do")
	@ResponseBody
	public Map<String, String> emplStatusUpdate(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		
		int result = employeeService.emplStatusUpdate(paramMap);
		
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	@RequestMapping("employeeDownload.do")
	@ResponseBody
	public void employeeDownload(@RequestParam Map<String, Object> paramMap, HttpServletResponse res) throws Exception {
		EmployeeModel employee = employeeService.employeeDetail(paramMap);
		
		String filePath = employee.getProfilePhysicalPath();
		
		// 가져온 파일을 0,1로 구성된 byte array로 변환
		byte bytes[] = FileUtils.readFileToByteArray(new File(filePath));
		
		// 파일 설정
		res.setContentType("application/octet-stream");
		res.setContentLength(bytes.length);
		res.setHeader("Content-Disposition",
	            "attachment; fileName=\"" + URLEncoder.encode(employee.getProfileFileName(), "UTF-8") + "\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		res.getOutputStream().write(bytes);
		res.getOutputStream().flush();
		res.getOutputStream().close();
	}
	
	@RequestMapping("getJobRolesByDepartment.do")
	@ResponseBody
	public Map<String, Object> getJobRolesByDepartment(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		List<GroupListModel> jobRoleGroupList = groupListService.jobRoleGroupList(paramMap);
		
		resultMap.put("jobRoleGroupList", jobRoleGroupList);
		
		return resultMap;
	}

}
