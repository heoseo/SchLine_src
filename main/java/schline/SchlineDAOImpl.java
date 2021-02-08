package schline;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

@Service
public interface SchlineDAOImpl {
	
	//각 인덱스로 과목명, 유저아이디 , 과제정보, 게시물, 확인여부 등 가져오기
	public ClassDTO getsubjectName(String subject_index);
	public UserVO getuserName(String user_id);
	public ExamDTO getExam(String subject_idx, String exam_idx);
	public ExamBoardDTO getView(String board_idx);
	public int getCheck(Integer exam_idx, String user_id);
	public ArrayList<Integer> getExamidx(String subject_idx, String exam_type);
	
	//시험타입으로 문제리스트 가져오기
	public ArrayList<ExamDTO> examlist(Map examidxs);
	
	//타입으로 과제 가져오기
	public ArrayList<ExamDTO> tasklist(String exam_case, String subject_idx);
	
	//협업게시판 리스트 가져오기
	public int getTotalCount(String subject_idx, String user_id);
	public ArrayList<ExamBoardDTO> teamList(String subject_idx, String user_id, int start, int end);
	
	//객관식문제의 문항 가져오기
	public ArrayList<ExamDTO> questionlist();
	
	//자동점수채점을 위해..문제리스트 가져오기
	public ArrayList<ExamDTO> scoringList();
	
	//과제 작성
	public int taskWrite(@Param("_subject_idx") String subject_idx,
					@Param("_user_id") String user_id,
					@Param("_board_title") String board_title,
					@Param("_board_content") String board_content,
					@Param("_board_file") String board_file,
					@Param("_exam_idx") String exam_idx	);
	
	public int teamWrite(@Param("_subject_idx") String subject_idx,
					@Param("_user_id") String user_id,
					@Param("_board_title") String board_title,
					@Param("_board_content") String board_content,
					@Param("_board_file") String board_file);
	
	//파일 수정하여 게시물 업로드
	public int teamFileEdit(@Param("_board_idx") String _board_idx,
					@Param("_board_title") String board_title,
					@Param("_board_content") String board_content,
					@Param("_board_file") String board_file);
	
	//단순 게시물 수정
	public int teamEdit(String board_idx, String board_title, String board_content);
	
	//체크여부 수정
	public int checkEdit(String exam_idx, String user_id);
	
	//게시물 삭제
	public int teamDelete(String board_idx, String user_id);
	
	///////////////////// 교수페이지 처리 ////////////////////
	
	//해당 아이디가 담당하는 과목의 문제리스트 가져오기...
	public ArrayList<ExamDTO> pexamList(String user_id);
	//객관식
	public ArrayList<ExamDTO> pquestionlist(String user_id);
}
 