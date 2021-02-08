<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<script type="text/javascript">
//대화가 디스플레이 되는 영역
var messageWindow;
//대화 입력 부분
var inputMessage;
//접속자 ID, 닉네임, 이미지 가져오는 부분
var user_id;
var chat_name;
var chat_image;
//웹소켓 객체 생성하여 서버 접속
var webSocket;

window.onload = function() {
	//대화 디스플레이 영역
	messageWindow = document.getElementById("chat-container");
	//대화영역의 스크롤바는 항상 아래로
	messageWindow.scrollTop = messageWindow.scrollHeight;
	//메세지 입력
	inputMessage = document.getElementById('inputMessage');
	//로그인 정보
	chat_id = document.getElementById('chat_id').value;
	chat_name = document.getElementById('chat_name').value;
	chat_img = document.getElementById('chat_img').value;
	///////////////테이블명보고 이름 바꿔주자///////////////////
	
	/*
	JS의 WebSocket객체를 이용해서 웹소켓 서버에 연결한다.
	웹소켓이므로 ws://로 시작한다. 마지막 경로에는 @ServerEndpoint
	어노테이션으로 지정했던 요청명을 사용한다.
	*/
	webSocket = new WebSocket('ws://localhost:9999/SchLine/ChatServer02');
	
    webSocket.onopen = function(event){
		wsOpen(event);
    };
	webSocket.onmessage = function(event){
		wsMessage(event);
    };
    webSocket.onclose = function(event){
		wsClose(event);
    };
    webSocket.onerror = function(event){
		wsError(event);
    };
}

//웹소켓 서버가 메세지를 받은 후 클라이언트에게 Echo할때 처리부분
function wsMessage(event) {
	var message = event.data.split("|");
	//첫번째 : 전송한 사람 아이디
	var sender = message[0];
	//두번째 : 채팅내용
	var content = message[1];
	var msg;
	
	//★상대방 아이콘 터치시 모달창으로 정보보이고, 귓속말, 신고, 차단 기능 구현
	
	if(content==""){
		//채팅내용 없다면 아무일도 하지않음
	}
	else{
		//내용에 @가 있다면 귓속말 명령어
		if(content.match("@")){
			if(content.match("@"+chat_name)){
				//귓속말 명령어를 한글로 대체한 후
				var temp = content.replace(("@"+chat_name), "[귓속말]:");
				//메세지에 UI 적용부분
				msg = makeBalloon(sender, temp);
				messageWindow.scrollTop = messageWindow.scrollHeight;
			}
		}
		//신고, 차단 기능 명령어
		//신고 클릭시 명령어 실행..?
		else if(content.match("/")){
			if(content.match("/"+"bolck")){
				
			}
		}
		else{
			//명령어가 아닐시 모두에게 디스플레이
			msg = makeBalloon(sender, content);
			messageWindow.scrollTop = messageWindow.scrollHeight;
		}
	}
}
//상대방이 보낸 메세지 출력 부분
function makeBalloon(id, cont){
   var msg = '';
   msg += '<div class="chat chat-left">';
   msg += '   <!-- 프로필 이미지 -->';
   msg += '   <span class="profile profile-img-b"></span>';
   msg += '   <div class="chat-box">';
   msg += '      <p style="font-weight: bold; font-size: 1.1em; margin-bottom: 5px;">'+id+'</p>';
   msg += '      <p class="bubble">'+cont+'</p>';
   msg += '      <span class="bubble-tail"></span>';
   msg += '   </div>';
   msg += '</div>';
   return msg;
}

function wsClose(event) {
	messageWindow.value += "연결끊기성공\n";
}
function wsError(event) {//에러메세지 경고창 띄워주기
	alert(event.data);
}

//클라이언트가 메세지 입력후 '보내기'버튼 누를때 호출
function sendMessage() {
	//웹소켓 서버로 대화내용 전송
	webSocket.send(chat_name+'|'+inputMessage.value);
	
	//내가 보낸 내용에 UI적용
	var msg = '';
    msg += '<div class="chat chat-right">';
    msg += '   <!-- 프로필 이미지 -->';
    msg += '   <span class="profile profile-img-a"></span>';
    msg += '   <div class="chat-box">';
    msg += '      <p class="bubble-me">'+inputMessage.value+'</p>';
    msg += '      <span class="bubble-tail"></span>';
    msg += '   </div>';
    msg += '</div>';
    
    messageWindow.innerHTML += msg;
    //전송 후 입력했던 대화내용 삭제
    inputMessage.value="";
    
    //대화영역의 스크롤바를 항상 아래로
    messageWindow.scrollTop = messageWindow.scrollHeight;
}

function enterkey() {
	//키보드 키코드 13(엔터키)일때 함수 즉시호출
	if(window.event.keyCode==13){
		sendMessage();
	}
}
</script>



<%--   		<input type="hidden" name="chat_id" value="${param.user_id }" /> --%>
<%--   		<input type="hidden" name="chat_name" value="${param.info_nick }" /> --%>
<%--   		<input type="hidden" name="chat_image" value="${param.info_img }" /> --%>
  		<input type="hidden" id="chat_id" value="lave" />
  		<input type="hidden" id="chat_name" value="라부" />
  		<input type="hidden" id="chat_img" value="" />
<%--   		<input type="hidden" name="chat_id" value="${param.user_id }" /> --%>
<%--   		<input type="hidden" name="chat_name" value="${param.info_nick }" /> --%>
<%--   		<input type="hidden" name="chat_image" value="${param.info_img }" /> --%>
   	<div id="chat-container" class="chat-area" style="height:500px;overflow:auto;">
	  		<p class="text-area">
	  			<!-- 메세지 입력창 -->
	  			<input type="text" id="inputMessage" onkeyup="enterkey();"
	  			style="width:auto; height: 60px; border: 0;"/>
	  		</p>
	   		<br />
   		</div>