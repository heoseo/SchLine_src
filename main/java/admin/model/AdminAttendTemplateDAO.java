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


public class AdminAttendTemplateDAO {
	
	// 멤버변수
	JdbcTemplate template;
	
	public AdminAttendTemplateDAO() {
		this.template = JdbcTemplateConst.template;
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
		String subject_name =  (String) map.get("subject_name");
		if (subject_name == null) subject_name = "자바";
		
		String sql = " 	SELECT Tb.*, rownum rNum "
				+ "		FROM ( "
			    + " 			SELECT * "
			    + "				FROM attendance_tb A "
				+ " 			INNER JOIN video_tb V ON A.video_idx=V.video_idx "
				+ " 			WHERE subject_idx = (SELECT subject_idx "
				+ "									FROM subject_tb "
				+ "									WHERE subject_name LIKE '%"+ subject_name +"%' "
				+ "									)"
				+ "					AND user_id = (	SELECT user_id "
				+ "									FROM user_tb "
				+ "									WHERE user_name LIKE '%" + map.get("searchUser") +"%' "
				+ "									)" 
				+ " 			ORDER BY A.video_idx asc   "
				+ "			 ) Tb ";
		
		
		
		
		return (ArrayList<AttendanceDTO>)
				template.query(sql, 
				new BeanPropertyRowMapper<AttendanceDTO>(
						AttendanceDTO.class));
	}
	
	public void editAttend(Map<String, Object> map) {
		
		String sql = "	UPDATE attendance_tb "
				+ "		SET attendance_flag=? "
				+ "		WHERE attendance_idx=? ";
		System.out.println("flag : " + map.get("attendance_flag")+ " idx : " + map.get("attendance_idx"));
		
		final int attendance_flag = Integer.parseInt((String) map.get("attendance_flag"));
		final int attendance_idx = Integer.parseInt((String) map.get("attendance_idx"));
		
		
		template.update(sql, new PreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps) throws SQLException {

				ps.setInt(1, attendance_flag);
				ps.setInt(2, attendance_idx);
				
			}
		});
	}

}
