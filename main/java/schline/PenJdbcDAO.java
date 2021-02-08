package schline;

import java.io.InputStream;
import java.io.Reader;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.Array;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.NClob;
import java.sql.ParameterMetaData;
import java.sql.PreparedStatement;
import java.sql.Ref;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.RowId;
import java.sql.SQLException;
import java.sql.SQLWarning;
import java.sql.SQLXML;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Map;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.PreparedStatementCreatorFactory;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.stereotype.Repository;


public class PenJdbcDAO {
	
	//멤버변수
	JdbcTemplate template;
	
	public PenJdbcDAO() {
		this.template = PenJdbcConst.template;
		System.out.println("JDBCTemplateDAO() 생성자 호출");
	}

	//게시물수 카운트
	public int getTotalCount(Map<String, Object> map)
	{
		String sql = "SELECT COUNT(*) FROM penboard "
		+ "  where board_type = '"+map.get("board_type")+"' ";	
		if(map.get("Word")!=null){
			sql +=" and "+map.get("Column")+" "
				+ " 	LIKE '%"+map.get("Word")+"%' ";				
		}
		//쿼리문에서 count(*)를 통해 반환되는 값을 정수형태로 반환한다.
		return template.queryForObject(sql, Integer.class);		
	}
	
	//글쓰기 처리
	public void write(final PenBbsDTO penBbsDTO) {
		System.out.println("PenJDBCDAO > penBbsDTO : " + penBbsDTO.toString());
		System.out.println("PenJDBCDAO > template : " + template);
		
		template.update(new PreparedStatementCreator() {
	
			@Override
			public PreparedStatement createPreparedStatement(Connection con) 
					throws SQLException {
				
				String sql = "INSERT INTO penboard ("
					+ " pen_idx, subject_idx, board_type, user_id, board_title, "
					+ " board_content,bgroup ) "
					+ " VALUES ("
					+ " seq_penboard.NEXTVAL,?,?,?,?,?,"
					+ "	seq_penboard.NEXTVAL)";
				//로그인 session 가져오기
				PreparedStatement psmt = con.prepareStatement(sql);
				psmt.setString(1, penBbsDTO.getSubject_idx());
				psmt.setString(2, penBbsDTO.getBoard_type());
				psmt.setString(3, "201701701");
				psmt.setString(4, penBbsDTO.getBoard_title());
				psmt.setString(5, penBbsDTO.getBoard_content());
				
				return psmt;
			}
		});			
	}
	//조회수 증가
	public void updateHit(final String pen_idx)
	{
		String sql = "UPDATE penboard SET "
			+ " hits=hits+1 "
			+ " WHERE pen_idx=? ";
		template.update(sql, new PreparedStatementSetter() {			
			
				@Override
			public void setValues(PreparedStatement ps) throws SQLException {
				ps.setInt(1, Integer.parseInt(pen_idx));				
			}
		});		 
	}	
	//게시물 상세보기
	public PenBbsDTO view(String pen_idx)
	{		
		//조회수 증가 위해 호출
		updateHit(pen_idx);		
		
		PenBbsDTO dto = new PenBbsDTO();		
		String sql = "SELECT * FROM penboard "
				+ " WHERE pen_idx="+pen_idx;	
	 		
		/*
		queryForObject()는 반환결과가 0개이거나 2개이상인경우
		예외가 발생되므로 반드시 예외처리를 해주는것이 좋다. 
		 */
		try {
			//반환값이 하나만 있는 select계열의 쿼리문 실행
			dto = template.queryForObject(sql, 
					new BeanPropertyRowMapper<PenBbsDTO>(						
							PenBbsDTO.class));			
		}
		catch (Exception e) {
			System.out.println("View()실행시 예외발생");		 
		}
		return dto;
	}	

