package kr.happyjob.study.personnel.model;

public class PromotionModel {
	private int employeeNumber;
	private String employeeName;
	private String departmentCode;
	private String jobGrade;
	private String createdAt;
	private String departmentDetailName;
	private int employeeId;
	private String recentJobGrade;
	private String newJobGrade;
	
	public String getNewJobGrade() {
		return newJobGrade;
	}
	public void setNewJobGrade(String newJobGrade) {
		this.newJobGrade = newJobGrade;
	}
	public String getRecentJobGrade() {
		return recentJobGrade;
	}
	public void setRecentJobGrade(String recentJobGrade) {
		this.recentJobGrade = recentJobGrade;
	}
	public int getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}
	public String getDepartmentDetailName() {
		return departmentDetailName;
	}
	public void setDepartmentDetailName(String departmentDetailName) {
		this.departmentDetailName = departmentDetailName;
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
	public String getDepartmentCode() {
		return departmentCode;
	}
	public void setDepartmentCode(String departmentCode) {
		this.departmentCode = departmentCode;
	}
	public String getJobGrade() {
		return jobGrade;
	}
	public void setJobGrade(String jobGrade) {
		this.jobGrade = jobGrade;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
}
