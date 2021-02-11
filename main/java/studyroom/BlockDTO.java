package studyroom;

//차단 테이블 chattingblock_tb
public class BlockDTO {
	
	private String user_id;
	private String block_user;//차단한 사람 아이디
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getBlock_user() {
		return block_user;
	}
	public void setBlock_user(String block_user) {
		this.block_user = block_user;
	}
}
