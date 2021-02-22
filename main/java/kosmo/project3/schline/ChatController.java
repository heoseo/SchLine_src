package kosmo.project3.schline;

import java.util.ArrayList;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

@Controller
@ServerEndpoint("/EchoServer.do")
public class ChatController {
	
	private static final List<Session> sessionList=new ArrayList<Session>();
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class); 
	
	public ChatController() {
		System.out.println("웹소켓(서버) 객체생성");
	} 

	
	@OnOpen 
	public void onOpen(Session session) {
		logger.info("Open session id:"+session.getId()); 
		try {
			final Basic basic=session.getBasicRemote();
	    	System.out.println(session.getId()+"웹소켓 채팅 연결됨");
//			basic.sendText("대화방에 연결 되었습니다.");
		}
		catch (Exception e) { 
			System.out.println(e.getMessage());
		}
		sessionList.add(session);
        logger.info("{} 연결됨", session.getId());
	} 	
	
	//메세지 뿌리기
	private void sendAllSessionToMessage(Session self, String message) { 
		try { 
			for(Session session : ChatController.sessionList) {
				if(!self.getId().equals(session.getId())) {
					session.getBasicRemote().sendText(message);
				}
			}
		}catch (Exception e) { 
			System.out.println(e.getMessage());
		}
	}
	
	//메세지 수신
	@OnMessage 
	public void onMessage(String message, Session session) {
		//String sender = message.split(",")[1];
		//message = message.split(",")[0];
    	logger.info("{}로 부터 {} 받음", session.getId(), message);
    	System.out.println("메세지="+message);
		try {
			final Basic basic=session.getBasicRemote();
			//basic.sendText(message);
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
		sendAllSessionToMessage(session, message);
	}
	
	@OnError 
	public void onError(Throwable e,Session session) {}
	
	@OnClose 
	public void onClose(Session session) {
		sessionList.remove(session);
        logger.info("{} 연결 끊김.", session.getId());
	} 	
}
