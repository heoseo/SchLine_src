package kosmo.project3.schline;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
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

import schline.ClassDTO;
import schline.ExamDTO;
import schline.SchlineDAOImpl;
import schline.UserVO;

@Controller
public class ExamController {
	
	@Autowired
	private SqlSession sqlSession;

	//시험시작, 또는 과제작성의 코드가 유사하여 통합...
	@RequestMapping("/class/examStart.do")
	public String examStart(Model model, HttpServletRequest req, Principal principal) {
		
		//과제정보를 가져오기 위한 파라미터 저장
		String exam_type = req.getParameter("exam_type");
		//선택했던 과목을 Get 파라미터로 받아옴
		String subject_idx = req.getParameter("subject_idx");
		//사용자 정보는 일단 더미를 임시로 가져옴..추후에 변경 필요
		String user_id = principal.getName();
		System.out.println(user_id);

		//과목을 받아왔으니.. 계정정보만 받아오면 될것 같군요
		Map<String, Object> map = new HashMap<String, Object>();
		
		String user_name, subject_name;
		//마감일...(사용하지 않을지도)
		java.sql.Date exam_date;
		String returnStr = "";
		
		//과목인덱스로 과목명 가져오기
		ClassDTO cdto = sqlSession.getMapper(SchlineDAOImpl.class)
				.getsubjectName(subject_idx);
		
		//유저아이디로 이름 가져오기
		UserVO uvo = sqlSession.getMapper(SchlineDAOImpl.class)
				.getuserName(user_id);
		
		user_name = uvo.getUser_name();
		subject_name = cdto.getSubject_name();
		map.put("user_id", user_id);
		map.put("user_name", user_name);
		map.put("subject_name", subject_name);
		
		//시험일때 경로(시험시작)(equals 대신 자꾸 ==을 쓰네요..)
		if(!exam_type.equals("1")) {
			
			returnStr = "/classRoom/exam/examStart";
		}
		//과제 작성일때 추가 쿼리문 실행..및 정보저장, 경로 설정
		else{
			System.out.println(exam_type+"   "+subject_idx+"   "+user_id);
			
			String exam_idx = req.getParameter("exam_idx");
			System.out.println("될까요?"+exam_idx);
			ExamDTO edto = sqlSession.getMapper(SchlineDAOImpl.class)
					.getExam(subject_idx, exam_idx);
			
			String temp = edto.getExam_content().replace("\r\n", "<br/>");
			edto.setExam_content(temp);
			
			map.put("exam_idx", edto.getExam_idx());
			map.put("subject_idx", edto.getSubject_idx());
			map.put("exam_name", edto.getExam_name());
			map.put("exam_postdate", edto.getExam_postdate());
			map.put("exam_date", edto.getExam_date());
			map.put("exam_type", edto.getExam_type());
			map.put("exam_content", edto.getExam_content());
			map.put("exam_scoring", edto.getExam_scoring());;
	
			returnStr = "/classRoom/exam/taskWrite";
		}
		
		model.addAttribute("map", map);
		
		return returnStr;
	}

