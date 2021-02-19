package android;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
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

import schline.ExamDTO;
import schline.SchlineDAOImpl;

@Controller
public class ExamAppController {
	
	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/android/taskList.do")
	@ResponseBody
	public ArrayList<ExamDTO> taskList(HttpServletRequest req){
		
		System.out.println("과제리스트 요청 들어옴");

		String user_id = req.getParameter("user_id");
		System.out.println(user_id);
		String subject_idx = req.getParameter("subject_idx");
		System.out.println(subject_idx);
		String exam_type = "1";
		
		ArrayList<ExamDTO> tasklist = 
				sqlSession.getMapper(SchlineDAOImpl.class).tasklist(exam_type, subject_idx, user_id);

		
		return tasklist;
	}
	
	
	///////////////////////////////////////////////
	//안드로이드에서 업로드 처리
	///////////////////////////////////////////////
	@RequestMapping(value="/android/taskUpload.do", method=RequestMethod.POST)
	@ResponseBody
	public Map uploadAndroid(Model model, MultipartHttpServletRequest req)
	{
	
	System.out.println("과제업로드 요청 들어옴");
	//서버의 물리적경로 얻어오기
	String path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile/task");
	System.out.println(path);
	//파일 insert 결과를 확인하기 위한 수
	int fileUp = 0;
	
	//폼값과 파일명을 저장후 View로 전달하기 위한 맵 컬렉션
	Map returnObj = new HashMap();
	try {
		//업로드폼의 file속성의 필드를 가져온다.(여기서는 2개임)
		Iterator itr = req.getFileNames();
		
		MultipartFile mfile = null;
		String fileName = "";
		String saveFileName = "";
		//파일외에 폼값 받음.
		String subject_idx = req.getParameter("subject_idx"); //과목idx
		String exam_idx = req.getParameter("exam_idx");//과제번호
		String user_id = req.getParameter("user_id"); //아이디
		String board_title = req.getParameter("board_title"); //과제물작성제목
		String board_content = req.getParameter("board_content"); //과제물작성내용
		String exam_name = req.getParameter("exam_name"); //과제명
		
		System.out.printf("subject_idx=%s,user_id=%s,exam_name=%s,"
				+ "board_title=%s,board_content=%s,exam_idx=%s"
				, subject_idx, user_id, exam_name, board_title, board_content, exam_idx);
		
		
		/*
		물리적경로를 기반으로 File객체를 생성한 후 지정된 디렉토리가
		있는지 확인한다. 만약 없다면 mkdirs()로 생성한다.
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
			String originalName = new String(mfile.getOriginalFilename().getBytes(), "UTF-8");
			//서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
			if("".equals(originalName)) {
				continue;
			}
			//파일명에서 확장자를 가져옴.
			String ext = originalName.substring(originalName.lastIndexOf("."));
			//확장자를 제외한 파일명(학생이 제출한 파일명)
			String userFileName = originalName.substring(0, originalName.lastIndexOf("."));
			
			//과제이름+학번+제출명으로 합치기
			saveFileName = "("+exam_name+"-"+user_id+")"+userFileName + ext;
			System.out.println("파일명 : "+saveFileName);
			
			//물리적 경로에 새롭게 생성된 파일명으로 파일저장
			File serverFullName = new File(path + File.separator + saveFileName);
			
			mfile.transferTo(serverFullName);
			
			//DB에 insert하기...
			fileUp = sqlSession.getMapper(SchlineDAOImpl.class)
				.taskWrite(subject_idx, user_id, board_title, board_content, saveFileName, exam_idx);
			
		}
			returnObj.put("files", saveFileName);
			returnObj.put("success", 1);
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
	

}
