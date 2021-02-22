package schline;

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
	public ArrayList<ExamDTO> getExamlist(String subject_idx, String exam_type);
	public ArrayList<Integer> getExamidx(String subject_idx, String exam_type);
	public ArrayList<Integer> getExamidxs(String subject_idx, String exam_type, String exam_idx);
	
	//시험타입으로 문제리스트 가져오기
	public ArrayList<ExamDTO> examlist(Map examidxs);
	
	//타입으로 과제 가져오기
	public ArrayList<ExamDTO> tasklist(String exam_case, String subject_idx, String user_id);
	//종합과제함 가져오기
	public ArrayList<ExamDTO> getAllTask(String subject_idx);
	//메인 과제함
	public ArrayList<ExamDTO> getMainTask(String User_id);
	//팀번호 가져오기
	public String getTeamNum(String user_id, String subject_idx);
	//협업게시판 리스트 가져오기
	public int getTotalCount(String subject_idx, String team_num);
	public ArrayList<ExamBoardDTO> teamList(String subject_idx, String team_num, int start, int end);
	public ArrayList<ExamBoardDTO> teamList2(String subject_idx, String team_num);
	
	//객관식문제의 문항 가져오기
	public ArrayList<ExamDTO> questionlist();
	
	//자동점수채점을 위해..문제리스트 가져오기
	public ArrayList<ExamDTO> scoringList();
	
	//주관식 문제 정답 입력
	public void insertAnswer(int question_idx, String user_id, String answer);
	
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
					@Param("_board_file") String board_file,
					@Param("_team_num") String team_num);
	
	public int teamWrite2(@Param("_subject_idx") String subject_idx,
			@Param("_user_id") String user_id,
			@Param("_board_title") String board_title,
			@Param("_board_content") String board_content,
			@Param("_team_num") String team_num);
	
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

	//////////////////////점수처리/////////////////////////
	//주관식 정답처리에 대한 점수증가
	public int gradeUp(String question_score, String user_id, String exam_idx);
	
	///////////////////// 교수페이지 처리 ////////////////////

	//해당 아이디가 담당하는 과목의 문제리스트 가져오기...
	public ArrayList<ExamDTO> pexamlist(String user_id);
	public ArrayList<ExamDTO> pinexamList(String user_id);
	public ArrayList<ExamDTO> ptasklist(String exam_type, String subejct_idx);
	//객관식
	public ArrayList<ExamDTO> pquestionlist(String user_id);
	//문제입력
	public int insertExam(String subject_idx, String exam_name, String exam_date, int exam_scoring, String exam_idx);
	public String getSubject_idx(String user_id);
	public String getExam_idx(String subject_idx);
	public int insertQuestion(String exam_idx, String question_type, String answer, String question_score, String question_content);
	public String getQuestion_idx();
	public int insertQuestionList(String question_idx, String questionlist_content, int questionlist_num);
	//시험삭제를 위한 타입(객관식,서술형판단해야함)
	public String getQuestionType(String question_idx);
	public int updateTask(String exam_name, String exam_date, String exam_content, String exam_scoring, String exam_idx);
	public int deleteQuestion(String question_idx);
	public void deleteQuestionlist(String question_idx);
	public void deleteQuestionAnswer(String question_idx);
	
	///교수페이지 과제////
	public int insertTask(String subject_idx, String exam_name, String exam_date, String exam_content, String exam_scoring);
	public void insertCheckList(ExamDTO examDTO);
	public void deleteExamBoard(String exam_idx);
	public void deleteCheckList(String exam_idx);
	public int deleteTask(String exam_idx, String subject_idx);
	//제출과제 확인용//
	public int getTotalTask(String subject_idx);
	public ArrayList<ExamBoardDTO> taskCheckList(String subject_idx, int start, int end);
	
	//주관식 확인
	public ArrayList<ExamDTO> examCheckList(String subject_idx, String user_id);
	//수강생리스트
	public ArrayList<UserVO> getuserNames(String subject_idx);
	//팀변경
	public int changeTeam(String user_id, String team_num, String subject_idx);
}

