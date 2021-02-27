package admin.model;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import admin.AdminCommandImpl;
import admin.model.AdminUserTemplateDAO;
import schline.ClassDTO;
import schline.GradeDTOImpl;
import schline.UserVO;
import schline.util.PagingUtil;
import schline.util.PagingUtil_admin;

/*
- BbsCommandImpl 인터페이스를 구현했으므로 execute()는 반드시 오버라이딩 해야 한다.
- 또한 해당 객체는 부모타입인 BbsCommandImpl로 참조할 수 있다. */
public class AttendEditCommand implements AdminCommandImpl{

	@Override
	public void execute(Model model) {
		
		Map<String, Object> paramMap = model.asMap();
		HttpServletRequest req = (HttpServletRequest)paramMap.get("req");
		
		// DAO객체 생성
		AdminAttendTemplateDAO attendDAO= new AdminAttendTemplateDAO();

		String attendance_idx = req.getParameter("attendance_idx");
		String attendance_flag = req.getParameter("attendance_flag");
		
		paramMap.put("attendance_idx",attendance_idx);
		paramMap.put("attendance_flag",attendance_flag);
				
		
	}
}