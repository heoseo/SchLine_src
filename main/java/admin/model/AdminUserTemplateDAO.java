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

import schline.UserVO;
import schline.util.JdbcTemplateConst;


/*	* JdbcTemplate 관련 주요 메소드
	 - List query(String sql, RowMapper rowMapper)
	 	: 여러개의 레코드를 반환하는 select계열의 쿼리문인 경우 사용
 	 - List query(String sql, Object[] args, RowMapper rowMapper)
 	 	: 인파라미터를 가진 여러개의 레코드를 반환하는 select계열의 쿼리문인 경우 사용
 	 	
 	 - Object queryForObject(String sql, RowMapper rowMapper)
 	 	: 하나의 레코드를 반환하는 select계열의 쿼리문 실행시 사용된다.
 	 - Object queryForObject(String sql, Object[] args, RowMapper rowMapper)
 	 	: 인파라미터가 있고, 하나의 레코드를 반환하는 select계열의 쿼리문 실행시 사용된다.

 	 - int queryForInt(String sql)
 	 	: 쿼리문의 실행결과가 숫자를 반환하는 select계열의 쿼리문에 사용된다.
 	 - int queryForInt(String sql, Object[] args)
 	 	: 인파라미터가 있고, 쿼리문의 실행결과가 숫자를 반환하는 select계열의 쿼리문에 사용된다.
 	 	
 	 - int update(String sql)
 	 	: 인파라미터가 없는 update/delete/insert 쿼리문을 처리할 때 사용
 	 - int update(String sql, Object[] args)
 	 	: 인파라미터가 있는 update/delete/insert 쿼리문을 처리할 때 사용
 */
public class AdminUserTemplateDAO {
	
	// 멤버변수
	JdbcTemplate template;
	
	// 생성자
	/*
	- 컨트롤러에서 @Aturowired를 통해 자동주입 받았던 빈을 정적변수인
		JdbcTemplateConst.template에 값을 할당하였으므로, 
		DB연결정보를 DAO에서 바로 사용하기 위해 값을 가져온다.	 */
	public AdminUserTemplateDAO() {
		this.template = JdbcTemplateConst.template;
		System.out.println("AdminUserTemplateDAO() 생성자 호출");
	}
	
	public void close() {
	}
	
	// MAP => Column, Word
	public int getTotalCount(Map<String, Object> map) {
		String sql = "	SELECT COUNT(*) "
				+ "		FROM user_tb "
				+ " 	WHERE authority = '" + map.get("userType") + "' " ;
		
		
		if(map.get("searchUser") != null) {
			sql += " 		AND user_name LIKE '%" + map.get("searchUser") + "%' ";
		}
		int result = template.queryForObject(sql, Integer.class);
		System.out.println("AdminUserTEmpolateDAO > getotalCount : " + result);
		
		// 쿼리문에서 count(*)를 통해 정수값 반환
		return result;
	}
	
