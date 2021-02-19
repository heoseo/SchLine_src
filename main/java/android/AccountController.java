package android;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import schline.AndroidattenDTO;
import schline.AttendanceDTO;
import schline.GradeDTO;
import schline.GradeDTOImpl;
import schline.RegistrationDTO;
import schline.UserInfoDTO;

@Controller
public class AccountController {
	
	//Mybatis 사용을 위한 자동주입
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/android/usersublist.do")
	@ResponseBody
	public ArrayList<UserInfoDTO> usersublist(UserInfoDTO userInfoDTO) {
		//public Map<String, Object> usersublist(UserInfoDTO userInfoDTO, HttpSession session) {
		
		System.out.println("http연결 성공(account)");
		//String user_id = (String) session.getAttribute("user_id");
		//userInfoDTO.setUser_id(user_id);
		//JSONObject로 반환할 경우.
	
		ArrayList<UserInfoDTO> sublist =
				sqlSession.getMapper(GradeDTOImpl.class).RegistrationInfo(userInfoDTO);
		
	
		return sublist;
		
	}
	
	@RequestMapping("/android/grade.do")
	@ResponseBody
	public Map<String, Object> grade(AndroidattenDTO androidattenDTO) {
		System.out.println("gradeHttp 연결 성공");
		int gradeNum = 0;
		Map<String, Object> returnMap = new HashMap<String, Object>();
		System.out.println(androidattenDTO);
		System.out.println(androidattenDTO.getUser_id());
		System.out.println(androidattenDTO.getSubject_idx());
		//출석
		ArrayList<AndroidattenDTO> attenlists = sqlSession.getMapper(GradeDTOImpl.class).listAttendance3(androidattenDTO);
		
		//과제 성적
		
		ArrayList<AndroidattenDTO> gradelists = sqlSession.getMapper(GradeDTOImpl.class).listGrade2(androidattenDTO);
		
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
		
		returnMap.put("attenlists", attenlists);
		returnMap.put("gradelists", gradelists);
		returnMap.put("gradeChar", gradeChar);
		
		RegistrationDTO registrationDTO = new RegistrationDTO();
		registrationDTO.setUser_id(attenlists.get(0).getUser_id());
		registrationDTO.setSubject_idx(attenlists.get(0).getSubject_idx());
		registrationDTO.setGrade_sub(Integer.toString(gradeNum));
		sqlSession.getMapper(GradeDTOImpl.class).Registrationgrade(registrationDTO);
		
		return returnMap;
	}
}
