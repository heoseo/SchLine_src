package schedule;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import schline.ClassDTO;
import schline.ExamDTO;
import schline.UserVO;

@Service
public interface ScheduleDAOImpl {
	
	
//#####################캘린더#########################################	
	
	//캘린더에 과제.시험 마감일 리스트표시하기.
	public ArrayList<ExamDTO> calendarList(String YearAndMonth);
	
	//일정에 공지,과제,시험 최근게시물 순으로 정렬하여 리스트 표시하기.
	public int getTotalCountAll(String user_id);
	public ArrayList<NoticeDTO> allListPage(String user_id, int s, int e);

	//일정에 공지
//	public int getTotalCount1(String user_id);
//	public ArrayList<NoticeDTO> noticeListPage(String user_id, int s, int e);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//#####################캘린더#########################################		
	
	
}
 