package schedule;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import schline.ClassDTO;
import schline.ExamBoardDTO;
import schline.ExamDTO;
import schline.UserVO;

@Service
public interface ScheduleDAOImpl {
	
	
//#####################캘린더#########################################	
	
	//캘린더에 과제.시험 마감일 리스트표시하기.
	public ArrayList<ExamDTO> calendarList(String YearAndMonth);
	
	
//####################일정게시판#########################################
	
	//일정에 공지,과제,시험 최근게시물 순으로 정렬하여 리스트 표시하기.
	public int getTotalCountAll(String user_id);
	public ArrayList<NoticeDTO> allBoard(String user_id, int s, int e);

	
	/* (2)
		201701700학생 공지사항 리스트(최신순으로 & 읽음->안읽음 순서대로)
		201701700은 파라미터로 바꾸기 */
	public ArrayList<NoticeDTO> allNoti(String user_id, int s, int e);
	
	/* (3)
		201701700학생 과제 리스트(최신순으로 & 읽음->안읽음 순서대로)
		201701700은 파라미터로 바꾸기. */
	public ArrayList<NoticeDTO> taskAndExam(String user_id, int s, int e);

	//공지안읽음리스트
	public ArrayList<NoticeDTO> notiRead(String user_id, int s, int e);
	//공지안읽음리스트
	public ArrayList<NoticeDTO> notiNotRead(String user_id, int s, int e);


//	<option value="allBoard" >전부</option>
//	<option value="allNoti">공지</option>
//	<option value="taskAndExam">과제/시험</option>
//	<option value="notiRead">읽은 공지</option>
//	<option value="notiNotRead">읽지않은 공지</option>
//#########################일정상세보기게시판###############################################
	
	//과제 상세보기 리스트 뿌리기.
	public ArrayList<NoticeDTO> noti(String IDX);
	public ArrayList<NoticeDTO> exam(String IDX);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
 