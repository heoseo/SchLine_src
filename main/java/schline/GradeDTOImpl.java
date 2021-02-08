package schline;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

@Service
public interface GradeDTOImpl {
	public ArrayList<AttendanceDTO> listAttendance(AttendanceDTO attendanceDTO);
	public ArrayList<GradeDTO> listGrade(GradeDTO gradeDTO);
}
