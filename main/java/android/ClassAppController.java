package android;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import schline.ClassDTO;
import schline.ClassDTOImpl;

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

}
