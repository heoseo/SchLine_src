package kosmo.project3.schline;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import schline.AttendanceDTO;
import schline.ClassDTOImpl;
import schline.ExamBoardDTO;
import schline.ExamDTO;
import schline.SchlineDAOImpl;
import schline.UserVO;

@Controller
public class ProfessorExamController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/professor/pexamlist.do")
	public String pexamlist(Model model, HttpServletRequest req, Principal principal) {
		
		String user_id = principal.getName();
		System.out.println(user_id);
		
		//아이디로 문제 리스트 가져오기(교수)
		ArrayList<ExamDTO> pexamlist = sqlSession.getMapper(SchlineDAOImpl.class)
				.pexamlist(user_id);
		
		ArrayList<ExamDTO> pinexamList = sqlSession.getMapper(SchlineDAOImpl.class)
				.pinexamList(user_id);
		
		if(req.getParameter("exam_idx")!=null) {
			model.addAttribute("exam_idx", req.getParameter("exam_idx"));
		}
		
		//시험타입(2)
		String exam_type = "2";
		ArrayList<ExamDTO> questionlist = null;
		for(ExamDTO dto : pinexamList) {
			
			String temp = dto.getQuestion_content().replace("\r\n", "<br/>");
			dto.setQuestion_content(temp);
			
			//문제의 유형이 객관식이라면...
			if(dto.getQuestion_type()==1) {
				//매퍼에 설정된 쿼리를 통해 문항을 가져온다.
				questionlist = 
						sqlSession.getMapper(SchlineDAOImpl.class).pquestionlist(user_id);
				for(ExamDTO listdto : questionlist) {
					//System.out.println(listdto.getQuestionlist_content());
					//문항 줄바꿈처리
					temp = listdto.getQuestionlist_content().replace("\r\n", "<br/>");
					listdto.setQuestionlist_content(temp);
				}
			}
		}
		model.addAttribute("exam_type", exam_type);
		model.addAttribute("questionlist", questionlist);
		model.addAttribute("pinexamList", pinexamList);
		model.addAttribute("pexamlist", pexamlist);
		
		return "/professor/exam/pexamlist";
	}
	
	@RequestMapping("/professor/pexamwrite.do")
	public String pexamwrite(Model model, HttpServletRequest req, Principal principal) {
		
		String user_id = principal.getName();

		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id).toString();
		System.out.println(subject_idx);
		String exam_idx = req.getParameter("exam_idx");
		System.out.println(exam_idx);
		String exam_content = req.getParameter("exam_content");
		
		String getdata = req.getParameter("exam_date");
	    SimpleDateFormat date12Format = new SimpleDateFormat("MM/dd/yyyy hh:mm a", Locale.US);
	    SimpleDateFormat date24Format = new SimpleDateFormat("MM/dd/yyyy HH:mm");
	    String exam_date = "";
	    try {
	    	exam_date = date24Format.format(date12Format.parse(getdata)).toString();
		}
	    catch (ParseException e) {
			e.printStackTrace();
		}
		
	    System.out.println("입력할날자포맷:"+exam_date);
		int exam_scoring = Integer.parseInt(req.getParameter("exam_scoring"));
		System.out.printf("시험이름:%s, 마감일:%s, 총배점:%s, 과목:%s", exam_content, exam_date, exam_scoring, subject_idx);
		int result = sqlSession.getMapper(SchlineDAOImpl.class)
				.insertExam(subject_idx, exam_content, exam_date, exam_scoring, exam_idx);
		System.out.println("시험일련번호:"+exam_idx);
