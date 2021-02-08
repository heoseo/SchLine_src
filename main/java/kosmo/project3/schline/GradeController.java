package kosmo.project3.schline;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import schline.AttendanceDTO;
import schline.ClassDTOImpl;
import schline.GradeDTO;
import schline.GradeDTOImpl;
import schline.VideoDTO;

@Controller
public class GradeController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/class/grade.do")
	public String lecture(Model model1, Model model2, Model model3, HttpServletRequest req) {
		
		int gradeNum = 0;
		
		//출석
		AttendanceDTO attendanceDTO = new AttendanceDTO();
		attendanceDTO.setSubject_idx(req.getParameter("subject_idx"));
		attendanceDTO.setUser_id("201701701");
		ArrayList<AttendanceDTO> attenlists = sqlSession.getMapper(GradeDTOImpl.class).listAttendance(attendanceDTO);
		model1.addAttribute("attenlists", attenlists);
		
		//과제 성적
		GradeDTO gradeDTO = new GradeDTO();
		gradeDTO.setSubject_idx(req.getParameter("subject_idx"));
		gradeDTO.setUser_id("201701701");
		ArrayList<GradeDTO> gradelists = sqlSession.getMapper(GradeDTOImpl.class).listGrade(gradeDTO);
		model2.addAttribute("gradelists", gradelists);
		
		//성적 종합
		//계산식 넣는 부분
		//예시) 총합
		for(int i =0 ; i<attenlists.size() ; i++) {
			if(attenlists.get(i).getAttendance_flag()==3) {
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
			gradeChar = "A-";
		}
		else if(gradeNum>=80) {
			gradeChar = "B+";
		}
		else if(gradeNum>=75) {
			gradeChar = "B";
		}
		else if(gradeNum>=70) {
			gradeChar = "B-";
		}
		else if(gradeNum>=65) {
			gradeChar = "C+";
		}
		else if(gradeNum>=60) {
			gradeChar = "C";
		}
		else if(gradeNum>=55) {
			gradeChar = "C-";
		}
		else if(gradeNum>=50) {
			gradeChar = "D+";
		}
		else if(gradeNum>=45) {
			gradeChar = "D";
		}
		else if(gradeNum>=40) {
			gradeChar = "D-";
		}
		else {
			gradeChar = "F";
		}
		
		model3.addAttribute("gradeChar", gradeChar);
		
		
		return "classRoom/grade";
	}

}

