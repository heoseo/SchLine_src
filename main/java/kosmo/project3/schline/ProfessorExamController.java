package kosmo.project3.schline;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import schline.ExamDTO;
import schline.SchlineDAOImpl;

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
				.pexamList(user_id);
		//시험타입(2)
		String exam_type = "2";
		ArrayList<ExamDTO> questionlist = null;
		for(ExamDTO dto : pexamlist) {
			
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
		model.addAttribute("pexamlist", pexamlist);
		
		return "/professor/exam/pexamlist";
	}
	
	@RequestMapping("/professor/pexamwrite.do")
	public String pexamwrite(Model model, HttpServletRequest req, Principal principal) {
		
		String user_id = principal.getName();

		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id);
		String exam_name = req.getParameter("exam_name");
		String exam_date = req.getParameter("exam_date");
		int exam_scoring = Integer.parseInt(req.getParameter("exam_scoring"));
		System.out.printf("시험이름:%s, 마감일:%s, 총배점:%s, 과목:%s", exam_name, exam_date, exam_scoring, subject_idx);
		int result = sqlSession.getMapper(SchlineDAOImpl.class)
				.insertExam(subject_idx, exam_name, exam_date, exam_scoring);
		
		if(result!=0) {
			
			String exam_idx = sqlSession.getMapper(SchlineDAOImpl.class).getExam_idx(subject_idx);
			System.out.println("시험일련번호:"+exam_idx);
			model.addAttribute("exam_idx", exam_idx);
		}
		else {
			System.out.println("뭔가 실패");
		}
		
		return "/professor/exam/pexamwrite";
	}
	
	@RequestMapping("/professor/examwriteaction.do")
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
			System.out.println("문제아이디 : "+question_idx);
			
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
	public String ptaskWrite(Model model, HttpServletRequest req, Principal principal) {
		
		String user_id = principal.getName();

		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id);
		String exam_type = "1";
		
		ArrayList<ExamDTO> pexamlist = sqlSession.getMapper(SchlineDAOImpl.class)
					.tasklist(exam_type, subject_idx);
		
		for(ExamDTO dto : pexamlist) {
			
			String temp = dto.getExam_content().replace("\r\n", "<br/>");
			dto.setQuestion_content(temp);
		}
		model.addAttribute("exam_type", exam_type);
		model.addAttribute("pexamlist", pexamlist);
		
		return "/professor/exam/pexamlist";
	}
	
	@RequestMapping("/professor/ptaskWriteAction")
	public String ptaskWriteAction(Model model, HttpServletRequest req, Principal principal){
		
		String user_id = principal.getName();
		String subject_idx = sqlSession.getMapper(SchlineDAOImpl.class).getSubject_idx(user_id); 
		String exam_name = req.getParameter("exam_name");
		String exam_date = req.getParameter("exam_date");
		String exam_content = req.getParameter("exam_content");
		String exam_scoring = req.getParameter("exam_scoring");
		System.out.printf("user_id: %s, subject_idx: %s, exam_name: %s, exam_date: %s, exam_content: %s, score:%s"
				,user_id, subject_idx, exam_name, exam_date, exam_content, exam_scoring);

		int result = sqlSession.getMapper(SchlineDAOImpl.class)
				.insertTask(subject_idx, exam_name, exam_date, exam_content, exam_scoring);
		System.out.println("과제작성결과:"+result);
		
		if(result==1) {
			model.addAttribute("msg", "과제를 작성했습니다.");
			model.addAttribute("url", "/schline/professor/ptaskList.do");
		}
		else {
			model.addAttribute("msg", "작성에 실패했습니다.");
			model.addAttribute("url", "/schline/professor/ptaskList.do");
		}
		
		return "/professor/exam/alert";
	}
}