	@RequestMapping("/class/examList.do")
	public String examList(Model model, HttpServletRequest req, Principal principal) {
		/*
		타입이 시험일때...
		*/
		String subject_idx = req.getParameter("subject_idx");
		System.out.println(subject_idx);
		String user_id = principal.getName();
		String exam_type = req.getParameter("exam_type");
		System.out.println(exam_type);
		
		//자바과목의 시험타입 idx들 가져오기..
		ArrayList<Integer> examidxs = sqlSession.getMapper(SchlineDAOImpl.class)
				.getExamidxs(subject_idx, exam_type);
		
		//플래그 자동입력 후 삭제요망
		ArrayList<Integer> examidx = sqlSession.getMapper(SchlineDAOImpl.class)
				.getExamidx(subject_idx, exam_type);
		
		//시험진행여부를 확인하는 플래그
		int check_flag = sqlSession.getMapper(SchlineDAOImpl.class).getCheck(examidx.get(0), user_id);
		//int check_flag = edto.getCheck_flag();
		System.out.println("플래그:"+check_flag);
		
		//시험을 진행하지 않았다면...
		if(check_flag!=1) {
			
			//시험idx 출력해서 확인..
			for(Integer i=0; i<examidxs.size(); i++) {
				System.out.println("시험idx:"+examidxs.get(i));
			}
			
			//시험idx를 맵에 담기
			Map<String, ArrayList<Integer>> map = new HashMap<String, ArrayList<Integer>>();
			map.put("examidxs", examidxs);
			
			//문제 인덱스를 담은 맵을 매퍼로 전달하여 쿼리문 실행(난이도별 추출)
			ArrayList<ExamDTO> examlist = 
					sqlSession.getMapper(SchlineDAOImpl.class).examlist(map);
			ClassDTO classdto = sqlSession.getMapper(SchlineDAOImpl.class)
					.getsubjectName(subject_idx);
			String subject_name = classdto.getSubject_name();
			
			//객관식 타입 문제의 문항을 가져오기 위한 리스트 선언
			ArrayList<ExamDTO> questionlist = null;
			String temp;
			//문제리스트 반복..
			for(ExamDTO dto : examlist) {
				
				//문제 줄바꿈처리
				temp = dto.getQuestion_content().replace("\r\n", "<br/>");
				dto.setQuestion_content(temp);
				
				//문제의 유형이 객관식이라면...
				if(dto.getQuestion_type()==1) {
					//매퍼에 설정된 쿼리를 통해 문항을 가져온다.
					questionlist = 
							sqlSession.getMapper(SchlineDAOImpl.class).questionlist();
					for(ExamDTO listdto : questionlist) {
						//System.out.println(listdto.getQuestionlist_content());
						//문항 줄바꿈처리
						temp = listdto.getQuestionlist_content().replace("\r\n", "<br/>");
						listdto.setQuestionlist_content(temp);
					}
				}
			}
			//뷰에서 사용하기 위해 모델 객체에 저장
			model.addAttribute("subject_name", subject_name);
			model.addAttribute("questionlist", questionlist);
			model.addAttribute("examlist", examlist);
			model.addAttribute("exam_type", exam_type);
			//뷰로 이동
			return "/classRoom/exam/examList";
		}
		else {
			model.addAttribute("msg", "이미 진행한 시험입니다.");
			model.addAttribute("url", "back");
			return "/classRoom/team/alert";
		}
		
	}

	
	@RequestMapping(value="/class/examComplete.do", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public Map<String, Object> examComplete(Model model, HttpServletRequest req, Principal principal) {

		/*
		과목 및 학생별로 판단하기 위해 파라미터처리가 필요..
		주관식인 경우 학생,문제,정답을 입력하는 테이블이 필요
		*/
		String user_id = principal.getName(); //추후 파라미터로 처리
		
		Map<String, Object> returnObj = new HashMap<String, Object>();
		//학생이 입력한 정답의 값을 배열로 가져옴
		String[] choice = req.getParameterValues("choice");
		//랜덤으로 출력했던 각 문제의 인덱스를 배열로 가져옴
		String[] questionNum = req.getParameterValues("questionNum");
		String subject_idx = req.getParameter("subject_idx");
		System.out.println(subject_idx); 
		//점수합산을 위해 쿼리를 통해 문제리스트를 가져옴
		ArrayList<ExamDTO> scoringList = sqlSession.getMapper(SchlineDAOImpl.class).scoringList();

		//과목인덱스로 과목명 가져오기
		ClassDTO cdto = sqlSession.getMapper(SchlineDAOImpl.class).getsubjectName(subject_idx);		
		//유저아이디로 이름 가져오기
		UserVO uvo = sqlSession.getMapper(SchlineDAOImpl.class).getuserName(user_id);
		
		String user_name = uvo.getUser_name();
		String subject_name = cdto.getSubject_name();
		
		//점수
		int score = 0;
		int s;
		int idx;
		for(ExamDTO dto : scoringList) {
				
			//문제의인덱스(총문제)의 크기만큼 반복
			for(int i = 0; i<questionNum.length; i++) {
			
				//리스트의 문제인덱스와 반복중인 문제의 인덱스가 같으면..
				if(Integer.parseInt(questionNum[i])==(dto.getQuestion_idx())){
					
					System.out.println("가져온인덱스 : "+ dto.getQuestion_idx()+"/시험문제인덱스 : "+questionNum[i]);
					System.out.println("가져온정답 : "+ dto.getAnswer()+"/학생선택 : "+choice[i]);
					System.out.println("가져온문제의타입(1객/2단/3주) : "+ dto.getQuestion_type());
					System.out.println("가져온문제의배점 : "+dto.getQuestion_score()+"점");
					
					//문제타입이 주관식이 아니라면...!
					if(dto.getQuestion_type()!=3) {
						//정답이라면...
						if(dto.getAnswer().equalsIgnoreCase(choice[i])) {
							System.out.println((i+1)+"번 문제 정답");
							
							idx = dto.getExam_idx();
							s = dto.getQuestion_score();
							String exam_idx = Integer.toString(idx);
							String scoreStr = Integer.toString(s);
							System.out.println(exam_idx+"<인덱스..점수>"+scoreStr);
							//점수는 아래에서 최종적으로 합산하여 입력
							//sqlSession.getMapper(SchlineDAOImpl.class).gradeUp(scoreStr, user_id, exam_idx);
							
							//점수 더하기
							score += dto.getQuestion_score();
						}
						//오답이면....
						else {
							System.out.println((i+1)+"번 문제 오답");
						}
					}
					//주관식일 경우...
					else {
						System.out.println("========위 문제는 주관식입니다..=========");
						System.out.println("서술형 입력값:"+choice[i]);
						int question_idx = dto.getQuestion_idx();
						sqlSession.getMapper(SchlineDAOImpl.class)
						.insertAnswer(question_idx, user_id, choice[i]);
					}
				}
			}
		}
		
		String exam_type = req.getParameter("exam_type");
		
		/*
		  시연에서는 시험 중 가장 낮은 인덱스 하나를 추출하여.. 완료처리하고
		  시험진행한것으로 판단 .. 시험별로 출제하게 되면
		  추후에 해당 시험의 인덱스를 받아와 완료처리하면 됨.
		 */
		ArrayList<Integer> examidxs = sqlSession.getMapper(SchlineDAOImpl.class)
				.getExamidx(subject_idx, exam_type);
		String exam_idx = examidxs.get(0).toString();
		sqlSession.getMapper(SchlineDAOImpl.class).checkEdit(exam_idx, user_id);
		//학생별로 점수를 insert 마찬가지로 시연에서는 첫 인덱스에 점수 입력
		String grade = Integer.toString(score);
		sqlSession.getMapper(SchlineDAOImpl.class).gradeUp(grade, user_id, exam_idx);
		
		////////////////////////////////////////////////////////////////////////////

		//returnObj.put("subject_idx", subject_idx); //없어도될듯...
		returnObj.put("score", score);
		returnObj.put("user_name", user_name);
		returnObj.put("subject_name", subject_name);
		
		return returnObj;
	}
	
//	@RequestMapping("/class/examScore.do")
//	public String examScore(Model model, HttpServletRequest req) {
//		
//		String score = req.getParameter("score");
//		model.addAttribute("score", score);
//		
//		return "/classRoom/exam/examScore";
//	}
	
	@RequestMapping("/class/taskList.do")
	public String taskList(Model model, HttpServletRequest req, Principal principal) {
		
		//로그인한 사용자가 과제를 제출했는지 확인하는 사용자정보 받아올 필요가 있을듯..
		String subject_idx = req.getParameter("subject_idx");
		String exam_type = req.getParameter("exam_type");
		//ArrayList<Integer> examidxs =sqlSession.getMapper(SchlineDAOImpl.class).getExamidx(subject_idx, exam_type);
		//System.out.println("과제인덱스:"+exam_idx);
		ClassDTO classdto = sqlSession.getMapper(SchlineDAOImpl.class)
				.getsubjectName(subject_idx);
		String subject_name = classdto.getSubject_name();
		String user_id = principal.getName();
		
		System.out.println("사용자 아이디"+user_id);
		
		/*
		 * if(check_flag!=1) { model.addAttribute("check", "미제출"); } else {
		 * model.addAttribute("check", "제출"); }
		 */
		ArrayList<ExamDTO> examlist = 
				sqlSession.getMapper(SchlineDAOImpl.class).tasklist("1", subject_idx, user_id);

		//리스트 반복..
		for(ExamDTO dto : examlist) {
			//int check_flag = sqlSession.getMapper(SchlineDAOImpl.class).getCheck(exam_idx, user_id);
			//줄바꿈처리
			String temp = dto.getExam_content().replace("\r\n", "<br/>");
			dto.setExam_content(temp);
		}
		
		model.addAttribute("subject_name", subject_name);
		model.addAttribute("examlist", examlist);
		
		//뷰로 이동
		return "/classRoom/exam/examList";
	}
	
	@RequestMapping(value="/class/taskWriteAction.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> taskWriteAction(MultipartHttpServletRequest req, Principal principal) {
		
		//경로 받아오기
		String path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile");
		System.out.println(path);
		
		//파일 insert 결과를 확인하기 위한 수
		int fileUp = 0;
		
		//과목idx
		String subject_idx = "";
		
		//과제idx 
		String exam_idx = req.getParameter("exam_idx");
		Map returnObj = new HashMap();
		
		try {
			//업로드폼의 file속성의 필드를 가져온다..(2개)
			
			//파일명 반복을 위해 Iterator 선언
			Iterator itr = req.getFileNames();
			
			MultipartFile mfile = null;
			String fileName = "";
//			List resultList = new ArrayList();
			
			//파일외에 폼값 받음.
			subject_idx = req.getParameter("subject_idx"); //과목idx
			String user_id = req.getParameter("user_id"); //아이디
			String board_title = req.getParameter("board_title"); //과제물작성제목
			String board_content = req.getParameter("board_content"); //과제물작성내용
			String exam_name = req.getParameter("exam_name"); //과제명
			
			//폼값 출력 테스트
			System.out.printf("subject_idx=%s,user_id=%s,exam_name=%s,"
					+ "board_title=%s,board_content=%s,exam_idx=%s"
					, subject_idx, user_id, exam_name, board_title, board_content, exam_idx);
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
				//확장자를 제외한 파일명(학생이 제출한 파일명)
				String userFileName = originalName.substring(0, originalName.lastIndexOf("."));
				
				//과제이름+학번+제출명으로 합치기
				String saveFileName = "("+exam_name+"-"+user_id+")"+userFileName+"("+fileindex+")" + ext;
				System.out.println("파일명 : "+saveFileName);
				
				//물리적 경로에 새롭게 생성된 파일명으로 파일저장
				File serverFullName = new File(path + File.separator + saveFileName);
				fileindex++;
				
				mfile.transferTo(serverFullName);
				
				//DB에 insert하기...
				fileUp = sqlSession.getMapper(SchlineDAOImpl.class)
					.taskWrite(subject_idx, user_id, board_title, board_content, saveFileName, exam_idx);
				
				
//				Map file = new HashMap();
//				맵에 저장하지 않고 DB에 하면될듯..추후처리
//				원본파일명
//				file.put("originalName", originalName);
//				저장된파일명
//				file.put("saveFileName", saveFileName);
//				서버의 전체경로
//				file.put("serverFullName", serverFullName);
//				제목
//				file.put("title", title);
				
//				위 4가지 정보를 저장한 Map을 ArrayList에 저장한다.
//				resultList.add(file);
			}
//			returnObj.put("files", resultList);
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
		
		if(fileUp!=0) {
			returnObj.put("taskResult", 1);
			String user_id = principal.getName();
			sqlSession.getMapper(SchlineDAOImpl.class).checkEdit(exam_idx, user_id);
		}
		else {
			returnObj.put("taskResult", 0);
		}
//		model.addAttribute("subject_idx", subject_idx);
//		model.addAttribute("exam_idx", exam_idx);
//		model.addAttribute("taskalert", fileUp);
		System.out.println(fileUp);
		//모델객체에 리스트 컬렉션을 저장한 후 뷰로 전달
		//model.addAttribute("returnObj", returnObj);

//		return "redirect:/class/taskList.do";
		return returnObj;
	}
	
	/////////////////////////////
	////////종합과제함/////////////
	
	@RequestMapping("/main/totalTask.do")
	public String totalTask(Model model, HttpServletRequest req, Principal principal) {
		
		String user_id = principal.getName();
		
		ArrayList<ExamDTO> examlist = sqlSession.getMapper(SchlineDAOImpl.class)
				.getAllTask(user_id);
		
		model.addAttribute("examlist", examlist);
		
		return "/main/totalTask";
	}
	
	

}
