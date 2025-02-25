package kr.happyjob.study.personnel.service;

import java.io.File;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.personnel.dao.EmployeeDao;
import kr.happyjob.study.personnel.dao.PromotionDao;
import kr.happyjob.study.personnel.dao.SalaryDao;
import kr.happyjob.study.personnel.model.EmployeeModel;
import kr.happyjob.study.personnel.model.SalaryClassModel;

@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	EmployeeDao employeeDao;
	
	@Autowired
	PromotionDao promotionDao;
	
	@Autowired
	SalaryDao salaryDao;
	
	@Value("${fileUpload.employeePath}")
	private String employeePath;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;

	@Override
	public List<EmployeeModel> employeeList(Map<String, Object> paramMap) throws Exception {
		return employeeDao.employeeList(paramMap);
	}

	@Override
	public EmployeeModel employeeDetail(Map<String, Object> paramMap) throws Exception {
		return employeeDao.employeeDetail(paramMap);
	}

	@Override
	@Transactional
	public int employeeUpdate(Map<String, Object> paramMap, HttpServletRequest req) throws Exception {
		EmployeeModel getDetail = employeeDao.employeeDetail(paramMap);
		
		// 현재 직급과 클라이언트에서 받은 job_grade 비교
		String currentJobGrade = getDetail.getJobGradeDetailName();
		String newJobGrade = paramMap.get("jobGradeDetailName").toString();
		
		// 변경된 파일을 저장
		MultipartHttpServletRequest multiFile = (MultipartHttpServletRequest) req;
		
		String itemFilePath = employeePath + File.separator;
		
		FileUtilCho fileUpload = new FileUtilCho(multiFile, rootPath, virtualRootPath, itemFilePath);
		
		Map<String, Object> fileInfo = fileUpload.uploadFiles();
		
		if(fileInfo != null && fileInfo.get("file_nm") != null) {
			if(getDetail.getProfileFileName() != null && !(getDetail.getProfileFileName().equals(fileInfo.get("file_nm")))) {
				File oldFile = new File(getDetail.getProfilePhysicalPath());
				oldFile.delete();
			}
		}
		
		if (fileInfo.get("file_nm") == null) {
			paramMap.put("fileYn", "N");
			paramMap.put("fileInfo", null);
		} else {
			paramMap.put("fileYn", "Y");
			paramMap.put("fileInfo", fileInfo);
		}
		
		// 직원 정보 업데이트
		int updateResult = employeeDao.employeeUpdate(paramMap);
		
		// 직급 변경이 발생한 경우
		if(!currentJobGrade.equals(newJobGrade)) {
			paramMap.put("oldJobGrade", currentJobGrade);
			paramMap.put("newJobGrade", newJobGrade);
			promotionDao.jobGradeHistSave(paramMap);
		}
		
		return updateResult;
	}
	
	@Override
	public int employeeSave(Map<String, Object> paramMap, HttpServletRequest req) throws Exception {
		MultipartHttpServletRequest multiFile = (MultipartHttpServletRequest) req;
		
		String itemFilePath = employeePath + File.separator;
		
		FileUtilCho fileUpload = new FileUtilCho(multiFile, rootPath, virtualRootPath, itemFilePath);
		
		Map<String, Object> fileInfo = fileUpload.uploadFiles();
		
		if(fileInfo.get("file_nm") == null) {
			paramMap.put("fileYn", "N");
			paramMap.put("fileInfo", null);
		} else {
			paramMap.put("fileYn", "Y");
			paramMap.put("fileInfo", fileInfo);
		}
		
		// MAX(number) + 1을 조회
		int newNumber = employeeDao.getMaxNumber();
		paramMap.put("newNumber", newNumber);
		
		int empSave = employeeDao.employeeSave(paramMap);
		
		// salary 테이블 insert
		int getSalary = salaryDao.getEmployeeSalary(paramMap);
		paramMap.put("salary", getSalary);
		
		salaryDao.insertSalary(paramMap);
				
		int empId = (int) paramMap.get("employeeId");
		
		int attSave = employeeDao.attendanceSave(empId);		
		
		return empSave;
	}

	@Override
	public List<SalaryClassModel> salaryClassList() throws Exception {
		return employeeDao.salaryClassList();
	}

	@Override
	public int employeeListCnt(Map<String, Object> paramMap) throws Exception {
		return employeeDao.employeeListCnt(paramMap);
	}

	@Override
	@Transactional
	public int emplStatusUpdate(Map<String, Object> paramMap) throws Exception {
		// salary, severancePay 값 변환
		if (paramMap.get("salary") instanceof String) {
			try {
				paramMap.put("salary", new BigDecimal(paramMap.get("salary").toString()));
			} catch (NumberFormatException e) {
				paramMap.put("salary", BigDecimal.ZERO);
			}
		}
		if (paramMap.get("severancePay") instanceof String) {
			try {
				paramMap.put("severancePay", new BigDecimal(paramMap.get("severancePay").toString()));
			} catch (NumberFormatException e) {
				paramMap.put("severancePay", BigDecimal.ZERO);
			}
		}
		
		int updateResult = employeeDao.emplStatusUpdate(paramMap);
		int insertResult = salaryDao.severancePaySave(paramMap);
		
		return updateResult > 0 ? insertResult : 0;
	}
	
}