	public ArrayList<Admin_UserVO> listPage(
			Map<String, Object> map){
		System.out.println("AdminUserT~ param.s_idx : " + map.get("subject_idx"));
		
		boolean flag = false;
		int start = 0, end = 0;
		if(map.get("start")!= null && map.get("end")!= null) {
			start = Integer.parseInt(map.get("start").toString());
			end = Integer.parseInt(map.get("end").toString());
			flag = true;
		}
		
		String user_type = (String) map.get("userType");
		
		String sql = "";
		if(user_type.equals("PROFESSOR")) {
			sql += "	SELECT * "
				+ "		FROM ( "
				+ "			SELECT Tb.*, rownum rNum "
				+ "			FROM ( "
				+ "				SELECT subject_idx, subject_name, U.* "
				+ "				FROM user_tb U, subject_tb S "
				+ "				WHERE U.user_id = S.user_id "
				+ "					AND authority = 'PROFESSOR' ";
		}
		else {
			sql += " 	SELECT * "
				+" 		FROM ("
				+"    		SELECT Tb.*, rownum rNum "
				+ "			FROM ("
				+"        		SELECT * FROM user_tb U"				
				+"				WHERE authority = '" + map.get("userType") + "' ";
		}
		
		if(map.get("searchUser")!=null)
		sql += " 					AND user_name LIKE '%"+map.get("searchUser")+"%' ";				
		sql += " 			ORDER BY U.user_id ASC"
		+"    				) Tb"
		+"				)";
		if(flag ==true)
			sql +=" 	WHERE rNum BETWEEN "+start+" and "+end;
		
		
		
		
		if(map.get("subject_idx") != null) {
			sql = "		SELECT * "
			+ "			FROM ("
				+ "			SELECT Tb.*, rownum rNum "
				+ "			FROM ("
				+ "				SELECT U.* "
				+ "				FROM registration_tb R, user_tb U "
				+ "				WHERE R.user_id = U.user_id "
				+ "   				AND subject_idx = 1 "
				+ "				ORDER BY U.user_id ASC"
				+ "				) Tb "
				+ "			) ";
			if(flag ==true)
				sql +=" WHERE rNum BETWEEN "+start+" and "+end;
			
					
		}
		
		System.out.println("AdminUserT~ sql : " + sql);
		return (ArrayList<Admin_UserVO>)
				template.query(sql, 
				new BeanPropertyRowMapper<Admin_UserVO>(
						Admin_UserVO.class));
	}
	
//	
//	// 조회수 증가
//	public void updateHit(final String idx) {
//		
//		String sql = "UPDATE springboard SET "
//					+ "		hits = hits + 1"
//					+ "WHERE idx=? ";
//		
//		// 
//		template.update(sql, new PreparedStatementSetter() {
//			
//			@Override
//			public void setValues(PreparedStatement ps) throws SQLException {
//
//				ps.setInt(1, Integer.parseInt(idx));
//			}
//		});
//	}
//	
//	
//	// 게시물 상세보기
//	public SpringBbsDTO view(String idx) {
//		
//		updateHit(idx);
//		
//		SpringBbsDTO dto = new SpringBbsDTO();
//		String sql = "SELECT * FROM springboard "
//				+ "	  WHERE idx="+idx;
//		
//		/*
//		- queryForObject()는 반환결과가 0개이거나 2개 이상인 경우 예외가 발생하므로
//			반드시 예외처리를 해주는 것이 좋다.
//		- 아래 try문안의 문장을 try문 밖에서 실행해주면 오류남.  */
//		try {
//			// 반환값이 하나만 있는 select계열의 쿼리문 실행
//			dto = template.queryForObject(sql, 
//					new BeanPropertyRowMapper<SpringBbsDTO>(SpringBbsDTO.class));
//		}
//		catch(Exception e) {
//			System.out.println("View()실행시 예외발생");
//		}
//		
//		return dto;
//	}
//	
//	
//	public int password(String idx, String pass) {
//		
//		int retNum = 0;
//		
//		String sql = "SELECT * FROM springboard "
//				+ "	  WHERE pass=" + pass+" AND idx=" + idx;
//		
//		try {
//			SpringBbsDTO dto = template.queryForObject(sql, 
//							new BeanPropertyRowMapper<SpringBbsDTO>(
//									SpringBbsDTO.class));
//			retNum = dto.getIdx();
//		}
//		catch(Exception e) {
//			System.out.println("password() 예외발생");
//		}
//		
//		return retNum;
//	}
//	
//	
//	
//	public void edit(final SpringBbsDTO dto) {
//		System.out.println("DAO edit진입");
//		
//		String sql = "	UPDATE springboard "
//				+ "		SET name=?, title=?, contents=?"
//				+ "		WHERE idx=? AND pass=?";
//		
//		
//		template.update(sql, new PreparedStatementSetter() {
//			
//			@Override
//			public void setValues(PreparedStatement ps) throws SQLException {
//
//				System.out.println("DAO edit > title: " + dto.getTitle());
//				
//				ps.setString(1, dto.getName());
//				ps.setString(2, dto.getTitle());
//				ps.setString(3, dto.getContents());
//				ps.setInt(4, dto.getIdx());
//				ps.setString(5, dto.getPass());
//				
//			}
//		});
//	}
//	
//	
//	public void delete(final String idx, final String pass) {
//		
//		String sql = "	DELETE FROM springboard "
//				+ "		WHERE idx=? AND pass=?";
//		
//		template.update(sql, new PreparedStatementSetter() {
//			
//			@Override
//			public void setValues(PreparedStatement ps) throws SQLException {
//				
//				ps.setString(1, idx);
//				ps.setString(2, pass);
//			}
//		});
//	}
//	
//	
//	// 답변글 입력
//	public void reply(final SpringBbsDTO dto) {
//		/*
//		 * 답변글을 입력하기전 일괄 업데이트 처리
//		 */
//		replyPrevUpdate(dto.getBgroup(), dto.getBstep());
//		
//		// write와 다른 점은 bgroup에 기존게시물의 번호가 들어가는 것이다.
//		String sql = "	INSERT INTO springboard "
//					+ "		(idx, name, title, contents, pass, "
//					+ "			bgroup, bstep, bindent) "
//					+ "	VALUES "
//					+ "		(springboard_seq.nextval, ?, ?, ?, ?, ?, ?, ? )";
//		
//		template.update(sql, new PreparedStatementSetter() {
//			
//			@Override
//			public void setValues(PreparedStatement ps) throws SQLException {
//
//				ps.setString(1, dto.getName());
//				ps.setString(2, dto.getTitle());
//				ps.setString(3, dto.getContents());
//				ps.setString(4, dto.getPass());
//				//원본글의 group번호를 입력
//				ps.setInt(5, dto.getBgroup());
//				//원본글의 step, indent에 +1한 후 입력
//				ps.setInt(6, dto.getBstep()+1);
//				ps.setInt(7, dto.getBindent()+1);
//			}
//		});
//	}
//	
//	
//	/*
//	 * 답변글을 입력하기 전 현재 step보다 큰 게시물들을  일괄적으로 step+1해서 뒤로 
//	 * 밀어주는 작업을 진행한다.
//	 */
//	public void replyPrevUpdate(final int strGroup, final int strStep) {
//		
//		String sql = "	UPDATE springboard "
//				+ "		SET bstep = bstep+1 "
//				+ "		WHERE bgroup=? AND bstep>?";
//		
//		template.update(sql, new PreparedStatementSetter() {
//			
//			@Override
//			public void setValues(PreparedStatement ps) throws SQLException {
//				ps.setInt(1, strGroup);
//				ps.setInt(2, strStep);
//				
//			}
//		});
//	}
//	
//	
	
//
//	
//
}
