package admin;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import schline.ClassDTOImpl;

@Component
public class FCMScheduleComponent {

	@Autowired
	private SqlSession sqlSession;
	
	@Scheduled(cron = "0/40 * * * * *") //40초 마다 호출
	public void autoUpdate() throws UnsupportedEncodingException {
		
		// 날짜시간에 대한 포맷 지정
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
		// 현재 시간을 위의 포맷으로 변경
		ArrayList<FcmDTO> fcm = sqlSession.getMapper(ClassDTOImpl.class).FcmSchedule();
		
		
		String nowTime = LocalTime.now().format(formatter);
		for (FcmDTO fcmDTO : fcm) {
			if(nowTime.equals(fcmDTO.getEndtime())) {
				ArrayList<String> deviceList = new ArrayList<String>();
				
				deviceList = sqlSession.getMapper(ClassDTOImpl.class).divIdList(fcmDTO.getSubject_idx());					
					
				String ApiKey = "AAAAf7xN3L8:APA91bFZJxe0rqAa5gzTfndBsuJLzU-pj6lYed78fGYsCJgCfIGBh8hcV-gBfAiRPOsdVUa4B3Gsw5gw6PltELeEBKenpDxnmIOvt7Lyxb_vHCW4RuWaVR5g_BSNMIi2nxfSV7ruNw8p";
				String fcmURL = "https://fcm.googleapis.com/fcm/send";
				
				
				String notiTitle = fcmDTO.getExam_name();
				String notiBody = "과제마감 3시간전 입니다!!!";
				String message = "0ㅇ0";
				System.out.println(notiTitle+"--"+message);

				try{
					

					//연결
					URL url = new URL(fcmURL);
					HttpURLConnection conn = (HttpURLConnection) url.openConnection();
					
					conn.setUseCaches(false);
					conn.setDoInput(true);
					conn.setDoOutput(true);
					
					conn.setRequestMethod("POST");
					conn.setRequestProperty("Authorization", "key="+ApiKey);
					conn.setRequestProperty("Content-Type", "application/json");
					
					JSONObject json = new JSONObject();
					
					JSONObject noti = new JSONObject();
					noti.put("title", notiTitle);
					noti.put("body", notiBody);
					
					JSONObject data = new JSONObject();
					data.put("message", message);
					
					//json.put("to", deviceId1);//한명한테 보낼때..
					json.put("registration_ids", deviceList);//여러명한테 보낼때..
					
					json.put("notification", noti);
					json.put("data", data);
					
					try{
						OutputStreamWriter wr = new OutputStreamWriter(
								conn.getOutputStream());
						System.out.println("JSON="+ json.toString());
						wr.write(json.toString());
						wr.flush();
						
						BufferedReader br = new BufferedReader(
								new InputStreamReader(conn.getInputStream()));
						
						String output;
						System.out.println("Output from Server ... \n");
						while((output = br.readLine()) != null){
							System.out.println(output);
						}
					}
					catch(Exception e){
						e.printStackTrace();
					}
					
				}
				catch(Exception e){
					e.printStackTrace();
				}
			}
			
		}
		System.out.println("스프링 스케쥴러 실행중~");
		
		
	}
	
		
	}

