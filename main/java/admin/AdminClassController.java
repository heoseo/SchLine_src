package admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import command.UserListCommand;
import schline.util.JdbcTemplateConst;



@Controller
public class AdminClassController {
	
	private JdbcTemplate template;

	@Autowired
	public void setTemplate(JdbcTemplate template) {
		this.template = template;
		
		System.out.println("@Autowired => JdbcTemplate 연결성공");
		
		// JdbxTEmplate을 해당 프로그램 전체에서 사용하기 위한 설정
		JdbcTemplateConst.template = this.template;
	}
	
	
	AdminCommandImpl command = null;
	// 사용자 리스트 가졍괴

	@RequestMapping("/board/list.do")
	public String list(Model model, HttpServletRequest req) {
		
		/*
		- 사용자로부터 받은 모든 요청은 request내장객체에 저장되고, 
			이를 커맨드객체로 전달하기 위해 model에 저장한 후 매개변수로 전달한다.		 */
		model.addAttribute("req", req);
		command = new UserListCommand();
		command.execute(model);
		
		return "admin/userList";
	}
//	@RequestMapping("/requestMapping/index.do")
//	public String rmIndx() {
//		
//		
//		return "02RequestMapping/index";
//	}
//	
//	/* 	단순히 요청명만 매핑하는 경우에는 value, method를 생략할 수 있으나
//		전송방식까지 명시해야할 경우에는 속성을 제거하면 에러가 발생한다.	 */
//	@RequestMapping(value="/requestMapping/getSearch.do",
//					method=RequestMethod.GET)
//	public String getSearch(HttpServletRequest req, Model model) {
//		System.out.println("RequestMethod.GET방식으로 폼값전송");
//		
//		// request객체를 통해 폼값받기
//		String sColumn = req.getParameter("searchColumn");
//		String sWord = req.getParameter("searchWord");
//		
//		// model객체에 저장하기
//		model.addAttribute("sColumn", sColumn);
//		model.addAttribute("sWord", sWord);
//		
//		// View호출
//		return "02RequestMapping/getSearch";
//	}
//	
//	
//	
//	/*	* ModelAndView객체
//	 		 : View로 전송할 데이터의 저장과 View를 호출하는 2가지 기능을 동시에 처리할 수 있는 클래스
//	 		  - View설정 : 참조변수.setViewName("뷰의경로 및 파일명")
//	 		  - model객체에 데이터 저장 : 참조변수.addObject("속성명", "속성값")
//	 		 : 최종적으로 뷰를 호출할 때는 ModelAndView 참조변수를 return한다.	 */
//	 
//	@RequestMapping(method=RequestMethod.POST, value="/requestMapping/postLogin.do")
//	public ModelAndView postLogin(
//									@RequestParam("user_id") String id,
//									@RequestParam("user_pw") String pw) {
//		ModelAndView mv = new ModelAndView();
//		
//		mv.setViewName("02RequestMapping/postLogin");
//		mv.addObject("id", id);
//		mv.addObject("pw", pw);
//		
//		/* ModelAndView객체를 반환하여 뷰를 호출한다.
//		 * 해당 메소드의 반환타입도 해당객체타입으로 지정한다. */
//		return mv;
//	}
//	
//	@RequestMapping("/requestMapping/modelAttribute")
//	public String studentInfo(
//				@ModelAttribute("s1") StudentDTO studentDTO) {
//		
//		return "02RequestMapping/modelAttribute";
//	}
}
