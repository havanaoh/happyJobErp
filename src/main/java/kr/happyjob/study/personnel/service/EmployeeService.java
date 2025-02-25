package kr.happyjob.study.personnel.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.personnel.model.EmployeeModel;
import kr.happyjob.study.personnel.model.SalaryClassModel;

public interface EmployeeService {
	List<EmployeeModel> employeeList(Map<String, Object> paramMap) throws Exception;
	
	int employeeListCnt(Map<String, Object> paramMap) throws Exception;
	
	EmployeeModel employeeDetail(Map<String, Object> paramMap) throws Exception;
	
	int employeeUpdate(Map<String, Object> paramMap, HttpServletRequest req) throws Exception;
	
	int employeeSave(Map<String, Object> paramMap, HttpServletRequest req) throws Exception;
	
	List<SalaryClassModel> salaryClassList() throws Exception;
	
	int emplStatusUpdate(Map<String, Object> paramMap) throws Exception;
}
