package android;

import java.io.UnsupportedEncodingException;
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
	public String appConnection(Model model, HttpServletRequest req, HttpSession session) throws UnsupportedEncodingException 
	{
   
		System.out.println("■[Schedule컨트롤러 > schedule.do 요청 들어옴.]■");
		
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("세션저장아이디체크>>>>>>>>>>>>>>>>>>>>: " + user_id); 
		
		String type = "allBoard";
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

}
