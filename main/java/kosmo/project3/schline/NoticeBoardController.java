package kosmo.project3.schline;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import Util.PagingUtil;
import professor.NoticeBoardDTO;
import professor.NoticeboardDAOImpl;


@Controller
public class NoticeBoardController {

	//servlet-context.xml에서 생성한 빈을 자동으로 주입받아 Mybatis를 사용할 준비를 한다.
	@Autowired
	private SqlSession sqlSession;
	//세터위의 @Autowired를 붙혀도 사용가능.
	//콘솔상의 로그를 확인을 위함이면 세터를 사용한다~해도안해도상관없다.
    public void setSqlSession(SqlSession sqlSession) { 
    	this.sqlSession = sqlSession; 
    	System.out.println("교수용공지사항컨트롤실행됨"); 
    }

    
	//게시판>공지사항시 이동.
	@RequestMapping("/professor/notiBoardList.do")
	public String notiBoardList(Model model, HttpServletRequest req, HttpSession session) 
	{
		System.out.println("■[NoticeBoard컨트롤러 > notiBoardList.do 요청 들어옴.]■");
		
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("세션저장아이디체크>>>>>: " + user_id); 
	
		
/////////게시물의 갯수를 카운트.//////////////////////////////////////////////
		/*
		서비스객체 역할을 하는 인터페이스에 정의된 추상메소드를 호출하면
		최종적으로 Mapper의 동일한 id속성값을 가진 엘리먼트의 
		쿼리문이 실행되어 결과를 반환받게 된다.
		 */
		int totalRecordCount =
			sqlSession.getMapper(NoticeboardDAOImpl.class)
				.boardCount(user_id);
		
		System.out.println("totalRecordCount  >   "+ totalRecordCount);
			
		//페이지 처리를 위한 설정값.
		int pageSize = 5;
		int blockPage = 5;
		
		//전체페이지수 계산.
		int totalPage =
			(int)Math.ceil((double)totalRecordCount/pageSize);
		
//		int check = Integer.parseInt(req.getParameter("nowPage")); 
//		System.out.println("check>>>>>>>>"+check);
		
		//현재페이지 번호 가져오기. 삼항연산자사용.
		int nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		
		//select할 게시물의 구간을 계산.
		int start = (nowPage-1) * pageSize + 1;
		int end = nowPage * pageSize;
		
		//Mapper 호출.
		ArrayList<NoticeBoardDTO> notiList =
			sqlSession.getMapper(NoticeboardDAOImpl.class)
				.getNoticeBoard(user_id, start, end);
		
		//페이지번호 처리.-----------해야됨 쿼리.........이상함.
		String pagingImg =
			PagingUtil.pagingImg(
				totalRecordCount,
				pageSize, blockPage, nowPage,
				req.getContextPath()
					+"/professor/notiBoardList.do?");
		
		//디버깅용
		//System.out.println("공지사항게시판컨트롤러> 전체게시물에서>  start : " + start + ", end : " + end);
		//System.out.println("notiList : >>>>" + notiList);

		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("notiList", notiList);	
		model.addAttribute("nowPage", nowPage);	
		
		return "/professor/notiBoardList";
	}
	///professor/notiWrite
	
	//리스트에서 글쓰기 눌러 글쓰기페이지로 이동.
	@RequestMapping("/professor/notiWrite")
	public String ajaxNoticeRead(Model model, HttpServletRequest req, HttpSession session) 
	{
		System.out.println("■[공지사항게시판컨트롤러 > notiWrite.do 요청 들어옴.]■");
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("세션저장아이디체크>>>: " + user_id); 
		
		String nowPage = req.getParameter("nowPage");
		System.out.println("페이지들어왔나요>>: " + nowPage); 
		
		//아이디로 선생님 정보 get
		ArrayList<NoticeBoardDTO> getProfessor =
			sqlSession.getMapper(NoticeboardDAOImpl.class)
				.getProfessor(user_id);
		//select * from user_tb where user_id = '202101000';
		String addProfessor= getProfessor.get(0).getUser_name();
		
		
		model.addAttribute("user_id", user_id);
		model.addAttribute("addProfessor", addProfessor);
		model.addAttribute("nowPage", nowPage);

		return "/professor/notiWrite";
	}
	
	
	
