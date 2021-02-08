package schline;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

@Service
public interface SchlineDAOImpl {
	
	//각 인덱스로 과목명, 유저아이디 , 과제정보 가져오기
	public ClassDTO getsubjectName(String subject_index);
	public UserVO getuserName(String user_id);
	public ExamDTO getExam(String exam_idx);
	
	//시험타입으로 문제리스트 가져오기
	public ArrayList<ExamDTO> examlist(String exam_case, String subject_idx);
	
	//타입으로 과제 가져오기
	public ArrayList<ExamDTO> tasklist(String exam_case, String subject_idx);
	
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
}
 