package kr.happyjob.study.business.model;

public class EstimateModel {
	private int id;
	private int clientId;
	private int empId;
	private String departmentCode;
	private String estimateEmpName;
	private String estimateDate;
	private String deliveryDate;
	private String clientName;
	private String productName;
	private int totalDeliveryCount;
	private int totalSupplyPrice;
	private int totalTax;
	
	private String salesArea;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getClientId() {
		return clientId;
	}
	public void setClientId(int clientId) {
		this.clientId = clientId;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getDepartmentCode() {
		return departmentCode;
	}
	public void setDepartmentCode(String departmentCode) {
		this.departmentCode = departmentCode;
	}
	public String getEstimateEmpName() {
		return estimateEmpName;
	}
	public void setEstimateEmpName(String estimateEmpName) {
		this.estimateEmpName = estimateEmpName;
	}
	public String getEstimateDate() {
		return estimateDate;
	}
	public void setEstimateDate(String estimateDate) {
		this.estimateDate = estimateDate;
	}
	public String getDeliveryDate() {
		return deliveryDate;
	}
	public void setDeliveryDate(String deliveryDate) {
		this.deliveryDate = deliveryDate;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getTotalDeliveryCount() {
		return totalDeliveryCount;
	}
	public void setTotalDeliveryCount(int totalDeliveryCount) {
		this.totalDeliveryCount = totalDeliveryCount;
	}
	public int getTotalSupplyPrice() {
		return totalSupplyPrice;
	}
	public void setTotalSupplyPrice(int totalSupplyPrice) {
		this.totalSupplyPrice = totalSupplyPrice;
	}
	public int getTotalTax() {
		return totalTax;
	}
	public void setTotalTax(int totalTax) {
		this.totalTax = totalTax;
	}
	public String getSalesArea() {
		return salesArea;
	}
	public void setSalesArea(String salesArea) {
		this.salesArea = salesArea;
	}
	
		
}
