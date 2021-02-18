package android;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ScheduleAppController {
	
	//servlet-context.xml에서 생성한 빈을 자동으로 주입받아 Mybatis를 사용할 준비를 한다.
	@Autowired
	private SqlSession sqlSession;
	//세터위의 @Autowired를 붙혀도 사용가능.
	//콘솔상의 로그를 확인을 위함이면 세터를 사용한다~해도안해도상관없다.
    public void setSqlSession(SqlSession sqlSession) { 
    	this.sqlSession = sqlSession; 
    	System.out.println("★스케쥴App컨트롤실행됨"); 
    }
    
    
	//핸드폰에서 하단 일정클릭시 페이지 전달. 아이디값도 받아야함.
	@RequestMapping("/android/schedule.do")
	public String appConnection(Model model, HttpServletRequest req, HttpSession session) 
	{
    
		String user_id = (String) session.getAttribute("user_id"); 
		//아니면 리퀘스트인듯..ㅎ제이슨!
		System.out.println("세션저장아이디체크>>>>>>>>>>>>>>>>>>>>: " + user_id);
		
		
		
		
		return user_id; 
	}
	
	

}
