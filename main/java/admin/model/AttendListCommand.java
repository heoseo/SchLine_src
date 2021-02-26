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
public class AttendListCommand implements AdminCommandImpl{

	@Override
	public void execute(Model model) {
		
		Map<String, Object> paramMap = model.asMap();
		HttpServletRequest req = (HttpServletRequest)paramMap.get("req");
		
		// DAO객체 생성
		AdminAttendTemplateDAO attendDAO= new AdminAttendTemplateDAO();
		AdminClassTemplateDAO classDAO = new AdminClassTemplateDAO();
		
		// 검색어 관련 폼값 처리
		String searchSubject = req.getParameter("searchSubject");
		String searchUser = req.getParameter("searchUser");
		
		paramMap.put("searchSubject",searchSubject);
		paramMap.put("searchUser",searchUser);
				
		System.out.println("searchSubject : " +searchSubject  + " searchUser: " +searchUser );
		
		
		// 과목 나열
		ArrayList<ClassDTO> subjectLists = classDAO.listPage(paramMap);
		
		// 출석 나열
		//해당과목 듣는 학생 리스트
		ArrayList<Admin_UserVO> userList = attendDAO.userList(paramMap);
//		ArrayList<ArrayList<AttendanceDTO>>
		
		ArrayList<ArrayList<AttendanceDTO>> attendLists = new ArrayList<ArrayList<AttendanceDTO>>();
		for(Admin_UserVO user : userList) {
			if(paramMap.get("searchUser") == null)
				paramMap.put("searchUser", user.getUser_name());
			else
				paramMap.put("searchUser", user.getUser_name());
			
			
			AttendanceDTO dto_for_user_id = new AttendanceDTO();
			AttendanceDTO dto_for_user_name = new AttendanceDTO();
			
			dto_for_user_id.setUser_id(user.getUser_id());
			dto_for_user_name.setUser_name(user.getUser_name());
			
			ArrayList<AttendanceDTO> attendList = attendDAO.attendList(paramMap);
			attendList.add(0, dto_for_user_id);
			attendList.add(1, dto_for_user_name);
			
//			for(AttendanceDTO attend : attendList) {
//				System.out.println(attend.getAttendance_idx());
//			}
			
			attendLists.add(attendList);
		}
		
		
		model.addAttribute("subjectLists", subjectLists);
		model.addAttribute("attendLists", attendLists);
		model.addAttribute("paramMap", paramMap);
		
		
		
	}
}