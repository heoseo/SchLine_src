package kosmo.project3.schline;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import schedule.CalendarDTO;

@Controller
public class ScheduleController {

	//일정>알림 이동.
	@RequestMapping("/schedule/alertList.do")
	public String alertListGo() {
		
		System.out.println("■[Schedule컨트롤러 > alertList.do 요청 들어옴.]■");

		return "/schedule/alertList";
	}
	
	//상단바 일정>드롭다운 캘린더 클릭시 이동.
	@RequestMapping("/schedule/calendarTop.do")
	public String calendarTopGo() {
		
		System.out.println("■ [Schedule컨트롤러 > calendarTo.do 요청 들어옴.]■");

		return "/schedule/calendarjavaAjax";
	}
	
	
	//일정>알림>왼쪽바 캘린더 클릭시 이동.
	@RequestMapping("/schedule/calendar.do")
	public String calendarLeftGo() {
		
		System.out.println("■ [Schedule컨트롤러 > calendarLeft.do 요청 들어옴.]■");

		return "/schedule/calendarjavaAjax";
	}
	
	
	//캘린더 온로드.
	@RequestMapping("/schedule/ajaxCalendar.do")
	public String ajaxCalendar() {
		
		System.out.println("■ [Schedule컨트롤러 > ajaxCalendar.do 요청 들어옴.]■");

		return "/schedule/ajaxCalendar";
	}
	
	

	//일정>알림>왼쪽바 캘린더 클릭시 이동.
//	@RequestMapping("/schedule/calendar.do")
//	public String calendarLeftGo() {
//		
//		System.out.println("■■ [Schedule컨트롤러 > calendarLeft.do 요청 들어옴.]■■");
//
//		return "/schedule/calendarjava";
//	}

//	//일정>알림>왼쪽바 캘린더 클릭시 이동.
//	@RequestMapping("/schedule/calendar.do")
//	public String calendarLeftGo() {
//		
//		System.out.println("■■ [Schedule컨트롤러 > calendarLeft.do 요청 들어옴.]■■");
//
//		return "/schedule/calendarjs";
//	}
//################################################################################
	
	
	
	/*
	servlet-context.xml에서 생성한 빈을 자동으로 주입받아
	Mybatis를 사용할 준비를 한다.
	 */
	@Autowired
	private SqlSession sqlSession;
	//세터위의 @Autowired를 붙혀도 사용가능.
	//콘솔상의 로그를 확인을 위함이면 세터를 사용한다~해도안해도상관없다.
	/*
	 * public void setSqlSession(SqlSession sqlSession) { this.sqlSession =
	 * sqlSession; System.out.println("마이바티스컨트롤실행됨"); }
	 */
	
	
	//달력리스트...
//	@RequestMapping("/schedule/ajaxCalendar.do")
//	@ResponseBody
//	public String ajaxCalendar(Model model, HttpServletRequest request) 
//	{
//		
//		//파라미터 저장을 위한 DTO객체 생성.
//		CalendarDTO calendarDTO = new CalendarDTO();
//		calendarDTO.setCalYear(request.getParameter("calYear"));
//		calendarDTO.setCalMon(request.getParameter("claMon"));
//		calendarDTO.setHmonth(request.getParameter("hmonth"));
//		calendarDTO.setHyear(request.getParameter("hyear"));
//		//디버깅용
//		System.out.println("<해당월: "+calendarDTO.getCalMon()+">");
//		System.out.println("<해당년도: "+calendarDTO.getCalYear()+">");
//		System.out.println("<히든태그 월: "+calendarDTO.getHmonth()+">");
//		System.out.println("<히든태그 년도: "+calendarDTO.getHyear()+">");
//		
//
//		
//		
//		
//		
//		System.out.println("■■ [Schedule컨트롤러 > ajaxCalendar.do 요청 들어옴.]■■");
//
//		return "/schedule/ajaxCalendar";
//	}
	
	

	
	
	
	
//#################################################################################
	
	//일정>알림>공지읽음 클릭시 이동.
	@RequestMapping("/schedule/alertNoticeRead.do")
	public String alertNoticeReadGo() {
		
		System.out.println("■■ [Schedule컨트롤러 > alertNoticeRead.do 요청 들어옴.]■■");

		return "/schedule/alertNoticeRead";
	}
	
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
