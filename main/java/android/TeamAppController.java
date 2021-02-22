package android;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

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

import schline.ExamBoardDTO;
import schline.SchlineDAOImpl;
import schline.UserVO;

@Controller
public class TeamAppController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/android/teamList.do")
	@ResponseBody
	public ArrayList<ExamBoardDTO> teamList(HttpServletRequest req){
		System.out.println("팀리스트 요청 들어옴");

		String user_id = req.getParameter("user_id");
		System.out.println(user_id);
		String subject_idx = req.getParameter("subject_idx");
		System.out.println(subject_idx);
		String team_num = sqlSession.getMapper(SchlineDAOImpl.class).getTeamNum(user_id, subject_idx);
		System.out.println("팀번호:"+team_num);
	
		ArrayList<ExamBoardDTO> teamlist = 
				sqlSession.getMapper(SchlineDAOImpl.class).teamList2(subject_idx, team_num);

		return teamlist;
	}
	
	@RequestMapping("/android/teamView.do")
	@ResponseBody
	public Map<String, Object> teamView(HttpServletRequest req){
		System.out.println("팀뷰 요청 들어옴");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String board_idx = req.getParameter("board_idx");
		
		ExamBoardDTO dto = sqlSession.getMapper(SchlineDAOImpl.class).getView(board_idx);
		UserVO uvo = sqlSession.getMapper(SchlineDAOImpl.class).getuserName(dto.getUser_id());

		String user_name = uvo.getUser_name();

		//dto.setBoard_content(dto.getBoard_content().replaceAll("\r\n", "<br/>"));
		
		map.put("board_idx", board_idx);
		map.put("user_name", user_name);
		map.put("subject_idx", dto.getSubject_idx());
		map.put("board_title", dto.getBoard_title());
		map.put("board_content", dto.getBoard_content());
		map.put("board_postdate", dto.getBoard_postdate());
		map.put("team_num", dto.getTeam_num());
		if(dto.getBoard_file()!=null) {
			map.put("board_file", dto.getBoard_file());
		}

		map.put("user_id", dto.getUser_id());
		
		return map;
	}
	
	@RequestMapping("/android/teamdownload.do")
	@ResponseBody
	public Map<String, Object> teamdownload(HttpServletRequest req){
		
		System.out.println("다운로드 요청 들어옴");
		
		String path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile/team");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("path", path);
		
		return map;
	}
	
	///////////////////////////////////////////////
	//안드로이드에서 업로드 처리
	///////////////////////////////////////////////
	@RequestMapping(value="/android/teamUpload.do", method=RequestMethod.POST)
	@ResponseBody
	public Map uploadAndroid(Model model, MultipartHttpServletRequest req)
	{
	
	System.out.println("협업업로드 요청 들어옴");
	//서버의 물리적경로 얻어오기
	String path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile/team");
	System.out.println(path);
	
	//과목idx
	String subject_idx = req.getParameter("subject_idx");
	System.out.println("과목코드:"+subject_idx);

	
	//폼값과 파일명을 저장후 View로 전달하기 위한 맵 컬렉션
	Map returnObj = new HashMap();
	int fileUp = 0;
	try {
		//업로드폼의 file속성의 필드를 가져온다..(2개)
		
		//파일명 반복을 위해 Iterator 선언
		Iterator itr = req.getFileNames();
		
		MultipartFile mfile = null;
		String fileName = "";
//		List resultList = new ArrayList();
		
		//파일외에 폼값 받음.
		//subject_idx = req.getParameter("subject_idx"); //과목idx
		
		String user_id = req.getParameter("user_id"); //아이디
		System.out.println("아이디:"+user_id);
		String board_title = req.getParameter("board_title"); //과제물작성제목
		String board_content = req.getParameter("board_content"); //과제물작성내용
		System.out.println("제목:"+board_title+" 내용:"+board_content);
		
		String team_num = sqlSession.getMapper(SchlineDAOImpl.class).getTeamNum(user_id, subject_idx);
		System.out.println("팀번호: "+team_num);
		
		//폼값 출력 테스트
		System.out.printf("subject_idx=%s,user_id=%s,"
				+ "board_title=%s,board_content=%s"
				, subject_idx, user_id, board_title, board_content);
		/*
		물리적경로를 기반으로 File객체를 생성한 후 지정된 디렉토리가
		있는지 확인한다. 만약 없다면 mkdirs()로 생성한다.
		 */
		File directory = new File(path);
		if(!directory.isDirectory()) {
			directory.mkdirs();
		}
		String saveFileName = null;
		
		if(itr.hasNext()==false) {
			
			//DB에 insert하기...
			fileUp = sqlSession.getMapper(SchlineDAOImpl.class)
					.teamWrite2(subject_idx, user_id, board_title, board_content, team_num);
			System.out.println("업로드결과:"+fileUp);
			returnObj.put("success", fileUp);
		}
		else {
			//업로드폼의 file필드 갯수만큼 반복
			while(itr.hasNext()) {
				System.out.println("반복문진입하나요?");
				//전송된 파일의 이름을 읽어온다.
				fileName = (String)itr.next();
				mfile = req.getFile(fileName);
				System.out.println("mfile="+mfile);
				//한글깨짐방지 처리후 전송된 파일명을 가져옴
				String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");
	
				
				if("".equals(originalName)) {
					saveFileName = "";
				}
				else {
					//파일명에서 확장자를 가져옴.
					String ext = originalName.substring(originalName.lastIndexOf("."));
					//확장자를 제외한 파일명(학생이 제출한 파일명)
					String userFileName = originalName.substring(0, originalName.lastIndexOf("."));
					
					//과제이름+학번+제출명으로 합치기(팀명으로 변경필요)
					saveFileName = "("+user_id+")"+userFileName + ext;
					System.out.println("파일명 : "+saveFileName);
					
					//물리적 경로에 새롭게 생성된 파일명으로 파일저장
					File serverFullName = new File(path + File.separator + saveFileName);
					
					mfile.transferTo(serverFullName);
					
				}
			}
			//DB에 insert하기...
			fileUp = sqlSession.getMapper(SchlineDAOImpl.class)
					.teamWrite(subject_idx, user_id, board_title, board_content, saveFileName, team_num);
			System.out.println("업로드결과:"+fileUp);
			returnObj.put("success", fileUp);
			}
		}
		catch(IOException e) {
			//파일업로드에 실패했을때
			returnObj.put("success", 0);
			e.printStackTrace();
		}
		catch(Exception e) {
			returnObj.put("success", 0);
			e.printStackTrace();
		}
		return returnObj;
	}/*
		안드로이드에서 사진을 업로드 한후 결과를 받아야 하므로
		기존 View를 호출하는 부분에서 JSON데이터를 반환하는 형태로
		변경한다.
	*/
	
	
	@RequestMapping(value="/android/teamEditAction.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> teamEditAction(MultipartHttpServletRequest req) {
		System.out.println("수정페이지 진입");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//경로 받아오기
		String path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile/team");
		System.out.println(path);
		 
		//과목idx
		String board_idx = req.getParameter("board_idx");
		System.out.println("게시물idx:"+board_idx);
		ExamBoardDTO dto = sqlSession.getMapper(SchlineDAOImpl.class).getView(board_idx);
		
		String board_file = dto.getBoard_file();
		System.out.println("db파일명:"+board_file+" 과목인덱스:"+dto.getSubject_idx());
		int subject_idx = dto.getSubject_idx();

		int fileUp = 0;
		try {
			
			String user_id = req.getParameter("user_id"); //아이디
			String board_title = req.getParameter("board_title"); //제목
			String board_content = req.getParameter("board_content"); //내용
				
			MultipartFile mfile = req.getFile("filename");
			System.out.println("mfile="+mfile);
			
			//한글깨짐방지 처리후 전송된 파일명을 가져옴
			if(mfile!=null) {
				
				String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");
				System.out.println("originalfile="+originalName);
			
				System.out.println("파일수정");
				//폼값 출력 테스트
				System.out.printf("user_id=%s, board_title=%s,"
						+ "board_content=%s, board_file=%s, new_file=%s"
						, user_id, board_title, board_content, board_file, originalName);
				
				String saveFileName = null;
				//파일명에서 확장자를 가져옴.
				String ext = originalName.substring(originalName.lastIndexOf("."));
				//확장자를 제외한 파일명(학생이 제출한 파일명)
				String userFileName = originalName.substring(0, originalName.lastIndexOf("."));
				
				//과제이름+학번+제출명으로 합치기(팀명으로 변경필요)
				saveFileName = "("+user_id+")"+userFileName + ext;
				System.out.println("파일명 : "+saveFileName);
				
				//물리적 경로에 새롭게 생성된 파일명으로 파일저장
				File serverFullName = new File(path + File.separator + saveFileName);
				
				mfile.transferTo(serverFullName);
				
				//DB에 update하기...
				fileUp = sqlSession.getMapper(SchlineDAOImpl.class)
						.teamFileEdit(board_idx, board_title, board_content, saveFileName);
				
				//기존파일 삭제처리
				deleteFile(path, board_file);
					
			}
			else {
				System.out.println("수정파일없음");
				fileUp = sqlSession.getMapper(SchlineDAOImpl.class)
						.teamEdit(board_idx, board_title, board_content);
			}
		}
		catch(IOException e) {
			e.printStackTrace();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println("수정여부:"+fileUp);
		
		if(fileUp!=0) {
			map.put("success", fileUp);
		}
		else {
			map.put("success", 0);
		}
		
		return map;
	}
	
	
	
	@RequestMapping("/android/teamDelete.do")
	@ResponseBody
	public Map<String, Object> teamDelete(HttpServletRequest req) {
		System.out.println("삭제요청들어옴");
		Map<String, Object> map = new HashMap<String, Object>();
		
		String user_id = req.getParameter("user_id"); //아이디
		String board_idx = req.getParameter("board_idx");
		String board_file = req.getParameter("board_file");
		System.out.println("파일:"+board_file);
		System.out.println(user_id+"  "+board_idx);
		int result = sqlSession.getMapper(SchlineDAOImpl.class).teamDelete(board_idx, user_id);
		System.out.println("결과값:"+result);
		if(board_file!=null||!board_file.equals("")) {
			String path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile/team");
			
			deleteFile(path, board_file);
		}
		
		if(result==1) {
			map.put("success", result);	
		}
		else {
			map.put("success", 0);
		}
		
		return map;
	}
	
	//파일삭제 메소드
	public static void deleteFile(String directory, String filename) {
		 
		System.out.println(directory+"   "+filename);
		//경로 + 파일명
		File f = new File(directory+File.separator+filename);
		//파일이 존재한다면 삭제
		if(f.exists()) {f.delete();}
	}
}
