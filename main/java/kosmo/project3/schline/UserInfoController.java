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
public class UserInfoController {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@RequestMapping("/user/userinfo.do")
	public String userInfo(Model model, HttpServletRequest req) {
		//유저(유저+기업)
		UserInfoDTO userInfoDTO = new UserInfoDTO();
		userInfoDTO.setUser_id("201701702");
		ArrayList<UserInfoDTO> lists =  sqlSession.getMapper(GradeDTOImpl.class).listInfo(userInfoDTO);
		model.addAttribute("lists", lists);

		return "userInfo/info";
	}
	
	@RequestMapping("/user/SubjectAtten.do")
	public String subjectAtten(Model model, HttpServletRequest req) {
	
		//과목+수강 리스트
		UserInfoDTO userInfoDTO = new UserInfoDTO();
		userInfoDTO.setUser_id("201701702");
		ArrayList<UserInfoDTO> lists =  sqlSession.getMapper(GradeDTOImpl.class).RegistrationInfo(userInfoDTO);
		System.out.println(lists);
		model.addAttribute("lists", lists);
		
		//출석
		AttendanceDTO attendanceDTO = new AttendanceDTO();
		attendanceDTO.setSubject_idx("1");
		attendanceDTO.setUser_id("201701702");
		ArrayList<AttendanceDTO> attenlists = sqlSession.getMapper(GradeDTOImpl.class).listAttendance(attendanceDTO);
		System.out.println(attenlists);
		model.addAttribute("attenlists", attenlists);
		
	
		return "userInfo/userSubject";
	}
	
	
	@RequestMapping("/user/SubjectGrade.do")
	public String subjectGrade(Model model, HttpServletRequest req) {
		

		//과목+수강 리스트
		UserInfoDTO userInfoDTO = new UserInfoDTO();
		userInfoDTO.setUser_id("201701702");
		ArrayList<UserInfoDTO> lists =  sqlSession.getMapper(GradeDTOImpl.class).RegistrationInfo(userInfoDTO);
		model.addAttribute("lists", lists);
		
		//수강중인 과목 성적 정리
		ArrayList listgrade = new ArrayList();
		for(int i =0; i<lists.size() ; i++) {
			listgrade.add(lists.get(i).getSubject_idx());
		}
		ArrayList listgrade2 = new ArrayList();
		Iterator iterator = listgrade.iterator();
					
		while(iterator.hasNext()){
			String value = (String)iterator.next();
			System.out.println("value="+value);
			int gradeNum = 0;
			
			AttendanceDTO attendanceDTO = new AttendanceDTO();
			attendanceDTO.setSubject_idx(value);
			attendanceDTO.setUser_id("201701702");
			ArrayList<AttendanceDTO> attenlists = sqlSession.getMapper(GradeDTOImpl.class).listAttendance(attendanceDTO);
			model.addAttribute("attenlists", attenlists);
			
			//과제 성적
			GradeDTO gradeDTO = new GradeDTO();
			gradeDTO.setSubject_idx(value);
			gradeDTO.setUser_id("201701702");
			ArrayList<GradeDTO> gradelists = sqlSession.getMapper(GradeDTOImpl.class).listGrade(gradeDTO);
			model.addAttribute("gradelists", gradelists);
			
			for(int i =0 ; i<attenlists.size() ; i++) {
				if(attenlists.get(i).getAttendance_flag().equals("2")) {
					gradeNum += 1;
				}
			}
			for(int j =0 ; j<gradelists.size() ; j++) {
				gradeNum += gradelists.get(j).getGrade_exam();
			}
			double totalgrade;
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
			listgrade2.add(gradeChar);
			model.addAttribute("gradeChar", gradeChar);
			RegistrationDTO registrationDTO = new RegistrationDTO();
			registrationDTO.setSubject_idx(value);
			registrationDTO.setUser_id("201701702");
			registrationDTO.setGrade_sub(Integer.toString(gradeNum));
			sqlSession.getMapper(GradeDTOImpl.class).Registrationgrade(registrationDTO);
		}
		
		System.out.println(listgrade2);
		Iterator iterator2 = listgrade2.iterator();
		double gradeNum=0.0;
		
		while(iterator2.hasNext()){
			String value = (String)iterator2.next();
			System.out.println(value);
			if(value=="A+") {
				gradeNum += 4.5;
			}
			else if(value=="A") {
				gradeNum += 4.0;
			}
			else if(value=="B+") {
				gradeNum += 3.5;
			}
			else if(value=="B") {
				gradeNum += 3.0;
			}
			else if(value=="C+") {
				gradeNum += 2.5;
			}
			else if(value=="C") {
				gradeNum += 2.0;
			}
			else if(value=="D+") {
				gradeNum += 1.5;
			}
			else if(value=="D") {
				gradeNum += 1.0;
			}
			else {
				gradeNum += 0.0;
			}
		}
		System.out.println(gradeNum);
		gradeNum = gradeNum/lists.size();
			
		model.addAttribute("gradeNum", gradeNum);
		model.addAttribute("listgrade2", listgrade2);
		model.addAttribute("lists", lists);
		
		return "userInfo/userGrade";
	}
}

