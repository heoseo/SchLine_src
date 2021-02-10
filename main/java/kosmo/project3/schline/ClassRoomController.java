package kosmo.project3.schline;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import schline.AttendanceDTO;
import schline.ClassDTO;
import schline.ClassDTOImpl;
import schline.PenBbsDTO;
import schline.PenJdbcConst;
import schline.PenJdbcDAO;
import schline.VideoDTO;
import schline.command.BbsCommandImpl;
import schline.command.DeleteActionCommand;
import schline.command.EditActionCommand;
import schline.command.EditCommand;
import schline.command.ListCommand;
import schline.command.ReplyActionCommand;
import schline.command.ReplyCommand;
import schline.command.ViewCommand;
import schline.command.WriteActionCommand;

@Controller
public class ClassRoomController {
	@Autowired
	private SqlSession sqlSession;
	
	private JdbcTemplate template;
	
	@Autowired
	public void setTemplate(JdbcTemplate template) {
		this.template = template;
		System.out.println("@Autowired=>JdbcTemplate 연결성공");
		//JdbcTemplate을 해당 프로그램 전체에서 사용하기 위한 설정
		PenJdbcConst.template = this.template;
	}
	
	
	//강의실 눌렀을 때 코스로 이동
	//로그인 끝나면 session 매개변수 상용
	@RequestMapping("/main/class.do")
	public String calssRoom(Model model, HttpSession session) {
		
		ClassDTO classdto = new ClassDTO();
		classdto.setUser_id(session.getAttribute("user_id").toString());
		ArrayList<ClassDTO> lists =  sqlSession.getMapper(ClassDTOImpl.class).listCourse(classdto);
		/*디버깅용
		String sql = sqlSession.getConfiguration().getMappedStatement("listCourse")
				.getBoundSql(ClassDTO).getSql();
		System.out.println("sql="+sql);
		 */
		model.addAttribute("lists", lists);
		return "classRoom/course";
	}
	//학생 강의 영상리스트
	@RequestMapping("/class/time.do")
	public String lecture(Model model,  HttpServletRequest req) {
		VideoDTO videoDTO = new VideoDTO();
		videoDTO.setSubject_idx(req.getParameter("subject_idx"));
		ArrayList<VideoDTO> lists = sqlSession.getMapper(ClassDTOImpl.class).listLecture(videoDTO);
		
		model.addAttribute("lists", lists);
		return "classRoom/lecture";
	}
	//교수용 강의 영상리스트 로그인 되면 세션에서 받아와.
	@RequestMapping("/professor/video.do")
	public String vidlist(Model model, HttpServletRequest req, HttpSession session) {
		String user_id = session.getAttribute("user_id").toString();
		ArrayList<VideoDTO> fileMap = sqlSession.getMapper(ClassDTOImpl.class).listVideo(user_id);
		String subject_idx = sqlSession.getMapper(ClassDTOImpl.class).whatsub_id(user_id);
		model.addAttribute("fileMap",fileMap);
		model.addAttribute("subject_idx",subject_idx);
		return "professor/videoUD";
		
	}
	@RequestMapping("/class/play.do")
	public String play(Model model,  HttpServletRequest req, HttpSession session) {
		
		String video_title = req.getParameter("title");
		String name = req.getParameter("name");
		String idx = req.getParameter("idx");
		String sub_idx = req.getParameter("sub_idx");
		String user_id = session.getAttribute("user_id").toString();
		
		AttendanceDTO dto = sqlSession.getMapper(ClassDTOImpl.class).selectat(user_id, idx);
		model.addAttribute("video_title", video_title);
		model.addAttribute("name", name);
		model.addAttribute("idx", idx);
		model.addAttribute("dto", dto);
		model.addAttribute("sub_idx", sub_idx);
		return "classRoom/video";
	}
	@RequestMapping("/professor/videowrite.do")
	public String videowrite(Model model, HttpServletRequest req) {
		String subject_idx = req.getParameter("subject_idx");
		model.addAttribute("subject_idx",subject_idx);
		return "professor/vidwrite";
	}
	//비디오 업로드 
	public static String getUuid() {
		String uuid = UUID.randomUUID().toString();
		System.out.println("생성된 UUID-1:"+uuid);
		uuid = uuid.replaceAll("-", "");
		System.out.println("생성된 UUID-2:"+uuid);
		return uuid;
	}
	@RequestMapping(value ="/professor/videoupload.do",method=RequestMethod.POST)
	public String vidUpload(Model model, MultipartHttpServletRequest req, HttpServletRequest request) {
		String subject_idx = request.getParameter("subject_idx");
		String end_date = request.getParameter("end_date");
		String title = request.getParameter("title");
		String path =
				req.getSession().getServletContext().getRealPath("/resources/video");
		System.out.println("path:"+path);
		try {
			Iterator itr = req.getFileNames();
			MultipartFile mfile = null;
			String fileName ="";
			String originalName ="";
			String saveFilename = "";
			File directory = new File(path);
			if(!directory.isDirectory()) {//디렉토리가 존재하지 않을시 생성
				directory.mkdir();
			}
			//파일 필드 갯수만큼 반복
			while (itr.hasNext()) {
				//전송된 파일의 이름을 읽어온다.
				fileName = (String)itr.next();
				mfile = req.getFile(fileName);
				System.out.println("mfile="+mfile);
				//한글깨짐 방지 처리후 전송된 파일명을 가져옴
				 originalName = new String(mfile.getOriginalFilename().getBytes(),"UTF-8");
				 System.out.println("originalName="+originalName);
				if("".equals(originalName)) {
					//서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
					continue;
				}
				String ext =
						originalName.substring(originalName.lastIndexOf('.'));
					//uuid를 통해 생성된 문자열과 확장자를 합쳐서 파일명 완성
					 saveFilename = getUuid() + ext;
					File serverFullName =
							new File(path+File.separator+saveFilename);
					mfile.transferTo(serverFullName);
		
				
				
			}
			sqlSession.getMapper(ClassDTOImpl.class).upvid(subject_idx, end_date, title,saveFilename);
			//학생 리스트 가져오고 디비 업뎃
		   
			String video_idx = sqlSession.getMapper(ClassDTOImpl.class).getVideoIdx(saveFilename);
			attendanceInsert(subject_idx, video_idx);
			
			
			
		}catch (IOException e) {
			e.printStackTrace();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:video.do";
	}
	public  void attendanceInsert(String subject_idx, String video_idx) {
		AttendanceDTO attendanceDTO = new AttendanceDTO();
		attendanceDTO.setVideo_idx(video_idx);
		String[] students =sqlSession.getMapper(ClassDTOImpl.class).StuList(subject_idx);
		for(String str : students) {
			attendanceDTO.setUser_id(str);
			sqlSession.getMapper(ClassDTOImpl.class).AttandanceInsDB(attendanceDTO);			
		}
		
		
		
	}
	@RequestMapping("/professor/vidmodify.do")
	public String gomodi(Model model, HttpServletRequest req) {
		String idx = req.getParameter("idx");
		VideoDTO videoDTO =
		sqlSession.getMapper(ClassDTOImpl.class).modilist(idx);
		
		model.addAttribute("videoDTO", videoDTO);
		return "professor/vidupdate";
	}
	@RequestMapping(value = "/professor/vidmodifyAction.do", method = RequestMethod.POST)
	public String modiaction(MultipartHttpServletRequest req, HttpServletRequest request) {
		String video_idx = request.getParameter("video_idx");
		String end_date = request.getParameter("end_date");
		String before = request.getParameter("before");
		String title = request.getParameter("title");
		String path =
				req.getSession().getServletContext().getRealPath("/resources/video");
		try {
			Iterator itr = req.getFileNames();
			MultipartFile mfile = null;
			String fileName ="";
			String originalName ="";
			String saveFilename = "";
			while (itr.hasNext()) {
				//전송된 파일의 이름을 읽어온다.
				fileName = (String)itr.next();
				mfile = req.getFile(fileName);
				//한글깨짐 방지 처리후 전송된 파일명을 가져옴
				 originalName = new String(mfile.getOriginalFilename().getBytes(),"UTF-8");
				 System.out.println("originalName="+originalName);
				 File befile = new File(path+File.separator+before);
				 if( befile.exists() && befile.isFile()) {
					 befile.delete();					 
				 }
				if("".equals(originalName)) {
					//서버로 전송된 파일이 없다면 while문의 처음으로 돌아간다.
					continue;
				}
				String ext =
						originalName.substring(originalName.lastIndexOf('.'));
					//uuid를 통해 생성된 문자열과 확장자를 합쳐서 파일명 완성
					 saveFilename = getUuid() + ext;
					 before = saveFilename;
					File serverFullName =
							new File(path+File.separator+saveFilename);
					mfile.transferTo(serverFullName);
		
				
				
			}
			sqlSession.getMapper(ClassDTOImpl.class).modivid(video_idx, end_date, title,before);
			
	 
			
			
			
		}catch (IOException e) {
			e.printStackTrace();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:video.do";
	}
	//교수페이지 강의 삭제
	@RequestMapping("/professor/deletevid.do")
	public String removeVid(HttpServletRequest request) {
		String path =
				request.getSession().getServletContext().getRealPath("/resources/video");
		String idx = request.getParameter("idx");
		String saved = request.getParameter("saved");
		try {
			File file = new File(path+File.separator+saved);
			 if( file.exists() && file.isFile()) {
				 file.delete();					 
			 }
			 
		}catch (Exception e) {
			e.printStackTrace();
		}
		sqlSession.getMapper(ClassDTOImpl.class).delAttendance(idx);
		sqlSession.getMapper(ClassDTOImpl.class).deletevid(idx);
		
		return "redirect:video.do";
	}
	
	
	//노란펜 캡쳐
	@ResponseBody
	@RequestMapping(value ="/yellow/ImgSave.do", method = RequestMethod.POST)
	public ModelMap ImgSaveTest(@RequestParam HashMap<Object, Object> param, final HttpServletRequest request, final HttpServletResponse response, HttpSession session) throws Exception {
		ModelMap map = new ModelMap();
		String user_id = session.getAttribute("user_id").toString();
		String title = request.getParameter("title");
		String binaryData = request.getParameter("imgSrc");
		FileOutputStream stream = null;
		try{
			System.out.println("binary file   "  + binaryData);
			if(binaryData == null || binaryData.trim().equals("")) {
			    throw new Exception();
			}
			binaryData = binaryData.replaceAll("data:image/png;base64,", "");
			Decoder decoder = Base64.getDecoder();
			//파일이름은 날짜+시간으로
			byte[] file = decoder.decode(binaryData);
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
			 Date nowdate = new Date();
			 String dateString = formatter.format(nowdate);
			String fileName=  dateString;
			//학번_note 폴더에  강의명 폴더(없으면 생성)
			File directory = new File("C:/"+user_id+"_note/"+title);
			if(!directory.isDirectory()) {//디렉토리가 존재하지 않을시 생성
				directory.mkdirs();
			}
			stream = new FileOutputStream(directory+File.separator+fileName+".png");
			System.out.println(stream);
			stream.write(file);
			stream.close();
			System.out.println("캡처 저장");
		    
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("에러 발생");
		}finally{
			if(stream != null) {
				stream.close();
			}
		}
		
		map.addAttribute("resultMap", "");
		return map;
	}
	
	//출석 디비 업데이트
		@RequestMapping("/class/atupdate.do")
		public void atupdate(HttpServletRequest req, HttpSession session) {
			String idx = req.getParameter("idx");
			String play = req.getParameter("play");
			String flag = req.getParameter("flag");
			String current = req.getParameter("current");
			AttendanceDTO dto = new AttendanceDTO();
			dto.setAttendance_flag(flag);
			dto.setCurrenttime(current);
			dto.setPlay_time(play);
			dto.setVideo_idx(idx);
			dto.setUser_id(session.getAttribute("user_id").toString());
			
			sqlSession.getMapper(ClassDTOImpl.class).atupdatedb(dto);
			
			 
		}
		BbsCommandImpl command = null;
		@RequestMapping("/penboard/list.do")
		public String penlist(Model model, HttpServletRequest req) {
			
			model.addAttribute("req", req);
			
			command = new ListCommand();
			command.execute(model);
			
			return "classRoom/penlist";
		}

		@RequestMapping("/penboard/write.do")
		public String write(HttpServletRequest req,Model model) {
			String sub_idx = req.getParameter("sub_idx");
			String time = req.getParameter("time");
			String vid_title = req.getParameter("vid_title");
			String flag = req.getParameter("flag");
			model.addAttribute("flag", flag);
			String title = vid_title +"_"+time;
			model.addAttribute("title",title);
			model.addAttribute("sub_idx",sub_idx);
			
			return "classRoom/penwrite";
		}
		@RequestMapping(value="/penboard/writeAction.do",
				method=RequestMethod.POST)
		public String writeAction(Model model, HttpServletRequest req, 
				PenBbsDTO penBbsDTO,HttpSession session) {
			//request객체를 모델에 저장
			penBbsDTO.setUser_id(session.getAttribute("user_id").toString());
			model.addAttribute("req", req);
			//View에서 전송한 폼값을 커맨드객체를 통해 저장후 model에 저장
			model.addAttribute("penBbsDTO", penBbsDTO);
			command = new WriteActionCommand();
			command.execute(model);
			String board_type = req.getParameter("board_type");
			return "redirect:list.do?nowPage=1&board_type="+board_type;
			
		}
		//게시물 상세보기
		@RequestMapping("/penboard/view.do")
		public String view(Model model, HttpServletRequest req)
		{
			model.addAttribute("req", req);
			command = new ViewCommand();
			command.execute(model);

			return "classRoom/penview";
		}
		//게시물 상세보기
		@RequestMapping("/penboard/editOrdel.do")
		public String editOrdelAction(Model model, HttpServletRequest req)
		{
			String modePage = null;
			
			String mode = req.getParameter("mode");
			String pen_idx = req.getParameter("pen_idx");
			String nowPage = req.getParameter("nowPage");
			
			PenJdbcDAO dao = new PenJdbcDAO();
			
			if(mode.equals("edit")) {
				model.addAttribute("req",req);
				command = new EditCommand();
				command.execute(model);
				
				
				
				modePage = "classRoom/penedit";
			}
			else if(mode.equals("delete"))
			{
				model.addAttribute("req",req);
				command = new DeleteActionCommand();
				command.execute(model);
				model.addAttribute("nowPage", nowPage);
				model.addAttribute("board_type", req.getParameter("board_type"));
				modePage = "redirect:list.do";	
			}
			return modePage;
		}
		//수정처리
		@RequestMapping("/penboard/editAction.do")
		public String editAction(HttpServletRequest req,Model model, 
				PenBbsDTO penBbsDTO){
			
			model.addAttribute("req", req);
			model.addAttribute("penBbsDTO", penBbsDTO);
			command = new EditActionCommand();
			command.execute(model);

			model.addAttribute("pen_idx", req.getParameter("pen_idx"));
			model.addAttribute("nowPage", req.getParameter("nowPage"));
			return "redirect:view.do";
		}
		//답변글 작성폼
		@RequestMapping("/penboard/reply.do")
		public String reply(HttpServletRequest req,
				Model model){

			System.out.println("reply()메소드호출");

			model.addAttribute("req", req);
			command = new ReplyCommand();
			command.execute(model);

			model.addAttribute("nowPage", req.getParameter("nowPage"));
			return "classRoom/penreply";
		}
		//답변글 입력하기
		@RequestMapping("/penboard/replyAction.do")
		public String replyAction(HttpServletRequest req,
				Model model, PenBbsDTO penBbsDTO,HttpSession session){
			//커맨드객체를 통해 입력폼에서 전송한 내용을 한번에 저장
			penBbsDTO.setUser_id(session.getAttribute("user_id").toString());
			model.addAttribute("penBbsDTO", penBbsDTO);
			model.addAttribute("req", req);
			command = new ReplyActionCommand();
			command.execute(model);

			model.addAttribute("nowPage", req.getParameter("nowPage"));
			model.addAttribute("board_type", req.getParameter("board_type"));
			return "redirect:list.do";
		}	

		//웹노티피케이션
		@RequestMapping(value="/class/WebNoti.do",method=RequestMethod.GET)
		public String webNoti() {
			
			return "classRoom/WebNoti";
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}