	//수정처리
	public void edit(final PenBbsDTO dto)
	{		 
		System.out.println("PenJDBCDAO > edit : " + dto.toString());
		String sql = "UPDATE penboard "
			+ " SET  board_title=?, board_content=?"
			+ " WHERE pen_idx=? ";
				 
		template.update(sql, new PreparedStatementSetter() {
			@Override
			public void setValues(PreparedStatement ps) 
					throws SQLException {
				ps.setString(1, dto.getBoard_title());
				ps.setString(2, dto.getBoard_content());
				ps.setString(3, dto.getPen_idx());
				
			}			
		});			 
	}
	//삭제처리
	public void delete(final String pen_idx){
		 
		String sql = "DELETE FROM penboard "
			+ " WHERE pen_idx=?";
	
		template.update(sql, new PreparedStatementSetter() {
			@Override
			public void setValues(PreparedStatement ps) 
					throws SQLException {
				ps.setString(1, pen_idx);
							}
		});
	}
	//답변글 입력	
	public void reply(final PenBbsDTO dto){
		
		/*
		답변글을 입력하기전 일괄 업데이트 처리
		 */
		replyPrevUpdate(Integer.parseInt(dto.getBgroup()) , Integer.parseInt(dto.getBstep()));
		System.out.println("PenJDBCDAO > edit : " + dto.toString());
		if(dto.getYorn() != null){
			String sql = "INSERT INTO penboard "
					+ " (pen_idx, subject_idx, board_type, user_id, board_title, "
					+ " board_content, bgroup, bstep, bindent,yorn) "
					+ " VALUES "
					+ " (seq_penboard.nextval, ?, ?, ?, ?,"
					+ " ?, ?, ?, ?,?)";
				
				template.update(sql, new PreparedStatementSetter() {
					@Override
					public void setValues(PreparedStatement ps) throws SQLException {
						ps.setString(1, dto.getSubject_idx() );
						ps.setString(2, dto.getBoard_type() );
						ps.setString(3, "201701712");
						ps.setString(4, dto.getBoard_title() );
						ps.setString(5, dto.getBoard_content() );
						ps.setString(6, dto.getBgroup());
						ps.setInt(7, Integer.parseInt(dto.getBstep())+1);
						ps.setInt(8, Integer.parseInt(dto.getBindent())+1);
						ps.setString(9, dto.getYorn());
					}
				});		
		}else {
			String sql = "INSERT INTO penboard "
				+ " (pen_idx, subject_idx, board_type, user_id, board_title, "
				+ " board_content, bgroup, bstep, bindent) "
				+ " VALUES "
				+ " (seq_penboard.nextval, ?, ?, ?, ?,"
				+ " ?, ?, ?, ?)";
			
			template.update(sql, new PreparedStatementSetter() {
				@Override
				public void setValues(PreparedStatement ps) throws SQLException {
					ps.setString(1, dto.getSubject_idx() );
					ps.setString(2, dto.getBoard_type() );
					ps.setString(3, "201701712");
					ps.setString(4, dto.getBoard_title() );
					ps.setString(5, dto.getBoard_content() );
					ps.setString(6, dto.getBgroup());
					ps.setInt(7, Integer.parseInt(dto.getBstep())+1);
					ps.setInt(8, Integer.parseInt(dto.getBindent())+1);
				}
			});
		}
	}
		
	/*
	답변글을 입력하기전 현재 step보다 큰 게시물들을 일괄적으로
	step+1해서 뒤로 밀어주는 작업을 진행한다. 
	 */
	public void replyPrevUpdate(final int strGroup, final int strStep) {
		
		String sql = "UPDATE penboard "
				+ " SET bstep = bstep+1 "
				+ " WHERE bgroup=? AND bstep=?";
		template.update(sql, new PreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps) throws SQLException {
				ps.setInt(1, strGroup);
				ps.setInt(2, strStep);
			}
		});		
	}

	
	
	//리스트처리(페이지O)
	public ArrayList<PenBbsDTO> listPage(Map<String, Object> map){
		
		int start = Integer.parseInt(map.get("start").toString());
		int end = Integer.parseInt(map.get("end").toString());
		
		String sql = ""
				+"SELECT * FROM ("
				+"    SELECT Tb.*, rownum rNum FROM ("
				+"        SELECT * FROM penboard "
				+ "  where board_type = '"+map.get("board_type")+"' ";				
			if(map.get("Word")!=null){
				sql +=" and "+map.get("Column")+" "
					+ " LIKE '%"+map.get("Word")+"%' ";				
			}			
			sql += " ORDER BY bgroup DESC, bstep ASC"			
			+"    ) Tb"
			+")"
			+" WHERE rNum BETWEEN "+start+" and "+end;
 	
		return (ArrayList<PenBbsDTO>)template
				.query(sql, new BeanPropertyRowMapper<PenBbsDTO>(PenBbsDTO.class));
	}


	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
