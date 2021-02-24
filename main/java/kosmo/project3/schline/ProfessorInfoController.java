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
import schline.UserInfoDTO;

@Controller
public class ProfessorInfoController {
	
	@Autowired
	private SqlSession sqlSession;
	
	//사용자
	@RequestMapping("/professor/professorinfo.do")
	public String userInfo(Model model, HttpSession session) {
		
		
		//선생님 아이디로 과목 번호 찾아오기
		String user_id = (String) session.getAttribute("user_id");
		System.out.println(user_id);
		
		UserInfoDTO userInfoDTO = new UserInfoDTO();
		userInfoDTO.setUser_id(user_id);
		ArrayList<UserInfoDTO> list = sqlSession.getMapper(GradeDTOImpl.class).subfind(userInfoDTO);
		
		String sub_idx = list.get(0).getSubject_idx();
		System.out.println("sub_idx: "+sub_idx); // 과목번호
		
		
		
		//학생 리스트 출력하기
		UserInfoDTO userInfoDTO2 = new UserInfoDTO();
		userInfoDTO2.setUser_id(user_id);
		userInfoDTO2.setSubject_idx(sub_idx);
		ArrayList<UserInfoDTO> lists =  sqlSession.getMapper(GradeDTOImpl.class).studentlist(userInfoDTO2);
		model.addAttribute("lists", lists);
		System.out.println("lists"+lists);
		
		//////////////////////////////
		//성적 계산하는 부분  ;;
		for (int z = 0; z<lists.size(); z++) {
			int gradeNum = 0;
			String student_id = lists.get(z).getUser_id();
			//출석
			AttendanceDTO attendanceDTO = new AttendanceDTO();
			attendanceDTO.setSubject_idx(sub_idx);
			attendanceDTO.setUser_id(student_id);
			ArrayList<AttendanceDTO> attenlists = sqlSession.getMapper(GradeDTOImpl.class).listAttendance(attendanceDTO);
			
			//과제 성적
			GradeDTO gradeDTO = new GradeDTO();
			gradeDTO.setSubject_idx(sub_idx);
			gradeDTO.setUser_id(student_id);
			ArrayList<GradeDTO> gradelists = sqlSession.getMapper(GradeDTOImpl.class).listGrade(gradeDTO);
			
			int Jgrade = gradelists.get(0).getGrade_exam();
			int Ggrade = gradelists.get(1).getGrade_exam();
			System.out.println("중간"+Jgrade);
			System.out.println("기말"+Ggrade);
			model.addAttribute("Jgrade", Jgrade);
			model.addAttribute("Ggrade", Ggrade);
			//성적 종합
			//계산식 넣는 부분
			//예시) 총합
			String gradeChar = null;
			if(Jgrade!=0 && Ggrade!=0) {
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
			}
			else {
				model.addAttribute("gradeChar", gradeChar);
			}
			
			RegistrationDTO registrationDTO = new RegistrationDTO();
			registrationDTO.setSubject_idx(sub_idx);
			registrationDTO.setUser_id(student_id);
			registrationDTO.setGrade_sub(Integer.toString(gradeNum));
			sqlSession.getMapper(GradeDTOImpl.class).Registrationgrade(registrationDTO);
		}
		
		//////////////////////
		
		//비디오 갯수 
		AttendanceDTO attendanceDTO = new AttendanceDTO();
		attendanceDTO.setSubject_idx(sub_idx);
		int videoNum = sqlSession.getMapper(GradeDTOImpl.class).videoConut(attendanceDTO);
		ArrayList<AttendanceDTO> lists2 =  sqlSession.getMapper(GradeDTOImpl.class).videoNum(attendanceDTO);
		model.addAttribute("videoNum", videoNum);
		model.addAttribute("lists2", lists2);
		
		//출석
		AttendanceDTO attendanceDTO2 = new AttendanceDTO();
		attendanceDTO2.setSubject_idx(sub_idx);
		ArrayList<AttendanceDTO> lists3 = sqlSession.getMapper(GradeDTOImpl.class).listAttendance2(attendanceDTO2);
		model.addAttribute("lists3", lists3);
		
		
		return "professor/professorinfo";
	}
	
