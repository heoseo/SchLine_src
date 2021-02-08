package studyroom;

public class InfoVO {
	
	private String user_id;//사용자 아이디 PK, FK
	private String info_nick; //닉네임
	private String info_img; //프로필 이미지
	private int info_atten; //총 출석일
	private int info_time; //누적 사용시간
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getInfo_nick() {
		return info_nick;
	}
	public void setInfo_nick(String info_nick) {
		this.info_nick = info_nick;
	}
	public String getInfo_img() {
		return info_img;
	}
	public void setInfo_img(String info_img) {
		this.info_img = info_img;
	}
	public int getInfo_atten() {
		return info_atten;
	}
	public void setInfo_atten(int info_atten) {
		this.info_atten = info_atten;
	}
	public int getInfo_time() {
		return info_time;
	}
	public void setInfo_time(int info_time) {
		this.info_time = info_time;
	}
}
