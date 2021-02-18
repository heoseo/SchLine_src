package kosmo.project3.schline;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;
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

import kosmo.project3.schline.MainClass.ConnectionThread;
import kosmo.project3.schline.MainClass.NickNameThread;
import kosmo.project3.schline.MainClass.UserClass;

//공부방 채팅 핸들러

//1. handler패키지 클래스 생성 및 TextWebSocketHandler 상속
//@ServerEndpoint("/echo.do")
public class EchoHandler extends TextWebSocketHandler{
	
	public EchoHandler() {
		System.out.println("채팅연결");
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
    	
        sessionList.add(session); //List사용시
        logger.info("{} 연결됨", session.getId());
        logger.info("연결IP: "+session.getRemoteAddress().getHostName());
        
        /*
        getCreateTime : 생성된 시간을 반환해주는 메소드입니다.
		getLastAccessedTime : 마지막으로 세션을 access한 시간을 반환해줍니다.
         */
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
    
	

	//기존방식
//	private static final List<Session> sessionList=new ArrayList<Session>();
//	private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class); 
//	
//
//	
//	@OnOpen 
//	public void onOpen(Session session, HttpSession ses) {
//		
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
//	
    
//    //////안드로이드/////
//    private ServerSocket server;
//
//    //사용자 객체들을 관리하는 ArrayList
//    ArrayList<UserClass> user_list;
//
//    public static void main(String[] args) {
//        System.out.println("이클 서버 연결됨");
//        new EchoHandler();
//    }
//
//    //메인메소드가 static으로 되어있기 때문에 다른것들을 다 static 으로 하기 귀찮기 때문에
//    // 따로 생성자를 만들어서 진행 - > 메인에서는 호출정도의 기능만 구현하는게 좋다.
//    public EchoHandler() {
//        try {
//            user_list = new ArrayList<UserClass>();
//            // 서버 가동
//            server = new ServerSocket(9999);
//            // 사용자 접속 대기 스레드 가동
//            ConnectionThread thread = new ConnectionThread();
//            thread.start();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//    }
//
//    // 사용자 접속 대기를 처리하는 스레드 클래스
//    class ConnectionThread extends Thread {
//
//        @Override
//        public void run() {
//            // TODO Auto-generated method stub
//            try {
//                while (true) {
//              	  Socket socket = server.accept();
//              	  System.out.println("사용자 접속");
//                    // 사용자 닉네임을 처리하는 스레드 가동
//                    NickNameThread thread = new NickNameThread(socket);
//                    thread.start();
//
//                }
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//    }
//
//    // 닉네임 입력처리 스레드
//    class NickNameThread extends Thread {
//        private Socket socket;
//
//        public NickNameThread(Socket socket) {
//            this.socket = socket;
//        }
//
//        public void run() {
//            try {
//                // 스트림 추출
//                InputStream is = socket.getInputStream();
//                OutputStream os = socket.getOutputStream();
//                DataInputStream dis = new DataInputStream(is);
//                DataOutputStream dos = new DataOutputStream(os);
//
//                //닉네임 수신
//                String nickName = dis.readUTF();
//                System.out.println("받은닉네임"+nickName);
//                // 환영 메세지를 전달한다.
//                dos.writeUTF(nickName + " 님 환영합니다.");
//                // 기 접속된 사용자들에게 접속 메세지를 전달한다.
//                sendToClient("서버 : " + nickName + "님이 접속하였습니다.");
//                // 사용자 정보를 관리하는 객체를 생성한다.
//                UserClass user = new UserClass(nickName, socket);
//                user.start();
//                user_list.add(user);
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//    }
//
//    // 사용자 정보를 관리하는 클래스
//    class UserClass extends Thread {
//        String nickName;
//        Socket socket;
//        DataInputStream dis;
//        DataOutputStream dos;
//
//        public UserClass(String nickName, Socket socket) {
//            try {
//                this.nickName = nickName;
//                this.socket = socket;
//                InputStream is = socket.getInputStream();
//                OutputStream os = socket.getOutputStream();
//                dis = new DataInputStream(is);
//                dos = new DataOutputStream(os);
//
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//
//        // 사용자로부터 메세지를 수신받는 스레드
//        public void run() {
//            try {
//                while (true) {
//                    //클라이언트에게 메세지를 수신받는다.
//                    String msg = dis.readUTF();
//                    // 사용자들에게 메세지를 전달한다
//                    sendToClient(nickName + " : " + msg);
//                }
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//    }
//
//    public synchronized void sendToClient(String msg) {
//        try {
//            // 사용자의 수만큼 반복
//            for (UserClass user : user_list) {
//                // 메세지를 클라이언트들에게 전달한다.
//                user.dos.writeUTF(msg);
//
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
}