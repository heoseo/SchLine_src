package professor;

import java.util.ArrayList;
import org.springframework.stereotype.Service;

@Service
public interface NoticeboardDAOImpl {

	//보드테이블 공지게시물 갯수 카운트
	public int boardCount(String user_id);
	//게시물리스트(보드공지테이블셀렉).
	public ArrayList<NoticeBoardDTO> getNoticeBoard(String user_id, int s, int e);
	//글쓰기시 선생님 아이디로 샘정보 가져오기. 이름뿌려줘야함.
	public ArrayList<NoticeBoardDTO> getProfessor(String user_id);
	
//############공지사항테이블 글쓰기(노티체크 샘에해당하는 학생수만큼 인설트포함)#########	
	
	//글쓰기 전송하기버튼클릭시. 인설트.
	public int insertBoard(String user_id, String board_title, String board_content, String saveFileName);
	
	//입력후 자동생성된 board_idx 값 가져오기.
	//마지막으로 인설트된 idx값 받아오기.
	public ArrayList<NoticeBoardDTO> getSeqIdx(String user_id);
	
	//게시물리스트(과목셀렉).
	public ArrayList<NoticeBoardDTO> getSubject(String user_id);
	
	//학생수 받아오는 쿼리실행.
	//(선생user_id랑헷갈린다....변수다르게받자)
	//registration_tb테이블 학생user_id값받아오는 셀렉트.
	public ArrayList<NoticeBoardDTO> getStudent(int subject_idx);
	
	//게시물리스트(과제셀렉)
	public ArrayList<NoticeBoardDTO> getExam(String sbuject_idx);
	
	//게시물리스트(공지첵셀렉)
	public ArrayList<NoticeBoardDTO> getNotiChk(String user_id);
	
	public int notiCheck(int board_idx ,int student_id);

	//게시물리스트(보드공지테이블셀렉).
	public ArrayList<NoticeBoardDTO> getNotiView(String user_id);

	
	//게시물리스트(보드공지테이블수정)
	public int notiEditAction
	(String board_title, String board_content, String board_file, String board_idx);
	
	
	//--노티체크테이블 idx삭제처리후! 게시물삭제가능
	public int deleteCheck(String user_id);
	//--게시물삭제처리.
	public int deleteNotiBoard(String user_id);

	
	
	
	
	
//#####################캘린더#########################################		
	
	
}
 