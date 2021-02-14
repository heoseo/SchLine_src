package kosmo.project3.schline;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sound.midi.MidiDevice.Info;
import javax.websocket.Session;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import oracle.net.aso.b;
import studyroom.BlockDTO;
import studyroom.InfoCommand;
import studyroom.InfoVO;
import studyroom.StudyCommandImpl;
import studyroom.StudyDAOImpl;

@Controller
public class StudyRoomController {
	
	//마이바티스 사용준비
	@Autowired
	private SqlSession sqlSession;
	
	//JdbcTemplate 사용준비
	private JdbcTemplate template;
	
	//JdbcTemplate 적용 빈 자동주입
	@Autowired
	public void setTemplate(JdbcTemplate template) {
		this.template = template;
		System.out.println("공부방 JdbcTemplate 연결성공");
	}	
	
	
	//공부방 메인
	@RequestMapping("/class/studyRoom.do")
	public String studyRoom (HttpSession session, Model model, Principal principal) {
		
		/*
		controller에서 시큐리티를 통해 로그인 한 사용자정보 얻어오기
			: @Controller로 선언된 클래스에서는 메소드 인자로 
			Principal 객체를 통해 사용자 아이디를 얻어올수 있다.
		 */
		//1.Principal 객체를 통한 사용자 아이디 얻기
		//시큐리티 유저 아이디 얻어오기
		String user_id = principal.getName();
		
		//로그인회원 프로필 불러오기
		InfoVO loginPeople = sqlSession.getMapper(StudyDAOImpl.class).user_nick(user_id);

		//파라미터전송을 위해 모델객체에 로그인회원정보 저장
//		model.addAttribute("loginPeople", loginPeople);
		model.addAttribute("info_nick", loginPeople.getInfo_nick());
		model.addAttribute("user_id", loginPeople.getUser_id());
		model.addAttribute("info_img", loginPeople.getInfo_img());
		model.addAttribute("info_time", loginPeople.getInfo_time());
		model.addAttribute("info_atten", loginPeople.getInfo_atten());
		model.addAttribute("reported_count", loginPeople.getReported_count());//신고횟수
		
		//전체회원 리스트 불러오기 및 랭킹매기기
		ArrayList<InfoVO> LankList = sqlSession.getMapper(StudyDAOImpl.class).lank_list();
		model.addAttribute("LankList",LankList);
		
		return "studyRoom/studyRoom";
	}
	
	//채팅방 이동해서 회원정보 불러오기
	//JDBCTemplate 인터페이스 구현용 command 객체 생성
	StudyCommandImpl command = null;
	
	//JDBCTemplate용★★★★★작동 안한다!!!!
	//채팅방 이동. 프로필 이미지 불러오기
//	@RequestMapping(value = "/class/studyRoomChat.do", method = RequestMethod.POST)
//	public String studyRoomGo(Model model, HttpServletRequest req) {
//		
//		//전체회원 정보 다 불러와서 넘겨줘야할듯...
//		System.out.println("가입된 회원프로필 불러오기");
//		
//		//req를 모델객체에 저장
//		model.addAttribute("req", req);
//		//View에서 전송한 값을 커맨드 객체에 저장후 model 저장
////			model.addAttribute("infoVO", infoVO);
//		command = new InfoCommand();
//		//전체 회원 리스트 불러오기
//		command.execute(model);
////		model.addAttribute("infoList", infoList);
//		
////			infoList = sqlSession.getMapper()
//		
//		return "studyRoom/studyRoomGo";
//	}
	
//	@RequestMapping("/class/checkName.do")
//	public String studyCheckName() {
//		return "studyRoom/checkName";
//	}
	
