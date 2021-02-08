package schline.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import schline.PenBbsDTO;
import schline.PenJdbcDAO;

public class ReplyCommand implements BbsCommandImpl {

	@Override
	public void execute(Model model) 
	{
		Map<String, Object> map = model.asMap();
		HttpServletRequest req = (HttpServletRequest)map.get("req");
	
		String pen_idx = req.getParameter("pen_idx");
		
		PenJdbcDAO dao = new PenJdbcDAO();
		//기존 게시물의 내용을 가져온다. 
		PenBbsDTO dto = dao.view(pen_idx);		
		//제목앞에 답변글이라는 표현으로 [RE]를 추가한다. 
		dto.setBoard_title( dto.getBoard_title());
		//내용에도 원본글을 표현하기 위해 문자열을 추가한다. 
		dto.setBoard_content("\n\r\n\r---[원본글]---\n\r"+dto.getBoard_content());
		//모델객체에 dto저장
		model.addAttribute("replyRow", dto);
	}
}