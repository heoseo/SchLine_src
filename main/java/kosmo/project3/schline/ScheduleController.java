package kosmo.project3.schline;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
		System.out.println("■[Schedule컨트롤러 > alertList.do 요청 들어옴.]■");
		
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("세션저장아이디체크>>>>>>>>>>>>>>>>>>>>: " + user_id); 
		
		String type = req.getParameter("type");
		System.out.println("타입뭐들어왓니: " + type); 

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
		int pageSize = 5;
		int blockPage = 5;
		
		//전체페이지수 계산.
		int totalPage =
			(int)Math.ceil((double)totalRecordCount/pageSize);
		
		//현재페이지 번호 가져오기. 삼항연산자사용.
		int nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		
		//select할 게시물의 구간을 계산.
		int start = (nowPage-1) * pageSize + 1;
		int end = nowPage * pageSize;

		//전부리스트게시물뿌리기.
		ArrayList<NoticeDTO> alertList =
				sqlSession.getMapper(ScheduleDAOImpl.class)
				.allBoard(user_id, start, end);
		
		
		
		//페이지번호 처리.
		String pagingImg =
			PagingUtil.pagingAjax(
				totalRecordCount,
				pageSize, blockPage, nowPage,
				req.getContextPath()
					+"/schedule/alertList.do?type="+type+"&nowPage="+nowPage);
		
		
		//페이지반환.
		String view = "";
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("List", alertList);	
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("type", type);
		
		//view = "/schedule/alertList";
		/////////////////////////////////////////////////////////

		//셀렉트체인지마다 페이지반환하여이동.
		ArrayList<NoticeDTO> List = null;
		switch(type) {
			case "allBoard":
				List = sqlSession.getMapper(ScheduleDAOImpl.class)
						.allBoard(user_id, start, end);
				
				totalRecordCount =
						sqlSession.getMapper(ScheduleDAOImpl.class)
							.getTotalCountAll(user_id);
						
				//페이지 처리를 위한 설정값.
				pageSize = 5;
				blockPage = 5;
				
				//전체페이지수 계산.
				totalPage =
					(int)Math.ceil((double)totalRecordCount/pageSize);
				
				//현재페이지 번호 가져오기. 삼항연산자사용.
				nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
				
				//select할 게시물의 구간을 계산.
				start = (nowPage-1) * pageSize + 1;
				end = nowPage * pageSize;
				
				//페이지번호 처리.
				pagingImg =
					PagingUtil.pagingAjax(
						totalRecordCount,
						pageSize, blockPage, nowPage,
						req.getContextPath()
							+"/schedule/alertList.do?type="+type+"&nowPage="+nowPage);
				
				
				model.addAttribute("pagingImg", pagingImg);
				model.addAttribute("List", List);	
				model.addAttribute("nowPage", nowPage);
				model.addAttribute("type", type);
					
				view = "/schedule/alertList";
	
				break;
			case "allNoti":
				List =	sqlSession.getMapper(ScheduleDAOImpl.class)
						.allNoti(user_id, start, end);
				
				totalRecordCount =
						sqlSession.getMapper(ScheduleDAOImpl.class)
							.getTotalCountAllNoti(user_id);
						
				//페이지 처리를 위한 설정값.
				pageSize = 5;
				blockPage = 5;
				
				//전체페이지수 계산.
				totalPage =
					(int)Math.ceil((double)totalRecordCount/pageSize);
				
				//현재페이지 번호 가져오기. 삼항연산자사용.
				nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
				
				//select할 게시물의 구간을 계산.
				start = (nowPage-1) * pageSize + 1;
				end = nowPage * pageSize;
				
				//페이지번호 처리.
				pagingImg =
					PagingUtil.pagingAjax(
						totalRecordCount,
						pageSize, blockPage, nowPage,
						req.getContextPath()
							+"/schedule/alertList.do?type="+type+"&nowPage="+nowPage);
				
				model.addAttribute("pagingImg", pagingImg);
				model.addAttribute("List", List);	
				model.addAttribute("nowPage", nowPage);
				model.addAttribute("type", type);
				
				view = "/schedule/allNoti";
					
				break;
			case "taskAndExam":
				List = sqlSession.getMapper(ScheduleDAOImpl.class)
						.taskAndExam(user_id, start, end);
				
				totalRecordCount =
						sqlSession.getMapper(ScheduleDAOImpl.class)
							.getTotalCountExam(user_id);
						
					//페이지 처리를 위한 설정값.
					pageSize = 5;
					blockPage = 5;
					
					//전체페이지수 계산.
					totalPage =
						(int)Math.ceil((double)totalRecordCount/pageSize);
					
					//현재페이지 번호 가져오기. 삼항연산자사용.
					nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
					
					//select할 게시물의 구간을 계산.
					start = (nowPage-1) * pageSize + 1;
					end = nowPage * pageSize;
					
					//페이지번호 처리.
					pagingImg =
						PagingUtil.pagingAjax(
							totalRecordCount,
							pageSize, blockPage, nowPage,
							req.getContextPath()
								+"/schedule/alertList.do?type="+type+"&nowPage="+nowPage);
					
					model.addAttribute("pagingImg", pagingImg);
					model.addAttribute("List", List);	
					model.addAttribute("nowPage", nowPage);
					model.addAttribute("type", type);
					
					view = "/schedule/taskAndExam";
				
				break;
			case "notiRead":
				List = sqlSession.getMapper(ScheduleDAOImpl.class)
						.notiRead(user_id, start, end);
				
				totalRecordCount =
						sqlSession.getMapper(ScheduleDAOImpl.class)
							.getTotalCountRead(user_id);
						
				//페이지 처리를 위한 설정값.
				pageSize = 5;
				blockPage = 5;
				
				//전체페이지수 계산.
				totalPage =
					(int)Math.ceil((double)totalRecordCount/pageSize);
				
				//현재페이지 번호 가져오기. 삼항연산자사용.
				nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
				
				//select할 게시물의 구간을 계산.
				start = (nowPage-1) * pageSize + 1;
				end = nowPage * pageSize;
				
				//페이지번호 처리.
				pagingImg =
					PagingUtil.pagingAjax(
						totalRecordCount,
						pageSize, blockPage, nowPage,
						req.getContextPath()
							+"/schedule/alertList.do?type="+type+"&nowPage="+nowPage);
				
				model.addAttribute("pagingImg", pagingImg);
				model.addAttribute("List", List);	
				model.addAttribute("nowPage", nowPage);
				model.addAttribute("type", type);
				
				view = "/schedule/notiRead";
				
				break;
			case "notiNotRead":
				List = sqlSession.getMapper(ScheduleDAOImpl.class)
					.notiNotRead(user_id, start, end);
				
				totalRecordCount =
						sqlSession.getMapper(ScheduleDAOImpl.class)
							.getTotalCountNotRead(user_id);
						
				//페이지 처리를 위한 설정값.
				pageSize = 5;
				blockPage = 5;
				
				//전체페이지수 계산.
				totalPage =
					(int)Math.ceil((double)totalRecordCount/pageSize);
				
				//현재페이지 번호 가져오기. 삼항연산자사용.
				nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
				
				//select할 게시물의 구간을 계산.
				start = (nowPage-1) * pageSize + 1;
				end = nowPage * pageSize;
				
				//페이지번호 처리.
				pagingImg =
					PagingUtil.pagingAjax(
						totalRecordCount,
						pageSize, blockPage, nowPage,
						req.getContextPath()
							+"/schedule/alertList.do?type="+type+"&nowPage="+nowPage);
				
				model.addAttribute("pagingImg", pagingImg);
				model.addAttribute("List", List);	
				model.addAttribute("nowPage", nowPage);
				model.addAttribute("type", type);

				view = "/schedule/notiNotRead";
				
				break;
		}
				
		//디버깅용
		//System.out.println("일정 컨트롤러에서> 전체게시물에서>  start : " + start + ", end : " + end);
		//System.out.println("allLists : >>>>>>>>>>>>" + alertList);
		return view;
	}
	
	
	//일정>알림 이동.