//		if(result!=0) {
//		
//			String exam_idx = sqlSession.getMapper(SchlineDAOImpl.class).getExam_idx(subject_idx);
//			//insertCheckList 메소드 호출하여 학생 체크리스트 insert
//			insertCheckList(subject_idx, exam_idx);
//			
//			
//			model.addAttribute("exam_idx", exam_idx);
//		}
//		else {
//			System.out.println("뭔가 실패");
//		}
		model.addAttribute("exam_idx", exam_idx);
		
		return "/professor/exam/pexamwrite";
	}
	
	@RequestMapping("/professor/examWriteAction.do")
	@ResponseBody
	public Map<String, Object> examwriteaction(Model model, HttpServletRequest req, Principal principal){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String question_content = req.getParameter("question_content");
		String exam_idx = req.getParameter("exam_idx");
		String question_type = req.getParameter("question_type");
		String question_score = req.getParameter("score");
		String answer = req.getParameter("answer");
		System.out.printf("exam_idx: %s, question_type: %s, answer: %s, question_score: %s, question_content: %s"
				,exam_idx, question_type, answer, question_score, question_content);
		int result = sqlSession.getMapper(SchlineDAOImpl.class)
				.insertQuestion(exam_idx, question_type, answer, question_score, question_content);
		
		//question_idx받아온 후 반영해야함..해당 문항을 인덱스에 맞게 insert해야할것
		if(question_type.equals("1")) {
			
			String question_idx = sqlSession.getMapper(SchlineDAOImpl.class).getQuestion_idx();
			System.out.println("객관식문제인덱스 : "+question_idx);
			
			String[] questionlist = req.getParameterValues("questionlist_content");
			for(String list : questionlist) {
				int num=1;
				int listresult = sqlSession.getMapper(SchlineDAOImpl.class)
						.insertQuestionList(question_idx, list, num);
				System.out.println(list+" "+num+" "+listresult);
				num++;
			}
		}

		if(result==1) {
			map.put("result", result);
		}
		else {
			map.put("result", 0);
		}
		return map;
	}
	
	@RequestMapping("/professor/ptaskList.do")
	public String ptaskList(Model model, HttpServletRequest req, Principal principal) {
		
		String user_id = principal.getName();

		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id);
		String exam_type = "1";
		
		ArrayList<ExamDTO> pexamlist = sqlSession.getMapper(SchlineDAOImpl.class)
					.ptasklist(exam_type, subject_idx);
		
		for(ExamDTO dto : pexamlist) {
			
			String temp = dto.getExam_content().replace("\r\n", "<br/>");
			dto.setQuestion_content(temp);
		}
		model.addAttribute("exam_type", exam_type);
		model.addAttribute("pexamlist", pexamlist);
		
		return "/professor/exam/pexamlist";
	}
	
	@RequestMapping("/professor/ptaskWriteAction.do")
	public String ptaskWriteAction(Model model, HttpServletRequest req, Principal principal){
		
		String user_id = principal.getName();
		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id); 
		String exam_name = req.getParameter("exam_name");
		
		String getdata = req.getParameter("exam_date");
	    SimpleDateFormat date12Format = new SimpleDateFormat("MM/dd/yyyy hh:mm a", Locale.US);
	    SimpleDateFormat date24Format = new SimpleDateFormat("MM/dd/yyyy HH:mm");
	    String exam_date = "";
	    try {
	    	exam_date = date24Format.format(date12Format.parse(getdata)).toString();
		}
	    catch (ParseException e) {
			e.printStackTrace();
		}
		
		String exam_content = req.getParameter("exam_content");
		String exam_scoring = req.getParameter("exam_scoring");
		System.out.printf("user_id: %s, subject_idx: %s, exam_name: %s, exam_date: %s, exam_content: %s, score:%s"
				,user_id, subject_idx, exam_name, exam_date, exam_content, exam_scoring);

		int result = sqlSession.getMapper(SchlineDAOImpl.class)
				.insertTask(subject_idx, exam_name, exam_date, exam_content, exam_scoring);
		
		System.out.println("과제작성결과:"+result);
		
		if(result==1) {
			String exam_idx = sqlSession.getMapper(SchlineDAOImpl.class).getExam_idx(subject_idx);
			//insertCheckList 메소드 호출하여 학생 체크리스트 insert
			insertCheckList(subject_idx, exam_idx);
			System.out.println("과제등록 성공");
//			model.addAttribute("msg", "과제를 작성했습니다.");
//			model.addAttribute("url", "/schline/professor/ptaskList.do");
		}
		else {
			System.out.println("과제등록 실패");
//			model.addAttribute("msg", "작성에 실패했습니다.");
//			model.addAttribute("url", "/schline/professor/ptaskList.do");
	}
		
		return "redirect:/professor/ptaskList.do";
	}
	
	@RequestMapping("/professor/ptaskDelete.do")
	public String ptaskDelete(Model model, HttpServletRequest req, Principal principal) {
		
		String user_id = principal.getName();
		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id);
		String exam_type = req.getParameter("exam_type");
		System.out.println("시험타입:"+exam_type);
		int result = 0;
		
		if(exam_type.equals("1")) {
			
			String exam_idx = req.getParameter("exam_idx");
			System.out.println("삭제하려는과제인덱스:"+exam_idx);
			sqlSession.getMapper(SchlineDAOImpl.class)
					.deleteExamBoard(exam_idx);
			sqlSession.getMapper(SchlineDAOImpl.class)
					.deleteCheckList(exam_idx);
			result = sqlSession.getMapper(SchlineDAOImpl.class)
					.deleteTask(exam_idx, subject_idx);
			
			System.out.println(result);
			
			if(result==1) {
				System.out.println("과제 삭제성공");
				return "redirect:/professor/ptaskList.do";
			}
			else {
				System.out.println("시험 삭제실패");
				return "redirect:/professor/ptaskList.do";
			}
		}
		else {
			System.out.println("이곳은 시험삭제입니다...");
			String question_idx = req.getParameter("question_idx");
			String question_type = sqlSession.getMapper(SchlineDAOImpl.class)
					.getQuestionType(question_idx);
			System.out.println("문제타입:"+question_type);
			if(question_type.equals("1")) {
				sqlSession.getMapper(SchlineDAOImpl.class)
					.deleteQuestionlist(question_idx);
				result = sqlSession.getMapper(SchlineDAOImpl.class)
					.deleteQuestion(question_idx);
			}
			else if(question_type.equals("3")){
				sqlSession.getMapper(SchlineDAOImpl.class)
					.deleteQuestionAnswer(question_idx);
				result = sqlSession.getMapper(SchlineDAOImpl.class)
					.deleteQuestion(question_idx);
			}
			else {
				result = sqlSession.getMapper(SchlineDAOImpl.class)
						.deleteQuestion(question_idx);
			}

			if(result==1) {
				System.out.println("시험 삭제성공");
				return "redirect:/professor/pexamlist.do";
			}
			else {
				System.out.println("시험 삭제실패");
				return "redirect:/professor/pexamlist.do";
			}
			
		}
		
	}
	
	@RequestMapping("/professor/ptaskEdit.do")
	public String ptaskEdit(Model model, HttpServletRequest req, Principal principal) {
		
		String exam_idx = req.getParameter("exam_idx");
		String user_id = principal.getName();
		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id);
		
		ExamDTO dto = sqlSession.getMapper(SchlineDAOImpl.class)
				.getExam(subject_idx, exam_idx);
		
		model.addAttribute("dto", dto);
		
		return "/professor/exam/ptaskEdit";
	}
	
	@RequestMapping(value="/professor/ptaskEditAction.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ptaskEditAction(Model model, HttpServletRequest req, Principal principal) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String user_id = principal.getName();
		String exam_idx = req.getParameter("exam_idx");
		String exam_name = req.getParameter("exam_name");
		String exam_date = req.getParameter("exam_date");
		String exam_content = req.getParameter("exam_content");
		String exam_scoring = req.getParameter("exam_scoring");
		System.out.printf("user_id: %s, exam_name: %s, exam_date: %s, exam_content: %s, score:%s"
				,user_id, exam_name, exam_date, exam_content, exam_scoring);

		int result = sqlSession.getMapper(SchlineDAOImpl.class)
				.updateTask(exam_name, exam_date, exam_content, exam_scoring, exam_idx);
		System.out.println("과제수정결과:"+result);
		
		
		if(result==1) {
			map.put("result", result);
		}
		else {
			map.put("result", 0);
		}
		return map;
	}
	
	////////////////////////////관리 선택///////////////////////////////////////
	@RequestMapping("/professor/select.do")
	public String pselect(Model model, HttpServletRequest req, Principal principal) {
		
		//유저아이디
		String user_id = principal.getName();
		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id);
		System.out.println("과목 인덱스 : "+subject_idx);
		
		ArrayList<UserVO> userlist =
				sqlSession.getMapper(SchlineDAOImpl.class).getuserNames(subject_idx);
		
		model.addAttribute("userlist", userlist);
		
		return "/professor/team/pselect";
	}
	
	@RequestMapping("/professor/teamChange.do")
	@ResponseBody
	public Map<String, Object> teamChange(HttpServletRequest req, Principal principal) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		//유저아이디
		String user_id = principal.getName();
		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id);
		System.out.println("과목 인덱스 : "+subject_idx);
		//학생아이디
		String stu_id="";
		//팀번호
		String team_num="";
		
		stu_id = req.getParameter("id");			
		team_num = req.getParameter("team_num");
		System.out.println(stu_id+' '+team_num);
		//팀배정하기
		if(req.getParameter("id")!=null&&req.getParameter("team_num")!=null) {
			int result = sqlSession.getMapper(SchlineDAOImpl.class)
					.changeTeam(stu_id, team_num, subject_idx);
			map.put("result", result);
			System.out.println("수정결과:"+result); 
		}
		else {
			System.out.println("수정실패");
			map.put("result", 0);
		}

		
		return map;
	}
	////////////////////////////과제 관리///////////////////////////////////////
	////////////////////////////협업쪽 관리///////////////////////////////////////
	@RequestMapping("/professor/teamList.do")
	public String teamList(Model model, HttpServletRequest req, Principal principal) {
		
		//유저아이디
		String user_id = principal.getName();
		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id);
		System.out.println("과목 인덱스 : "+subject_idx);
		String team_num = req.getParameter("team_num");
		System.out.println("팀번호:"+team_num);
		UserVO uvo;
		
		//게시물의 갯수를 카운트...
		int totalRecordCount = sqlSession.getMapper(SchlineDAOImpl.class).getTotalCount(subject_idx, team_num);
		System.out.println("totalRecordCOunt="+totalRecordCount);
		
		//페이지 처리를 위한 설정값
		int pageSize = 2;
		int blockPage = 2;
		//전체 페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
		int nowPage = req.getParameter("nowPage")==null ? 1 : 
			Integer.parseInt(req.getParameter("nowPage"));
		//select할 게시물의 구간을 계산
		int start = (nowPage-1)*pageSize + 1;
		int end = nowPage * pageSize;
		
		ArrayList<ExamBoardDTO> teamlist = 
				sqlSession.getMapper(SchlineDAOImpl.class).teamList(subject_idx, team_num, start, end);
		
		//가상번호 계산하여 부여하기
		int virtualNum = 0;
		int countNum = 0;
		
		//리스트 반복..
		for(ExamBoardDTO dto : teamlist) {
			
			virtualNum = totalRecordCount -(((nowPage-1)*pageSize) + countNum++);
			dto.setVirtualNum(virtualNum);
			uvo = sqlSession.getMapper(SchlineDAOImpl.class).getuserName(dto.getUser_id());

			dto.setUser_name(uvo.getUser_name());
			//줄바꿈처리
			String temp = dto.getBoard_content().replace("\r\n", "<br/>");
			dto.setBoard_content(temp);
		}
		
		String pagingImg =
				pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
					req.getContextPath()+"/professor/teamList.do?subject_idx="+subject_idx+"&team_num="+team_num+"&");
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("teamlist", teamlist);
		model.addAttribute("team_num", team_num);
		
		return "/professor/team/pteamlist";
	}
	
	@RequestMapping("/professor/teamView.do")
	public String teamTaskView(Model model, HttpServletRequest req) {
		
		String board_idx = req.getParameter("board_idx");
		String team_num = req.getParameter("team_num");
		ExamBoardDTO dto = sqlSession.getMapper(SchlineDAOImpl.class).getView(board_idx);
		UserVO uvo = sqlSession.getMapper(SchlineDAOImpl.class).getuserName(dto.getUser_id());

		String user_name = uvo.getUser_name();

		dto.setBoard_content(dto.getBoard_content().replaceAll("\r\n", "<br/>"));
		
		model.addAttribute("user_id", dto.getUser_id());
		model.addAttribute("user_name", user_name);
		model.addAttribute("board_idx", board_idx);
		model.addAttribute("subject_idx", dto.getSubject_idx());
		model.addAttribute("board_title", dto.getBoard_title());
		model.addAttribute("board_content", dto.getBoard_content());
		model.addAttribute("board_postdate", dto.getBoard_postdate());
		model.addAttribute("team_num", dto.getTeam_num());
		if(dto.getBoard_file()!=null) {
			model.addAttribute("board_file", dto.getBoard_file());
		}
		
		model.addAttribute("team_num",team_num);
		return "/professor/team/pteamView";
	}
	
	@RequestMapping("/professor/teamDownload.do")
	public void teamDownload (HttpServletRequest req, HttpServletResponse resp) {
		
		String path = "";
		if(req.getParameter("downParam")!=null&&req.getParameter("downParam").equals("task")) {
			path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile/task");
		}
		else {
			path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile/team");			
		}
		
		String file_name = req.getParameter("board_file");
		
		//다운로드 메소드 호출
		download(req, resp, path, file_name);
	}
	
	@RequestMapping("/professor/teamWrite.do")
	public String teamWrite(Model model, HttpServletRequest req, Principal principal) {
		
		//유저아이디
		String user_id = principal.getName();
		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id);
		//모델에 저장할 맵
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		//유저이름 얻어오기
		UserVO uvo = sqlSession.getMapper(SchlineDAOImpl.class).getuserName(user_id);
		String user_name = uvo.getUser_name(); 
		
		//맵에 담기
		paramMap.put("user_name", user_name);
		
		//맵을 모델에 저장
		model.addAttribute("paramMap", paramMap);
		
		return "/professor/team/pteamWrite";
	}
	
	@RequestMapping(value="/professor/teamWriteAction.do", method=RequestMethod.POST)
	public String teamWriteAction(Model model, MultipartHttpServletRequest req, Principal principal) {
		
		//경로 받아오기
		String user_id = principal.getName();
		String path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile/team");
		System.out.println(path);
		 
		//과목idx
		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id);
		String team_num = req.getParameter("team_num");
		System.out.println(subject_idx);
		//과제idx
		String exam_idx = "";
		Map returnObj = new HashMap();
		int fileUp = 0;
		try {
			//업로드폼의 file속성의 필드를 가져온다..(2개)
			
			//파일명 반복을 위해 Iterator 선언
			Iterator itr = req.getFileNames();
			
			MultipartFile mfile = null;
			String fileName = "";
//			List resultList = new ArrayList();
			
			//파일외에 폼값 받음.			
			String board_title = req.getParameter("board_title"); //과제물작성제목
			String board_content = req.getParameter("board_content"); //과제물작성내용
			
			//폼값 출력 테스트
			System.out.printf("subject_idx=%s,user_id=%s,"
					+ "board_title=%s,board_content=%s,team_num=%s"
					, subject_idx, user_id, board_title, board_content, team_num);
			System.out.println();
			/*
			물리적경로를 기반으로 File객체를 생성한 후 지정된 디렉토리가
			있는지 확인한다. 만약 없다면 mkdirs()로 생성한다.
			 */
			File directory = new File(path);
			if(!directory.isDirectory()) {
				directory.mkdirs();
			}
			//업로드폼의 file필드 갯수만큼 반복
			while(itr.hasNext()) {
				//전송된 파일의 이름을 읽어온다.
				fileName = (String)itr.next();
				mfile = req.getFile(fileName);
				System.out.println("mfile="+mfile);
				//한글깨짐방지 처리후 전송된 파일명을 가져옴
				String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");
				String saveFileName = null;
				if("".equals(originalName)) {
					saveFileName = "";
				}
				else {
					//파일명에서 확장자를 가져옴.
					String ext = originalName.substring(originalName.lastIndexOf("."));
					//확장자를 제외한 파일명(학생이 제출한 파일명)
					String userFileName = originalName.substring(0, originalName.lastIndexOf("."));
					
					//과제이름+학번+제출명으로 합치기(팀명으로 변경필요)
					saveFileName = "(team"+team_num+")"+userFileName + ext;
					System.out.println("파일명 : "+saveFileName);
					
					//물리적 경로에 새롭게 생성된 파일명으로 파일저장
					File serverFullName = new File(path + File.separator + saveFileName);
					
					mfile.transferTo(serverFullName);
				}
				//DB에 insert하기...
				fileUp = sqlSession.getMapper(SchlineDAOImpl.class)
						.teamWrite(subject_idx, user_id, board_title, board_content, saveFileName, team_num);
			}
		}
		catch(IOException e) {
			e.printStackTrace();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		returnObj.put("subject_idx", subject_idx);
		returnObj.put("exam_idx", exam_idx);
//		returnObj.put("taskalert", fileUp);
		String returnStr ="";
		if(fileUp!=0) {
			returnObj.put("taskResult", 1);
			returnStr = "redirect:/professor/teamList.do?subject_idx="+subject_idx+"&team_num="+team_num;
		}
		else {
			returnObj.put("taskResult", 0);
			returnStr = "redirect:/professor/teamList.do?subject_idx="+subject_idx+"&team_num="+team_num;
		}
//		model.addAttribute("subject_idx", subject_idx);
//		model.addAttribute("exam_idx", exam_idx);
//		model.addAttribute("taskalert", fileUp);
		System.out.println(fileUp);
		//모델객체에 리스트 컬렉션을 저장한 후 뷰로 전달
		//model.addAttribute("returnObj", returnObj);

//		return "redirect:/class/taskList.do";
		return returnStr;
	}
	
	
	@RequestMapping("/professor/teamDelete.do")
	public String teamDelete(Model model, HttpServletRequest req, Principal principal) {
		
		String user_id = principal.getName(); //아이디
		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id);
		String board_idx = req.getParameter("board_idx");
		String board_file = req.getParameter("board_file");
		String team_num = req.getParameter("team_num");
		System.out.println(user_id+" "+subject_idx+" "+board_idx);
		int result = sqlSession.getMapper(SchlineDAOImpl.class).teamDelete(board_idx, user_id);
		System.out.println("결과값:"+result);
		if(!req.getParameter("board_file").equals("")) {
			String path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile/team");
			
			deleteFile(path, board_file);
		}
		
		if(result==1) {
			model.addAttribute("msg", "삭제되었습니다.");
			model.addAttribute("url", "teamList.do?subject_idx="+subject_idx+"&team_num="+team_num);

		}
		else {
			model.addAttribute("msg", "삭제에 실패했습니다.");
			model.addAttribute("url", "teamList.do?subject_idx="+subject_idx+"&team_num="+team_num);
		}
		
		return "/professor/exam/alert";
	}
	
	
	@RequestMapping("/professor/pteamEdit.do")
	public String teamEdit(Model model, HttpServletRequest req, Principal principal) {
		
		//게시물번호
		String board_idx = req.getParameter("board_idx");
		
		//게시물가져오기
		ExamBoardDTO dto = sqlSession.getMapper(SchlineDAOImpl.class).getView(board_idx);
		
		//게시물 작성한 회원정보
		UserVO uvo = sqlSession.getMapper(SchlineDAOImpl.class).getuserName(dto.getUser_id());
		//회원이름
		String user_name = uvo.getUser_name();

		System.out.println(dto.getBoard_title()+" | "+dto.getBoard_content());
		
		//수정폼에 출력할 정보들 모델에 저장
		model.addAttribute("user_name", user_name);
		model.addAttribute("board_idx", board_idx);
		model.addAttribute("subject_idx", dto.getSubject_idx());
		model.addAttribute("board_title", dto.getBoard_title());
		model.addAttribute("board_content", dto.getBoard_content());
		model.addAttribute("board_postdate", dto.getBoard_postdate());
		if(dto.getBoard_file()!=null) {
			model.addAttribute("board_file", dto.getBoard_file());
		}
	
		return "/professor/team/pteamEdit";
	}
	
	
	@RequestMapping(value="/professor/teamEditAction.do", method=RequestMethod.POST)
	public String teamEditAction(Model model, MultipartHttpServletRequest req, Principal principal) {
		
		//경로 받아오기
		String path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile/team");
		System.out.println(path);
		String team_num = req.getParameter("team_num");
		System.out.println("수정용 팀번호:"+team_num);
		//과목idx
		String board_idx = req.getParameter("board_idx");
		System.out.println("게시물idx:"+board_idx);
		ExamBoardDTO dto = sqlSession.getMapper(SchlineDAOImpl.class).getView(board_idx);
		
		String board_file = dto.getBoard_file();
		System.out.println("db파일명:"+board_file+" 과목인덱스:"+dto.getSubject_idx());
		int subject_idx = dto.getSubject_idx();

		int fileUp = 0;
		try {
			
			String user_id = principal.getName(); //아이디
			String board_title = req.getParameter("board_title"); //제목
			String board_content = req.getParameter("board_content"); //내용
				
			MultipartFile mfile = req.getFile("file1");
			System.out.println("mfile="+mfile);
			
			//한글깨짐방지 처리후 전송된 파일명을 가져옴
			String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");
			
			if(!originalName.equals("")) {
				System.out.println("파일수정");
				//폼값 출력 테스트
				System.out.printf("user_id=%s, board_title=%s,"
						+ "board_content=%s, board_file=%s, new_file=%s"
						, user_id, board_title, board_content, board_file, originalName);
				
				String saveFileName = null;
				//파일명에서 확장자를 가져옴.
				String ext = originalName.substring(originalName.lastIndexOf("."));
				//확장자를 제외한 파일명(학생이 제출한 파일명)
				String userFileName = originalName.substring(0, originalName.lastIndexOf("."));
				
				//과제이름+학번+제출명으로 합치기(팀명으로 변경필요)
				saveFileName = "(team"+team_num+")"+userFileName + ext;
				System.out.println("파일명 : "+saveFileName);
				
				//물리적 경로에 새롭게 생성된 파일명으로 파일저장
				File serverFullName = new File(path + File.separator + saveFileName);
				
				mfile.transferTo(serverFullName);
				
				//DB에 update하기...
				fileUp = sqlSession.getMapper(SchlineDAOImpl.class)
						.teamFileEdit(board_idx, board_title, board_content, saveFileName);
				
				//기존파일 삭제처리
				deleteFile(path, board_file);
					
			}
			else {
				System.out.println("수정파일없음");
				fileUp = sqlSession.getMapper(SchlineDAOImpl.class)
						.teamEdit(board_idx, board_title, board_content);
			}
		}
		catch(IOException e) {
			e.printStackTrace();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		String returnStr ="";
		if(fileUp!=0) {
			returnStr = "redirect:/professor/teamList.do?subject_idx="+subject_idx+"&team_num="+team_num;
		}
		else {
			returnStr = "redirect:/professor/teamList.do?subject_idx="+subject_idx+"&team_num="+team_num;
		}
		System.out.println(fileUp);
		
		return returnStr;
	}
	
	//주관식답 확인
	@RequestMapping("/professor/answerCheck.do")
	public String answerCheck(Model model, HttpServletRequest req, Principal principal) {
		
		
		
		return "/professor/exam/panswerCheck";
	}
	
	//과제물확인
	@RequestMapping("/professor/taskCheck.do")
	public String taskCheck(Model model, HttpServletRequest req, Principal principal) {
		
		//유저아이디
		String user_id = principal.getName();
		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id);
		System.out.println("과목 인덱스 : "+subject_idx);
		UserVO uvo;
		
		//게시물의 갯수를 카운트...
		int totalRecordCount = sqlSession.getMapper(SchlineDAOImpl.class).getTotalTask(subject_idx);
		System.out.println("totalRecordCOunt="+totalRecordCount);
		System.out.println(totalRecordCount);
		//페이지 처리를 위한 설정값
		int pageSize = 5;
		int blockPage = 5;
		//전체 페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//현재페이지에 대한 파라미터 처리 및 시작/끝의 rownum구하기
		int nowPage = req.getParameter("nowPage")==null ? 1 : 
			Integer.parseInt(req.getParameter("nowPage"));
		//select할 게시물의 구간을 계산
		int start = (nowPage-1)*pageSize + 1;
		int end = nowPage * pageSize;
		
		ArrayList<ExamBoardDTO> teamlist = 
				sqlSession.getMapper(SchlineDAOImpl.class).taskCheckList(subject_idx, start, end);
		
		//가상번호 계산하여 부여하기
		int virtualNum = 0;
		int countNum = 0;
		
		//리스트 반복..
		for(ExamBoardDTO dto : teamlist) {
			
			virtualNum = totalRecordCount -(((nowPage-1)*pageSize) + countNum++);
			dto.setVirtualNum(virtualNum);
			uvo = sqlSession.getMapper(SchlineDAOImpl.class).getuserName(dto.getUser_id());

			dto.setUser_name(uvo.getUser_name());
			//줄바꿈처리
			String temp = dto.getBoard_content().replace("\r\n", "<br/>");
			dto.setBoard_content(temp);
		}
		
		String pagingImg =
				pagingImg(totalRecordCount, pageSize, blockPage, nowPage,
					req.getContextPath()+"/professor/taskCheck.do?subject_idx="+subject_idx+"&");
		
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("teamlist", teamlist);
		
		return "/professor/exam/ptaskCheck";
	}
	
	
	@RequestMapping("/professor/examCheck.do")
	public String examCheck(Model model, HttpServletRequest req, Principal principal) {
		
		//유저아이디
		String user_id = principal.getName();
		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id);
		System.out.println("과목 인덱스 : "+subject_idx);
		String stu_id="";
		UserVO uvo;
		//학생아이디
		if(req.getParameter("id")!=null) {
			stu_id = req.getParameter("id");			
		}

		ArrayList<ExamDTO> teamlist = 
				sqlSession.getMapper(SchlineDAOImpl.class).examCheckList(subject_idx, stu_id);
		ArrayList<UserVO> userlist =
				sqlSession.getMapper(SchlineDAOImpl.class).getuserNames(subject_idx);
		//리스트 반복..
		for(ExamDTO dto : teamlist) {
		
			uvo = sqlSession.getMapper(SchlineDAOImpl.class).getuserName(dto.getUser_id());

			dto.setUser_name(uvo.getUser_name());
			//줄바꿈처리
			String temp = dto.getQuestionanswer_content().replace("\r\n", "<br/>");
			dto.setQuestionanswer_content(temp);
			
			temp = dto.getQuestion_content().replace("\r\n", "<br/>");
			dto.setQuestion_content(temp);
		}
		
		model.addAttribute("userlist", userlist);
		model.addAttribute("teamlist", teamlist);
		
		return "/professor/exam/pexamCheck";
	}
	
	
	
	
	
	
	
	
	
	//파일삭제 메소드
	public static void deleteFile(String directory, String filename) {
		 
		System.out.println(directory+"   "+filename);
		//경로 + 파일명
		File f = new File(directory+File.separator+filename);
		//파일이 존재한다면 삭제
		if(f.exists()) {f.delete();}
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
	
	
	@RequestMapping("/professor/examScoring.do")
	public String examScoring(Model model, HttpServletRequest req, Principal principal) {
		
		//교수아이디로
		String pro_id = principal.getName();
		//과목을 얻어온 후
		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(pro_id);
		System.out.println("주관식용과목인덱스:"+subject_idx);
		//학생 아이디 얻어옴
		String user_id = req.getParameter("user_id");
		//배점 얻어옴
		String question_score = req.getParameter("question_score");
		//문제의 인덱스
		String exam_idx = req.getParameter("exam_idx");
		System.out.println(user_id+" "+question_score+" "+exam_idx);
	
		//점수반영을 위한 인덱스 추출 및 점수 증가
//		ArrayList<Integer> examidxs = sqlSession.getMapper(SchlineDAOImpl.class).getExamidx(subject_idx, "2");
//		String exam_idx_score = examidxs.get(0).toString();
//		System.out.println("주관식용 인덱스:"+exam_idx_score);
		sqlSession.getMapper(SchlineDAOImpl.class).gradeUp(question_score, user_id, exam_idx);
		System.out.println("점수반영 성공");

		return "redirect:examCheck.do?id="+user_id;
	}
	
	@RequestMapping("/professor/taskScoring.do")
	public String taskScoring(Model model, HttpServletRequest req, Principal principal) {
		
		//교수아이디로
		String pro_id = principal.getName();
		//과목을 얻어온 후
		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(pro_id);
		String exam_type = "1";
		String user_id = req.getParameter("user_id");
		String grade_exam = req.getParameter("score");
		String exam_idx = req.getParameter("exam_idx");
		System.out.println("과제idx:"+exam_idx);
		ArrayList<Integer> score_exam_idx = sqlSession.getMapper(SchlineDAOImpl.class)
				.getExamidx(subject_idx, exam_type);
		String examidxStr = score_exam_idx.get(0).toString();
		System.out.println("반영할 idx는?:"+examidxStr);
		
		sqlSession.getMapper(SchlineDAOImpl.class).gradeUp(grade_exam, user_id, examidxStr);
		
		return "redirect:taskCheck.do";
	}
	
	//////기타 유틸 등....////////////
	
	//해당 과목을 수강중인 학생들의 id를 기준으로 examcheck테이블에 데이터생성(insert)
	public void insertCheckList(String subject_idx, String exam_idx) {
		
		ExamDTO examDTO = new ExamDTO();
		int idx = Integer.parseInt(exam_idx);
		examDTO.setExam_idx(idx);
		String[] students = sqlSession.getMapper(ClassDTOImpl.class)
				.StuList(subject_idx);
		for(String str : students) {
			examDTO.setUser_id(str);
			sqlSession.getMapper(SchlineDAOImpl.class)
				.insertCheckList(examDTO);
		}
	}
	
	public static String pagingImg(int totalRecordCount, int pageSize, 
			int blockPage, int nowPage,	String page) {
		
		String pagingStr = "";
		
		//1.전체페이지 구하기
		int totalPage = 
		(int)(Math.ceil(((double)totalRecordCount/pageSize)));
		
		/*2.현재페이지번호를 통해 이전 페이지블럭에
		해당하는 페이지를 구한다.
		*/
		int intTemp = 
			(((nowPage-1) / blockPage) * blockPage) + 1;
		
		//3.처음페이지 바로가기 & 이전페이지블럭 바로가기
		if(intTemp != 1) {
			//첫번째 페이지 블럭에서는 출력되지 않음
			//두번째 페이지 블럭부터 출력됨.
			pagingStr += "<li class='page-item'>"
				+ "<a class='page-link' href='"+page+"nowPage=1'>"
				+ "<<</a></li>";
			pagingStr += "<li class='page-item'>"
				+ "<a class='page-link' href='"+page+"nowPage="+(intTemp-blockPage)+"'>"
				+ "<</a></li>";
		}
		
		//페이지표시 제어를 위한 변수
		int blockCount = 1;
		/*
		4.페이지를 뿌려주는 로직 : blockPage의 수만큼 또는
			마지막페이지가 될때까지 페이지를 출력한다.
		*/
		while(blockCount<=blockPage && intTemp<=totalPage)
		{
			if(intTemp==nowPage) {
				pagingStr += 
						"<li class='page-item'>"
						+ "<a class='page-link'>"+intTemp+"</a></li>";
			}
			else {
				pagingStr += "<li class='page-item'>"
						+ "<a class='page-link' href='"+page
					+"nowPage="+intTemp+"'>"+
					intTemp+"</a></li>";
			}
			intTemp++;
			blockCount++;
		}
		
		//5.다음페이지블럭 & 마지막페이지 바로가기
		if(intTemp <= totalPage) {
			pagingStr += "<li class='page-item'>"
				+ "<a class='page-link' href='"+page+"nowPage="+intTemp+"'>"
				+ "></a></li>";
			pagingStr += "<li class='page-item'>"
				+ "<a class='page-link' href='"+page+"nowPage="+totalPage+"'>"
				+ ">></a></li>";
		}		
		return pagingStr;
	}
}
