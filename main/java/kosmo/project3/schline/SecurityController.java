package kosmo.project3.schline;

import java.security.Principal;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import security.CustomUserDetails;


@Controller
public class SecurityController {
	
//	@RequestMapping("/member/login.do")
//	public String securityIndex2Login(Model model, Authentication authentication, Principal principal) {
//		
//		return "member/login";
//	}
//	
	@RequestMapping("/member/getAuth")
	public void getAuth() {
		
	}

	@RequestMapping("/member/accessDenied.do")
	public String securityIndex2AccessDenied(HttpServletRequest request) {
		
		return "member/accessDenied";
	}
	
		
	

	

}
