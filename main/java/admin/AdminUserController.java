package admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import admin.model.UserListCommand;
import schline.util.JdbcTemplateConst;



@Controller
public class AdminUserController {
	
	private JdbcTemplate template;

	@Autowired
	public void setTemplate(JdbcTemplate template) {
		this.template = template;
		
		System.out.println("AdminUserController@Autowired => JdbcTemplate 연결성공");
		
		JdbcTemplateConst.template = this.template;
	}
	
	
	AdminCommandImpl command = null;

	@RequestMapping("/admin/userList")
	public String list(Model model, HttpServletRequest req) {
		
		model.addAttribute("req", req);
		

		command = new UserListCommand();
		command.execute(model);
		
		return "admin/user/userList";
	}

	
	
}
