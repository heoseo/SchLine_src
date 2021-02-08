package kosmo.project3.schline;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
	public String studyRoom (HttpSession session, Model model) {
		
		String user_id = "201701700";
//		String user_id = session.getAttribute("user_id");
		//로그인회원 프로필 불러오기
		InfoVO loginPeople = sqlSession.getMapper(StudyDAOImpl.class).user_nick(user_id);
		//내랭킹, 접속시간
		System.out.println("로그인회원 닉네임 = "+ loginPeople.getInfo_nick());
		System.out.println("로그인회원 아이디 = "+ loginPeople.getUser_id());
		System.out.println("로그인회원 사진 = "+ loginPeople.getInfo_img());
		System.out.println("로그인회원 접속시간 = "+ loginPeople.getInfo_time());
//		System.out.println("로그인회원 랭킹 = "+ loginPeople.get());
		
		//세션영역에 닉네임과 이미지 저장
		session.setAttribute("user_id", user_id);//나중에 지우기!
		session.setAttribute("info_nick", loginPeople.getInfo_nick());
		session.setAttribute("info_img", loginPeople.getInfo_img());
		//파라미터전송을 위해 모델객체에 로그인회원정보 저장
		model.addAttribute("info_nick", loginPeople.getInfo_nick());
		model.addAttribute("user_id", loginPeople.getUser_id());
		model.addAttribute("info_img", loginPeople.getInfo_img());
		model.addAttribute("info_time", loginPeople.getInfo_time());
		model.addAttribute("info_atten", loginPeople.getInfo_atten());
		//나의 랭킹순위 전달하기
//		model.addAttribute("my_lank", );
		
		//전체회원 리스트 불러오기 및 랭킹매기기
		ArrayList<InfoVO> LankList = sqlSession.getMapper(StudyDAOImpl.class).lank_list();
		model.addAttribute("LankList",LankList);
		
		//내 접속시간 및 랭킹 가져오기
//		int MyLank = sqlSession.getMapper(StudyDAOImpl.class).my_lank(user_id);
//		System.out.println("내랭킹"+MyLank);
//		model.addAttribute(MyLank);//반환된 내 랭킹 담아주기
		
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
	public String studyRoomChatGo(Model model, HttpServletRequest req, HttpSession session) {
		
		String user_id = session.getAttribute("user_id").toString();
//		String user_id = session.getAttribute("user_id");
		
		//접속수 올리기
		
		
		//로그인회원 프로필 불러오기
		InfoVO loginPeople = sqlSession.getMapper(StudyDAOImpl.class).user_nick(user_id);
		System.out.println("로그인회원 닉네임 = "+ loginPeople.getInfo_nick());
		
		
		
		//세션영역에 닉네임과 이미지 저장
//		session.setAttribute("info_nick", loginPeople.getInfo_nick());
//		session.setAttribute("info_img", loginPeople.getInfo_img());
		//파라미터전송을 위해 모델객체에 로그인회원정보 저장
		model.addAttribute("info_nick", loginPeople.getInfo_nick());
		model.addAttribute("user_id", loginPeople.getUser_id());
		model.addAttribute("info_img", loginPeople.getInfo_img());
		
		//전체회원 정보 다 불러와서 넘겨줘야할듯...
		System.out.println("가입된 회원프로필 불러오기");
		
		//전체회원 리스트 불러오기
		ArrayList<InfoVO> studyList = sqlSession.getMapper(StudyDAOImpl.class).study_list();
		
		System.out.println("전체리스트 모델객체에 담기");
		model.addAttribute("studyList", studyList);
		
		return "studyRoom/studyRoomGo";
	}
	
	
	//프로필수정 팝업 ajax페이지 불러오기
	@RequestMapping("/sudtyRoom/profileAjax.do")
	public String profileAjax() {
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
			//////파일 업로드//////
			//서버의 풀리적 경로 얻어오기
			String path = req.getSession().getServletContext().getRealPath("/resources/profile_image");
			System.out.println("path="+path);
			
			//스프링에서는 파일이름 getFileNames() 으로 가지고온다!!
			if(req.getFileNames()==null){//null에러방지 처리
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
				
				Iterator<String> itr = req.getFileNames();//변경한 이미지
				while(itr.hasNext()) {
					//파일업로드 위한 멀티파트 객체 생성
					MultipartFile mfile = null;
					//전송된 파일의 이름을 읽어온다
					change_img = (String)itr.next();
					mfile = req.getFile(change_img);
					System.out.println("파일이름="+mfile);
					
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
		System.out.println("시간저장 함수호출");
		//10초마다 정보저장해주는 함수 호출
		String user_id = (String)session.getAttribute("user_id");
		System.out.println("아이디="+user_id);
		//null값이 전송된다!!!
		int time = Integer.parseInt(req.getParameter("send_time").toString());
		System.out.println(time);
//		Double time = Double.parseDouble(req.getParameter("send_time"));
		System.out.println("send_time="+time);
		//System.out.println(str.getClass().getName()); //변수타입 출력
		
		int result= sqlSession.getMapper(StudyDAOImpl.class).study_time(user_id, time);
		System.out.println("결과값ㅅ"+result);
		if(result==1) {
			System.out.println("시간저장 성공");
			map.put("setTime", 1);
		}
		return map;
	}
	
	//ajax로 내용 저장
	//채팅내용전송시 자동저장
	@RequestMapping("/class/chatSave.do")
	@ResponseBody //이건 왜 붙이는거쥬 ? 값만 보낼때 쓰는거같음
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
	
	
}
