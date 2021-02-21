package kosmo.project3.schline;

import java.security.Principal;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import schline.ClassDTO;
import schline.ClassDTOImpl;
import schline.ExamDTO;
import schline.GradeDTOImpl;
import schline.SchlineDAOImpl;
import schline.UserInfoDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String goMain(Principal principal, Authentication authentication, HttpSession session, Model model) {
//		System.out.println("HomeController > / 요청 들어옴.");
		
		if(authentication != null) {
			
			Collection<? extends GrantedAuthority> user_auth = null;
			
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			
			String user_id = userDetails.getUsername();
			user_auth = userDetails.getAuthorities();
			
			UserInfoDTO userInfoDTO = new UserInfoDTO();
			userInfoDTO.setUser_id(user_id);
			UserInfoDTO lists =  sqlSession.getMapper(GradeDTOImpl.class).listInfo_admin(userInfoDTO);
			String user_name = lists.getUser_name();
			
			
			session.setAttribute("user_id", user_id);
			session.setAttribute("user_auth", user_auth);
			session.setAttribute("user_name", user_name);
			
			if(user_auth.toString().contains("ROLE_STUDENT")) {
				ClassDTO classdto = new ClassDTO();
	            classdto.setUser_id(session.getAttribute("user_id").toString());
	            ArrayList<ClassDTO> course =  sqlSession.getMapper(ClassDTOImpl.class).listCourse(classdto);
	            model.addAttribute("course", course);
	            
	             //메인 과제리스트 뿌리기 시작
	             ArrayList<ExamDTO> examlist =
	             sqlSession.getMapper(SchlineDAOImpl.class) .getMainTask(user_id);
	              model.addAttribute("examlist", examlist); 
	              //메인 과제리스트 뿌리기 종료
	                   

				
						
				return "main/studentHome";
			}
			else if(user_auth.toString().contains("ROLE_PROFESSOR")) {
				return "redirect:professor/video.do";
			}
			else if(user_auth.toString().contains("ROLE_ADMIN")) {
				return "redirect:admin/userList";
			}
		}
		
//		System.out.println("HomeController > authentication없음!!");
		return "home";
		
	}
	
	// 무료탬플릿 설명서1
	@RequestMapping("/elements.do")
	public String elementsGo() {

		return "elements";
	}
	
	
}
