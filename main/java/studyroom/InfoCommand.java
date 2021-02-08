package studyroom;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

//회원List 불러오기
public class InfoCommand implements StudyCommandImpl{

	@Override
	public void execute(Model model) {
		
		System.out.println("InfoCommand호출. 회원리스트 불러오기 시작");
		
		/*
		컨트롤러에서 인자로 전달한 model 객체에는 request객체가 저장되어있다.
		asMap()을 통해 Map컬렉션으로 변환한 후 모든 요청을 가져올 수 있다.
		 */
		Map<String, Object> paramMap = model.asMap();
		HttpServletRequest req = (HttpServletRequest)paramMap.get("req");
		
		//폼값처리
		String user_id = req.getParameter("user_id");
		String info_nick = req.getParameter("info_nick");
		String info_img = req.getParameter("info_img");
		
		System.out.println("user_id= "+user_id);
		System.out.println("info_nick= "+info_nick);
		System.out.println("info_img= "+info_img);
		
		//dao객체생성
		StudyTemplateDAO dao = new StudyTemplateDAO();
		//회원정보를 저장할 리스트 만들기
		List<InfoVO> infoList = dao.people_list();
		
		//회원리스트 model객체에 담아준다
		model.addAttribute("infoList", infoList);
		System.out.println("회원리스트 모델에 담기 완료");
		
		//파라미터로 받아온 로그인 학생 정보를 model객체에 따로 담아준다.
		for(InfoVO row : infoList) {
			if(row.getUser_id().equals(user_id)) {
				model.addAttribute("user_id", user_id);
				model.addAttribute("info_nick", info_nick);
				model.addAttribute("info_img", info_img);
				System.out.println("학생정보 모델에 담기 완료");
			}
		}
	}
}
