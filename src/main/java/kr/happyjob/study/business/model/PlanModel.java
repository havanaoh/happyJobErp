package kr.happyjob.study.business.model;

public class PlanModel {
	
	private int plan_num;
	private int emp_id;
	private int client_id;
	private int manufacturer_id;
	private String industry_code;
	private String target_date;
	private int goal_quanti;
	private int perform_qut;
	private String	plan_memo;
	private String	detail_code;
	private int product_id;
	private  String product_name;
	public int getPlan_num() {
		return plan_num;
	}
	public void setPlan_num(int plan_num) {
		this.plan_num = plan_num;
	}
	public int getEmp_id() {
		return emp_id;
	}
	public void setEmp_id(int emp_id) {
		this.emp_id = emp_id;
	}
	public int getClient_id() {
		return client_id;
	}
	public void setClient_id(int client_id) {
		this.client_id = client_id;
	}
	public int getManufacturer_id() {
		return manufacturer_id;
	}
	public void setManufacturer_id(int manufacturer_id) {
		this.manufacturer_id = manufacturer_id;
	}
	public String getIndustry_code() {
		return industry_code;
	}
	public void setIndustry_code(String industry_code) {
		this.industry_code = industry_code;
	}
	public String getTarget_date() {
		return target_date;
	}
	public void setTarget_date(String target_date) {
		this.target_date = target_date;
	}
	public int getGoal_quanti() {
		return goal_quanti;
	}
	public void setGoal_quanti(int goal_quanti) {
		this.goal_quanti = goal_quanti;
	}
	public int getPerform_qut() {
		return perform_qut;
	}
	public void setPerform_qut(int perform_qut) {
		this.perform_qut = perform_qut;
	}
	public String getPlan_memo() {
		return plan_memo;
	}
	public void setPlan_memo(String plan_memo) {
		this.plan_memo = plan_memo;
	}
	public String getDetail_code() {
		return detail_code;
	}
	public void setDetail_code(String detail_code) {
		this.detail_code = detail_code;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	
	

}
