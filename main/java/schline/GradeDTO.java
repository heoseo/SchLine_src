package schline;

public class GradeDTO {
	//성적 변수
	private int grade_idx;
	private String user_id;
	private int exam_idx;
	private int grade_exam;
	//과제 테이블 조인용
	private String subject_idx; 	//각 과목의 인덱스(FK)	
	private String exam_name;	 //과제 이름
	java.sql.Date exam_postdate; //작성 날짜	
	java.sql.Date exam_date;	//제출마감일
	private int exam_type;		//과제(1), 시험(2)
	private String exam_content; //본문
	private int exam_scoring; 	//과제, 시험에 대한 배점
	
	public int getGrade_idx() {
		return grade_idx;
	}
	public void setGrade_idx(int grade_idx) {
		this.grade_idx = grade_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getExam_idx() {
		return exam_idx;
	}
	public void setExam_idx(int exam_idx) {
		this.exam_idx = exam_idx;
	}
	public int getGrade_exam() {
		return grade_exam;
	}
	public void setGrade_exam(int grade_exam) {
		this.grade_exam = grade_exam;
	}
	public String getSubject_idx() {
		return subject_idx;
	}
	public void setSubject_idx(String subject_idx) {
		this.subject_idx = subject_idx;
	}
	public String getExam_name() {
		return exam_name;
	}
	public void setExam_name(String exam_name) {
		this.exam_name = exam_name;
	}
	public java.sql.Date getExam_postdate() {
		return exam_postdate;
	}
	public void setExam_postdate(java.sql.Date exam_postdate) {
		this.exam_postdate = exam_postdate;
	}
	public java.sql.Date getExam_date() {
		return exam_date;
	}
	public void setExam_date(java.sql.Date exam_date) {
		this.exam_date = exam_date;
	}
	public int getExam_type() {
		return exam_type;
	}
	public void setExam_type(int exam_type) {
		this.exam_type = exam_type;
	}
	public String getExam_content() {
		return exam_content;
	}
	public void setExam_content(String exam_content) {
		this.exam_content = exam_content;
	}
	public int getExam_scoring() {
		return exam_scoring;
	}
	public void setExam_scoring(int exam_scoring) {
		this.exam_scoring = exam_scoring;
	}
	
	
	
}
