package android;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import schline.ClassDTO;
import schline.ClassDTOImpl;
import schline.VideoDTO;

@Controller
public class ClassAppController {
	@Autowired
	private SqlSession sqlSession;
	
///////////// 스쿨라인 앱 컨트롤러  start///////////////
	
@RequestMapping("/android/CourseList.do")
@ResponseBody
public ArrayList<ClassDTO> courseList(HttpServletRequest req){
	
	ClassDTO classdto = new ClassDTO();
	classdto.setUser_id(req.getParameter("userID"));
	ArrayList<ClassDTO> lists = 
			sqlSession.getMapper(ClassDTOImpl.class).listCourse(classdto);
	
	return lists;
	
	
}
/*//학생 강의 영상리스트
	@RequestMapping("/android/time.do")
	@ResponseBody
	public ArrayList<VideoDTO> lecture(Model model,  HttpServletRequest req) {
		VideoDTO videoDTO = new VideoDTO();
		videoDTO.setSubject_idx(req.getParameter("subject_idx"));
		ArrayList<VideoDTO> lists = sqlSession.getMapper(ClassDTOImpl.class).listLecture(videoDTO);
		
		return lists;
	}*/
//학생 강의 영상리스트
	@RequestMapping("/android/time.do")
	@ResponseBody
	public Map<String,Object> lecture(Model model,  HttpServletRequest req) {
		Map<String, Object> map = new HashMap<String, Object>();
		VideoDTO videoDTO = new VideoDTO();
		videoDTO.setSubject_idx(req.getParameter("subject_idx"));
		ArrayList<VideoDTO> lists = sqlSession.getMapper(ClassDTOImpl.class).listLecture(videoDTO);
		
		map.put("lists", lists);
		return map;
	}

}
