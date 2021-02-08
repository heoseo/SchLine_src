package kosmo.project3.schline;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.context.request.SessionScope;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

//공부방 채팅 핸들러

//1. handler패키지 클래스 생성 및 TextWebSocketHandler 상속
//@ServerEndpoint("/echo.do")
public class EchoHandler extends TextWebSocketHandler{
	//연결확인을 위한 생성자
	public EchoHandler() {
		System.out.println("다혜채팅 연결");
	} 

    /*
		-클라이언트 접속때마다 Session id 저장하기에 static으로 선언
		-웹브라우저가 웹소켓을 지원해야함. 닫으면 close됨
		-Collection의 syncronizedSet()은 공유객체의 동시접근 막음
     */
//    private static Set<WebSocketSession> clients 
//    	= Collections.synchronizedSet(new HashSet<WebSocketSession>());
    
	 //세션 리스트(기존)
  private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
  
    
    //로그를 남기기위한 변수
    private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);

    
    //2.이벤트 처리를위한 메소드들 선언
    
    //클라이언트 연결
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	System.out.println(session.getId()+"웹소켓 채팅 연결됨");
    	
    	//Set컬렉션에 사용자 세션아이디 추가
//    	clients.add(session);
        sessionList.add(session); //List사용시
        logger.info("{} 연결됨", session.getId());
        logger.info("연결IP: "+session.getRemoteAddress().getHostName());
    }
    
   
    //클라이언트가 웹소켓 서버로 메시지를 전송 시
    /*
	    1. Send : 클라이언트가 서버에 메세지 전송
	    2. Emit : 서버에 연결된 클라이언트에게 메세지 전송
	    #{0}: 메세지보낸 클라이언트 , #{1}: 메세지내용 
     */
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        //동기화블럭으로 공유객체의 동시접근 제한
//        synchronized (clients) {
        synchronized (sessionList) {
        	System.out.println("메세지전송 실행");
        	logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
        	
        	//모든 유저에게 메세지 출력
        	for(WebSocketSession user : sessionList){
        		//보낸 사용자는 받지않는 조건문
        		if (!session.getId().equals(user.getId())) {//user아니고 user.getId()로 해줘야함!!!
        			user.sendMessage(new TextMessage(message.getPayload()));
        		}
        	}
        }
//        for(WebSocketSession sess : sessionList){
//        	sess.sendMessage(new TextMessage(message.getPayload()));
//        }
    }
    
    
    /*
		클라이언트와 서버 연결종료
		CloseStatus: 연결상태(확인필요)
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    	System.out.println("연결끊김");
//        sessionList.remove(session);
    	sessionList.remove(session);
        logger.info("{} 연결 끊김.", session.getId());
    }
    
	
	
	
	
	
	
	
//	private static final List<Session> sessionList=new ArrayList<Session>();
//	private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class); 
//	
//
//	
//	@OnOpen 
//	public void onOpen(Session session) {
//		logger.info("Open session id:"+session.getId()); 
//		try {
//			final Basic basic=session.getBasicRemote();
//			basic.sendText("대화방에 연결 되었습니다.");
//		}
//		catch (Exception e) { 
//			System.out.println(e.getMessage());
//		}
//		
//		sessionList.add(session);
//	} 	
//	
//	
//	private void sendAllSessionToMessage(Session self, String message) { 
//		try { 
//			for(Session session : EchoHandler.sessionList) {
//				if(!self.getId().equals(session.getId())) {
//					session.getBasicRemote().sendText(message);
//				}
//			}
//		}catch (Exception e) { 
//			System.out.println(e.getMessage());
//		}
//	}
//	
//	@OnMessage 
//	public void onMessage(String message, Session session) {
//		//String sender = message.split(",")[1];
//		//message = message.split(",")[0];
//		logger.info("Message From : "+message); 
//		try {
//			final Basic basic=session.getBasicRemote();
//			//basic.sendText(message);
//		}
//		catch (Exception e) {
//			System.out.println(e.getMessage());
//		}
//		sendAllSessionToMessage(session, message);
//	}
//	
//	@OnError 
//	public void onError(Throwable e,Session session) {}
//	
//	@OnClose 
//	public void onClose(Session session) {
//		logger.info("Session "+session.getId()+" has ended");
//		sessionList.remove(session);
//	} 	
//	
	
	
	
	
	
	
}