package kosmo.project3.schline;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import schline.AttendanceDTO;
import schline.GradeDTO;
import schline.GradeDTOImpl;
import schline.RegistrationDTO;

@Controller
public class GradeController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/class/grade.do")
	public String grade(Model model, HttpSession session, HttpServletRequest req) {
		
		int gradeNum = 0;
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("user_id "+user_id); // 201701700
		//출석
		AttendanceDTO attendanceDTO = new AttendanceDTO();
		attendanceDTO.setSubject_idx(req.getParameter("subject_idx"));
		System.out.println(req.getParameter("subject_idx")); // 1
		attendanceDTO.setUser_id(user_id);
		ArrayList<AttendanceDTO> attenlists = sqlSession.getMapper(GradeDTOImpl.class).listAttendance(attendanceDTO);
		model.addAttribute("attenlists", attenlists);
		System.out.println("attenlists "+attenlists); // 없음
		
		//과제 성적
		GradeDTO gradeDTO = new GradeDTO();
		gradeDTO.setSubject_idx(req.getParameter("subject_idx"));
		gradeDTO.setUser_id(user_id);
		ArrayList<GradeDTO> gradelists = sqlSession.getMapper(GradeDTOImpl.class).listGrade(gradeDTO);
		model.addAttribute("gradelists", gradelists);
		System.out.println("gradelists "+gradelists); 
		
		//성적 종합
		//계산식 넣는 부분
		//예시) 총합
		for(int i =0 ; i<attenlists.size() ; i++) {
			if(attenlists.get(i).getAttendance_flag().equals("2")) {
				gradeNum += 1;
			}
		}
		System.out.println(gradeNum);
		for(int j =0 ; j<gradelists.size() ; j++) {
			gradeNum += gradelists.get(j).getGrade_exam();
		}
		System.out.println(gradeNum);
		
		String gradeChar;
		if(gradeNum>=95) {
			gradeChar = "A+";
		}
		else if(gradeNum>=90) {
			gradeChar = "A";
		}
		else if(gradeNum>=85) {
			gradeChar = "B+";
		}
		else if(gradeNum>=80) {
			gradeChar = "B";
		}
		else if(gradeNum>=75) {
			gradeChar = "C+";
		}
		else if(gradeNum>=70) {
			gradeChar = "C";
		}
		else if(gradeNum>=65) {
			gradeChar = "D+";
		}
		else if(gradeNum>=60) {
			gradeChar = "D";
		}
		else {
			gradeChar = "F";
		}
		
		model.addAttribute("gradeChar", gradeChar);
		
		RegistrationDTO registrationDTO = new RegistrationDTO();
		registrationDTO.setSubject_idx(req.getParameter("subject_idx"));
		registrationDTO.setUser_id(user_id);
		registrationDTO.setGrade_sub(Integer.toString(gradeNum));
		sqlSession.getMapper(GradeDTOImpl.class).Registrationgrade(registrationDTO);
		
		return "classRoom/grade";
	}
	

}

