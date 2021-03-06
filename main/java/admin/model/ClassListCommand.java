package admin.model;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import admin.AdminCommandImpl;
import schline.ClassDTO;
import schline.UserVO;
import schline.util.PagingUtil;
import schline.util.PagingUtil_admin;

/*
- BbsCommandImpl 인터페이스를 구현했으므로 execute()는 반드시 오버라이딩 해야 한다.
- 또한 해당 객체는 부모타입인 BbsCommandImpl로 참조할 수 있다. */
public class ClassListCommand implements AdminCommandImpl{

	@Override
	public void execute(Model model) {
		
//		System.out.println("UserListCommand > execute() 호출");
		
		/*
		- 컨트롤로에서 인자로 전달한 model객체에는 request객체가 저장되어 있다.
		- asMap()을 통해 Map컬렉션으로 변환한 후 모든 요청을 가져올 수 있다.		 */
		Map<String, Object> paramMap = model.asMap();
		HttpServletRequest req = (HttpServletRequest)paramMap.get("req");
		
		// DAO객체 생성
		AdminClassTemplateDAO dao = new AdminClassTemplateDAO();
		
		// 검색어 관련 폼값 처리
		String addQueryString = "";
		String searchColumn = req.getParameter("searchColumn");
		if(searchColumn == null)
			searchColumn = "PROFESSOR";
		String searchWord = req.getParameter("searchWord");
		
//		System.out.println("UserListController > userType : " + userType + ", searchUser : " + searchWord);
		
		addQueryString = String.format("searchColumn=%s", searchColumn);
		paramMap.put("searchColumn", searchColumn);
				
		if(searchWord != null) {
			addQueryString += String.format("searchWord=%s", searchWord);
			paramMap.put("searchWord", searchWord);
		}
		
		// paramMap : list_flag, table, Word 
		
		// 전체 레코드 수 카운트하기
		int totalRecordCount = dao.getTotalCount(paramMap);
		
		
		/************************페이지 처리 start***************************/
		// Environment 객체를통한 외부파일 읽기
		int pageSize = 10;
		int blockPage= 6;
		
		// 전체 페이지 수를 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		
		// 현재 페이지 번호. 첫 진입일 떄는 무조건 1페이지로 지정
		int nowPage = req.getParameter("nowPage")==null ? 1 :
					Integer.parseInt(req.getParameter("nowPage"));
		
		// 리스트에 출력할 게시물의 구간을 계산
//		int start = (nowPage-1) * pageSize + 1;
//		int end = nowPage * pageSize;
		
//		paramMap.put("start", start);
//		paramMap.put("end", end);
		
				
		
		/************************페이지 처리 end***************************/
		
		
		
		ArrayList<ClassDTO> listRows = dao.listPage(paramMap);
		
		// 가상번호 계산하여 부여하기
		int virtualNum = 0;
		int countNum = 0;
		
		for(ClassDTO row : listRows)
		{
			virtualNum = totalRecordCount - (((nowPage-1)*pageSize) + countNum++);
		}
		 
		// 리스트에 출력한 list컬렉션을 model객체에 저장한 후 뷰로 전달한다.
		String pagingImg = PagingUtil_admin.pagingImg(totalRecordCount, pageSize, blockPage, nowPage, 
											req.getContextPath()+"/class/subjectList?"+addQueryString);
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("listRows", listRows);
		model.addAttribute("paramMap", paramMap);
		
		// JDBCTemplete에서는 자원반납을 하지 않는다.
		//dao.close();
		
	}
}