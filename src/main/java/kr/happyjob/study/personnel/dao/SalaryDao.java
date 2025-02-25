package kr.happyjob.study.personnel.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.personnel.model.EmployeeModel;
import kr.happyjob.study.personnel.model.SalaryClassModel;
import kr.happyjob.study.personnel.model.SalaryModel;

public interface SalaryDao {
	List<SalaryModel> salaryList(Map<String, Object> paramMap) throws Exception;
	
	int salaryListCnt(Map<String, Object> paramMap) throws Exception;
	
	List<SalaryModel> salaryDetail(Map<String, Object> paramMap) throws Exception;
	
	int salaryDetailCnt(Map<String, Object> paramMap) throws Exception;
	
	SalaryModel salaryListDetail(Map<String, Object> paramMap) throws Exception;

	int paymentStatusUpdate(Map<String, Object> paramMap) throws Exception;
	
	int allPaymentStatusUpdate(Map<String, Object> paramMap) throws Exception;
	
	int countUnpaidSalaries(Map<String, Object> paramMap) throws Exception;
	
	SalaryClassModel salaryClassList(Map<String, Object> paramMap) throws Exception;
	
	List<SalaryModel> getUnpaidSalaries(Map<String, Object> paramMap) throws Exception;
	
	int severancePaySave(Map<String, Object> paramMap) throws Exception;
	
	int getEmployeeSalary(Map<String, Object> paramMap);
	
	List<EmployeeModel> getUnpaidEmployeeId(Map<String, Object> paramMap);
	
	int checkSalaryExists(Map<String, Object> paramMap) throws Exception;
	
	int updateSalary(Map<String, Object> paramMap) throws Exception;
	
	int insertSalary(Map<String, Object> paramMap) throws Exception;
	
}
