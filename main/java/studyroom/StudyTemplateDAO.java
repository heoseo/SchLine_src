package studyroom;
/*
JdbcTemplate 관련 주요메소드

- List query(String sql, RowMapper rowMapper)
	: 여러개의 레코드를 반환하는 select계열의 쿼리문인 경우 사용
- List query(String sql, Object[] args, RowMapper rowMapper)
	: 인파라미터를 가진 여러개의 레코드를 반환하는 select계열의
	쿼리문인 경우 사용

- Object queryForObject(String sql, RowMapper rowMapper)
	: 하나의 레코드를 반환하는 select계열의 쿼리문 실행시 사용된다. 
- Object queryForObject(String sql, Object[] args, RowMapper rowMapper)
	: 인파라미터가 있고, 하나의 레코드를 반환하는 select계열의 쿼리문 실행시 사용된다. 

- int queryForInt(String sql)
	: 쿼리문의 실행결과가 숫자를 반환하는 select계열의 쿼리문에
	사용된다. 
- int queryForInt(String sql, Object[] args)
	: 인파라미터가 있고, 쿼리문의 실행결과가 숫자를 반환하는 select계열의 쿼리문에
	사용된다. 

- int update(String sql)
	: 인파라미터가 없는 update/delete/insert 쿼리문을 처리할때 사용
- int update(String sql, Object[] args)
	: 인파라미터가 있는 update/delete/insert 쿼리문을 처리할때 사용
*/

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;

public class StudyTemplateDAO {
	
	//멤버변수
	JdbcTemplate template;
	/*
	컨트롤러에서 @Autowired를 통해 주입받았던 빈을 정적변수인
	JdbcTemplateConst.template에 값을 할당하였으므로, DB연결정보를
	DAO에서 바로 사용하기위해 값을 가져온다.
	 */
	public StudyTemplateDAO() {//생성자
		this.template = StudyTemplateConst.template;
		System.out.println("StudyTemplateDAO 생성자 호출");
	}
	
	public void close() {
		//JDBCTemplate에서는 사용하지 않음.
		/*
		Spring 설정파일에서 빈을 생성하므로 자원을 해제하면 다시
		new를 통해 생성해야하므로 자원해제를 하지 않는다.
		*/
	}
	
	//회원리스트 불러오기
	public ArrayList<InfoVO> people_list()
	{
		String sql =" SELECT * FROM chattinginfo_tb ";
		
			System.out.println("회원 리스트 불러오기");
		/*
		RowMapper 객체가 select를 통해 얻어온 ResultSet을 DTO객체에 저장하고
		list컬렉션에 적재하여 반환한다.
		 */
		//null에러 발생
			
		ArrayList<InfoVO> test = (ArrayList<InfoVO>)
				template.query(sql, new BeanPropertyRowMapper<InfoVO>(InfoVO.class));
		//값이 안나와융!!!!!!!!!
		for(InfoVO info : test) {
			System.out.println("test값="+info.getInfo_nick());
		}
		
		return (ArrayList<InfoVO>)
			template.query(sql, new BeanPropertyRowMapper<InfoVO>(InfoVO.class));
	}
	
	//로그인 학생 정보 불러오기
	public InfoVO my_list(String user_id) {
		/*
		queryForObject()는 반환결과가 0개이거나 2개이상인 경우 예외가 발생하므로
		반드시 예외처리 해주는것이 좋음
		 */
		InfoVO dto = new InfoVO();
		try {
			String sql = "SELECT * FROM chattinginfo_tb WHERE user_id ="+user_id;
			
			//반환값이 하나인 select 계열의 쿼리문 실행
			dto = template.queryForObject(sql, new BeanPropertyRowMapper<InfoVO>(InfoVO.class));
		} 
		catch (Exception e) {
			System.out.println("공부방 학생정보 불러오기 오류");
		}
		return dto;
	}
	
	
	//Mapper로 변경
	//프로필 정보 업데이트 하기
	public void updateInfo (final InfoVO dto) {
		
		String sql = "UPDATE chattinginfo_tb "
				+ " SET info_nick =? , info_img=? "
				+ " WHERE user_id =? ";
		/*
			 매개변수로 전달되는 값을 익명클래스 내에서 사용할때는
			 반드시 final로 선언하여 값의 변경이 불가능하게 해야한다.
			 final로 선언하지 않을경우 에러가 발생한다.
			 	-> 쿼리문은 일회용이므로
		 */
		template.update(sql, new PreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps) throws SQLException {
				ps.setString(1, dto.getInfo_nick());
				ps.setString(2, dto.getInfo_img());
				ps.setString(3, dto.getUser_id());
				
			}
		});
	}
}