	@RequestMapping("/professor/studentinfo.do")
	public String studentInfo(Model model, HttpSession session, HttpServletRequest req) {
		
		
		//선생님 아이디로 과목 번호 찾아오기
		String user_id = (String) session.getAttribute("user_id");
		System.out.println(user_id);
		
		UserInfoDTO userInfoDTO = new UserInfoDTO();
		userInfoDTO.setUser_id(user_id);
		ArrayList<UserInfoDTO> list = sqlSession.getMapper(GradeDTOImpl.class).subfind(userInfoDTO);
		
		String sub_idx = list.get(0).getSubject_idx();
		System.out.println("sub_idx: "+sub_idx); // 과목번호
		
		System.out.println("!: "+user_id);
		System.out.println("@: "+req.getParameter("user_id"));
		
//		String student_id = req.getParameter("user_id");
		String student_id = req.getParameter("user_id");
		model.addAttribute("student_id", student_id);
		int gradeNum = 0;
		//출석
		AttendanceDTO attendanceDTO = new AttendanceDTO();
		attendanceDTO.setSubject_idx(sub_idx);
		attendanceDTO.setUser_id(student_id);
		ArrayList<AttendanceDTO> attenlists = sqlSession.getMapper(GradeDTOImpl.class).listAttendance(attendanceDTO);
		model.addAttribute("attenlists", attenlists);
		System.out.println("attenlists "+attenlists); // 없음
		
		//과제 성적
		GradeDTO gradeDTO = new GradeDTO();
		gradeDTO.setSubject_idx(sub_idx);
		gradeDTO.setUser_id(student_id);
		ArrayList<GradeDTO> gradelists = sqlSession.getMapper(GradeDTOImpl.class).listGrade(gradeDTO);
		model.addAttribute("gradelists", gradelists);
		System.out.println("gradelists "+gradelists); 
		
		int Jgrade = gradelists.get(0).getGrade_exam();
		int Ggrade = gradelists.get(1).getGrade_exam();
		System.out.println("중간"+Jgrade);
		System.out.println("기말"+Ggrade);
		model.addAttribute("Jgrade", Jgrade);
		model.addAttribute("Ggrade", Ggrade);
		String gradeChar = null;
		//성적 종합
		//계산식 넣는 부분
		//예시) 총합
		if(Jgrade!=0 && Ggrade!=0) {
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
		}
		else {
			model.addAttribute("gradeChar", gradeChar);
		}
		RegistrationDTO registrationDTO = new RegistrationDTO();
		registrationDTO.setSubject_idx(sub_idx);
		registrationDTO.setUser_id(student_id);
		registrationDTO.setGrade_sub(Integer.toString(gradeNum));
		sqlSession.getMapper(GradeDTOImpl.class).Registrationgrade(registrationDTO);
			
		return "professor/studentinfo";
	}
	
	@RequestMapping("/professor/professorSetting.do")
	public String professorSetting(Model model, HttpServletRequest req, HttpSession session) {
		
		
		//선생님 아이디로 과목 번호 찾아오기
		String user_id = (String) session.getAttribute("user_id");
		System.out.println(user_id);
		
		UserInfoDTO userInfoDTO = new UserInfoDTO();
		userInfoDTO.setUser_id(user_id);
		ArrayList<UserInfoDTO> list = sqlSession.getMapper(GradeDTOImpl.class).subfind(userInfoDTO);
		
		String sub_idx = list.get(0).getSubject_idx();
		System.out.println("sub_idx: "+sub_idx); // 과목번호
				
		//비디오 갯수 
		AttendanceDTO attendanceDTO = new AttendanceDTO();
		attendanceDTO.setSubject_idx(sub_idx);
		int videoNum = sqlSession.getMapper(GradeDTOImpl.class).videoConut(attendanceDTO);
		ArrayList<AttendanceDTO> lists2 =  sqlSession.getMapper(GradeDTOImpl.class).videoNum(attendanceDTO);
		model.addAttribute("videoNum", videoNum);
		model.addAttribute("lists2", lists2);
		
		AttendanceDTO attenDTO = new AttendanceDTO();
		
		String student_id = req.getParameter("user_id");
		System.out.println(student_id);
		for(int i = 0 ; i<lists2.size() ; i++) {
			
			String check = req.getParameter(Integer.toString(i+1));
			attenDTO.setAttendance_flag(check);
			attenDTO.setVideo_idx(lists2.get(i).getVideo_idx());
			attenDTO.setUser_id(student_id);
			System.out.println(check);
			System.out.println(lists2.get(i).getVideo_idx());
			System.out.println(student_id);
			sqlSession.getMapper(GradeDTOImpl.class).attenupdate(attenDTO);
		}
		return "redirect:studentinfo.do?user_id="+student_id;
		
	}
	
	
	
	
}

