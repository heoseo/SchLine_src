package admin.model;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import admin.AdminCommandImpl;
import admin.model.AdminUserTemplateDAO;
import schline.AttendanceDTO;
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
		String searchColumn = req.getParameter("searchColumn");
		if(searchColumn == null) {
			searchColumn = "PROFESSOR";
			System.out.println("UserListController > searchColumn 안들어옴.");
		}
		String searchSubject = req.getParameter("searchSubject");
		String searchUser = req.getParameter("searchUser");
		
		
		
		paramMap.put("searchSubject",searchSubject);
		paramMap.put("searchUser",searchUser);
				
		
		
		
		// 과목 나열
		ArrayList<ClassDTO> subjectLists = classDAO.listPage(paramMap);
		
		// 출석 나열
		//해당과목 듣는 학생 리스트
		ArrayList<Admin_UserVO> userLists = attendDAO.userList(paramMap);
//		ArrayList<ArrayList<AttendanceDTO>>
		
		for(Admin_UserVO user : userLists) {
			
		}
		
		
		model.addAttribute("subjectLists", subjectLists);
		model.addAttribute("userLists", userLists);
		model.addAttribute("paramMap", paramMap);
		
		
		
		

		
		
		
		
		
		//출석
		
	}
}