	//마이바티스로 변경
	//공부방 채팅 이동
	@RequestMapping(value = "/class/studyRoomChat.do", method = RequestMethod.POST)
	public String studyRoomChatGo(Model model, HttpServletRequest req, HttpSession session,
			Authentication authentication) {
		
		//시큐리티 Authentication 객체를 통한 사용자 아이디 얻기
		UserDetails userDetails = (UserDetails)authentication.getPrincipal();
		String user_id = userDetails.getUsername();
		
		//접속수 올리기
		
		
		//로그인회원 프로필 불러오기
		InfoVO loginPeople = sqlSession.getMapper(StudyDAOImpl.class).user_nick(user_id);
		System.out.println("로그인회원 닉네임 = "+ loginPeople.getInfo_nick());
		
		//파라미터전송을 위해 모델객체에 로그인회원정보 저장
		model.addAttribute("info_nick", loginPeople.getInfo_nick());
		model.addAttribute("user_id", loginPeople.getUser_id());
		model.addAttribute("info_img", loginPeople.getInfo_img());
		
		System.out.println("가입된 회원프로필 불러오기");
		//전체회원 리스트 불러오기
		ArrayList<InfoVO> studyList = sqlSession.getMapper(StudyDAOImpl.class).study_list();
		
		System.out.println("전체리스트 모델객체에 담기");
		model.addAttribute("studyList", studyList);
		
		return "studyRoom/studyRoomGo";
	}
	
	
	//프로필수정 팝업 ajax페이지 불러오기
	@RequestMapping("/sudtyRoom/profileAjax.do")
	public String profileAjax(HttpServletRequest req, Model model) {
		model.addAttribute("user_id", req.getParameter("user_id"));
		model.addAttribute("info_nick", req.getParameter("info_nick"));
		model.addAttribute("info_img", req.getParameter("info_img"));
		return "studyRoom/ajaxInfo";
	}
	
	//콜백데이터를 제이슨으로 쓸떄
	@RequestMapping("/class/returnStudyAjax.do")
	@ResponseBody
	public Map<String, Object> nameCheck(HttpServletRequest req){
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("result_nick", "중복닉네임이 존재합니다.");
		
		return map;
	}
	
