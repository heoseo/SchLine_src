package schline.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import schline.PenBbsDTO;
import schline.PenJdbcDAO;

public class WriteActionCommand implements BbsCommandImpl {
	
	@Override
	public void execute(Model model) {
		
		//파라미터 한번에 전달받기
		Map<String, Object> paramMap = model.asMap();
		//request객체와 DTO객체를 형변환 후 가져옴.
		HttpServletRequest req = (HttpServletRequest)paramMap.get("req");
		PenBbsDTO penBbsDTO = (PenBbsDTO)paramMap.get("penBbsDTO");

		System.out.println("penBbsDTO.title="+penBbsDTO.getBoard_title());
	
		PenJdbcDAO dao = new PenJdbcDAO();		
		dao.write(penBbsDTO);
	}
}
