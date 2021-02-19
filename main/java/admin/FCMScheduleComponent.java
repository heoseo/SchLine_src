package admin;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class FCMScheduleComponent {

	@Scheduled(cron = "0/10 * * * * *") //10초 마다 호출
	public void autoUpdate() {
		
		// 날짜시간에 대한 포맷 지정
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
		// 현재 시간을 위의 포맷으로 변경
		String nowTime = LocalTime.now().format(formatter);
		System.out.println("스케쥴러 호출됩니다."+ nowTime);
		
		
		
	}
	
}
