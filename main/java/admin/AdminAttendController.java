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

import admin.model.AttendListCommand;
import admin.model.UserListCommand;
import schline.util.JdbcTemplateConst;



@Controller
public class AdminAttendController {
	
	private JdbcTemplate template;

	@Autowired
	public void setTemplate(JdbcTemplate template) {
		this.template = template;
		
		
		JdbcTemplateConst.template = this.template;
	}
	
	
	AdminCommandImpl command = null;

	@RequestMapping("/admin/attend")
	public String list(Model model, HttpServletRequest req) {
		
		model.addAttribute("req", req);
		

		command = new AttendListCommand();
		command.execute(model);
		
		return "admin/attend/attendList";
	}
	
	
	
}
