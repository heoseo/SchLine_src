package schline.command;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import schline.PenBbsDTO;
import schline.PenJdbcDAO;
import schline.util.EnvFileReader;
import schline.util.PagingUtil;

public class ListCommand implements BbsCommandImpl {

	@Override
	public void execute(Model model) {
		
		System.out.println("ListCommand > execute() 호출");
	
		Map<String, Object> paramMap = model.asMap();
		HttpServletRequest req = (HttpServletRequest)paramMap.get("req");
 
		//DAO객체생성
		PenJdbcDAO dao = new PenJdbcDAO();		
 
		String  board_type = req.getParameter("board_type");
		paramMap.put("board_type", board_type);
		//검색어 관련 폼값 처리
		String addQueryString = "";
		String searchColumn = req.getParameter("searchColumn");				
		String searchWord = req.getParameter("searchWord");
		if(searchWord!=null)
		{
			addQueryString = String.format("searchColumn=%s"
				+"&searchWord=%s&", searchColumn, searchWord);

			System.out.println(addQueryString);
			paramMap.put("Column", searchColumn);
			paramMap.put("Word", searchWord);
		}

		//게시물 레코드수 카운트
		int totalRecordCount = dao.getTotalCount(paramMap);
		
		////////////////////////
		///페이지처리 start
		//Environment객체를 통한 외부파일 읽기
		int pageSize = Integer.parseInt(
				EnvFileReader.getValue("SpringBbsInit.properties", 
						"springBoard.pageSize"));
		int blockPage = Integer.parseInt(
				EnvFileReader.getValue("SpringBbsInit.properties", 
						"springBoard.blockPage"));
		//페이지수를 계산		
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);

		int nowPage = req.getParameter("nowPage")==null ? 1 :
			Integer.parseInt(req.getParameter("nowPage"));
		//리스트에 출력할 게시물의 구간을 계산(select절의 between에 사용)
		int start = (nowPage-1) * pageSize + 1;
		int end = nowPage * pageSize;

		paramMap.put("start", start);
		paramMap.put("end", end);		
		///페이지처리 end
		///////////////////////
		
		ArrayList<PenBbsDTO> listRows = dao.listPage(paramMap);
		 		
	
		int virtualNum = 0;
		int countNum = 0;
		
		for(PenBbsDTO row : listRows)
		{
			
			virtualNum = totalRecordCount
					- (((nowPage-1)*pageSize) + countNum++);
			//setter를 통해 저장
			row.setVirtualNum(virtualNum); 
			
			//답변글 출력시의 처리부분
			String reSpace="";
			if(Integer.parseInt(row.getBindent()) > 0) 
			{
				//bindent의 크기만큼 반복해서 공백문자 추가
				for(int i=0 ; i<Integer.parseInt(row.getBindent()) ; i++) {
					reSpace += "&nbsp;&nbsp;";
				}
				//제목앞에 reply 아이콘 추가 및 공백문자를 통한 들여쓰기 처리
				row.setBoard_title(reSpace 
						+ "<img src='../resources/images/reply.png' width='40px'>" 
						+ row.getBoard_title()); 
			}
		}	
 
		//리스트에 출력할 List컬렉션을 model객체에 저장한 후 뷰로 전달한다.
		String pagingImg = PagingUtil.pagingImg(totalRecordCount,
				pageSize, blockPage, nowPage,
				req.getContextPath()+"/penboard/list.do?"+addQueryString+"board_type="+board_type+"&");
		model.addAttribute("pagingImg", pagingImg);
		model.addAttribute("totalPage", totalPage);//전체페이지수
		model.addAttribute("nowPage", nowPage);//현재페이지번호
		model.addAttribute("listRows", listRows);
		model.addAttribute("board_type", board_type);

		//JDBCTemplete에서는 자원반납을 하지 않는다. 
		//dao.close();
	}
}

