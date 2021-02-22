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

import schline.AttendanceDTO;
import schline.ClassDTO;
import schline.UserVO;
import schline.util.JdbcTemplateConst;


public class AdminAttendTemplateDAO {
	
	// 멤버변수
	JdbcTemplate template;
	
	public AdminAttendTemplateDAO() {
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
		int result = template.queryForObject(sql, Integer.class);
		System.out.println("AdminUserTEmpolateDAO > getotalCount : " + result);
		
		// 쿼리문에서 count(*)를 통해 정수값 반환
		return result;
	}
	
	//searchSubject를 듣는 과목의 학생 리스트
	public ArrayList<Admin_UserVO> userList(
			Map<String, Object> map){
		
		
		
		String sql = "	SELECT * "
				+ "		FROM ( "
				+ "			SELECT Tb.*, rownum rNum "
				+ "			FROM ( "
				+ "				SELECT S.subject_idx, S.subject_name, U.* "
				+ "				FROM user_tb U, registration_tb R, subject_tb S"
				+ "				WHERE U.user_id = R.user_id "
				+ "					AND R.subject_idx = S.subject_idx";
		
		if(map.get("searchSubject")!=null)
			sql += "				AND subject_name LIKE '%"+map.get("searchSubject")+"%' ";
		else
			sql += "				AND S.subject_idx = 1 ";
			
		sql += " 			ORDER BY U.user_id ASC"
		+"    				) Tb"
		+"				)";
		
		
		
		
		
		return (ArrayList<Admin_UserVO>)
				template.query(sql, 
				new BeanPropertyRowMapper<Admin_UserVO>(
						Admin_UserVO.class));
	}
	
	
	public ArrayList<AttendanceDTO> attendList(
			Map<String, Object> map){
		
		
		
		String sql = " 	SELECT Tb.*, rownum rNum "
				+ "		FROM ( "
			    + " 			SELECT * "
			    + "				FROM attendance_tb A "
				+ " 			INNER JOIN video_tb V ON A.video_idx=V.video_idx "
				+ " 			WHERE subject_idx = "+ map.get("subject_idx")+" AND user_id = " + map.get("subject_idx") 
				+ " 			ORDER BY A.video_idx asc   "
				+ "			 ) Tb ";
		
		
		
		
		
		return (ArrayList<AttendanceDTO>)
				template.query(sql, 
				new BeanPropertyRowMapper<AttendanceDTO>(
						AttendanceDTO.class));
	}

}
