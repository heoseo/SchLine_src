package studyroom;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

@Service
public interface StudyDAOImpl {
	
	//1.mapper연결 안했을때 -> Service 참조
//	public String execute();
	
	//2.mapper연결을통해 dao 진행
	
	//접속한 학생의 기존닉네임 체크
	public InfoVO user_nick(String user_id);
	
	//닉네임으로 다른사람 프로필보기
	public InfoVO other_profile(String ck_nick);

	//아이디 중복확인
	public int check_nick(@Param("_nick") String info_nick);
	
	//기존 프로필 첨부파일 삭제
	public void delete_profile(String info_img);
	
	//@Param : Mapper전달한 파라미터 이름 그대로 사용 가능
	public int edit_profile (@Param("_info_nick") String info_nick,
			@Param("_info_img") String info_img,
			@Param("_user_id") String user_id);
	
	//전체회원 리스트 불러오기
	public ArrayList<InfoVO> study_list();
	//1~10등까지 랭킹리스트 가져오기
	public ArrayList<InfoVO> lank_list();
	
	//공부시간 업데이트해주는 함수
	public int study_time(@Param("_id") String user_id);
	
	//채팅 기록 담기
	public int chat_history(String user_id, String cont);
	
	//신고하기
	public int reported_people(String other_nick);
	
	//차단하기
	public int block_people(@Param("user_id") String user_id, @Param("other_id") String other_id);
	
	//차단목록 불러오기
//	public ArrayList<BlockDTO> check_bolck(String ot_id, String user_id);
	public Integer check_bolck(String ot_id, String user_id);
	
	//동일한 날짜에 접속한적 있는지 체크
	public Integer check_day(String today, String user_id);
	
	//출석카운트 증가
	public int atten_plus(String today, String user_id);
	
	////////////안드로이드///////////////////
	public InfoVO login_info(InfoVO infoVO);
	
}
