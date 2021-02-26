package admin.model;

public class Admin_UserVO {
	private String user_id;
	private String orga_id;
	private String user_name;
	private String phone_num;
	private String user_pass;
	private String email;
	private int grade_total;
	private String authority;
	private String enabled;
	// 가상번호 부여를 위한 멤버변수 추가
	private int virtualNum;
	
	private String subject_name;
	private String subject_idx;
	
	public String getEnabled() {
		return enabled;
	}
	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}
	public String getAuthority() {
		return authority;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getOrga_id() {
		return orga_id;
	}
	public void setOrga_id(String orga_id) {
		this.orga_id = orga_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPhone_num() {
		return phone_num;
	}
	public void setPhone_num(String phone_num) {
		this.phone_num = phone_num;
	}
	public String getUser_pass() {
		return user_pass;
	}
	public void setUser_pass(String user_pass) {
		this.user_pass = user_pass;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getGrade_total() {
		return grade_total;
	}
	public void setGrade_total(int grade_total) {
		this.grade_total = grade_total;
	}
	public String getuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public int getVirtualNum() {
		return virtualNum;
	}
	public void setVirtualNum(int virtualNum) {
		this.virtualNum = virtualNum;
	}
	public String getSubject_idx() {
		return subject_idx;
	}
	public void setSubject_idx(String subject_idx) {
		this.subject_idx = subject_idx;
	}
	public String getSubject_name() {
		return subject_name;
	}
	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}

}