//	@RequestMapping("/schedule/ListView.do")
//	public String ajaxNoticeRead(Model model, HttpServletRequest req, HttpSession session) 
//	{
//		System.out.println("■[Schedule컨트롤러 > ListView.do 요청 들어옴.]■");
//		String user_id = (String) session.getAttribute("user_id");
//		//System.out.println("세션저장아이디체크>>>: " + user_id); 
//		
//		String type = req.getParameter("type"); 
//		//System.out.println("일정 컨트롤러에서 셀렉트의 type이 뭐가 넘어왓니이1?!? :>>>>" + type);
//		
//		model.addAttribute("pagingImg", pagingImg);
//		model.addAttribute("nowPage", nowPage);
//		model.addAttribute("ajaxAlertList", ajaxAlertList);
//		
//
//
//		return "/schedule/ajaxAlertList";
//	}
	
	
	//일정>알림>게시물제목클릭시.상세보기.
	@RequestMapping("/schedule/viewPop.do")
	public String viewList(Model model, HttpServletRequest req, HttpSession session) {
		
		System.out.println("■[Schedule컨트롤러 > viewPop.do 요청 들어옴.]■");
		
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("세션저장아이디체크>>>>>>>>>>>>>>>>>>>>: " + user_id); 
		
		String IDX = req.getParameter("IDX");
		String noti_or_exam = req.getParameter("noti_or_exam");
		
		System.out.println("IDX > " + IDX);
		System.out.println("noti_or_exam > " + noti_or_exam);
		//String query = "SELECT * FROM board WHERE num=?";

		String view = "";
		ArrayList<NoticeDTO> viewList = null;
		switch(noti_or_exam) {
		
		case "noti":
			viewList = sqlSession.getMapper(ScheduleDAOImpl.class)
					.noti(IDX);
			sqlSession.getMapper(ScheduleDAOImpl.class)
					.checkNoti(user_id, IDX);
			
			view = "/schedule/viewNoti";
			break;
		case "exam":
			viewList = sqlSession.getMapper(ScheduleDAOImpl.class)
				.exam(IDX);
			sqlSession.getMapper(ScheduleDAOImpl.class)
					.checkExam(user_id, IDX);
			
			view = "/schedule/viewExam";
			break;
		}
		
		System.out.println("viewList : >>" + viewList);
		model.addAttribute("viewList", viewList);
		
		System.out.println("■ [Schedule컨트롤러 > viewPop.do 요청 들어옴.]■");
		
		return view;
	}
	//공지게시물 파일 다운로드.
//	@RequestMapping("/schedule/download.do")
//	public ModelAndView download(HttpServletRequest req, HttpServletResponse resp) throws Exception
//	{
//	
//		System.out.println("■ [Schedule컨트롤러 > download.do 요청 들어옴.]■");
//		
//		//저장된 파일명.
//		String fileName = req.getParameter("fileName");
//		//원본파일명.
//		String oriFileName = req.getParameter("oriFileName");
//		//물리적경로.
//		String saveDirectory = req.getSession().getServletContext()
//			.getRealPath("resources/upload");
//		//경로와 파일명을 통해 File객체 생성.
//		File downloadFile = 
//			new File(saveDirectory+"/"+fileName);
//		//해당 경로에 파일이 있는지 확인.
//		if(!downloadFile.canRead()) {
//			throw new Exception("파일을 찾을수 없습니다.");
//		}
//		ModelAndView mv = new ModelAndView();
//		mv.setViewName("fileDownloadView");//다운로드 할 View명.
//		mv.addObject("downloadFile", downloadFile);//저장된파일명.
//		mv.addObject("oriFileName", oriFileName);//원본파일명.
//		
//		return mv;	
//	}

	
//#################################################################	
	

	

}