	//이미지 그대로두고 닉네임만 바꿀때!!
	//프로필 수정(파일업로드는 POST)
	@RequestMapping(value = "/class/editInfo.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> editInfo(Model model, MultipartHttpServletRequest req) 
	{
		//결과값 반환을 위한 Map 생성
		Map<String, Object> checkMap = new HashMap<String, Object>();
		System.out.println("프로필 수정 시작");
		
		String user_id = req.getParameter("user_id");//학번
		String change_nick = req.getParameter("change_nick");//변경 닉네임
		String info_img = req.getParameter("info_img");//기존 이미지
		
		String change_img;
		int result;
		System.out.println("파라미터 받아오기 완료");
		
		//내 닉네임 확인
		InfoVO myname_check = sqlSession.getMapper(StudyDAOImpl.class).user_nick(user_id);
		//기존닉네임과 변경한 닉네임이 같지 않을때 중복체크진행
		if(!myname_check.getInfo_nick().equals(change_nick)) {
			//닉네임 중복확인
			int name_check = sqlSession.getMapper(StudyDAOImpl.class).check_nick(change_nick);
			System.out.println("닉네임 중복확인 시작");
			
			//중복닉네임이 있을경우
			if(name_check!=0) {
				checkMap.put("result", 0);
				System.out.println("중복닉네임 있음");
				return checkMap;
			}
			System.out.println("중복아이디없음. 프로필수정 시작");
		}
		try {
			//파일업로드 위한 멀티파트 객체 생성
			MultipartFile mfile = null;
			//////파일 업로드//////
			//서버의 풀리적 경로 얻어오기
			String path = req.getSession().getServletContext().getRealPath("/resources/profile_image");
			System.out.println("path="+path);
			
			Iterator<String> itr = req.getFileNames();//변경한 이미지
			while(itr.hasNext()) {
				//전송된 파일의 이름을 읽어온다
				change_img = (String)itr.next();
				mfile = req.getFile(change_img);
				System.out.println("파일이름="+mfile);
			
			//스프링에서는 파일이름 getFileNames() 으로 가지고온다!!
				//req.getFile().equals("")
//			if(req.getFile().equals("")){//null에러방지 처리
			if(mfile.getOriginalFilename().equals("")){//null에러방지 처리
				//img변경이 없을땐 기존이미지로 바로 프로필 수정 진행한다.
				System.out.println("기존이미지적용 프로필수정1");
				result = sqlSession.getMapper(StudyDAOImpl.class)
						.edit_profile(change_nick, info_img, user_id); 
				System.out.println("기존이미지적용 프로필수정2");
				if(result==1) {
					System.out.println("기존이미지적용 프로필수정 성공");
					checkMap.put("result", 1);
				}
			}
			else {//이미지 변경이 있을경우
				System.out.println("이미지 변경시 프로필 수정");
				
				//기존이미지 삭제처리
				deleteFile(path, info_img);
				System.out.println("기존이미지 삭제 완료");
				
				/*
				물리적 경로를 기반으로 File객체를 생성한 후 지정된 디렉토리가 있는지 확인한다.
				만약 없다면 mkdir로 생성한다.
				 */
				File directory = new File(path);
				if(!directory.isDirectory()) {
					directory.mkdir();
				}
				
				//한글깨짐방치 처리후 전송된 파일명을 가져옴
				String originalName = new String(mfile.getOriginalFilename().getBytes(),"UTF-8");
				
				System.out.println("오리지널 파일이름="+originalName);
				
				//전송된 파일이 없다면 while문 처음으로 돌아간다.
				if("".equals(originalName)) {continue;};
				
				//파일명에서 확장자를 가져옴.
				String ext = originalName.substring(originalName.lastIndexOf('.'));
				//UUID를 통해 생성된 문자열과 확장자를 합쳐서 파일명 완성
				String saveFileName = user_id+"_img"+ext;
				System.out.println("새롭게 저장한 파일이름"+saveFileName);
				//물리적 경로에 새롭게 생성된 파일명으로 파일저장
				File serverFullName = new File(path + File.separator + saveFileName);
				
				mfile.transferTo(serverFullName);
				
				//기존 프로필사진 실제파일 삭제처리(DB는 덮어쓰기)
				result = sqlSession.getMapper(StudyDAOImpl.class)
						.edit_profile(change_nick, saveFileName, user_id); 
			
				if(result==1) {
					System.out.println("파일 업로드 성공");
					checkMap.put("result", 1);
				}
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		//return "studyRoom/studyRoom";
		//ajax방식으로 페이지 이동 되지않고 결과값만 전송하기위한 map 반환
		return checkMap;
	}
	
	
	//프로필 이미지 기존파일 삭제
	public void deleteFile(String path,String info_img) {
		try {
			//기존파일 삭제처리
			if(info_img.equals("user.png")) {//기본이미지면 삭제하지 않는다.
				System.out.println("기본이미지라 삭제하지않음");
				return;
			}
			else {
				System.out.println("기존파일 삭제 시작");
			    File f = new File(path+File.separator+info_img);
			    if(f.exists()) {
			     f.delete();
			    }
		    }
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	//프로필 이미지 기존파일 삭제
//	public void deleteFile(HttpServletRequest req,String info_img) {
//		try {
//				System.out.println("기존프로필 삭제시작");
//				//파일의 실제 저장경로 가져오기
//				//이걸쓰면 컴퓨터별로 경로를 다 바꿔줘야함...
//	//			Path file = Paths.get("C:\02Workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\K10Spring\resources\profile_image");
//				
//				//서버의 물리적경로 가져오기
//				String path = req.getSession().getServletContext().getRealPath("/resources/profile_image/"+info_img);
//	//			if(Files.probeContentType(path).startsWith("image")) {
//				Path deletePath = Paths.get(path);
//				//실제 파일 삭제
//				Files.delete(deletePath);
//	//			}
//		}
//		catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
	
	
	//공부시간 10초별 저장해주기
	@RequestMapping("/class/studyTimeSet.do")
	@ResponseBody
	public Map<String, Object> studyTime(HttpServletRequest req, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		/* 일반적인 클래스에서 사용자 정보 얻어오기
			 	: 스프링 컨테이너의 전역변수로 선언된 SecurityContextHolder
			 	객체를 통해 사용자 아이디를 얻어올수 있다.
		*/
		Object object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails sch = (UserDetails)object;
		String user_id = sch.getUsername();
		
		//10초마다 정보저장해주는 함수 호출
		int time = Integer.parseInt(req.getParameter("send_time").toString());
		
		int result= sqlSession.getMapper(StudyDAOImpl.class).study_time(user_id, time);
		if(result==1) {
			System.out.println("시간저장 성공");
			map.put("setTime", 1);
		}
		return map;
	}
	
	//채팅내용전송시 자동저장
	@RequestMapping("/class/chatSave.do")
	@ResponseBody
	public Map<String, Object> sendMSG(HttpServletRequest req, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("전송과 동시에 채팅내용 저장");
		
		String user_id = session.getAttribute("user_id").toString();
		String chat_content = req.getParameter("chat_content");
		System.out.println("user_id"+user_id);
		System.out.println("컨텐츠"+chat_content);
		int result = sqlSession.getMapper(StudyDAOImpl.class).chat_history(user_id, chat_content);
		
		if(result==1) {
			System.out.println("채팅담기 성공");
			map.put("result", 1);
		}
		return map;
	}
	
	//채팅 닉네임확인, 신고, 차단 ajax
	@RequestMapping("/class/checkUSer.do")
	@ResponseBody //제이슨이나 컬렉션을 텍스트형식으로 웹에 뿌려줌
	public Map<String, Object> checkUser(Model model, HttpServletRequest req, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("닉네임확인, 신고, 차단 컨트롤러 진입");
		String user_id = session.getAttribute("user_id").toString();
		String ot_nick =req.getParameter("ot_nick");
		String flag = req.getParameter("flag").toString();//1은 신고, 0은 차단, 2는 프로필확인
		System.out.println("ot_nick= "+ot_nick);
		System.out.println("flag="+flag);
		//닉네임으로 정보체크
		InfoVO other_pro = sqlSession.getMapper(StudyDAOImpl.class).other_profile(ot_nick);
		if(other_pro.getInfo_nick()!=null) {
			map.put("result", 1);//성공시 반환값 1을 담아줌
		}
		if(flag.equals("1")) {//신고하기 일 경우
			int reported_count = sqlSession.getMapper(StudyDAOImpl.class).reported_people(ot_nick);
			if(reported_count==1) {
				System.out.println("신고성공");
				map.put("check", 1);//성공시 반환값 1을 담아줌
			}
		}
		else if(flag.equals("0")) {//차단하기 일 경우
			//사용자 닉네임으로 아이디값을 받아와서 그 아이디를 차단해줌
			String other_id = other_pro.getUser_id();
			//차단한 유저가 중복되지않게 처리해주는게 좋은데...시간되면 하자
			int block = sqlSession.getMapper(StudyDAOImpl.class).block_people(user_id, other_id);
			if (block==1) {
				System.out.println("차단성공");
				map.put("check", 0);//성공시 반환값 1을 담아줌
			}
		}
		return map;
	}
	
	//프로필보기 링크로 이동
	@RequestMapping("/class/openProfile.do")
	public String openProfile(HttpServletRequest req, Model model) {
		System.out.println("프로필 새창열기");
		String ot_nick = req.getParameter("ot_nick");//프로필보기 사용자아이디
		String user_id = req.getParameter("user_id");//로그인된 사용자아아디
		System.out.println("ot_nick"+ot_nick);
		
		InfoVO other_pro = sqlSession.getMapper(StudyDAOImpl.class).other_profile(ot_nick);
		
		if(other_pro.getInfo_nick()!=null) {
			model.addAttribute("ot", other_pro);//배열에 담아주기
		}
		return "studyRoom/openProfile";
	}
	
//	//신고와 차단
	@RequestMapping("/class/studyBlock.do")
	@ResponseBody
	public Map<String, Object> studyBlock(HttpServletRequest req, Model model, HttpSession session) {
		System.out.println("차단리스트 불러오기");
		Map<String, Object> map = new HashMap<String, Object>();
		String ot_nick = req.getParameter("ot_nick").toString();
		String user_id = session.getAttribute("user_id").toString();
		
		//닉네임으로 정보체크
		InfoVO other_pro = sqlSession.getMapper(StudyDAOImpl.class).other_profile(ot_nick);
		
//		Integer blockCheck = 
		//		blockList.contains("ot_nick");
		//null에러 방지를 위해 전체를 if문에 넣어줌
		if(sqlSession.getMapper(StudyDAOImpl.class).check_bolck(other_pro.getUser_id(), user_id)==null) {
			System.out.println("차단유저 아님, 다음진행");
		}
		else {
			System.out.println(ot_nick+"차단유저의 메세지 전송됨");
			map.put("check", 1);
		}
		return map;
	}
	
	
}
