package studyroom;

public class InfoVO {
	
	private String user_id;//사용자 아이디 PK, FK
	private int info_atten; //총 출석일
	private int info_time; //누적 사용시간
	private String info_nick; //닉네임
	private String info_img; //프로필 이미지
	
	//내 등수를 가져오기 위해 추가된 변수(디비x)
	private int info_lack;
	public int getInfo_lack() {
		return info_lack;
	}
	public void setInfo_lack(int info_lack) {
		this.info_lack = info_lack;
	}
	
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
