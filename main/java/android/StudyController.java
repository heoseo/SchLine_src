package android;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import studyroom.InfoVO;
import studyroom.StudyDAOImpl;

////안드로이드 공부방 컨트롤러
@Controller
public class StudyController {
	
	public StudyController() {
		System.out.println("안드로이드 공부방 생성자 호출");
	}
	
	//Mybatis 사용을위한 자동주입
	@Autowired
	private SqlSession sqlSession;
	
	//로그인된 회원정보 JSONObject로 반환
	//커맨드 객체를 통해 한번에 정보주입
	@RequestMapping("/android/class/study.do")
	@ResponseBody
	public Map<String, Object> study(HttpServletRequest req, InfoVO infoVO){
		System.out.println("모바일 공부방 컨트롤러");
		Map<String, Object> map = new HashMap<String, Object>();
		
		//InfoVO infoVO = new InfoVO();
		infoVO.setUser_id(req.getParameter("user_id"));
		System.out.println("안스user_id="+req.getParameter("user_id"));
		
		InfoVO user = sqlSession.getMapper(StudyDAOImpl.class).login_info(infoVO);
		
		//로그인 회원 정보를 map에 담기
		map.put("user", user);
		
		return map;
	}
	
	@RequestMapping("/android/class/studyLank.do")
	@ResponseBody
	public ArrayList<InfoVO> lankList(HttpServletRequest req){
		
		//전체회원 리스트 불러오기 및 랭킹매기기
		ArrayList<InfoVO> LankList = sqlSession.getMapper(StudyDAOImpl.class).lank_list();
		
		return LankList;
	}
	
	
//	@RequestMapping("/android/class/study.do")
//	@ResponseBody
//	public Map<String, Object> study(HttpServletRequest req, Principal principal){
//		Map<String, Object> map = new HashMap<String, Object>();
//		
//		//시큐리티 유저 아이디 얻어오기
//		String user_id = principal.getName();
//		System.out.println("시큐리티 유저아이디="+user_id);
//		
//		InfoVO user = sqlSession.getMapper(StudyDAOImpl.class).user_nick(user_id);
//		//로그인 회원 정보를 map에 담기
//		map.put("user", user);
//		
//		return map;
//	}
	
	@RequestMapping("/android/class/studyChat.do")
	public Map<String, Object> studyChat(InfoVO infoVO){
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("모바일 채팅방 이동");
		
		//로그인회원 프로필 불러오기
		InfoVO user = sqlSession.getMapper(StudyDAOImpl.class).login_info(infoVO);
		map.put("user", user);
		
		//전체회원 리스트 불러오기
		ArrayList<InfoVO> studyList = sqlSession.getMapper(StudyDAOImpl.class).study_list();
		map.put("studyList", studyList);
		
		return map;
	}
	
	
	//안드로이드 파일업로드
	

	
	
}
