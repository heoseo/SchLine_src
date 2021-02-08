package kosmo.project3.schline;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import schline.ClassDTO;
import schline.ClassDTOImpl;
import schline.VideoDTO;

@Controller
public class ClassRoomController {
	@Autowired
	private SqlSession sqlSession;
	
	//강의실 눌렀을 때 코스로 이동
	//로그인 끝나면 session 매개변수 상용
	@RequestMapping("/main/class.do")
	public String calssRoom(Model model) {
		
		ClassDTO classdto = new ClassDTO();
		classdto.setUser_id("201701701");
		ArrayList<ClassDTO> lists =  sqlSession.getMapper(ClassDTOImpl.class).listCourse(classdto);
		/*디버깅용
		String sql = sqlSession.getConfiguration().getMappedStatement("listCourse")
				.getBoundSql(ClassDTO).getSql();
		System.out.println("sql="+sql);
		 */
		model.addAttribute("lists", lists);
		return "classRoom/course";
	}
	@RequestMapping("/class/time.do")
	public String lecture(Model model,  HttpServletRequest req) {
		VideoDTO videoDTO = new VideoDTO();
		videoDTO.setSubject_idx(req.getParameter("subject_idx"));
		ArrayList<VideoDTO> lists = sqlSession.getMapper(ClassDTOImpl.class).listLecture(videoDTO);
		
		model.addAttribute("lists", lists);
		return "classRoom/lecture";
	}
	@RequestMapping("/class/play.do")
	public String play(Model model,  HttpServletRequest req) {
		
		String video_title = req.getParameter("title");
		
		model.addAttribute("video_title", video_title);
		return "classRoom/video";
	}

}