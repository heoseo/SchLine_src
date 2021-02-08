package schedule;

//파라미터 처리를 위한 DTO객체.
public class CalendarDTO {

	private String hmonth; //히든폼 해당월
	private String hyear; //히든폼 해당년도
	private String calMon; //리스트부분 해당월
	private String calYear; //리스트부분 해당 년도.
	
	//디폴트생성자 생성.
	public CalendarDTO() {}
	
	public CalendarDTO(String hmonth, String hyear, String calMon, String calYear) {
		super();
		this.hmonth = hmonth;
		this.hyear = hyear;
		this.calMon = calMon;
		this.calYear = calYear;
	}
	
	
	//getter/setter 메소드생성.
	public String getHmonth() {
		return hmonth;
	}

	public void setHmonth(String hmonth) {
		this.hmonth = hmonth;
	}

	public String getHyear() {
		return hyear;
	}

	public void setHyear(String hyear) {
		this.hyear = hyear;
	}

	public String getCalMon() {
		return calMon;
	}

	public void setCalMon(String calMon) {
		this.calMon = calMon;
	}

	public String getCalYear() {
		return calYear;
	}

	public void setCalYear(String calYear) {
		this.calYear = calYear;
	}
	
	

	
	
	
	
	
	
	
	
}
