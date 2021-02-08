package studyroom;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

/*
컨트롤러와 모델사이의 중재자 역할을 하는 서비스 객체라는 뜻으로 붙이는 어노테이션
명시적인 의미이며, servlet-context.xml에 conponent-scan에
추가되어 있으면 스프링이 시작될때 자동으로 빈이 생성된다.
*/
@Service
public interface StudyCommandImpl {
	
	void execute(Model model);
	
}
