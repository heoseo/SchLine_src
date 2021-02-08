package schline;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

@Service
public interface ClassDTOImpl {
	public ArrayList<ClassDTO> listCourse(ClassDTO classdto);
	public ArrayList<VideoDTO> listLecture(VideoDTO videoDTO );
	public ArrayList<VideoDTO> listVideo(@Param("user") String user_id);
	public String whatsub_id(@Param("idx") String user_id);
	public void upvid (@Param("idx") String subject_idx, @Param("end") String end_date,
			@Param("title") String title, @Param("server") String saveFilename);
	public VideoDTO modilist (@Param("idx") String idx);
	public void modivid (@Param("idx") String video_idx, @Param("end") String end_date,
			@Param("title") String title, @Param("server") String saveFilename);
	public void deletevid (@Param("vid_idx") String idx);
	public void atupdatedb(AttendanceDTO attendanceDTO);
	public AttendanceDTO selectat (@Param("user") String user_id, @Param("idx") String video_idx);
}
