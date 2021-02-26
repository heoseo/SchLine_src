package admin.model;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import schline.util.JdbcTemplateConst;


public class AdminUserTemplateDAO {
	
	// 멤버변수
	JdbcTemplate template;
	
	public AdminUserTemplateDAO() {
		this.template = JdbcTemplateConst.template;
		System.out.println("AdminUserTemplateDAO() 생성자 호출");
	}
	
	public void close() {
	}
	
	public int getTotalCount(Map<String, Object> map) {
		String sql = "	SELECT COUNT(*) "
				+ "		FROM user_tb "
				+ " 	WHERE authority = '" + map.get("searchColumn") + "' " ;
		
		
		if(map.get("searchWord") != null) {
			sql += " 		AND user_name LIKE '%" + map.get("searchWord") + "%' ";
		}
		if(map.get("subject_idx") != null) {
			sql = "		SELECT COUNT(*) "
			+ "			FROM ("
				+ "			SELECT Tb.*, rownum rNum "
				+ "			FROM ("
				+ "				SELECT U.* "
				+ "				FROM registration_tb R, user_tb U "
				+ "				WHERE R.user_id = U.user_id "
				+ "   				AND subject_idx = "+map.get("subject_idx")+" "
				+ "				ORDER BY U.user_id ASC"
				+ "				) Tb "
				+ "			) ";
		}
		int result = template.queryForObject(sql, Integer.class);
		
		// 쿼리문에서 count(*)를 통해 정수값 반환
		return result;
	}
	
	public ArrayList<Admin_UserVO> listPage(
			Map<String, Object> map){
		
		boolean flag = false;
		int start = 0, end = 0;
		if(map.get("start")!= null && map.get("end")!= null) {
			start = Integer.parseInt(map.get("start").toString());
			end = Integer.parseInt(map.get("end").toString());
			flag = true;
		}
		
		String searchColumn = (String) map.get("searchColumn");
		String searchWord = (String) map.get("searchWord");

		String sql = "";
		
		if(searchColumn == "PROFESSOR")
			sql = "		SELECT * "
				+ "		FROM ( "
				+ "			SELECT Tb.*, rownum rNum "
				+ "			FROM ( "
				+ "				SELECT subject_idx, subject_name, U.* "
				+ "				FROM user_tb U, subject_tb S "
				+ "				WHERE U.user_id = S.user_id "
				+ "					AND authority = 'PROFESSOR' ";
		else
			sql = "		SELECT * "
					+ "	FROM ( "
					+ "		SELECT Tb.*, rownum rNum "
					+ "		FROM ( "
					+ "			SELECT * "
					+ "			FROM user_tb U "
					+ "			WHERE authority = '"+searchColumn+"' ";
		
		if(searchWord!=null)
			sql += " 				AND user_name LIKE '%"+searchWord+"%' ";	
		
		sql += " 			ORDER BY U.user_id ASC"
		+"    				) Tb"
		+"				)";
		if(flag ==true)
			sql +=" 	WHERE rNum BETWEEN "+start+" and "+end;
		
		
		
		
		// subject_idx != null ==> 과목조회에서 과목을 클릭했음.
		System.out.println("AdminUserTEmplateDAO > subject_idx : " + map.get("subject_idx"));
		if(map.get("subject_idx") != null) {
			sql = "		SELECT * "
			+ "			FROM ("
				+ "			SELECT Tb.*, rownum rNum "
				+ "			FROM ("
				+ "				SELECT U.* "
				+ "				FROM registration_tb R, user_tb U "
				+ "				WHERE R.user_id = U.user_id "
				+ "   				AND subject_idx = "+map.get("subject_idx")+" "
				+ "				ORDER BY U.user_id ASC"
				+ "				) Tb "
				+ "			) ";
			if(flag ==true)
				sql +=" WHERE rNum BETWEEN "+start+" and "+end;
					
		}
		
		return (ArrayList<Admin_UserVO>)
				template.query(sql, 
				new BeanPropertyRowMapper<Admin_UserVO>(
						Admin_UserVO.class));
	}

}
