package admin;

import java.util.Map;

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

import admin.model.AdminAttendTemplateDAO;
import admin.model.AdminStudyRoomTemplateDAO;
import admin.model.ClassListCommand;
import admin.model.StudyRoomListCommand;
import admin.model.UserListCommand;
import schline.util.JdbcTemplateConst;



@Controller
public class AdminStudyroomController {
	
	private JdbcTemplate template;

	@Autowired
	public void setTemplate(JdbcTemplate template) {
		this.template = template;
		
		System.out.println("@Autowired => JdbcTemplate 연결성공");
		
		JdbcTemplateConst.template = this.template;
	}
	
	
	AdminCommandImpl command = null;

	@RequestMapping("/admin/studyRoom/user")
	public String list(Model model, HttpServletRequest req) {
		
		model.addAttribute("req", req);
		command = new StudyRoomListCommand();
		command.execute(model);
		
		return "admin/studyRoom/userList";
	}
	
	
	@RequestMapping("/admin/studyRoom/editBlackList")
	public String editBlackList( Model model, HttpServletRequest req) {
		

		String user_id = req.getParameter("user_id");
        
		
		Map<String, Object> paramMap = model.asMap();
		paramMap.put("user_id", user_id);

		AdminStudyRoomTemplateDAO attendDAO = new AdminStudyRoomTemplateDAO(); 
		attendDAO.editBlackList(paramMap);
		
		
		return "admin/attend/attendList";
		
	}
	
	
}
