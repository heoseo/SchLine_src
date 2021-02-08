package kosmo.project3.schline;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StudyRoomController {
	
	//공부방 메인
	@RequestMapping("/class/studyRoom.do")
	public String studyRoom () {
		return "studyRoom/studyRoom";
	}
	
	//실제 공부방 이동
	@RequestMapping("/class/studyRoomChat.do")
	public String studyRoomGo() {
		//채팅용
		return "studyRoom/studyRoomGo";
	}
	
	
	//마이바티스 사용준비
	@Autowired
	private SqlSession SqlSession;
	
	
	@RequestMapping("/chat")
	public String chatView() {
		//Echo핸들러로 연결
		return "";
	}
}
