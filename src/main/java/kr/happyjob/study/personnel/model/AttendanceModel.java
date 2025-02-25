package kr.happyjob.study.personnel.model;

import java.util.Date;

public class AttendanceModel {
	private int id;
	private int empId;
	private String startDate;
	private String endDate;
	private String approvalDate;
	private String approver;
	private boolean isApproval;
	private double attCnt;
	private double useAttCnt;
	private double leftAttCnt;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getApprovalDate() {
		return approvalDate;
	}
	public void setApprovalDate(String approvalDate) {
		this.approvalDate = approvalDate;
	}
	public String getApprover() {
		return approver;
	}
	public void setApprover(String approver) {
		this.approver = approver;
	}
	public boolean isApproval() {
		return isApproval;
	}
	public void setApproval(boolean isApproval) {
		this.isApproval = isApproval;
	}
	public double getAttCnt() {
		return attCnt;
	}
	public void setAttCnt(double attCnt) {
		this.attCnt = attCnt;
	}
	public double getUseAttCnt() {
		return useAttCnt;
	}
	public void setUseAttCnt(double useAttCnt) {
		this.useAttCnt = useAttCnt;
	}
	public double getLeftAttCnt() {
		return leftAttCnt;
	}
	public void setLeftAttCnt(double leftAttCnt) {
		this.leftAttCnt = leftAttCnt;
	}
	
}
