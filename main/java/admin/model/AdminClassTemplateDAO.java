package admin.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.PreparedStatementSetter;

import schline.ClassDTO;
import schline.UserVO;
import schline.util.JdbcTemplateConst;


public class AdminClassTemplateDAO {
	
	// 멤버변수
	JdbcTemplate template;
	
	// 생성자
	/*
	- 컨트롤러에서 @Aturowired를 통해 자동주입 받았던 빈을 정적변수인
		JdbcTemplateConst.template에 값을 할당하였으므로, 
		DB연결정보를 DAO에서 바로 사용하기 위해 값을 가져온다.	 */
	public AdminClassTemplateDAO() {
		this.template = JdbcTemplateConst.template;
	}
	
	public void close() {
		
	}
	
	// MAP => Column, Word
	public int getTotalCount(Map<String, Object> map) {
		String sql = "	SELECT COUNT(*) "
				+ "		FROM subject_tb S, user_tb U"
				+ " 	WHERE S.user_id = U.user_id ";
		
		
		if(map.get("searchWord") != null) {
			sql += " 		AND user_name LIKE '%" + map.get("searchWord") + "%' ";
		}
		int result = template.queryForObject(sql, Integer.class);
		
		// 쿼리문에서 count(*)를 통해 정수값 반환
		return result;
	}
	
	public ArrayList<ClassDTO> listPage(
			Map<String, Object> map){
		
		boolean flag = false;
		int start = 0, end = 0;
		if(map.get("start")!= null && map.get("end")!= null) {
			start = Integer.parseInt(map.get("start").toString());
			end = Integer.parseInt(map.get("end").toString());
			flag = true;
		}
		
		
		String sql = " 	SELECT * "
				+" 		FROM ("
				+"    		SELECT Tb.*, rownum rNum "
				+ "			FROM ("
				+"        		SELECT subject_idx, subject_name, U.* "
				+ "				FROM user_tb U, subject_tb S "				
				+"				WHERE U.user_id = S.user_id ";
		
		if(map.get("searchWord")!=null)
		sql += " 					AND "+map.get("searchColumn")+" LIKE '%"+map.get("searchWord")+"%' ";				
		sql += " 			ORDER BY subject_idx ASC"
		+"    				) Tb"
		+"				)";
		
		if(map.get("searchSubject")!=null)
			sql += " 					AND subject_name LIKE '%"+map.get("searchSubject")+"%' ";				
			sql += " 			ORDER BY subject_idx ASC"
			+"    				) Tb"
			+"				)";
		if(flag ==true)
			sql +=" 	WHERE rNum BETWEEN "+start+" and "+end;
		
	
			
					
		
		
		return (ArrayList<ClassDTO>)
				template.query(sql, 
				new BeanPropertyRowMapper<ClassDTO>(
						ClassDTO.class));
	}
	

	
}
