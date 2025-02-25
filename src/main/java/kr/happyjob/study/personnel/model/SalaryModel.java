package kr.happyjob.study.personnel.model;

import java.math.BigDecimal;

public class SalaryModel {
	private int salaryId;
	private int employeeId;
	private BigDecimal salary;
	private BigDecimal baseSalary;
	private BigDecimal nationalPension;
	private BigDecimal healthInsurance;
	private BigDecimal industrialAccident;
	private BigDecimal employmentInsurance;
	private BigDecimal additionalAmount;
	private BigDecimal totalSalary;
	private BigDecimal severancePay;
	private int paymentStatus;
	private String paymentDate;
	private int employeeNumber;
	private String employeeName;
	private String departmentDetailName;
	private String jobGradeDetailName;
	private String loginId;
	private int workingYear;
	
	
	public int getWorkingYear() {
		return workingYear;
	}
	public void setWorkingYear(int workingYear) {
		this.workingYear = workingYear;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public BigDecimal getEmploymentInsurance() {
		return employmentInsurance;
	}
	public void setEmploymentInsurance(BigDecimal employmentInsurance) {
		this.employmentInsurance = employmentInsurance;
	}
	public BigDecimal getIndustrialAccident() {
		return industrialAccident;
	}
	public int getEmployeeNumber() {
		return employeeNumber;
	}
	public void setEmployeeNumber(int employeeNumber) {
		this.employeeNumber = employeeNumber;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getDepartmentDetailName() {
		return departmentDetailName;
	}
	public void setDepartmentDetailName(String departmentDetailName) {
		this.departmentDetailName = departmentDetailName;
	}
	public String getJobGradeDetailName() {
		return jobGradeDetailName;
	}
	public void setJobGradeDetailName(String jobGradeDetailName) {
		this.jobGradeDetailName = jobGradeDetailName;
	}
	public void setIndustrialAccident(BigDecimal industrialAccident) {
		this.industrialAccident = industrialAccident;
	}
	public int getSalaryId() {
		return salaryId;
	}
	public void setSalaryId(int salaryId) {
		this.salaryId = salaryId;
	}
	public int getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}
	public BigDecimal getSalary() {
		return salary;
	}
	public void setSalary(BigDecimal salary) {
		this.salary = salary;
	}
	public BigDecimal getBaseSalary() {
		return baseSalary;
	}
	public void setBaseSalary(BigDecimal baseSalary) {
		this.baseSalary = baseSalary;
	}
	public BigDecimal getNationalPension() {
		return nationalPension;
	}
	public void setNationalPension(BigDecimal nationalPension) {
		this.nationalPension = nationalPension;
	}
	public BigDecimal getHealthInsurance() {
		return healthInsurance;
	}
	public void setHealthInsurance(BigDecimal healthInsurance) {
		this.healthInsurance = healthInsurance;
	}
	public BigDecimal getAdditionalAmount() {
		return additionalAmount;
	}
	public void setAdditionalAmount(BigDecimal additionalAmount) {
		this.additionalAmount = additionalAmount;
	}
	public BigDecimal getTotalSalary() {
		return totalSalary;
	}
	public void setTotalSalary(BigDecimal totalSalary) {
		this.totalSalary = totalSalary;
	}
	public BigDecimal getSeverancePay() {
		return severancePay;
	}
	public void setSeverancePay(BigDecimal severancePay) {
		this.severancePay = severancePay;
	}
	public int getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(int paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	public String getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	
	
}
