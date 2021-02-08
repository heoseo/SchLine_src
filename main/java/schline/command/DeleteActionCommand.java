package schline.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import schline.PenJdbcDAO;

public class DeleteActionCommand implements BbsCommandImpl {

	@Override
	public void execute(Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest req = (HttpServletRequest)map.get("req");
				
		String pen_idx = req.getParameter("pen_idx");
		
				
		PenJdbcDAO dao = new PenJdbcDAO();
		dao.delete(pen_idx);
	}
}







