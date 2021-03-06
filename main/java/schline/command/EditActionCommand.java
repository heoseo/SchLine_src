package schline.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import schline.PenBbsDTO;
import schline.PenJdbcDAO;

 
public class EditActionCommand implements BbsCommandImpl {
 
	
	@Override
	public void execute(Model model) {
		
		Map<String, Object> map = model.asMap();
		
		HttpServletRequest req = (HttpServletRequest)map.get("req");
		PenBbsDTO penBbsDTO = (PenBbsDTO)map.get("penBbsDTO");

		PenJdbcDAO dao = new PenJdbcDAO();
	
		
		dao.edit(penBbsDTO);
	}
}



