package admin.model;

//출석체크용
public class AttendanceDTO {
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
	
	//관리자용 출석 리스트.
	private String user_name;
	
	
	public String getServer_saved() {
		return server_saved;
	}
	public void setServer_saved(String server_saved) {
		this.server_saved = server_saved;
	}
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
	public String getRnum() {
		return rnum;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	
	
}
