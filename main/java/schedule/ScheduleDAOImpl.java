package schedule;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import professor.NoticeBoardDTO;
import schline.ClassDTO;
import schline.ExamDTO;
import schline.UserVO;

@Service
public interface ScheduleDAOImpl {
	
	
//#####################캘린더#########################################	
	
	//캘린더에 과제.시험 마감일 리스트표시하기.
	public ArrayList<ExamDTO> calendarList(String user_id, String YearAndMonth);
	
//#####################알림리스트#########################################	
	//일정에 공지,과제,시험 최근게시물 순으로 정렬하여 리스트 표시하기.
	public int getTotalCountAll(String user_id);
	public int getTotalCountAllNoti(String user_id);
	public int getTotalCountExam(String user_id);
	public int getTotalCountRead(String user_id);
	public int getTotalCountNotRead(String user_id);

	//리스트뿌리기.
	public ArrayList<NoticeDTO> allBoard(String user_id, int start, int end);
	public ArrayList<NoticeDTO> allNoti(String user_id, int start, int end);
	public ArrayList<NoticeDTO> taskAndExam(String user_id, int start, int end);
	public ArrayList<NoticeDTO> notiRead(String user_id, int start, int end);
	public ArrayList<NoticeDTO> notiNotRead(String user_id, int start, int end);
	
	
	
//#########################일정상세보기쿼리문################################### -->		
	
////일정>알림>과제/시험 셀렉트 옵션 체인지이벤트. 체인지시 이동. ..뭔소맂
	public ArrayList<NoticeDTO> noti(String iDX);
	public ArrayList<NoticeDTO> exam(String iDX);
	//게시물읽을시 읽음처리.
	public int checkNoti(String user_id, String iDX);
	public int checkExam(String user_id, String iDX);



//상세보기시  제출하기누를때 밑의 에이젝스로 폼출력하기. 과목idx받아오기.
	//게시물리스트(과목셀렉).
	public ArrayList<NoticeBoardDTO> getSubject(String user_id);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//#####################캘린더#########################################		
	
	
}
 