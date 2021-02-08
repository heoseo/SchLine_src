package studyroom;

import java.sql.Date;

public class ChatDTO {
	
	//테이블명 : chatting_tb
	private int chat_message_idx; //메세지idx, PK
	private String user_id; //학생id, FK
	private String chat_content;//내용
	private Date chat_time; //메세지 보낸시간
	
	
	public int getChat_message_idx() {
		return chat_message_idx;
	}
	public void setChat_message_idx(int chat_message_idx) {
		this.chat_message_idx = chat_message_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getChat_content() {
		return chat_content;
	}
	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}
	public Date getChat_time() {
		return chat_time;
	}
	public void setChat_time(Date chat_time) {
		this.chat_time = chat_time;
	}	
}
