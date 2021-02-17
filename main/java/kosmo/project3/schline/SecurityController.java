package kosmo.project3.schline;

import java.security.Principal;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
public class SecurityController {
	
	@RequestMapping("/member/login.do")
	public String securityIndex2Login(Model model, Authentication authentication, Principal principal, HttpServletRequest request) {
		
		String user_id = request.getParameter("user_id");
		String user_pass = request.getParameter("user_pass");
		
		request.getParameter("SecurityConrtroller > user_id = : " +  user_id + "user_pass : " + user_pass);
		
		return "redirect:/";
	}
	
	@RequestMapping("/member/getAuth")
	public void getAuth() {
		
	}

	@RequestMapping("/member/accessDenied.do")
	public String securityIndex2AccessDenied(HttpServletRequest request) {
		
		return "member/accessDenied";
	}
	
		
	

	

}
