package kosmo.project3.schline;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import schline.AttendanceDTO;
import schline.ExamBoardDTO;
import schline.GradeDTO;
import schline.GradeDTOImpl;
import schline.RegistrationDTO;
import schline.UserInfoDTO;
import schline.UserSettingDTO;

@Controller
public class UserInfoController {
	
	@Autowired
	private SqlSession sqlSession;
	
	//사용자
	@RequestMapping("/user/userinfo.do")
	public String userInfo(Model model, HttpSession session) {
		//유저(유저+기업)
		String user_id = (String) session.getAttribute("user_id");
		UserInfoDTO userInfoDTO = new UserInfoDTO();
		userInfoDTO.setUser_id(user_id);
		ArrayList<UserInfoDTO> lists =  sqlSession.getMapper(GradeDTOImpl.class).listInfo(userInfoDTO);
		model.addAttribute("lists", lists);
		
		UserInfoDTO userInfoDTO2 = new UserInfoDTO();
		userInfoDTO2.setUser_id(user_id);
		ArrayList<UserInfoDTO> lists2 =  sqlSession.getMapper(GradeDTOImpl.class).blockuser(userInfoDTO2);
		model.addAttribute("lists2", lists2);
		
		return "userInfo/info";
	}
	
	
	
	//수강 목록
	@RequestMapping("/user/SubjectAtten.do")
	public String subjectAtten(Model model, HttpSession session, HttpServletRequest req) {
	
		String user_id = (String) session.getAttribute("user_id");
		
		//과목+수강 리스트 (학생이 수강하는 과목 subject_idx)
		UserInfoDTO userInfoDTO = new UserInfoDTO();
		userInfoDTO.setUser_id(user_id);
		ArrayList<UserInfoDTO> lists =  sqlSession.getMapper(GradeDTOImpl.class).RegistrationInfo(userInfoDTO);
		System.out.println(lists);
		System.out.println(lists.get(0));
		System.out.println(lists.get(0).getSubject_idx());
		//lists 객체 배열 (subject_idx)
		model.addAttribute("lists", lists);
		
		ArrayList<String> list = new ArrayList<String>();
		for (int i =0; i<lists.size(); i++) {
		list.add(lists.get(i).getSubject_idx());
		}
		System.out.println(list);
		
		//subject_idx가 1
		AttendanceDTO attendanceDTO = new AttendanceDTO();
		attendanceDTO.setSubject_idx(list.get(0));
		attendanceDTO.setUser_id(user_id);
		ArrayList<AttendanceDTO> atten1 = sqlSession.getMapper(GradeDTOImpl.class).AttenInfo(attendanceDTO);
		model.addAttribute("atten1", atten1);
		
		//subject_idx가 2
		AttendanceDTO attendanceDTO2 = new AttendanceDTO();
		attendanceDTO2.setSubject_idx(list.get(1));
		attendanceDTO2.setUser_id(user_id);
		ArrayList<AttendanceDTO> atten2 = sqlSession.getMapper(GradeDTOImpl.class).AttenInfo(attendanceDTO2);
		model.addAttribute("atten2", atten2);
		
		//subject_idx가 3
		AttendanceDTO attendanceDTO3 = new AttendanceDTO();
		attendanceDTO3.setSubject_idx(list.get(2));
		attendanceDTO3.setUser_id(user_id);
		ArrayList<AttendanceDTO> atten3 = sqlSession.getMapper(GradeDTOImpl.class).AttenInfo(attendanceDTO3);
		model.addAttribute("atten3", atten3);
		
		//subject_idx가 4
		AttendanceDTO attendanceDTO4 = new AttendanceDTO();
		attendanceDTO4.setSubject_idx(list.get(3));
		attendanceDTO4.setUser_id(user_id);
		ArrayList<AttendanceDTO> atten4 = sqlSession.getMapper(GradeDTOImpl.class).AttenInfo(attendanceDTO4);
		model.addAttribute("atten4", atten4);
		
		//subject_idx가 5
		AttendanceDTO attendanceDTO5 = new AttendanceDTO();
		attendanceDTO5.setSubject_idx(list.get(4));
		attendanceDTO5.setUser_id(user_id);
		ArrayList<AttendanceDTO> atten5 = sqlSession.getMapper(GradeDTOImpl.class).AttenInfo(attendanceDTO5);
		model.addAttribute("atten5", atten5);
		
		return "userInfo/userSubject";
	}
	
	
	
	
	//성적 조회
	@RequestMapping("/user/SubjectGrade.do")
	public String subjectGrade(Model model, HttpSession session) {
		
		String user_id = (String) session.getAttribute("user_id");
		//과목+수강 리스트
		UserInfoDTO userInfoDTO = new UserInfoDTO();
		userInfoDTO.setUser_id(user_id);
		ArrayList<UserInfoDTO> lists =  sqlSession.getMapper(GradeDTOImpl.class).RegistrationInfo(userInfoDTO);
		model.addAttribute("lists", lists);
		
		//수강중인 과목 성적 정리 및 총 성적 등록
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
			attendanceDTO.setUser_id(user_id);
			ArrayList<AttendanceDTO> attenlists = sqlSession.getMapper(GradeDTOImpl.class).listAttendance(attendanceDTO);
//			model.addAttribute("attenlists", attenlists);
			
			//과제 성적
			GradeDTO gradeDTO = new GradeDTO();
			gradeDTO.setSubject_idx(value);
			gradeDTO.setUser_id(user_id);
			ArrayList<GradeDTO> gradelists = sqlSession.getMapper(GradeDTOImpl.class).listGrade(gradeDTO);
//			model.addAttribute("gradelists", gradelists);
			
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
//			model.addAttribute("gradeChar", gradeChar);
			RegistrationDTO registrationDTO = new RegistrationDTO();
			registrationDTO.setSubject_idx(value);
			registrationDTO.setUser_id(user_id);
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
		
		System.out.println(gradeNum);
		model.addAttribute("listgrade2", listgrade2);
		model.addAttribute("gradeNum", gradeNum);
		
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
		model.addAttribute("gradeChar", gradeChar);
		ArrayList<String> list = new ArrayList<String>();
		for (int i =0; i<lists.size(); i++) {
		list.add(lists.get(i).getSubject_idx());
		}
		System.out.println(list); // [1,2,3,4,5]
		
		AttendanceDTO attendanceDTO1 = new AttendanceDTO();
		attendanceDTO1.setSubject_idx(list.get(0));
		attendanceDTO1.setUser_id(user_id);
		ArrayList<AttendanceDTO> attenlists1 = sqlSession.getMapper(GradeDTOImpl.class).listAttendance(attendanceDTO1);
		GradeDTO gradeDTO1 = new GradeDTO();
		gradeDTO1.setSubject_idx(list.get(0));
		gradeDTO1.setUser_id(user_id);
		ArrayList<GradeDTO> gradelists1 = sqlSession.getMapper(GradeDTOImpl.class).listGrade(gradeDTO1);
		model.addAttribute("gradelists1", gradelists1);
		String gradeChar1=graderesult(attenlists1,gradelists1);
		model.addAttribute("gradeChar1", gradeChar1);
		
		AttendanceDTO attendanceDTO2 = new AttendanceDTO();
		attendanceDTO2.setSubject_idx(list.get(1));
		attendanceDTO2.setUser_id(user_id);
		ArrayList<AttendanceDTO> attenlists2 = sqlSession.getMapper(GradeDTOImpl.class).listAttendance(attendanceDTO2);
		GradeDTO gradeDTO2 = new GradeDTO();
		gradeDTO2.setSubject_idx(list.get(1));
		gradeDTO2.setUser_id(user_id);
		ArrayList<GradeDTO> gradelists2 = sqlSession.getMapper(GradeDTOImpl.class).listGrade(gradeDTO2);
		model.addAttribute("gradelists2", gradelists2);
		String gradeChar2=graderesult(attenlists2,gradelists2);
		model.addAttribute("gradeChar2", gradeChar2);
		
		AttendanceDTO attendanceDTO3 = new AttendanceDTO();
		attendanceDTO3.setSubject_idx(list.get(2));
		attendanceDTO3.setUser_id(user_id);
		ArrayList<AttendanceDTO> attenlists3 = sqlSession.getMapper(GradeDTOImpl.class).listAttendance(attendanceDTO3);
		GradeDTO gradeDTO3 = new GradeDTO();
		gradeDTO3.setSubject_idx(list.get(2));
		gradeDTO3.setUser_id(user_id);
		ArrayList<GradeDTO> gradelists3 = sqlSession.getMapper(GradeDTOImpl.class).listGrade(gradeDTO3);
		model.addAttribute("gradelists3", gradelists3);
		String gradeChar3=graderesult(attenlists3,gradelists3);
		model.addAttribute("gradeChar3", gradeChar3);
		
		AttendanceDTO attendanceDTO4 = new AttendanceDTO();
		attendanceDTO4.setSubject_idx(list.get(3));
		attendanceDTO4.setUser_id(user_id);
		ArrayList<AttendanceDTO> attenlists4 = sqlSession.getMapper(GradeDTOImpl.class).listAttendance(attendanceDTO4);
		GradeDTO gradeDTO4 = new GradeDTO();
		gradeDTO4.setSubject_idx(list.get(3));
		gradeDTO4.setUser_id(user_id);
		ArrayList<GradeDTO> gradelists4 = sqlSession.getMapper(GradeDTOImpl.class).listGrade(gradeDTO4);
		model.addAttribute("gradelists4", gradelists4);
		String gradeChar4=graderesult(attenlists4,gradelists4);
		model.addAttribute("gradeChar4", gradeChar4);
		
		AttendanceDTO attendanceDTO5 = new AttendanceDTO();
		attendanceDTO5.setSubject_idx(list.get(4));
		attendanceDTO5.setUser_id(user_id);
		ArrayList<AttendanceDTO> attenlists5 = sqlSession.getMapper(GradeDTOImpl.class).listAttendance(attendanceDTO5);
		GradeDTO gradeDTO5 = new GradeDTO();
		gradeDTO5.setSubject_idx(list.get(4));
		gradeDTO5.setUser_id(user_id);
		ArrayList<GradeDTO> gradelists5 = sqlSession.getMapper(GradeDTOImpl.class).listGrade(gradeDTO5);
		model.addAttribute("gradelists5", gradelists5);
		String gradeChar5=graderesult(attenlists5,gradelists5);
		model.addAttribute("gradeChar5", gradeChar5);
		
		return "userInfo/userGrade";
	}
	public static String graderesult (ArrayList<AttendanceDTO> atten, ArrayList<GradeDTO> grade) {
		
		int gradeNum = 0;
		
		for(int i =0 ; i<atten.size() ; i++) {
			if(atten.get(i).getAttendance_flag().equals("2")) {
				gradeNum += 1;
			}
		}
		for(int j =0 ; j<grade.size() ; j++) {
			gradeNum += grade.get(j).getGrade_exam();
		}
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
		return gradeChar;
	}
	

