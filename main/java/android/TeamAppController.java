package android;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

		dto.setBoard_content(dto.getBoard_content().replaceAll("\r\n", "<br/>"));
		
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
		
		String path = req.getSession().getServletContext().getRealPath("/resources/uploadsFile");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("path", path);
		
		return map;
	}
}
