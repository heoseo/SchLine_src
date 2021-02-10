package android;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import schline.UserDAO;
import schline.UserVO;

@Controller
public class LoginController {

	//Mybatis 사용을 위한 자동주입
	@Autowired
	private SqlSession sqlSession;
	
	
	
	//매개변수가 필요없이 회원리스트 전체를 JSONArray로 데이터 반환.
	@RequestMapping("/android/memberLogin.do")
	@ResponseBody
		public Map<String, Object> memberLogin(UserVO memberVO) {
		System.out.println("A35Http02 연결 성공");
		
		//JSONObject로 반환할 경우.
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		UserVO memberInfo =
				sqlSession.getMapper(UserDAO.class).memberLogin(memberVO);
		
		if(memberInfo==null) {
			//회원정보 불일치로 로그인에 실패한 경우..결과만 0으로 내려준다.
			returnMap.put("isLogin", 0);
		}
		else {
			//로그인에 설공하면 결과는 1, 해당 회원의 정보를 객체로 내려준다.
//	          memberMap.put("id", memberInfo.getId());
//	          memberMap.put("pass", memberInfo.getPass());
//	          memberMap.put("name", memberInfo.getName());
			
			returnMap.put("memberInfo", memberInfo);
			returnMap.put("isLogin", 1);
		}
       
     
		return returnMap;
	}
}
