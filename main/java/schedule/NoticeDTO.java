package schedule;

import java.sql.Date;

public class NoticeDTO {
	
	//쿼리문 결과값에 맞춘 별칭변수.
	private int IDX;
	private int SUB_IDX;
	private String TITLE;
	private String CONTENT;
	private java.sql.Date POSTDATE;
	private int RNUM;
	//공지사항 확인유무(0:확인안함. 1:확인).
	private int CHECK_FLAG;
	
	
	

	
	
	//보드테이블 기본값들
	private int board_idx;
	private int subject_idx;
	private String board_type;
	private String user_id;
	private String board_title;
	private String board_content;
	private String board_file;
	private java.sql.Date board_postdate;
	private String board_flag_te;
	private int exam_idx;
	private java.sql.Date exam_postdate; //작성 날짜
	
	
	//다른 테이블과 조인
	private String user_name;
	private String subject_name;
	private String exam_name;
	private String exam_content;
	private java.sql.Date exam_date;
	
	//registration_tb 테이블
	//(학생(사용자가) 선택한 과목 리스트.)
	private String regi_idx;
	private String grade_sub;
	
	
	
	public NoticeDTO() {}



	public NoticeDTO(int iDX, int sUB_IDX, String tITLE, String cONTENT, Date pOSTDATE, int rNUM, int cHECK_FLAG,
			int board_idx, int subject_idx, String board_type, String user_id, String board_title, String board_content,
			String board_file, Date board_postdate, String board_flag_te, int exam_idx, Date exam_postdate,
			String user_name, String subject_name, String exam_name, String exam_content, Date exam_date,
			String regi_idx, String grade_sub) {
		super();
		IDX = iDX;
		SUB_IDX = sUB_IDX;
		TITLE = tITLE;
		CONTENT = cONTENT;
		POSTDATE = pOSTDATE;
		RNUM = rNUM;
		CHECK_FLAG = cHECK_FLAG;
		this.board_idx = board_idx;
		this.subject_idx = subject_idx;
		this.board_type = board_type;
		this.user_id = user_id;
		this.board_title = board_title;
		this.board_content = board_content;
		this.board_file = board_file;
		this.board_postdate = board_postdate;
		this.board_flag_te = board_flag_te;
		this.exam_idx = exam_idx;
		this.exam_postdate = exam_postdate;
		this.user_name = user_name;
		this.subject_name = subject_name;
		this.exam_name = exam_name;
		this.exam_content = exam_content;
		this.exam_date = exam_date;
		this.regi_idx = regi_idx;
		this.grade_sub = grade_sub;
	}



	public int getIDX() {
		return IDX;
	}



	public void setIDX(int iDX) {
		IDX = iDX;
	}



	public int getSUB_IDX() {
		return SUB_IDX;
	}



	public void setSUB_IDX(int sUB_IDX) {
		SUB_IDX = sUB_IDX;
	}



	public String getTITLE() {
		return TITLE;
	}



	public void setTITLE(String tITLE) {
		TITLE = tITLE;
	}



	public String getCONTENT() {
		return CONTENT;
	}



	public void setCONTENT(String cONTENT) {
		CONTENT = cONTENT;
	}



	public java.sql.Date getPOSTDATE() {
		return POSTDATE;
	}



	public void setPOSTDATE(java.sql.Date pOSTDATE) {
		POSTDATE = pOSTDATE;
	}



	public int getRNUM() {
		return RNUM;
	}



	public void setRNUM(int rNUM) {
		RNUM = rNUM;
	}



	public int getCHECK_FLAG() {
		return CHECK_FLAG;
	}



	public void setCHECK_FLAG(int cHECK_FLAG) {
		CHECK_FLAG = cHECK_FLAG;
	}



	public int getBoard_idx() {
		return board_idx;
	}



	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}



	public int getSubject_idx() {
		return subject_idx;
	}



	public void setSubject_idx(int subject_idx) {
		this.subject_idx = subject_idx;
	}



	public String getBoard_type() {
		return board_type;
	}



	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}



	public String getUser_id() {
		return user_id;
	}



	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}



	public String getBoard_title() {
		return board_title;
	}



	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}



	public String getBoard_content() {
		return board_content;
	}



	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}



	public String getBoard_file() {
		return board_file;
	}



	public void setBoard_file(String board_file) {
		this.board_file = board_file;
	}



	public java.sql.Date getBoard_postdate() {
		return board_postdate;
	}



	public void setBoard_postdate(java.sql.Date board_postdate) {
		this.board_postdate = board_postdate;
	}



	public String getBoard_flag_te() {
		return board_flag_te;
	}



	public void setBoard_flag_te(String board_flag_te) {
		this.board_flag_te = board_flag_te;
	}



	public int getExam_idx() {
		return exam_idx;
	}



	public void setExam_idx(int exam_idx) {
		this.exam_idx = exam_idx;
	}



	public java.sql.Date getExam_postdate() {
		return exam_postdate;
	}



	public void setExam_postdate(java.sql.Date exam_postdate) {
		this.exam_postdate = exam_postdate;
	}



	public String getUser_name() {
		return user_name;
	}



	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}



	public String getSubject_name() {
		return subject_name;
	}



	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}



	public String getExam_name() {
		return exam_name;
	}



	public void setExam_name(String exam_name) {
		this.exam_name = exam_name;
	}



	public String getExam_content() {
		return exam_content;
	}



	public void setExam_content(String exam_content) {
		this.exam_content = exam_content;
	}



	public java.sql.Date getExam_date() {
		return exam_date;
	}



	public void setExam_date(java.sql.Date exam_date) {
		this.exam_date = exam_date;
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

	

	
	
	

	
	
	
	

	
	
	
}
