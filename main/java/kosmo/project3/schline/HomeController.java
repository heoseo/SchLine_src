package kosmo.project3.schline;

import java.security.Principal;
import java.text.DateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String goMain(Principal principal, Authentication authentication, HttpSession session) {
//		System.out.println("HomeController > / 요청 들어옴.");
		
		if(authentication != null) {
			
			Collection<? extends GrantedAuthority> user_auth = null;
			
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			System.out.println("authorities: " + userDetails.getAuthorities());
			
			String user_id = userDetails.getUsername();
			user_auth = userDetails.getAuthorities();
			
			
			session.setAttribute("user_id", user_id);
			session.setAttribute("user_auth", user_auth);
			
			if(user_auth.toString().contains("ROLE_STUDENT")) {
				return "main/studentHome";
			}
			else if(user_auth.toString().contains("ROLE_PROFESSOR")) {
				return "main/professorHome";
			}
			else if(user_auth.toString().contains("ROLE_ADMIN")) {
				return "admin/userList";
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
