package professor;

import java.security.Principal;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TestProfessorController {
	@RequestMapping(value = "/professor/empty", method = RequestMethod.GET)
	public String goMain() {
		
		return "professor/empty";
	}

}
