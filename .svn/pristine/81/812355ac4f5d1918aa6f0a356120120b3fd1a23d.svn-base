package kr.happyjob.study.personnel.service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.personnel.dao.SalaryDao;
import kr.happyjob.study.personnel.model.EmployeeModel;
import kr.happyjob.study.personnel.model.SalaryClassModel;
import kr.happyjob.study.personnel.model.SalaryModel;

@Service
public class SalaryServiceImpl implements SalaryService {
	
	@Autowired
	private SalaryDao salaryDao;
	
	@Override
	public List<SalaryModel> salaryList(Map<String, Object> paramMap) throws Exception {
		return salaryDao.salaryList(paramMap);
	}

	@Override
	public List<SalaryModel> salaryDetail(Map<String, Object> paramMap) throws Exception {
		return salaryDao.salaryDetail(paramMap);
	}

	@Override
	public int paymentStatusUpdate(Map<String, Object> paramMap) throws Exception {
		// paramMap의 baseSalary 값 변환
		BigDecimal getBaseSalary;
	    Object baseSalaryObj = paramMap.get("baseSalary");
	    
	    if (baseSalaryObj instanceof BigDecimal) {
	        getBaseSalary = (BigDecimal) baseSalaryObj;
	    } else if (baseSalaryObj instanceof String) {
	        getBaseSalary = new BigDecimal((String) baseSalaryObj);
	    } else if (baseSalaryObj instanceof Number) {
	        getBaseSalary = BigDecimal.valueOf(((Number) baseSalaryObj).doubleValue());
	    } else {
	        throw new IllegalArgumentException("Invalid baseSalary type: " + baseSalaryObj);
	    }
		
		BigDecimal nationalPension = getBaseSalary.multiply(BigDecimal.valueOf(0.045));
		BigDecimal healthInsurance = getBaseSalary.multiply(BigDecimal.valueOf(0.0343));
		BigDecimal employmentInsurance = getBaseSalary.multiply(BigDecimal.valueOf(0.08));
		BigDecimal industrialAccident = getBaseSalary.multiply(BigDecimal.valueOf(0.0156));
		BigDecimal totalSalary = getBaseSalary
			    .subtract(nationalPension)
			    .subtract(healthInsurance)
			    .subtract(employmentInsurance)
			    .subtract(industrialAccident);

		
		paramMap.put("nationalPension", nationalPension);
		paramMap.put("healthInsurance", healthInsurance);
		paramMap.put("employmentInsurance", employmentInsurance);
		paramMap.put("industrialAccident", industrialAccident);
		paramMap.put("totalSalary", totalSalary);
		
		return salaryDao.paymentStatusUpdate(paramMap);
	}

	@Override
	public int allPaymentStatusUpdate(Map<String, Object> paramMap) throws Exception {
		List<SalaryModel> getUnpaidSalaries = salaryDao.getUnpaidSalaries(paramMap);
		int updatedCount = 0;
		
		for (SalaryModel unpaidSalary : getUnpaidSalaries) {
			// paramMap의 baseSalary 값 변환
			BigDecimal getBaseSalary;
		    Object baseSalaryObj = unpaidSalary.getBaseSalary();
		    
		    if (baseSalaryObj instanceof BigDecimal) {
		        getBaseSalary = (BigDecimal) baseSalaryObj;
		    } else if (baseSalaryObj instanceof String) {
		        getBaseSalary = new BigDecimal((String) baseSalaryObj);
		    } else if (baseSalaryObj instanceof Number) {
		        getBaseSalary = BigDecimal.valueOf(((Number) baseSalaryObj).doubleValue());
		    } else {
		        throw new IllegalArgumentException("Invalid baseSalary type: " + baseSalaryObj);
		    }
			
			BigDecimal nationalPension = getBaseSalary.multiply(BigDecimal.valueOf(0.045));
			BigDecimal healthInsurance = getBaseSalary.multiply(BigDecimal.valueOf(0.0343));
			BigDecimal employmentInsurance = getBaseSalary.multiply(BigDecimal.valueOf(0.08));
			BigDecimal industrialAccident = getBaseSalary.multiply(BigDecimal.valueOf(0.0156));
			BigDecimal totalSalary = getBaseSalary
				    .subtract(nationalPension)
				    .subtract(healthInsurance)
				    .subtract(employmentInsurance)
				    .subtract(industrialAccident);

			paramMap.put("salaryId", unpaidSalary.getSalaryId());
			paramMap.put("nationalPension", nationalPension);
			paramMap.put("healthInsurance", healthInsurance);
			paramMap.put("employmentInsurance", employmentInsurance);
			paramMap.put("industrialAccident", industrialAccident);
			paramMap.put("totalSalary", totalSalary);
			
			int result = salaryDao.paymentStatusUpdate(paramMap);
			
			if(result > 0) {
				updatedCount++;
			} else {
				System.out.println("업데이트 실패: salaryId = " + unpaidSalary.getSalaryId());
			}
		}		
				
		return updatedCount;
	}

	@Override
	public int countUnpaidSalaries(Map<String, Object> paramMap) throws Exception {
		return salaryDao.countUnpaidSalaries(paramMap);
	}

	@Override
	public int salaryListCnt(Map<String, Object> paramMap) throws Exception {
		return salaryDao.salaryListCnt(paramMap);
	}

	@Override
	public int salaryDetailCnt(Map<String, Object> paramMap) throws Exception {
		return salaryDao.salaryDetailCnt(paramMap);
	}

	@Override
	public SalaryModel salaryListDetail(Map<String, Object> paramMap) throws Exception {
		return salaryDao.salaryListDetail(paramMap);
	}

	@Override
	public SalaryClassModel salaryClassList(Map<String, Object> paramMap) throws Exception {
		return salaryDao.salaryClassList(paramMap);
	}

	@Override
	public int getEmployeeSalary(Map<String, Object> paramMap) {
		return salaryDao.getEmployeeSalary(paramMap);
	}

	@Override
	public List<EmployeeModel> getUnpaidEmployeeId(Map<String, Object> paramMap) {
		return salaryDao.getUnpaidEmployeeId(paramMap);
	}

	@Override
	public int mergeSalary(Map<String, Object> paramMap) throws Exception {
		int count = salaryDao.checkSalaryExists(paramMap);
		int result;
	    if (count > 0) {
	       result = salaryDao.updateSalary(paramMap);
	    } else {
	       result = salaryDao.insertSalary(paramMap);
	    }
	    
	    return result;
	}

}
