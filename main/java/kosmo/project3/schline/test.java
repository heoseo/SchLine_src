//package kosmo.project3.schline;
//
//import java.sql.PreparedStatement;
//import java.util.ArrayList;
//
//import org.springframework.jdbc.core.BeanPropertyRowMapper;
//import org.springframework.jdbc.core.PreparedStatementCreator;
//
//import springboard.model.JDBCTemplateDAO;
//import springboard.model.SpringBbsDTO;
//
//public class test {
//	
//	//게시판 글 등록하기
//	public void write(final BoardDTO boardDTO) {
//		template.update(~~~){
//			
//			//게시판에 글 등록하는 쿼리
//			String sql = "INSERT INTO baord_tb~~~~";
//			
//			//board_type = noti이면
//			if(boardDTO.getBoardType().equals("noti")) {
//			
//				//해당 과목을 수강하는 학생 리스트 배열로 가져오기.
//				ArrayList<String> studentList = getStudentList(boardDTO.getSubjectIdx());
//				
//			
//				//해당과목 수강하는 학생 수 만큼 noticecheck_tb에 insert하기
//				JDBCTemplateDAO dao = new JDBCTemplateDAO();
//				dao.insertNotiCheck(studentList);
//				
//			}
//			
//			
//		}
//	}
//	
//	//해당과목 수강하는 학생 수 만큼 noticecheck_tb에 insert하기
//	public void insertNotiCheck(final ArrayList<String> studentList) {
//		
//		for(String student_id : studentList) {
//			template.update(~~~~){
//				String sql = "INSERT noticecheck_tb VALUES(시퀀스, ?, 0)";
//				
//				PreparedStatement psmt = con.prepareStatement(sql);
//				psmt.setString(1, student_id);
//			}
//		}
//	}
//	
//	//해당 과목 수강하는 학생리스트 가져오기
//	public void getStudentList(final String subject_idx) {
//		
//			
//		String sql = "select user_id
//						from registration_tb
//						where subject_idx=1";
//						
//		return (ArrayList<SpringBbsDTO>)
//				template.query(sql, ~~~~~);
//								
//							
//	}
//
//}
