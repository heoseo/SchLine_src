package schline;

public class PenBbsDTO {
	private String pen_idx ;
	private String subject_idx ;
	private String board_type;
	private String user_id ;
	private String board_title ;
	private String board_content ;
	private String  hits ;
	private String  bgroup ;
	private String bstep ;
	private String bindent ;
	private String yorn ;
	private java.sql.Date postdate;
	
	private int virtualNum;

	@Override
	public String toString() {
		return "PenBbsDTO [pen_idx=" + pen_idx + ", subject_idx=" + subject_idx + ", board_type=" + board_type
				+ ", user_id=" + user_id + ", board_title=" + board_title + ", board_content=" + board_content
				+ ", hits=" + hits + ", bgroup=" + bgroup + ", bstep=" + bstep + ", bindent=" + bindent + ", yorn="
				+ yorn + ", postdate=" + postdate + ", virtualNum=" + virtualNum + "]";
	}

	public String getPen_idx() {
		return pen_idx;
	}

	public void setPen_idx(String pen_idx) {
		this.pen_idx = pen_idx;
	}

	public String getSubject_idx() {
		return subject_idx;
	}

	public void setSubject_idx(String subject_idx) {
		this.subject_idx = subject_idx;
	}

	public String getBoard_type() {
		return board_type;
	}

	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public String getHits() {
		return hits;
	}

	public void setHits(String hits) {
		this.hits = hits;
	}

	public String getBgroup() {
		return bgroup;
	}

	public void setBgroup(String bgroup) {
		this.bgroup = bgroup;
	}

	public String getBstep() {
		return bstep;
	}

	public void setBstep(String bstep) {
		this.bstep = bstep;
	}

	public String getBindent() {
		return bindent;
	}

	public void setBindent(String bindent) {
		this.bindent = bindent;
	}

	public String getYorn() {
		return yorn;
	}

	public void setYorn(String yorn) {
		this.yorn = yorn;
	}

	public java.sql.Date getPostdate() {
		return postdate;
	}

	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}

	public int getVirtualNum() {
		return virtualNum;
	}

	public void setVirtualNum(int virtualNum) {
		this.virtualNum = virtualNum;
	}
}