	//글쓰기페이지에서 전송하기클릭할때입장.
	@RequestMapping("/professor/notiWriteAction.do")
	public String notiWriteAction(Model model, MultipartHttpServletRequest req, HttpSession session,  Principal principal) 
	{
		System.out.println("■[공지사항게시판컨트롤러 > notiWriteAction.do 요청 들어옴.]■");
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("세션저장아이디체크>>>: " + user_id); 
		
		String nowPage = req.getParameter("nowPage");
		System.out.println("페이지들어왔나요>>: " + nowPage); 
	
		
		//아이디로 선생님 정보 get
		//로그인한 샘의 정보 가져오기 (이름출력)
		ArrayList<NoticeBoardDTO> getProfessor =
				sqlSession.getMapper(NoticeboardDAOImpl.class)
					.getProfessor(user_id);
		//select * from user_tb where user_id = '202101000';
		String PorfessorName= getProfessor.get(0).getUser_name() + " 교수";
		
		System.out.println("PorfessorName>>>>"+ PorfessorName);		
		
		//파일경로 받아오기.
		String path =req.getSession().getServletContext()
				.getRealPath("/resources/uploadsFile");
		System.out.println(path);
		
		//파일 insert 결과를 확인하기 위한 수
		int fileUp = 0;
		
		Map returnObj = new HashMap();
		
		try {
			//업로드폼의 file속성의 필드를 가져온다..(2개)
			
			//파일명 반복을 위해 Iterator 선언
			Iterator itr = req.getFileNames();
			
			MultipartFile mfile = null;
			String fileName = "";
			
			//파일외에 폼값 받음.
			String board_title = req.getParameter("board_title"); //과제물작성제목
			String board_content = req.getParameter("board_content"); //과제물작성내용

			//폼값 출력 테스트
			System.out.printf("board_title=%s,board_content=%s", board_title, board_content);
			
			/*
			물리적경로를 기반으로 File객체를 생성한 후 지정된 디렉토리가
			있는지 확인한다. 만약 없다면 mkdirs()로 생성한다.
			 */
			File directory = new File(path);
			if(!directory.isDirectory()) {
				directory.mkdirs();
			}
			//여러파일인 경우 파일명변경에 추가할 숫자 설정
			int fileindex = 1;
			
			//업로드폼의 file필드 갯수만큼 반복
			while(itr.hasNext()) {
				//전송된 파일의 이름을 읽어온다.
				fileName = (String)itr.next();
				mfile = req.getFile(fileName);
				System.out.println("mfile="+mfile);
				//한글깨짐방지 처리후 전송된 파일명을 가져옴
				String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");
				//서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
				if("".equals(originalName)) {
					continue;
				}
				
				//파일명에서 확장자를 가져옴.
				String ext = originalName.substring(originalName.lastIndexOf("."));
				//확장자를 제외한 파일명.
				String userFileName = originalName.substring(0, originalName.lastIndexOf("."));
				
				//선생아이디+제출명 합치기
				String saveFileName = "("+PorfessorName+")"+userFileName+"("+fileindex+")" + ext;
				System.out.println("파일명 :>>>> "+saveFileName);
				
				//물리적 경로에 새롭게 생성된 파일명으로 파일저장
				File serverFullName = new File(path + File.separator + saveFileName);
				fileindex++;
				
				mfile.transferTo(serverFullName);

				//인설트 쿼리!!!!
				sqlSession.getMapper(NoticeboardDAOImpl.class)
				.insertBoard(user_id, board_title, board_content, saveFileName);
				
			}
		}
		catch(IOException e) {
			e.printStackTrace();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		//공지사항게시한 추가된 board_idx 을 받으려면 시퀀스로 받는데 넥스트발은 +1이니까 -1해야됨,
		ArrayList<NoticeBoardDTO> getSeqIdx =
				sqlSession.getMapper(NoticeboardDAOImpl.class)
				.getSeqIdx(user_id);
		//System.out.println("getSeqIdx쿼리후결과 > "+ getSeqIdx);
		
		int seqIDX = Integer.parseInt(getSeqIdx.get(0).getLast_number());
		seqIDX--;
		System.out.println("seqIDX쿼리후결과 > "+ seqIDX);
		
		//게시물의 subject_idx 구하기
		ArrayList<NoticeBoardDTO> getSubject =
				sqlSession.getMapper(NoticeboardDAOImpl.class)
				.getSubject(user_id);
		System.out.println("getStudent쿼리후결과 > "+ getSubject);
		
		int sub_idx = getSubject.get(0).getSubject_idx();
		System.out.println("sub_idx쿼리후결과 > "+ sub_idx);
		
		//subject_idx로 학생 15명 id 구하기!!!!
		ArrayList<NoticeBoardDTO> getStudent =
				sqlSession.getMapper(NoticeboardDAOImpl.class)
				.getStudent(sub_idx);
		System.out.println("getStudent쿼리후결과 > "+ getStudent);
		
		int seqidx = seqIDX;
		
		//user_id(학생), seqIDX 로 15개 인설트 쿼리!!!!
		
		for( int i =0; i<getStudent.size(); i++) {
			int student_id = Integer.parseInt(getStudent.get(i).getUser_id());
			int result = sqlSession.getMapper(NoticeboardDAOImpl.class)
			.notiCheck(seqIDX, student_id);
			System.out.println("뽀문학생아디만큼노티첵 >> "+ result);
		}
	
		System.out.println(fileUp);
		
		model.addAttribute("nowPage", nowPage);

		return "redirect:notiBoardList.do";
	}
	
	//교수용게시판공시사항 제목 클릭시 상세보기.
	@RequestMapping("/professor/notiView.do")
	public String viewList(Model model, HttpServletRequest req, HttpSession session) {
		
		System.out.println("■[노티보드컨트롤러 > notiView.do 요청 들어옴.]■");
		
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("세션저장아이디체크>>>>>>>>>>>>>>>>>>>>: " + user_id); 
		
		String board_idx = req.getParameter("board_idx");
		System.out.println("board_idx > " + board_idx);
		//현재페이지 번호 가져오기. 삼항연산자사용.
		int nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		System.out.println("페이지들어왔나요>>: " + nowPage); 
		//String query = "SELECT * FROM board WHERE num=?";

		//파람값으로 넘어온board_idx(게시물의번호) 받아서셀렉.
		ArrayList<NoticeBoardDTO> getNotiView =
		sqlSession.getMapper(NoticeboardDAOImpl.class)
			.getNotiView(board_idx);
	
		model.addAttribute("nowPage", nowPage);
		System.out.println("getNotiView : >>" + getNotiView);
		model.addAttribute("getNotiView", getNotiView);

		return "/professor/notiView";
	}
	
	//교수용게시판공지사항 상세보기에서 수정하기 클릭시 수정하기페이지이동.
	@RequestMapping("/professor/notiEdit.do")
	public String notiEdit(Model model, HttpServletRequest req, HttpSession session) {
		
		System.out.println("■[노티보드컨트롤러 > notiEdit.do 요청 들어옴.]■");
		
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("세션저장아이디체크>>>>>>>>>>>>>>>>>>>>: " + user_id); 
		
		String board_idx = req.getParameter("board_idx");
		System.out.println("board_idx > " + board_idx);
		//현재페이지 번호 가져오기. 삼항연산자사용.
		int nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		System.out.println("페이지들어왔나요>>: " + nowPage); 
		//String query = "SELECT * FROM board WHERE num=?";
		
		//파람값으로 넘어온board_idx(게시물의번호) 받아서셀렉.
		ArrayList<NoticeBoardDTO> getNotiView =
				sqlSession.getMapper(NoticeboardDAOImpl.class)
				.getNotiView(board_idx);
		
		model.addAttribute("nowPage", nowPage);
		System.out.println("getNotiView : >>" + getNotiView);
		model.addAttribute("getNotiView", getNotiView);
		
		return "/professor/notiEdit";
	}		
	
	//교수용게시판공지사항 수정하기에서 전송하기클릭시.
	@RequestMapping("/professor/notiEditAction.do")
	public String notiEditAction(Model model, MultipartHttpServletRequest req, HttpSession session,  Principal principal) {
		
		System.out.println("■[노티보드컨트롤러 > notiEditAction.do 요청 들어옴.]■");
		
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("세션저장아이디체크>>>>>>>>>>>>>>>>>>>>: " + user_id); 
		
		//select * from user_tb WHERE user_id='202101000';
		
		//파일경로 받아오기.
		String path =req.getSession().getServletContext()
				.getRealPath("/resources/uploadsFile");
		System.out.println(path);
		
		//파일 insert 결과를 확인하기 위한 수
		int fileUp = 0;
		
		Map returnObj = new HashMap();
		
		try {
			//업로드폼의 file속성의 필드를 가져온다..(2개)
			
			//파일명 반복을 위해 Iterator 선언
			Iterator itr = req.getFileNames();
			
			MultipartFile mfile = null;
			String fileName = "";
			
			//파일외에 폼값 받음.
			String board_idx = req.getParameter("board_idx");
			System.out.println("board_idx > " + board_idx);
			//현재페이지 번호 가져오기. 삼항연산자사용.
			int nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
			System.out.println("페이지들어왔나요>>: " + nowPage); 
			//String query = "SELECT * FROM board WHERE num=?";
			String board_title = req.getParameter("board_title"); //과제물작성제목
			String board_content = req.getParameter("board_content"); //과제물작성내용

			//폼값 출력 테스트
			System.out.printf("board_title=%s,board_content=%s", board_title, board_content);
			
			/*
			물리적경로를 기반으로 File객체를 생성한 후 지정된 디렉토리가
			있는지 확인한다. 만약 없다면 mkdirs()로 생성한다.
			 */
			File directory = new File(path);
			if(!directory.isDirectory()) {
				directory.mkdirs();
			}
			//여러파일인 경우 파일명변경에 추가할 숫자 설정
			int fileindex = 1;
			
			//업로드폼의 file필드 갯수만큼 반복
			while(itr.hasNext()) {
				//전송된 파일의 이름을 읽어온다.
				fileName = (String)itr.next();
				mfile = req.getFile(fileName);
				System.out.println("mfile="+mfile);
				//한글깨짐방지 처리후 전송된 파일명을 가져옴
				String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");
				//서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
				if("".equals(originalName)) {
					continue;
				}
				
				//파일명에서 확장자를 가져옴.
				String ext = originalName.substring(originalName.lastIndexOf("."));
				//확장자를 제외한 파일명.
				String userFileName = originalName.substring(0, originalName.lastIndexOf("."));
				
				//선생아이디+제출명 합치기
				String saveFileName = "("+user_id+")"+userFileName+"("+fileindex+")" + ext;
				System.out.println("파일명 :>>>> "+saveFileName);
				
				//물리적 경로에 새롭게 생성된 파일명으로 파일저장
				File serverFullName = new File(path + File.separator + saveFileName);
				fileindex++;
				
				mfile.transferTo(serverFullName);
				
				//파람값으로 넘어온board_idx(게시물의번호) 게시물 수정!업데이트문!
				sqlSession.getMapper(NoticeboardDAOImpl.class)
				.notiEditAction(board_title, board_content, saveFileName, board_idx);

				
				model.addAttribute("nowPage", nowPage);
				
			}
		}
		catch(IOException e) {
			e.printStackTrace();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
				
		return "redirect:notiBoardList.do";
	}		
	
	//교수용게시판공시사항 상세보기에서 삭제버튼클릭시 삭제.
	@RequestMapping("/professor/notiDelete.do")
	public String notiDelete(Model model, HttpServletRequest req, HttpSession session) {
		
		System.out.println("■[노티보드컨트롤러 > notiDelete.do 요청 들어옴.]■");
		
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("세션저장아이디체크>>>>>>>>>>>>>>>>>>>>: " + user_id); 
		
		String board_idx = req.getParameter("board_idx");
		System.out.println("board_idx > " + board_idx);
		//현재페이지 번호 가져오기. 삼항연산자사용.
		int nowPage = req.getParameter("nowPage")==null ? 1 : Integer.parseInt(req.getParameter("nowPage"));
		System.out.println("페이지들어왔나요>>: " + nowPage); 
		
		//파람값으로 넘어온board_idx(게시물의번호) 받아서삭제.
		sqlSession.getMapper(NoticeboardDAOImpl.class)
		.deleteCheck(board_idx);
		//파람값으로 넘어온board_idx(게시물의번호) 받아서삭제.
		sqlSession.getMapper(NoticeboardDAOImpl.class)
		.deleteNotiBoard(board_idx);
		

		model.addAttribute("nowPage", nowPage);

		
		return "redirect:notiBoardList.do";
	}		
			
	//다운로드처리.	
	@RequestMapping("/professor/download.do")
	public void teamDownload (HttpServletRequest req, HttpServletResponse resp) {
		
		String path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile");
		System.out.println("서버경로확인:"+path);
		String file_name = req.getParameter("board_file");
		System.out.println("다운로드파일 리퀘스트확인:"+file_name);
		
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
			
			
			
}
