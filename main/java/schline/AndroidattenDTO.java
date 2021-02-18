package schline;

public class AndroidattenDTO {
	
	private String attendance_idx;
	private String user_id;
	private String video_idx;
	private String play_time;
	private String attendance_flag;
	private String currenttime;
	//비디오 테이블 참조용 인덱스 추가
	private String subject_idx;
	private String video_postdate;
	private String video_title;
	private String video_end;
	private String server_saved;
	private String rnum;
	
	private int grade_idx;
	private int exam_idx;
	private int grade_exam;
	//과제 테이블 조인용
	private String exam_name;	 //과제 이름
	java.sql.Date exam_postdate; //작성 날짜	
	java.sql.Date exam_date;	//제출마감일
	private int exam_type;		//과제(1), 시험(2)
	private String exam_content; //본문
	private int exam_scoring; 	//과제, 시험에 대한 배점
	public String getAttendance_idx() {
		return attendance_idx;
	}
	public void setAttendance_idx(String attendance_idx) {
		this.attendance_idx = attendance_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getVideo_idx() {
		return video_idx;
	}
	public void setVideo_idx(String video_idx) {
		this.video_idx = video_idx;
	}
	public String getPlay_time() {
		return play_time;
	}
	public void setPlay_time(String play_time) {
		this.play_time = play_time;
	}
	public String getAttendance_flag() {
		return attendance_flag;
	}
	public void setAttendance_flag(String attendance_flag) {
		this.attendance_flag = attendance_flag;
	}
	public String getCurrenttime() {
		return currenttime;
	}
	public void setCurrenttime(String currenttime) {
		this.currenttime = currenttime;
	}
	public String getSubject_idx() {
		return subject_idx;
	}
	public void setSubject_idx(String subject_idx) {
		this.subject_idx = subject_idx;
	}
	public String getVideo_postdate() {
		return video_postdate;
	}
	public void setVideo_postdate(String video_postdate) {
		this.video_postdate = video_postdate;
	}
	public String getVideo_title() {
		return video_title;
	}
	public void setVideo_title(String video_title) {
		this.video_title = video_title;
	}
	public String getVideo_end() {
		return video_end;
	}
	public void setVideo_end(String video_end) {
		this.video_end = video_end;
	}
	public String getServer_saved() {
		return server_saved;
	}
	public void setServer_saved(String server_saved) {
		this.server_saved = server_saved;
	}
	public String getRnum() {
		return rnum;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
	}
	public int getGrade_idx() {
		return grade_idx;
	}
	public void setGrade_idx(int grade_idx) {
		this.grade_idx = grade_idx;
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
