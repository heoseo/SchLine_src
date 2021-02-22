package kosmo.project3.schline;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import schedule.ScheduleDAOImpl;
import schline.ExamDTO;

@Controller
public class CalendarController {

	//servlet-context.xml에서 생성한 빈을 자동으로 주입받아 Mybatis를 사용할 준비를 한다.
	@Autowired
	private SqlSession sqlSession;
	//세터위의 @Autowired를 붙혀도 사용가능.
	//콘솔상의 로그를 확인을 위함이면 세터를 사용한다~해도안해도상관없다.
    public void setSqlSession(SqlSession sqlSession) { 
    	this.sqlSession = sqlSession; 
    	System.out.println("달력컨트롤 실행됨"); 
    }
	
	//상단고정바 일정>드롭다운 캘린더 클릭시 이동.
	@RequestMapping("/schedule/calendarTop.do")
	public String calendarTop() {
		
		System.out.println("■ [Calendar컨트롤러 > calendarTop.do 요청 들어옴.]■");

		return "/schedule/calendar";
	}
	
	//일정>알림>왼쪽바 캘린더 클릭시 이동.
	@RequestMapping("/schedule/calendar.do")
	public String calendarLeft() {
		
		System.out.println("■ [Calendar컨트롤러 > calendarLeft.do 요청 들어옴.]■");

		return "/schedule/calendar";
	}
	//캘린더 에이젝스.
	@RequestMapping("/schedule/ajaxCalendar.do")
	public String ajaxCalendar(Model model, HttpServletRequest req, HttpSession session) {
		
		System.out.println("■[Calendar컨트롤러 > ajaxCalendar.do 요청 들어옴.]■");
		
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("세션저장아이디체크>>>>>: " + user_id); 
		
		//파라미터 저장을 위한 DTO객체 생성.
		String year = req.getParameter("year").toString();
		int month = Integer.parseInt(req.getParameter("month"));
		String monthStr = "";
		
		if(month < 10)
			monthStr = "0"+ Integer.toString(month);
		else
			monthStr = Integer.toString(month);
		
		String YearAndMonth = year +  monthStr;
		//디버깅용
		//System.out.println("ScheduleController > YearAndMonth : " + YearAndMonth);
		
		//Mybatis로 한것..
		ArrayList<ExamDTO> lists =
			sqlSession.getMapper(ScheduleDAOImpl.class)
				.calendarList(user_id, YearAndMonth);
		
		model.addAttribute("lists", lists);
	
		
		System.out.println("■ [Calendar컨트롤러 > ajaxCalendar.do 요청 들어옴.]■");

		return "/schedule/ajaxCalendar";
	}
	
}
