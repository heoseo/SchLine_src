package android;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kosmo.project3.schline.StudyRoomController;
import studyroom.InfoVO;
import studyroom.StudyDAOImpl;

////안드로이드 공부방 컨트롤러
@Controller
public class StudyController {
	
	public StudyController() {
		System.out.println("안드로이드 공부방 생성자 호출");
	}
	
	//Mybatis 사용을위한 자동주입
	@Autowired
	private SqlSession sqlSession;
	
	//로그인된 회원정보 JSONObject로 반환
	//커맨드 객체를 통해 한번에 정보주입
	@RequestMapping("/android/class/study.do")
	@ResponseBody
	public Map<String, Object> study(HttpServletRequest req, InfoVO infoVO){
		System.out.println("모바일 공부방 컨트롤러");
		Map<String, Object> map = new HashMap<String, Object>();
		
		//InfoVO infoVO = new InfoVO();
		infoVO.setUser_id(req.getParameter("user_id"));
		System.out.println("안스user_id="+req.getParameter("user_id"));
		
		InfoVO user = sqlSession.getMapper(StudyDAOImpl.class).login_info(infoVO);
		
		//프로필 이미지 서버의 물리적 경로 불러오기
		String path = req.getSession().getServletContext().getRealPath("/resources/profile_image");
		
		map.put("image", path+user.getInfo_img());
		
		//경로를 기반으로 파일객체 생성
		File file = new File(path);
		//파일의 목록을 배열형태로 얻어옴
		File[] fileArray = file.listFiles();
		
		for(File f : fileArray) {
			if(f.getName().equals(user.getUser_id()+"_img")) {
				map.put("img", path+user.getUser_id()+"_img"+File.separator);
				//Map의 key로 파일명, value로 파일용량을 저장
				map.put(f.getName(), (int)Math.ceil(f.length()/1024.0));
			}
		}
		//로그인 회원 정보를 map에 담기
		map.put("user", user);
		
		return map;
	}
	
	
	
	@RequestMapping("/android/class/studyLank.do")
	@ResponseBody
	public ArrayList<InfoVO> lankList(HttpServletRequest req){
		
		//전체회원 리스트 불러오기 및 랭킹매기기
		ArrayList<InfoVO> LankList = sqlSession.getMapper(StudyDAOImpl.class).lank_list();
		
		return LankList;
	}
	
	
//	@RequestMapping("/android/class/study.do")
//	@ResponseBody
//	public Map<String, Object> study(HttpServletRequest req, Principal principal){
//		Map<String, Object> map = new HashMap<String, Object>();
//		
//		//시큐리티 유저 아이디 얻어오기
//		String user_id = principal.getName();
//		System.out.println("시큐리티 유저아이디="+user_id);
//		
//		InfoVO user = sqlSession.getMapper(StudyDAOImpl.class).user_nick(user_id);
//		//로그인 회원 정보를 map에 담기
//		map.put("user", user);
//		
//		return map;
//	}
	
