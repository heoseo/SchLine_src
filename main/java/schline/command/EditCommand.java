package schline.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import schline.PenBbsDTO;
import schline.PenJdbcDAO;

@Service
public class EditCommand implements BbsCommandImpl {

	PenJdbcDAO dao;
	@Autowired	
	public void setDao(PenJdbcDAO dao) {
		this.dao = dao;
		System.out.println("JDBCTemplateDAO 자동주입(Edit)");
	}
	
	@Override
	public void execute(Model model) {
	
		Map<String, Object> paramMap = model.asMap();
		HttpServletRequest req = (HttpServletRequest)paramMap.get("req");
		
		String pen_idx = req.getParameter("pen_idx");
	 
		PenJdbcDAO dao = new PenJdbcDAO();
		
		PenBbsDTO dto = dao.view(pen_idx);
		model.addAttribute("viewRow", dto);
		model.addAttribute("nowPage", req.getParameter("nowPage"));
		
	}
}





