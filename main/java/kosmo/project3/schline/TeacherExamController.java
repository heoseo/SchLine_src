package kosmo.project3.schline;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

public class TeacherExamController {

	@RequestMapping("/teacher/teacherExam.do")
	public String teacherExam(Model model, HttpServletRequest req) {
		
		
		return "classRoom/teacher/teacherExam";
	}
}