	@RequestMapping("/android/class/studyChat.do")
	public Map<String, Object> studyChat(InfoVO infoVO){
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("모바일 채팅방 이동");
		
		//로그인회원 프로필 불러오기
		InfoVO user = sqlSession.getMapper(StudyDAOImpl.class).login_info(infoVO);
		map.put("user", user);
		
		//전체회원 리스트 불러오기
		ArrayList<InfoVO> studyList = sqlSession.getMapper(StudyDAOImpl.class).study_list();
		map.put("studyList", studyList);
		
		return map;
	}
	
	
//안드로이드 파일업로드 - 기존 업로드 컨트롤러 사용
//////////////////////////////////////////


/*
안드로이드에서 사진을 업로드 한후 결과를 받아야 하므로
기존 View를 호출하는 부분에서 JSON데이터를 반환하는 형태로
변경한다.
*/



//파일목록보기
@RequestMapping("/fileUpload/uploadList.do")
public String uploadList(HttpServletRequest req, Model model) {
//서버의 물리적경로 얻어오기
String path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile");
//경로를 기반으로 파일객체 생성
File file = new File(path);
//파일의 목록을 배열형태로 얻어옴
File[] fileArray = file.listFiles();
//뷰로 전달할 파일목록을 저장하기 위해 Map생성
Map<String, Integer> fileMap = new HashMap<String, Integer>();
for(File f : fileArray) {
//Map의 key로 파일명, value로 파일용량을 저장
fileMap.put(f.getName(), (int)Math.ceil(f.length()/1024.0));//kb단위출력(1024로 나눳으니!)
}

model.addAttribute("fileMap", fileMap);
return "06FileUpload/uploadList";
}




//선생님 코드
@RequestMapping(value = "/android/class/editProfile.do", method = RequestMethod.POST)
@ResponseBody //@ResponseBody 사용할려면 반환값 - 컬렉션
public Map uploadAndroid(Model model, MultipartHttpServletRequest req)
{	
	//서버의 물리적경로 얻어오기
	String path = req.getSession().getServletContext().getRealPath("/resources/profile_image");
	String user_id = req.getParameter("user_id");
	//폼값과 파일명을 저장후 View로 전달하기 위한 맵 컬렉션
	Map returnObj = new HashMap();
	
	try {
		
		//업로드폼의 file속성의 필드를 가져온다.(여기서는 2개임)
		Iterator itr = req.getFileNames();
		
		MultipartFile mfile = null;
		String fileName = "";
		List resultList = new ArrayList();
		//파일외에 폼값 받음.
		String title = req.getParameter("title");
		System.out.println("title="+title);
		
		/*
		물리적경로를 기반으로 File객체를 생성한 후 지정된 디렉토리가
		있는지 확인한다. 만약 없다면 mkdir()로 생성한다.
		 */
		File directory = new File(path);
		if(!directory.isDirectory()) {
			directory.mkdirs();
		}
		
		//업로드폼의 file필드 갯수만큼 반복
		while(itr.hasNext()) {
			//전송된 파일의 이름을 읽어온다.
			fileName = (String)itr.next();
			mfile = req.getFile(fileName);
			System.out.println("mfile="+mfile);
			
			//한글깨짐방지 처리후 전송된 파일명을 가져옴
			String originalName = 
					new String(mfile.getOriginalFilename().getBytes(),"UTF-8");
			//서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
			if("".equals(originalName)) {
				continue;
			}
			
			//파일명에서 확장자를 가져옴.
			String ext = originalName.substring(originalName.lastIndexOf('.'));
			//UUID를 통해 생성된 문자열과 확장자를 합쳐서 파일명 완성
			String saveFileName = user_id+"_img" + ext;
			//물리적 경로에 새롭게 생성된 파일명으로 파일저장
			File serverFullName = new File(path + File.separator + saveFileName);
			
			mfile.transferTo(serverFullName);
			
			Map file = new HashMap();
			//원본 파일명
			file.put("originalName", originalName);
			//저장된 파일명
			file.put("saveFileName", saveFileName);
			//서버의 전체경로
			file.put("serverFullName", serverFullName);
			//제목
			file.put("title", title);
			
			//위 4가지 정보를저장한 Map을 ArrayList에저장한다.
			resultList.add(file);
		}
		//파일업로드에 성공했을때
		returnObj.put("files", resultList);
		returnObj.put("success", 1);//안드로이드 추가부분
	}
	catch (IOException e) {
		//파일업로드에 실패했을때
		returnObj.put("success", 0);//안드로이드 추가부분
		e.printStackTrace();
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	//맵 반환
	return returnObj;//안드로이드 추가부분
}/*
	안드로이드에서 사진을 업로드 한후 결과를 받아야 하므로
	기존 View를 호출하는 부분에서 JSON데이터를 반환하는 형태로
	변경한다.
*/




//@RequestMapping(value = "/android/class/editProfile.do", method = RequestMethod.POST)
//@ResponseBody
public Map<String, Object> editInfo(Principal principal, Model model, MultipartHttpServletRequest req) 
{
	//결과값 반환을 위한 Map 생성
	Map<String, Object> checkMap = new HashMap<String, Object>();
	System.out.println("프로필 수정 시작");
	
	//String user_id = req.getParameter("user_id");//학번
	String user_id = principal.getName();
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
//		if(req.getFile().equals("")){//null에러방지 처리
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
			
			StudyRoomController st = new StudyRoomController();
			//기존이미지 삭제처리
			st.deleteFile(path, info_img);
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



	
	
}
