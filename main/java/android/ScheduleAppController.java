package android;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import Util.PagingUtil;
import schedule.NoticeDTO;
import schedule.ScheduleDAOImpl;
import schline.ExamDTO;

@Controller
public class ScheduleAppController {
	
	//servlet-context.xml에서 생성한 빈을 자동으로 주입받아 Mybatis를 사용할 준비를 한다.
	@Autowired
	private SqlSession sqlSession;
	
	//세터위의 @Autowired를 붙혀도 사용가능.
	//콘솔상의 로그를 확인을 위함이면 세터를 사용한다~해도안해도상관없다.
    public void setSqlSession(SqlSession sqlSession) { 
    	this.sqlSession = sqlSession; 
    	System.out.println("★안드로이드스케쥴 컨트롤실행됨"); 
    }
    
	String user_id = null;
	String type = null;

    
	//핸드폰에서 하단 일정클릭시 페이지 전달. 아이디값도 받아야함.
	@RequestMapping("/android/alertList.do")
	public String appConnection(Model model, HttpServletRequest req, HttpSession session) throws UnsupportedEncodingException 
	{
   
		System.out.println("■[안드로이드컨트롤러 > appConnection.do 요청 들어옴.]■");

		if(user_id == null) {
			user_id = req.getParameter("user_id");
			session.setAttribute("user_id", user_id);
		}
		if(user_id == null) {
			user_id = (String) session.getAttribute("user_id");
		}
		//String user_id_test = (String) session.getAttribute("user_id");
		//System.out.println("안드에서들어온 세션아이디값: " + user_id_test); 
		//System.out.println("안드에서들어온 리퀘스트아이디값: " + user_id); 
		

		
		String type = req.getParameter("type");
		if(type == null) {
			type = "allBoardApp";
		}
				 
		System.out.println("alertListApp타입: " + type); 

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
		model.addAttribute("user_id", user_id);
		System.out.println("스케줄안드로이드>> 페이지바뀌기전 아이디값: " + user_id); 
		
		//view = "/schedule/alertList";
		/////////////////////////////////////////////////////////

		//셀렉트체인지마다 페이지반환하여이동.
		ArrayList<NoticeDTO> List = null;
		switch(type) {
			case "allBoardApp":
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
				model.addAttribute("user_id", user_id);
				System.out.println("스케줄안드로이드>> allBoard 페이지바뀌기전 아이디값: " + user_id); 
					
				view = "/schedule/alertListApp";
	
				break;
			case "allNotiApp":
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
				model.addAttribute("user_id", user_id);
				System.out.println("스케줄안드로이드>> allNoti 페이지바뀌기전 아이디값: " + user_id); 

				
				view = "/schedule/allNotiApp";
					
				break;
			case "taskAndExamApp":
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
					model.addAttribute("user_id", user_id);
					
					System.out.println("스케줄안드로이드>> taskAndExam 페이지진입 아이디값: " + user_id); 

					
					
					view = "/schedule/taskAndExamApp";
				
				break;
			case "notiReadApp":
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
				model.addAttribute("user_id", user_id);
				System.out.println("스케줄안드로이드>> notiRead 페이지바뀌기전 아이디값: " + user_id); 

				
				view = "/schedule/notiReadApp";
				
				break;
			case "notiNotReadApp":
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
				model.addAttribute("user_id", user_id);
				System.out.println("스케줄안드로이드>> notiNotRead 페이지진입전 아이디값: " + user_id); 


				view = "/schedule/notiNotReadApp";
				
				break;
		}
		
		
				
		//디버깅용
		//System.out.println("일정 컨트롤러에서> 전체게시물에서>  start : " + start + ", end : " + end);
		//System.out.println("allLists : >>>>>>>>>>>>" + alertList);
		return view;
	}
	
	
	//일정>알림>게시물제목클릭시.상세보기.
	@RequestMapping("/android/viewPop.do")
	public String viewList(Model model, HttpServletRequest req, HttpSession session) {
		
		System.out.println("■ [SchedulApp컨트롤러 > viewPop.do 요청 들어옴.]■");
		
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("안드로이드상세보기세션저장아이디>>>: " + user_id); 
		
		
		if(user_id == null) {
			user_id = req.getParameter("user_id");
			session.setAttribute("user_id", user_id);
			System.out.println("상세보기>리퀘스트저장아이디>>>: " + user_id); 
		}
		
		if(user_id == null) {
			user_id = (String) session.getAttribute("user_id");
		}
	
		
		
		String nowPage = req.getParameter("nowPage");
		
		String IDX = req.getParameter("IDX");
		String subject_idx = req.getParameter("subject_idx");
		String noti_or_exam = req.getParameter("noti_or_exam");
		
		System.out.println("IDX > " + IDX);
		System.out.println("안드상세보기 컨트롤>> subject_idx >> " + subject_idx);
		System.out.println("noti_or_exam > " + noti_or_exam);

		String view = "";
		ArrayList<NoticeDTO> viewList = null;
		switch(noti_or_exam) {
		
		case "noti":
			viewList = sqlSession.getMapper(ScheduleDAOImpl.class)
					.noti(IDX);
			sqlSession.getMapper(ScheduleDAOImpl.class)
					.checkNoti(user_id, IDX);
			
			type = req.getParameter("type");
			if(type == null) {
				type = "allBoard";
			}
			System.out.println("상세보기>노티> 타입뭐들어왓낭: " + type); 
			
			model.addAttribute("user_id", user_id);
			model.addAttribute("board_idx", IDX);
			model.addAttribute("subject_idx", subject_idx);
			//System.out.println("과제상세보기 서브젝트idx잘나왔나요"+SUB_IDX);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("type", type);
			
			view = "/schedule/viewNotiApp";
			break;
			
		case "exam":
		

			viewList = sqlSession.getMapper(ScheduleDAOImpl.class)
				.exam(IDX);
			sqlSession.getMapper(ScheduleDAOImpl.class)
					.checkExam(user_id, IDX);
			
			type = req.getParameter("type");
			if(type == null) {
				type = "taskAndExam";
			}
			System.out.println("상세보기>이그잼>타입뭐들어왓낭: " + type); 
			
			model.addAttribute("user_id", user_id);
			model.addAttribute("exam_idx", IDX);
			model.addAttribute("subject_idx", subject_idx);
			//System.out.println("과제상세보기 서브젝트idx잘나왔나요"+SUB_IDX);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("type", type);
			
		
			view = "/schedule/viewExamApp";
			
			break;
		}
		
		System.out.println("viewList : >>" + viewList);
		model.addAttribute("viewList", viewList);

		
		return view;
	}
	
	
	
	
	
	
	
	
	
	
	
