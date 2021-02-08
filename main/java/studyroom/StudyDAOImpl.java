package studyroom;

import org.springframework.stereotype.Service;

@Service
public interface StudyDAOImpl {
	
	//@Param : Mapper전달한 파라미터 이름 그대로 사용 가능
	//studyRoomMapper 호출시 사용할 추상메소드
	
	//mapper연결 안했을때
	public String execute();
	
	//mapper연결을통해 dao 진행
	
}