	//제출 파일
	@RequestMapping("/user/SubjectFile.do")
	public String subjectFile(Model model, HttpSession session, HttpServletRequest req) {
	

		//유저아이디
		String user_id = (String) session.getAttribute("user_id");
		
		ExamBoardDTO examBoardDTO = new ExamBoardDTO();
		examBoardDTO.setUser_id(user_id);
		ArrayList<ExamBoardDTO> lists =  sqlSession.getMapper(GradeDTOImpl.class).boardInfo(examBoardDTO);
		
		
		model.addAttribute("lists", lists);
		
	
	
		return "userInfo/userFile";
	}
	
	@RequestMapping("/user/userDownload.do")
	public void userDownload (HttpServletRequest req, HttpServletResponse resp) {
		
		String path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile");
		String file_name = req.getParameter("board_file");
		
		//다운로드 메소드 호출
		download(req, resp, path, file_name);
	}
	
	
	//파일 다운로드 메소드
	public static void download(
			HttpServletRequest request,
			HttpServletResponse response,
			String directory, String fileName){
		/*
		파일다운로드 원리
		1.웹브라우저가 인식하지 못하는 컨텐츠타입을 응답헤더에 설정해주면
		웹브라우저는 자체 다운로드 창을 띄운다.
		
		2.서버에 저장된 파일을 출력스트림을 통해 웹브라우저에 출력한다.
		*/
		try{
			//파일이 저장된 물리적인 경로를 가져온다.
			//String saveDirectory = request.getServletContext().getRealPath(directory);
			
			//3.파일 크기를 얻기 위한 파일객체 생성
			// - 다운로드시 프로그래스바를 표시하기 위함.
			File f = new File(directory+File.separator+fileName);			
			long length = f.length();
			
			//다운로드를 위한 응답헤더 설정
			//4.다운로드창을 보여주기 위한 응답헤더 설정
			//4-1.웹브라우저가 인식하지 못하는 컨텐츠타입(MIME)을 설정
			response.setContentType("binary/octect-stream");
			//4-2.다운로드시 프로그래스바를 표시하기위한 컨텐츠길이 설정(Long타입 인식?)
			//response.setContentLengthLong(length);
			
			/*
			4-3. 응답헤더명 : Content-Disposition
				응답헤더명에 따른 값 : attachment;filename=파일명
				setHeader(응답헤더명,헤더값)으로 추가함
			브라우저 종류에 따라 한글파일명이 깨지는 경우가 있음으로
			브라우저별 인코딩 방식을 달리하는것임(파일명을 인코딩)
			*/
			boolean isIE = 
				request.getHeader("user-agent").toUpperCase().indexOf("MSIE")!=-1 ||
				request.getHeader("user-agent").toUpperCase().indexOf("11.0")!=-1;
			
			if(isIE){//인터넷 익스플로러
				fileName = URLEncoder.encode(fileName, "UTF-8");
			}
			else{//기타 웹브라우져
			/*
			new String(byte[] bytes, String charset)사용
			1) 파일명을 byte형 배열로 변환
			2) String클래스의 생성자에 
				변환한 배열과 charset는 8859_1을 지정함.
			*/
				fileName = new String(fileName.getBytes("UTF-8"),"8859_1");
			}
			
			response.setHeader("Content-Disposition", 
					"attachment;filename="+fileName);
			
			/*
			IO작업을 통해서 서버에 있는 파일을 웹브라우저에 바로 출력
			
			데이터소스 : 파일 - 노드스트림 : FileInputStream
								필터스트림 : BufferedInputStream
			데이터목적지 : 웹브라우저 - 노드스트림 : response.getOutputStream();
										필터스트림 : BufferedOutputStream
			*/
			//5.서버에 있는 파일에 연결할 입력스트림 생성
			BufferedInputStream bis 
				= new BufferedInputStream(
						new FileInputStream(f));
			//6.웹브라우저에 연결할 출력스트림 생성
			BufferedOutputStream bos 
				= new BufferedOutputStream(
						response.getOutputStream());
			//7.bis로 읽고 bos로 웹브라우저에 출력
			int data;
			while((data=bis.read()) != -1){
				bos.write(data);
				//bos.flush();
			}
			//8.스트림 닫기
			bis.close();
			bos.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}		
	}
//		
//	@RequestMapping("/user/notiSetting.do")
//	public String notiSetting(Model model, HttpServletRequest req, HttpSession session) {
//		String user_set = req.getParameter("user_set");
////		System.out.println(user_set);
//		String user_id = (String) session.getAttribute("user_id");
//		
//		UserSettingDTO userSettingDTO = new UserSettingDTO();
//		userSettingDTO.setUser_id(user_id);
//		userSettingDTO.setUser_set(user_set);
//		userSettingDTO.setSetting_name("noti");
//		sqlSession.getMapper(GradeDTOImpl.class).notiset(userSettingDTO);
//		
//		return "redirect:userinfo.do";
//		
//	}
//	@RequestMapping("/user/examSetting.do")
//	public String examSetting(Model model, HttpServletRequest req, HttpSession session) {
//		String user_set = req.getParameter("user_set");
////		System.out.println(user_set);
//		String user_id = (String) session.getAttribute("user_id");
//		
//		UserSettingDTO userSettingDTO = new UserSettingDTO();
//		userSettingDTO.setUser_id(user_id);
//		userSettingDTO.setUser_set(user_set);
//		userSettingDTO.setSetting_name("exam");
//		sqlSession.getMapper(GradeDTOImpl.class).examset(userSettingDTO);
//		
//		return "redirect:userinfo.do";
//		
//	}
	
	@RequestMapping("/user/blockDelete.do")
	public String blockDelete (HttpServletRequest req, HttpSession session) {
		
		String user_id = (String) session.getAttribute("user_id");
		
		UserInfoDTO userInfoDTO = new UserInfoDTO();
		userInfoDTO.setUser_id(user_id);
		userInfoDTO.setBlock_user(req.getParameter("block_user"));
		System.out.println(req.getParameter("block_user"));
		
		ArrayList<UserInfoDTO> lists3 =  sqlSession.getMapper(GradeDTOImpl.class).blockdelete(userInfoDTO);
		
		return "redirect:userinfo.do";
	}
}

