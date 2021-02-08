package schline.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import schline.PenBbsDTO;
import schline.PenJdbcDAO;

public class ViewCommand implements BbsCommandImpl {
	@Override
	public void execute(Model model) {
		
		Map<String, Object> paramMap = model.asMap();
		HttpServletRequest req = (HttpServletRequest)paramMap.get("req");
		//폼값받기
		String pen_idx = req.getParameter("pen_idx");
		String nowPage = req.getParameter("nowPage");
		 
		PenJdbcDAO dao = new PenJdbcDAO();					
		PenBbsDTO dto = new PenBbsDTO();
		dto = dao.view(pen_idx);
		if(dto.getBoard_content()!=null) {
			//줄바꿈 처리위해 <br/>로 변경
			dto.setBoard_content(dto.getBoard_content().replace("\r\n", "<br/>"));
			model.addAttribute("viewRow", dto);
			model.addAttribute("nowPage", nowPage);
		}
	}
}