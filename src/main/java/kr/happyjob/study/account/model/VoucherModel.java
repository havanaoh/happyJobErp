package kr.happyjob.study.account.model;

public class VoucherModel {
	private String voucher_no;
	private String voucher_date;
	private String account_type;
	private String client_name;
	private String debit_name;
	private String crebit_name;
	private int voucher_amount;
	private int order_id;
	private int exp_id;
	private String emp_name;
	
	public int getVoucher_amount() {
		return voucher_amount;
	}
	public void setVoucher_amount(int voucher_amount) {
		this.voucher_amount = voucher_amount;
	}
	public String getVoucher_no() {
		return voucher_no;
	}
	public void setVoucher_no(String voucher_no) {
		this.voucher_no = voucher_no;
	}
	public String getVoucher_date() {
		return voucher_date;
	}
	public void setVoucher_date(String voucher_date) {
		this.voucher_date = voucher_date;
	}
	public String getAccount_type() {
		return account_type;
	}
	public void setAccount_type(String account_type) {
		this.account_type = account_type;
	}
	public String getClient_name() {
		return client_name;
	}
	public void setClient_name(String client_name) {
		this.client_name = client_name;
	}
	public String getDebit_name() {
		return debit_name;
	}
	public void setDebit_name(String debit_name) {
		this.debit_name = debit_name;
	}
	public String getCrebit_name() {
		return crebit_name;
	}
	public void setCrebit_name(String credit_name) {
		this.crebit_name = credit_name;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public int getExp_id() {
		return exp_id;
	}
	public void setExp_id(int exp_id) {
		this.exp_id = exp_id;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	
	
}
