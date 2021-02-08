package schline;

public class ClassDTO {
	//과목
	private String regi_idx;
	private String subject_idx;
	private String user_id;
	private String grade_sub;
	//수강
	private String subject_name;
	// 교수명
	private String user_name;
	
	
	
	public String getSubject_idx() {
		return subject_idx;
	}
	public void setSubject_idx(String subject_idx) {
		this.subject_idx = subject_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getSubject_name() {
		return subject_name;
	}
	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}
	public String getRegi_idx() {
		return regi_idx;
	}
	public void setRegi_idx(String regi_idx) {
		this.regi_idx = regi_idx;
	}
	public String getGrade_sub() {
		return grade_sub;
	}
	public void setGrade_sub(String grade_sub) {
		this.grade_sub = grade_sub;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	
	
	

}
