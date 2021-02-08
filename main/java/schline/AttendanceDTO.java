package schline;

//출석체크용
public class AttendanceDTO {
	private int attendance_idx;
	private String user_id;
	private String video_idx;
	private int play_time;
	private int attendance_flag;
	//비디오 테이블 참조용 인덱스 추가
	private String subject_idx;
	private String video_postdate;
	private String video_title;
	private String video_end;
	private String rnum;
	
	
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
	public int getAttendance_idx() {
		return attendance_idx;
	}
	public void setAttendance_idx(int attendance_idx) {
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
	public void setVideo_idx(String string) {
		this.video_idx = string;
	}
	public int getPlay_time() {
		return play_time;
	}
	public void setPlay_time(int play_time) {
		this.play_time = play_time;
	}
	public int getAttendance_flag() {
		return attendance_flag;
	}
	public void setAttendance_flag(int attendance_flag) {
		this.attendance_flag = attendance_flag;
	}

	
}
