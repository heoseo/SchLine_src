package schline;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

@Service
public interface GradeDTOImpl {
	public ArrayList<AttendanceDTO> listAttendance(AttendanceDTO attendanceDTO);
	public ArrayList<AttendanceDTO> listAttendance2(AttendanceDTO attendanceDTO);
	public ArrayList<AndroidattenDTO> listAttendance3(AndroidattenDTO androidattenDTO);
	public ArrayList<AttendanceDTO> attenupdate(AttendanceDTO attendanceDTO);
	public int videoConut(AttendanceDTO attendanceDTO);
	public ArrayList<AttendanceDTO> videoNum(AttendanceDTO attendanceDTO);
	public ArrayList<GradeDTO> listGrade(GradeDTO gradeDTO);
	public ArrayList<AndroidattenDTO> listGrade2(AndroidattenDTO androidattenDTO);
	public ArrayList<RegistrationDTO> Registrationgrade(RegistrationDTO registrationDTO);	
	public ArrayList<AndroidattenDTO> Registrationgrade2(AndroidattenDTO androidattenDTO);	
	public ArrayList<AttendanceDTO> AttenInfo(AttendanceDTO attendanceDTO);	
	public ArrayList<UserInfoDTO> listInfo(UserInfoDTO userInfoDTO);		
	public UserInfoDTO listInfo_admin(UserInfoDTO userInfoDTO);	
	public ArrayList<UserInfoDTO> RegistrationInfo(UserInfoDTO userInfoDTO);	
	public ArrayList<AndroidattenDTO> RegistrationInfo2(AndroidattenDTO androidattenDTO);	
	public ArrayList<UserInfoDTO> blockuser(UserInfoDTO userInfoDTO);	
	public ArrayList<UserInfoDTO> blockdelete(UserInfoDTO userInfoDTO);	
	public ArrayList<ExamBoardDTO> boardInfo(ExamBoardDTO examBoardDTO);	
	public ArrayList<UserSettingDTO> notiset(UserSettingDTO userSettingDTO);	
	public ArrayList<UserSettingDTO> examset(UserSettingDTO userSettingDTO);	
	public ArrayList<UserInfoDTO> subfind(UserInfoDTO userInfoDTO);	
	public ArrayList<UserInfoDTO> studentlist(UserInfoDTO userInfoDTO);	
	
	
}
