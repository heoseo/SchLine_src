package kosmo.project3.schline;

import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import schline.AttendanceDTO;
import schline.GradeDTO;
import schline.GradeDTOImpl;
import schline.RegistrationDTO;
import schline.UserInfoDTO;

@Controller
public class GradeController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/class/grade.do")
	public String lecture(Model model, HttpServletRequest req) {
		
		int gradeNum = 0;
		
		//출석
		AttendanceDTO attendanceDTO = new AttendanceDTO();
		attendanceDTO.setSubject_idx(req.getParameter("subject_idx"));
		attendanceDTO.setUser_id("201701701");
		ArrayList<AttendanceDTO> attenlists = sqlSession.getMapper(GradeDTOImpl.class).listAttendance(attendanceDTO);
		model.addAttribute("attenlists", attenlists);
		
		//과제 성적
		GradeDTO gradeDTO = new GradeDTO();
		gradeDTO.setSubject_idx(req.getParameter("subject_idx"));
		gradeDTO.setUser_id("201701701");
		ArrayList<GradeDTO> gradelists = sqlSession.getMapper(GradeDTOImpl.class).listGrade(gradeDTO);
		model.addAttribute("gradelists", gradelists);
		
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
		registrationDTO.setUser_id("201701701");
		registrationDTO.setGrade_sub(Integer.toString(gradeNum));
		sqlSession.getMapper(GradeDTOImpl.class).Registrationgrade(registrationDTO);
		
		return "classRoom/grade";
	}
	

}

