package android;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
	
	@RequestMapping("/android/SubjectGrade.do")
	@ResponseBody
	public Map<String, Object> subjectgrade(AndroidattenDTO androidattenDTO) {
		
		//과목+수강 리스트
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		ArrayList<AndroidattenDTO> lists =  sqlSession.getMapper(GradeDTOImpl.class).RegistrationInfo2(androidattenDTO);
		returnMap.put("lists", lists);
		//수강중인 과목 성적 정리 및 총 성적 등록
		ArrayList listgrade = new ArrayList();
		
		for(int i =0; i<lists.size() ; i++) {
			listgrade.add(lists.get(i).getSubject_idx());
		}
		
		String user_id = androidattenDTO.getUser_id();
		
		ArrayList listgrade2 = new ArrayList();
		
		Iterator iterator = listgrade.iterator();
		while(iterator.hasNext()){
			String value = (String)iterator.next();
			System.out.println("value="+value);
			int gradeNum = 0;
			
			AndroidattenDTO androidattenDTO2 = new AndroidattenDTO();
			androidattenDTO2.setSubject_idx(value);
			androidattenDTO2.setUser_id(user_id);
			ArrayList<AndroidattenDTO> attenlists = sqlSession.getMapper(GradeDTOImpl.class).listAttendance3(androidattenDTO2);
			
			//과제 성적
			AndroidattenDTO androidattenDTO3 = new AndroidattenDTO();
			androidattenDTO3.setSubject_idx(value);
			androidattenDTO3.setUser_id(user_id);
			ArrayList<AndroidattenDTO> gradelists = sqlSession.getMapper(GradeDTOImpl.class).listGrade2(androidattenDTO3);
			
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
			AndroidattenDTO androidattenDTO4 = new AndroidattenDTO();
			androidattenDTO4.setSubject_idx(value);
			androidattenDTO4.setUser_id(user_id);
			androidattenDTO4.setGrade_sub(Integer.toString(gradeNum));
			sqlSession.getMapper(GradeDTOImpl.class).Registrationgrade2(androidattenDTO4);
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
		gradeNum = gradeNum/lists.size();
		returnMap.put("listgrade2", listgrade2);
		returnMap.put("gradeNum", gradeNum);
		
		
		String gradeChar;
		if(gradeNum>=4.5) {
			gradeChar = "A+";
		}
		else if(gradeNum>=4.0) {
			gradeChar = "A";
		}
		else if(gradeNum>=3.5) {
			gradeChar = "B+";
		}
		else if(gradeNum>=3.0) {
			gradeChar = "B";
		}
		else if(gradeNum>=2.5) {
			gradeChar = "C+";
		}
		else if(gradeNum>=2.0) {
			gradeChar = "C";
		}
		else if(gradeNum>=1.5) {
			gradeChar = "D+";
		}
		else if(gradeNum>=1.0) {
			gradeChar = "D";
		}
		else {
			gradeChar = "F";
		}
		
		returnMap.put("gradeChar", gradeChar);

		return returnMap;
	}
	
	@RequestMapping("/android/userinfo.do")
	@ResponseBody
	public ArrayList<UserInfoDTO> userInfo(UserInfoDTO userInfoDTO) {
		//유저(유저+기업)
		System.out.println("http연결 성공(userinfo)");
		ArrayList<UserInfoDTO> lists =  sqlSession.getMapper(GradeDTOImpl.class).listInfo(userInfoDTO);
		
		return lists;
	}
	
}
