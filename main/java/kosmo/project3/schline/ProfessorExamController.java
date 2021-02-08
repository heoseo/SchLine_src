package kosmo.project3.schline;

import java.security.Principal;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
		ArrayList<ExamDTO> pexamlist = sqlSession.getMapper(SchlineDAOImpl.class).pexamList(user_id);
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
		
		model.addAttribute("questionlist", questionlist);
		model.addAttribute("pexamlist", pexamlist);
		
		return "/professor/exam/pexamlist";
	}
}
