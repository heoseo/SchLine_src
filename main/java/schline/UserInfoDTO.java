package schline;

public class UserInfoDTO {
	//계정 정보
	private String user_id;
	private String orga_id;
	private String user_name; //학생 명
	private String phone_num;
	private String user_pass;
	private String email;
	private int grade_total;
	private String authority;
	private String enabled;
	private String rnum;

	//수강 ,기업, 과목 테이블 참조용
	private String regi_idx;
	private String subject_idx;
	private String grade_sub;
	private String orga_name;
	
	private String subject_name;
	private String team_idx;
	private String block_user;
	
	
	public String getOrga_name() {
		return orga_name;
	}
	public void setOrga_name(String orga_name) {
		this.orga_name = orga_name;
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
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getEnabled() {
		return enabled;
	}
	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}
	public String getRnum() {
		return rnum;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
	}
	public String getRegi_idx() {
		return regi_idx;
	}
	public void setRegi_idx(String regi_idx) {
		this.regi_idx = regi_idx;
	}
	public String getSubject_idx() {
		return subject_idx;
	}
	public void setSubject_idx(String subject_idx) {
		this.subject_idx = subject_idx;
	}
	public String getGrade_sub() {
		return grade_sub;
	}
	public void setGrade_sub(String grade_sub) {
		this.grade_sub = grade_sub;
	}
	public String getSubject_name() {
		return subject_name;
	}
	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}
	public String getTeam_idx() {
		return team_idx;
	}
	public void setTeam_idx(String team_idx) {
		this.team_idx = team_idx;
	}
	public String getBlock_user() {
		return block_user;
	}
	public void setBlock_user(String block_user) {
		this.block_user = block_user;
	}
	
	
}
