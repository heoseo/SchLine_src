package android;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import schline.AttendanceDTO;
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
		String subject_idx=req.getParameter("subject_idx");
		String user_id = req.getParameter("user_id");
		ArrayList<VideoDTO> lists = sqlSession.getMapper(ClassDTOImpl.class).applistLecture(subject_idx, user_id);
		
		
		map.put("lists", lists);
		return map;
	}

	@RequestMapping("/android/token.do")
	@ResponseBody
	public String getToken(Model model, HttpServletRequest req) {
		String token = req.getParameter("token");
		String user_id = req.getParameter("user_id");
		sqlSession.getMapper(ClassDTOImpl.class).updateToken(token, user_id);
		
		return "ok";
	}
	@RequestMapping("/android/atupdate.do")
	@ResponseBody
    public void atupdate(HttpServletRequest req, HttpSession session) {
       String idx = req.getParameter("idx");
       String play = req.getParameter("play");
       String current = req.getParameter("current");
       String attend = req.getParameter("attend");
       AttendanceDTO dto = new AttendanceDTO();
       dto.setCurrenttime(current);
       dto.setAttendance_flag(attend);
       dto.setPlay_time(play);
       dto.setVideo_idx(idx);
       dto.setUser_id(req.getParameter("user_id"));
       System.out.println("안드디비 idx"+idx+" 플레이"+play+" current"+current+" attend:"+attend+"아이디"+dto.getUser_id());
       sqlSession.getMapper(ClassDTOImpl.class).atupdatedb(dto);
       
    
        
    }
}
