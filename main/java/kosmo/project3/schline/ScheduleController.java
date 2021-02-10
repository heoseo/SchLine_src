package kosmo.project3.schline;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import Util.PagingUtil;
import schedule.NoticeDTO;
import schedule.ScheduleDAOImpl;

@Controller
public class ScheduleController {
	
	//servlet-context.xml에서 생성한 빈을 자동으로 주입받아 Mybatis를 사용할 준비를 한다.
	@Autowired
	private SqlSession sqlSession;
	//세터위의 @Autowired를 붙혀도 사용가능.
	//콘솔상의 로그를 확인을 위함이면 세터를 사용한다~해도안해도상관없다.
    public void setSqlSession(SqlSession sqlSession) { 
    	this.sqlSession = sqlSession; 
    	System.out.println("스케쥴컨트롤실행됨"); 
    }
    
	//일정>알림 이동.
	@RequestMapping("/schedule/alertList.do")
	public String allList(Model model, HttpServletRequest req, HttpSession session) 
	{
		
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("세션저장아이디체크>>>>>>>>>>>>>>>>>>>>: " + user_id); 
		
		String type = req.getParameter("type");

/////////게시물의 갯수를 카운트.//////////////////////////////////////////////
		/*
		서비스객체 역할을 하는 인터페이스에 정의된 추상메소드를 호출하면
		최종적으로 Mapper의 동일한 id속성값을 가진 엘리먼트의 
		쿼리문이 실행되어 결과를 반환받게 된다.
		 */
		int totalRecordCount =
			sqlSession.getMapper(ScheduleDAOImpl.class)
				.getTotalCountAll(user_id);
			
	
		//페이지 처리를 위한 설정값.
		int pageSize = 20;
		int blockPage = 10;
		
		//전체페이지수 계산.
		int totalPage =
			(int)Math.ceil((double)totalRecordCount/pageSize);
		
		//현재페이지 번호 가져오기. 삼항연산자사용.
		int nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		
		//select할 게시물의 구간을 계산.
		int start = (nowPage-1) * pageSize + 1;
		int end = nowPage * pageSize;
		
		 
		//Mapper 호출.
		ArrayList<NoticeDTO> alertList =
			sqlSession.getMapper(ScheduleDAOImpl.class)
				.allBoard(user_id, start, end);
////////////////////////////////////////////////////////////////////////////////////
		System.out.println("■[Schedule컨트롤러 > alertList.do 요청 들어옴.]■");
		
		//페이지번호 처리.
		String pagingImg =
			PagingUtil.pagingAjax(
				totalRecordCount,
				pageSize, blockPage, nowPage,
				req.getContextPath()
					+"/schedule/alertList.do?type="+type+"&");
		
		
		
		//디버깅용
		//System.out.println("일정 컨트롤러에서> 전체게시물에서>  start : " + start + ", end : " + end);
		//System.out.println("allLists : >>>>>>>>>>>>" + alertList);
		
		
		//게시물의 줄바꿈 처리.
		for(NoticeDTO dto : alertList)
		{
			String temp = dto.getCONTENT().replace("\r\n", "<br/>");
			dto.setCONTENT(temp);
			//디버깅용
			//System.out.println("temp : >>>>>>" + temp);
		}
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("alertList", alertList);	
		
		
		System.out.println("■[Schedule컨트롤러 > alertList.do 요청 들어옴.]■");

		return "/schedule/alertList";
	}
	
	
	//일정>알림 이동.
	@RequestMapping("/schedule/ajaxAlertList.do")
	public String ajaxNoticeRead(Model model, HttpServletRequest req, HttpSession session) 
	{
		
		String user_id = (String) session.getAttribute("user_id");
		//System.out.println("세션저장아이디체크>>>>>>>>>>>>>>>>>>>>: " + user_id); 
		
		String type = req.getParameter("type"); 
		 
		
		//System.out.println("일정 컨트롤러에서 셀렉트의 type이 뭐가 넘어왓니이1?!? :>>>>>>>" + type);
		
		
		//게시물의 갯수를 카운트.
		/*
		서비스객체 역할을 하는 인터페이스에 정의된 추상메소드를 호출하면
		최종적으로 Mapper의 동일한 id속성값을 가진 엘리먼트의 
		쿼리문이 실행되어 결과를 반환받게 된다.
		 */
		int totalRecordCount =
			sqlSession.getMapper(ScheduleDAOImpl.class)
				.getTotalCountAll(user_id);
		
		//페이지 처리를 위한 설정값.
		int pageSize = 20;
		int blockPage = 10;
		
		//전체페이지수 계산.
		int totalPage =
			(int)Math.ceil((double)totalRecordCount/pageSize);
		
		//현재페이지 번호 가져오기. 삼항연산자사용.
		int nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		
		//select할 게시물의 구간을 계산.
		int start = (nowPage-1) * pageSize + 1;
		int end = nowPage * pageSize;
		

		
		//Mapper 호출.
		ArrayList<NoticeDTO> ajaxAlertList = null;
		
		switch(type) {
		
			case "allBoard":
				ajaxAlertList = sqlSession.getMapper(ScheduleDAOImpl.class)
						.allBoard(user_id, start, end);
				break;
			case "allNoti":
				ajaxAlertList =	sqlSession.getMapper(ScheduleDAOImpl.class)
						.allNoti(user_id, start, end);
				break;
			case "taskAndExam":
				ajaxAlertList = sqlSession.getMapper(ScheduleDAOImpl.class)
						.taskAndExam(user_id, start, end);
				break;
			case "notiRead":
				ajaxAlertList = sqlSession.getMapper(ScheduleDAOImpl.class)
						.notiRead(user_id, start, end);
				break;
			case "notiNotRead":
				ajaxAlertList = sqlSession.getMapper(ScheduleDAOImpl.class)
					.notiNotRead(user_id, start, end);
				break;
			
		}
		
		//페이지번호 처리.
		String pagingImg =
			PagingUtil.pagingAjax(totalRecordCount,
				pageSize, blockPage, nowPage,
				req.getContextPath()
					+"/schedule/alertList.do?type="+type+"&");
		
		
		//System.out.println("★일정 컨트롤> 에이젝스>알림게시물에서>  start : " + start + ", end : " + end);
		
		//System.out.println("ajaxList : >>>>>>>>>>>>" + ajaxAlertList);
		
		
		//게시물의 줄바꿈 처리.
//		for(NoticeDTO dto : ajaxAlertList)
//		{
//			String temp = dto.getCONTENT().replace("\r\n", "<br/>");
//			dto.setCONTENT(temp);
//			System.out.println("temp : >>>>>>" + temp);
//		}
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("ajaxAlertList", ajaxAlertList);
		
		System.out.println("■[Schedule컨트롤러 > ajaxAlertList.do 요청 들어옴.]■");

		return "/schedule/ajaxAlertList";
	}
	
	
	//일정>알림>과제/시험 셀렉트 옵션 체인지이벤트. 체인지시 이동.
	@RequestMapping("/schedule/viewList.do")
	public String viewPop(Model model, HttpServletRequest req) {
		
		String IDX = req.getParameter("IDX");
		String noti_or_exam = req.getParameter("noti_or_exam");
		
		System.out.println("IDX > " + IDX);
		System.out.println("noti_or_exam > " + noti_or_exam);
		//String query = "SELECT * FROM board WHERE num=?";
		
		ArrayList<NoticeDTO> ajaxPopList = null;
		
		String view = "";
		switch(noti_or_exam) {
		
		case "noti":
			ajaxPopList = sqlSession.getMapper(ScheduleDAOImpl.class)
					.noti(IDX);
			view = "/schedule/viewNoti";
			break;
		case "exam":
			ajaxPopList = sqlSession.getMapper(ScheduleDAOImpl.class)
				.exam(IDX);
			view = "/schedule/viewExam";
			break;
		}
		
		System.out.println("ajaxPopList : >>>>>>>>>>>>" + ajaxPopList);
		
		model.addAttribute("ajaxPopList", ajaxPopList);
		
		System.out.println("■ [Schedule컨트롤러 > viewPop.do 요청 들어옴.]■");
		
		return view;
	}
	//일정>알림>과제/시험에서 제목클릭시 팝업창띄운후 viewPop에서 제출하기버튼 클릭시호출.
//	@RequestMapping("/schedule/submitTask.do")
//	public String submitTask(Model model, HttpServletRequest req) {
//	
//		System.out.println("■ [Schedule컨트롤러 > submitTask.do 요청 들어옴.]■");
//
//		return "/schedule/submitTask";	
//	}
	
	
	
//#################################################################	
	

	

}
