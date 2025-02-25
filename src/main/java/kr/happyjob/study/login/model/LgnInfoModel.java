package kr.happyjob.study.login.model;


public class LgnInfoModel {


	//사용자 이메일
	private String user_email;
	
	//로그인 ID
	private String loginID;
	
	//비밀번호
	private String password;
	
	//은행 코드
	private String detail_name;
	private String detail_code;
	
	//승인 코드
	private String approval_cd;
	
	
	/*// 게시판 글 번호
	private int row_num;
	
	// 오피스 ID
	private String ofc_id;
	
	// 오피스 명
	private String ofc_nm;
	
	// 오피스 구분 코드
	private String ofc_dvs_cod;
	*/
	
	// 사용자 로그인 ID
	private String lgn_id;
	
	// 사용자 로그인 PW
	private String pwd;
	
	// 사용자 시스템 ID
	private String usr_sst_id;
	
	// 사용자 성명
	private String usr_nm;
	
	// 로그린 사용자 권란       mng: 관리자       gnr: 일반
	private String mem_author;
	
	//user_idx수정자 박선준
	private int usr_idx;
	
	// 프로필 이미지 
	private String profileFileName;
	private String profilePhysicalPath;
	private String profileLogicalPath;
	private int profileFileSize;
	private String profileFileExt;
	
	// 재직상태
	private String emplStatus;
		

	public String getEmplStatus() {
		return emplStatus;
	}

	public void setEmplStatus(String emplStatus) {
		this.emplStatus = emplStatus;
	}

	public String getProfileFileName() {
		return profileFileName;
	}

	public void setProfileFileName(String profileFileName) {
		this.profileFileName = profileFileName;
	}

	public String getProfilePhysicalPath() {
		return profilePhysicalPath;
	}

	public void setProfilePhysicalPath(String profilePhysicalPath) {
		this.profilePhysicalPath = profilePhysicalPath;
	}

	public String getProfileLogicalPath() {
		return profileLogicalPath;
	}

	public void setProfileLogicalPath(String profileLogicalPath) {
		this.profileLogicalPath = profileLogicalPath;
	}

	public int getProfileFileSize() {
		return profileFileSize;
	}

	public void setProfileFileSize(int profileFileSize) {
		this.profileFileSize = profileFileSize;
	}

	public String getProfileFileExt() {
		return profileFileExt;
	}

	public void setProfileFileExt(String profileFileExt) {
		this.profileFileExt = profileFileExt;
	}

	public int getUsr_idx() {
		return usr_idx;
	}

	public void setUsr_idx(int usr_idx) {
		this.usr_idx = usr_idx;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getDetail_name() {
		return detail_name;
	}

	public void setDetail_name(String detail_name) {
		this.detail_name = detail_name;
	}

	public String getDetail_code() {
		return detail_code;
	}

	public void setDetail_code(String detail_code) {
		this.detail_code = detail_code;
	}

	public String getApproval_cd() {
		return approval_cd;
	}

	public void setApproval_cd(String approval_cd) {
		this.approval_cd = approval_cd;
	}

	public String getLgn_id() {
		return lgn_id;
	}

	public void setLgn_id(String lgn_id) {
		this.lgn_id = lgn_id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getUsr_sst_id() {
		return usr_sst_id;
	}

	public void setUsr_sst_id(String usr_sst_id) {
		this.usr_sst_id = usr_sst_id;
	}

	public String getUsr_nm() {
		return usr_nm;
	}

	public void setUsr_nm(String usr_nm) {
		this.usr_nm = usr_nm;
	}

	public String getMem_author() {
		return mem_author;
	}

	public void setMem_author(String mem_author) {
		this.mem_author = mem_author;
	}

	
	

}
