package schline;

public class ExamDTO {

	private int exam_idx; 		//과제,시험의 관리번호(PK)
	private int subject_idx; 	//각 과목의 인덱스(FK)	
	private String exam_name;	 //과제 이름
	private java.sql.Date exam_postdate; //작성 날짜	
	private java.sql.Date exam_date;	//제출마감일
	private int exam_type;		//과제(1), 시험(2)
	private String exam_content; //본문
	private int exam_scoring; 	//과제, 시험에 대한 배점
	
	private int question_idx;	//문제 인덱스(PK)
	private int question_type;	//문제 타입(객관식1, 단답형2, 서술형3)
	private String answer;		//정답
	private int question_score;	//문제별 배점
	private String question_content; //문제의 내용
	
	//객관식 문항용 변수
	private int questionlist_idx; //문제리스트(PK)	
	private String questionlist_content; //문항 내용
	private String questionlist_num;	//문항 번호(1~99)
	
	
	//getter/setter 생성
	public int getExam_idx() {
		return exam_idx;
	}
	public void setExam_idx(int exam_idx) {
		this.exam_idx = exam_idx;
	}
	public int getSubject_idx() {
		return subject_idx;
	}
	public void setSubject_idx(int subject_idx) {
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
	public int getQuestion_idx() {
		return question_idx;
	}
	public void setQuestion_idx(int question_idx) {
		this.question_idx = question_idx;
	}
	public int getQuestion_type() {
		return question_type;
	}
	public void setQuestion_type(int question_type) {
		this.question_type = question_type;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public int getQuestion_score() {
		return question_score;
	}
	public void setQuestion_score(int question_score) {
		this.question_score = question_score;
	}
	public String getQuestion_content() {
		return question_content;
	}
	public void setQuestion_content(String question_content) {
		this.question_content = question_content;
	}
	public int getQuestionlist_idx() {
		return questionlist_idx;
	}
	public void setQuestionlist_idx(int questionlist_idx) {
		this.questionlist_idx = questionlist_idx;
	}
	public String getQuestionlist_content() {
		return questionlist_content;
	}
	public void setQuestionlist_content(String questionlist_content) {
		this.questionlist_content = questionlist_content;
	}
	public String getQuestionlist_num() {
		return questionlist_num;
	}
	public void setQuestionlist_num(String questionlist_num) {
		this.questionlist_num = questionlist_num;
	}
}
