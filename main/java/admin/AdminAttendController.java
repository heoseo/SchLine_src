package admin;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import admin.model.AdminAttendTemplateDAO;
import admin.model.AttendEditCommand;
import admin.model.AttendListCommand;
import admin.model.AttendanceDTO;
import admin.model.AttendanceMiniDTO;
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
	
	
	@RequestMapping(value="/admin/attend/editAttend", method=RequestMethod.POST)
	public String editAttend(@RequestBody AttendanceMiniDTO attend, Model model, HttpServletRequest req) {
		
//		model.addAttribute("req", req);

		String attendance_flag = attend.getAttendance_flag();
		String attendance_idx = attend.getAttendance_idx();
		
		Map<String, Object> paramMap = model.asMap();
		paramMap.put("attendance_idx", attendance_idx);
		paramMap.put("attendance_flag", attendance_flag);

		AdminAttendTemplateDAO attendDAO = new AdminAttendTemplateDAO(); 
		attendDAO.editAttend(paramMap);
		
		return "true";
		
	}
	
	
	
}
