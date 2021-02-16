package android;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	
	/**
	 * 로그인 폼을 거치지 않고 바로 로그인
	 * @param username
	 * @return
	 */
//	@RequestMapping("/android/loginWithoutForm/{username}/{pass}")
	public String loginWithoutForm(	@PathVariable(value="username") String username,
									@PathVariable(value="pass") String pass) {
	  
	  List<GrantedAuthority> roles = new ArrayList<>(1);
	  String roleStr = username.equals("admin") ? "ROLE_ADMIN" : "ROLE_GUEST";
	  roles.add(new SimpleGrantedAuthority(roleStr));
	  
	  User user = new User(username, pass, roles);
	  
	  Authentication auth = new UsernamePasswordAuthenticationToken(user, pass, roles);
	  SecurityContextHolder.getContext().setAuthentication(auth);
	  return "redirect:/class/studyRoom.do";
	}
	
	//http://localhost:9999/schline/android/loginWithoutForm?user_id=201701700&user_pass=qwer1234
	@RequestMapping("/android/loginWithoutForm")
	private String securityLoginWithoutLoginForm(HttpServletRequest req, Object item) { 

		String user_id = req.getParameter("user_id");
		String user_pass = req.getParameter("user_pass");
		
		System.out.println("LoginController > user_id " + user_id + " user_pass " + user_pass);
		
	
		//로그인 세션에 들어갈 권한을 설정합니다. 
		List<GrantedAuthority> list = new ArrayList<GrantedAuthority>();
		list.add(new SimpleGrantedAuthority("ROLE_STUDENT"));
		
		SecurityContext sc = SecurityContextHolder.getContext();
		//아이디, 패스워드, 권한을 설정합니다. 아이디는 Object단위로 넣어도 무방하며
		//패스워드는 null로 하여도 값이 생성됩니다.
		sc.setAuthentication(new UsernamePasswordAuthenticationToken(user_id, user_pass, list));
		HttpSession session = req.getSession(true);
	  
		//위에서 설정한 값을 Spring security에서 사용할 수 있도록 세션에 설정해줍니다.
		session.setAttribute(HttpSessionSecurityContextRepository.
							SPRING_SECURITY_CONTEXT_KEY, sc);
		
					
		System.out.println("session.id => " +
							session.getAttribute(HttpSessionSecurityContextRepository.
													SPRING_SECURITY_CONTEXT_KEY));
		
		return "redirect:/";
	}
}
