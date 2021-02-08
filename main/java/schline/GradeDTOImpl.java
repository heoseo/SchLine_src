package schline;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

@Service
public interface GradeDTOImpl {
	public ArrayList<AttendanceDTO> listAttendance(AttendanceDTO attendanceDTO);
	public ArrayList<GradeDTO> listGrade(GradeDTO gradeDTO);
	public ArrayList<RegistrationDTO> Registrationgrade(RegistrationDTO registrationDTO);	
	public ArrayList<UserInfoDTO> listInfo(UserInfoDTO userInfoDTO);	
	public ArrayList<UserInfoDTO> RegistrationInfo(UserInfoDTO userInfoDTO);	
	
}
