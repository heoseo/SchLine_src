package admin.model;

public class AttendanceMiniDTO {
	
	private String attendance_idx;
	private String attendance_flag;
	public String getAttendance_idx() {
		return attendance_idx;
	}
	public void setAttendance_idx(String attendance_idx) {
		this.attendance_idx = attendance_idx;
	}
	public String getAttendance_flag() {
		return attendance_flag;
	}
	public void setAttendance_flag(String attendance_flag) {
		this.attendance_flag = attendance_flag;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "flag : " + attendance_flag + " idx : " + attendance_idx;
	}
}
