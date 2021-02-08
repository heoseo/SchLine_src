package kosmo.project3.schline;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

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
	public String allList(Model model, HttpServletRequest req) 
	{
		
		String user_id = "201701700";	
		
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
		int pageSize = 10;
		int blockPage = 5;
		
		//전체페이지수 계산.
		int totalPage =
			(int)Math.ceil((double)totalRecordCount/pageSize);
		
		//현재페이지 번호 가져오기. 삼항연산자사용.
		int nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		
		//select할 게시물의 구간을 계산.
		int start = (nowPage-1) * pageSize + 1;
		int end = nowPage * pageSize;
		

		
		//Mapper 호출.
		ArrayList<NoticeDTO> allLists =
			sqlSession.getMapper(ScheduleDAOImpl.class)
				.allListPage(user_id, start, end);
		
		System.out.println("■[Schedule컨트롤러 > alertList.do 요청 들어옴.]■");
		
		//페이지번호 처리.
		String pagingImg =
			PagingUtil.pagingImg(
				totalRecordCount,
				pageSize, blockPage, nowPage,
				req.getContextPath()
					+"/schedule/alertList.do?");
		
		model.addAttribute("pagingImg", pagingImg);
		
		//디버깅용
		//System.out.println("일정 컨트롤러에서> 전체게시물에서>  start : " + start + ", end : " + end);
		//System.out.println("allLists : >>>>>>>>>>>>" + allLists);
		
		
		//게시물의 줄바꿈 처리.
		for(NoticeDTO dto : allLists)
		{
			String temp = dto.getCONTENT().replace("\r\n", "<br/>");
			dto.setCONTENT(temp);
			//디버깅용
			//System.out.println("temp : >>>>>>" + temp);
		}
		
		model.addAttribute("allLists", allLists);	
		
		
		System.out.println("■[Schedule컨트롤러 > alertList.do 요청 들어옴.]■");

		return "/schedule/alertList";
	}
	
	
	//일정>알림 이동.
	@RequestMapping("/schedule/ajaxNoticeRead.do")
	public String ajaxNoticeRead(Model model, HttpServletRequest req) 
	{
		
		String type = req.getParameter("type");
		
		System.out.println("일정 컨트롤러에서 셀렉트의 type이 뭐가 넘어왓니이1?!? :>>>>>>>" + type);
		
		String user_id = "201701700";	
		
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
		int pageSize = 10;
		int blockPage = 5;
		
		//전체페이지수 계산.
		int totalPage =
			(int)Math.ceil((double)totalRecordCount/pageSize);
		
		//현재페이지 번호 가져오기. 삼항연산자사용.
		int nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		
		//select할 게시물의 구간을 계산.
		int start = (nowPage-1) * pageSize + 1;
		int end = nowPage * pageSize;
		

		
		//Mapper 호출.
		ArrayList<NoticeDTO> ajaxNoticeRead =
			sqlSession.getMapper(ScheduleDAOImpl.class)
				.allListPage(user_id, start, end);
		
		System.out.println("■[Schedule컨트롤러 > alertList.do 요청 들어옴.]■");
		
		//페이지번호 처리.
		String pagingImg =
			PagingUtil.pagingImg(
				totalRecordCount,
				pageSize, blockPage, nowPage,
				req.getContextPath()
					+"/schedule/alertList.do?");
		
		model.addAttribute("pagingImg", pagingImg);
		
		System.out.println("일정 컨트롤러에서> 전체게시물에서>  start : " + start + ", end : " + end);
		
		System.out.println("ajaxNoticeRead : >>>>>>>>>>>>" + ajaxNoticeRead);
		
		
		//게시물의 줄바꿈 처리.
		for(NoticeDTO dto : ajaxNoticeRead)
		{
			String temp = dto.getCONTENT().replace("\r\n", "<br/>");
			dto.setCONTENT(temp);
			System.out.println("temp : >>>>>>" + temp);
		}
		
		model.addAttribute("ajaxNoticeRead", ajaxNoticeRead);
		
		System.out.println("■[Schedule컨트롤러 > ajaxNoticeRead.do 요청 들어옴.]■");

		return "/schedule/ajaxNoticeRead";
	}
	
	
	
	
	
	
	
	
	
//#################################################################	
	
	
	
	
	
	
	
//##################모달창띄우기..대기..####################	
	
	
	
	//일정>알림>공지읽음 클릭시 이동.
	@RequestMapping("/schedule/alertNoticeNotRead.do")
	public String alertNoticeNotReadGo() {
		
		System.out.println("■■ [Schedule컨트롤러 > alertNoticeNotRead.do 요청 들어옴.]■■");

		return "/schedule/alertNoticeNotRead";
	}
	
	//일정>알림>공지읽음 클릭시 이동.
	@RequestMapping("/schedule/correction.do")
	public String correctionGo() {
		
		System.out.println("■■ [Schedule컨트롤러 > correction.do 요청 들어옴.]■■");

		return "/schedule/correction";
	}
	
	//일정>알림>공지읽음 클릭시 이동.
	@RequestMapping("/schedule/deadLine.do")
	public String deadLineGo() {
		
		System.out.println("■■ [Schedule컨트롤러 > deadLine.do 요청 들어옴.]■■");

		return "/schedule/deadLine";
	}
	

}
