package schline;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import admin.FcmDTO;

@Service
public interface ClassDTOImpl {
	public ArrayList<ClassDTO> listCourse(ClassDTO classdto);
	public ArrayList<VideoDTO> listLecture(VideoDTO videoDTO );
	public ArrayList<VideoDTO> applistLecture(@Param("subject_idx") String subject_idx, @Param("user_id") String user_id );
	public ArrayList<VideoDTO> listVideo(@Param("user") String user_id);
	public String whatsub_id(@Param("idx") String user_id);
	public void upvid (@Param("idx") String subject_idx, @Param("end") String end_date,
			@Param("title") String title, @Param("server") String saveFilename);
	public VideoDTO modilist (@Param("idx") String idx);
	public void modivid (@Param("idx") String video_idx, @Param("end") String end_date,
			@Param("title") String title, @Param("server") String saveFilename);
	public void deletevid (@Param("vid_idx") String idx);
	public void delAttendance (@Param("vid_idx") String idx);
	public void atupdatedb(AttendanceDTO attendanceDTO);
	public AttendanceDTO selectat (@Param("user") String user_id, @Param("idx") String video_idx);
	public String[] StuList (@Param("s_id") String subject_idx);
	public String getVideoIdx (@Param("save") String saveFilename);
	public void  AttandanceInsDB(AttendanceDTO attendanceDTO);
	public ArrayList<String> divIdList(@Param("idx") String subject_idx);
	public String divID(String user_id);
	public String stu_id(String bgroup , String bindent);
	public ArrayList<FcmDTO> FcmSchedule ();
	public void updateToken(@Param("token") String token ,@Param("id") String user_id);
}
