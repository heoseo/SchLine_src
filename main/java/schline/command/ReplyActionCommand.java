package schline.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import schline.PenBbsDTO;
import schline.PenJdbcDAO;

public class ReplyActionCommand implements BbsCommandImpl {
	
	@Override
	public void execute(Model model) {
		
		Map<String, Object> paramMap = model.asMap();
		HttpServletRequest req = (HttpServletRequest)paramMap.get("req");
		PenBbsDTO dto = (PenBbsDTO)paramMap.get("penBbsDTO");
				 
		PenJdbcDAO dao = new PenJdbcDAO();		
		dao.reply(dto);				
		
	}
}