	//공지게시물 파일 다운로드.
	//다운로드처리.	
	@RequestMapping("/android/download.do")
	public void teamDownload (HttpServletRequest req, HttpServletResponse resp) {
		
		String path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile");
		System.out.println("서버경로확인:"+path);
		String file_name = req.getParameter("board_file");
		
		//다운로드 메소드 호출
		download(req, resp, path, file_name);
	}		
				
	//파일 다운로드 메소드
	public static void download(
			HttpServletRequest request,
			HttpServletResponse response,
			String directory, String fileName){
		/*
		파일다운로드 원리
		1.웹브라우저가 인식하지 못하는 컨텐츠타입을 응답헤더에 설정해주면
		웹브라우저는 자체 다운로드 창을 띄운다.
		
		2.서버에 저장된 파일을 출력스트림을 통해 웹브라우저에 출력한다.
		*/
		try{
			//파일이 저장된 물리적인 경로를 가져온다.
			//String saveDirectory = request.getServletContext().getRealPath(directory);
			
			//3.파일 크기를 얻기 위한 파일객체 생성
			// - 다운로드시 프로그래스바를 표시하기 위함.
			File f = new File(directory+File.separator+fileName);			
			long length = f.length();
			
			//다운로드를 위한 응답헤더 설정
			//4.다운로드창을 보여주기 위한 응답헤더 설정
			//4-1.웹브라우저가 인식하지 못하는 컨텐츠타입(MIME)을 설정
			response.setContentType("binary/octect-stream");
			//4-2.다운로드시 프로그래스바를 표시하기위한 컨텐츠길이 설정(Long타입 인식?)
			//response.setContentLengthLong(length);
			
			/*
			4-3. 응답헤더명 : Content-Disposition
				응답헤더명에 따른 값 : attachment;filename=파일명
				setHeader(응답헤더명,헤더값)으로 추가함
			브라우저 종류에 따라 한글파일명이 깨지는 경우가 있음으로
			브라우저별 인코딩 방식을 달리하는것임(파일명을 인코딩)
			*/
			boolean isIE = 
				request.getHeader("user-agent").toUpperCase().indexOf("MSIE")!=-1 ||
				request.getHeader("user-agent").toUpperCase().indexOf("11.0")!=-1;
			
			if(isIE){//인터넷 익스플로러
				fileName = URLEncoder.encode(fileName, "UTF-8");
			}
			else{//기타 웹브라우져
			/*
			new String(byte[] bytes, String charset)사용
			1) 파일명을 byte형 배열로 변환
			2) String클래스의 생성자에 
				변환한 배열과 charset는 8859_1을 지정함.
			*/
				fileName = new String(fileName.getBytes("UTF-8"),"8859_1");
			}
			
			response.setHeader("Content-Disposition", 
					"attachment;filename="+fileName);
			
			/*
			IO작업을 통해서 서버에 있는 파일을 웹브라우저에 바로 출력
			
			데이터소스 : 파일 - 노드스트림 : FileInputStream
								필터스트림 : BufferedInputStream
			데이터목적지 : 웹브라우저 - 노드스트림 : response.getOutputStream();
										필터스트림 : BufferedOutputStream
			*/
			//5.서버에 있는 파일에 연결할 입력스트림 생성
			BufferedInputStream bis 
				= new BufferedInputStream(
						new FileInputStream(f));
			//6.웹브라우저에 연결할 출력스트림 생성
			BufferedOutputStream bos 
				= new BufferedOutputStream(
						response.getOutputStream());
			//7.bis로 읽고 bos로 웹브라우저에 출력
			int data;
			while((data=bis.read()) != -1){
				bos.write(data);
				//bos.flush(); 
			}
			//8.스트림 닫기
			bis.close();
			bos.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}		
	}	
	
	
	//#################################캘린더##########################################
	//캘린더 에이젝스.
	//@RequestMapping("/android/ajaxCalendar.do")
	@RequestMapping("/android/examList.do")
	@ResponseBody
	public ArrayList<ExamDTO> ajaxCalendar(Model model, HttpServletRequest req, HttpSession session) {
		
		System.out.println("■[CalendarApp컨트롤러 > ajaxCalendar.do 요청 들어옴.]■");
				
		String user_id = req.getParameter("user_id");
		System.out.println("안드로이드 저장아이디체크>>>>>: " + user_id); 
		
		//파라미터 저장을 위한 DTO객체 생성.
		String year = req.getParameter("year").toString();
		int month = Integer.parseInt(req.getParameter("month"));
		String monthStr = "";
		
		if(month < 10)
			monthStr = "0"+ Integer.toString(month);
		else
			monthStr = Integer.toString(month);
		
		String YearAndMonth = year + monthStr;
		
		System.out.println("ScheduleController > YearAndMonth : " + YearAndMonth);
		
		//시험리스트 불러오기
		ArrayList<ExamDTO> lists =
			sqlSession.getMapper(ScheduleDAOImpl.class).calendarList(user_id, YearAndMonth);
		
		for(ExamDTO list : lists) {
			list.getExam_date();
		}
		
		return lists;
	}
}
