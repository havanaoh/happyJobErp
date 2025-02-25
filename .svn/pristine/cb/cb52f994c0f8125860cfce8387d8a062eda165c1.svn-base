package kr.happyjob.study.personnel.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.personnel.model.EmployeeModel;
import kr.happyjob.study.personnel.model.SalaryClassModel;

public interface EmployeeDao {
	List<EmployeeModel> employeeList(Map<String, Object> paramMap) throws Exception;
	
	int employeeListCnt(Map<String, Object> paramMap) throws Exception;
	
	EmployeeModel employeeDetail(Map<String, Object> paramMap) throws Exception;
	
	int employeeUpdate(Map<String, Object> paramMap) throws Exception;
	
	int employeeSave(Map<String, Object> paramMap) throws Exception;
	
	List<SalaryClassModel> salaryClassList() throws Exception; 
	
	int emplStatusUpdate(Map<String, Object> paramMap) throws Exception;

	int attendanceSave(int empId) throws Exception;
	
	int getMaxNumber() throws Exception;
}
