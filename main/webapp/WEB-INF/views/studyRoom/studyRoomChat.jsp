<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
@charset "utf-8";

/* reset */

/* html {height:100%; overflow-y:scroll} */
/* body {height: auto; width: auto; overflow:auto;} */
/* html, h1, h2, h3, h4, h5, h6, form, fieldset, img {margin:0;padding:0;border:0} */
ul,li,ol,dl,dd,dt{list-style:none;padding:0;margin:0;font-size:1em}
article, aside, details, figcaption, figure, footer, header, hgroup, menu, nav, section {display:block}
legend {position:absolute;margin:0;padding:0;font-size:0;line-height:0;text-indent:-9999em;overflow:hidden}
label, input, button, select, img {vertical-align:middle}
input, button {margin:0;padding:0;}
button {cursor:pointer;font-family:'돋움', Dotum , sans-serif;border:none;padding:0;background:#fff;outline:0}
input[type="submit"]{cursor:pointer;}
textarea, select {font-family:'돋움', Dotum;font-size:1em}
select {margin:0;padding:0}
p {margin:0;padding:0;word-break:break-all}
hr {display:none}
pre {overflow-x:scroll;}
a, a:link, a:visited {color:#000;text-decoration:none}
a:hover{text-decoration:underline;color:#ff5191}
a:focus, a:active {color:#000;text-decoration:none;}


/* 본문 */

#chat-wrapper{margin:20px auto;width:580px;border-radius:10px 10px 0 0;background:#edecea;}
#chat-header{background:url('../img/ctrl.png') #cecece 510px 20px no-repeat;padding:25px;border-radius:10px 10px 0 0}
#chat-header h1{font-size:14px;}
#chat-container{padding:20px}
#chat-container:after{display:block;visibility:hidden;clear:both;content:"";}
#chat-footer{background:#CECECE;padding:20px;}
#chat-footer p.text-area{background:#fff;min-height:65px;border-radius:5px}
#chat-footer p.text-area button{float:right;padding:25px 20px;border-radius:5px;background:#777;color:#fff;}

/* 채팅 말풍선 */

.chat{position:relative;width:100%;margin-bottom:10px}
.chat:after{display:block;visibility:hidden;clear:both;content:"";}
.chat .bubble{display:inline-block;max-width:300px;padding:10px;background:#fff;border-radius:5px;line-height:16px;}
.chat .bubble-me{display:inline-block;max-width:300px;padding:10px;background:#D3E3F4;border-radius:5px;line-height:16px;}

/* 왼쪽 채팅 */
.chat-left .profile{float:left;display:inline-block;width:70px;height:70px;}
.chat-left .chat-box{display:inline-block;margin:15px 0 0 10px;}

/* -- 프로필 이미지 타입 -- */
.chat-left .profile-img-a{background:url('<%=request.getContextPath()%>/resources/img/profile-a.png') 0 0 no-repeat;}
.chat-left .profile-img-b{background:url('<%=request.getContextPath()%>/resources/img/profile-b.png') 0 0 no-repeat;}
.chat-left .profile-img-c{background:url('<%=request.getContextPath()%>/resources/img/profile-c.png') 0 0 no-repeat;}
.chat-left .profile-img-d{background:url('<%=request.getContextPath()%>/resources/img/profile-d.png') 0 0 no-repeat;}

.chat-left .bubble{margin-left:10px;}
.chat-left .bubble .bubble-tail{position:absolute;left:84px;top:25px;width:9px;height:10px;background: url('<%=request.getContextPath()%>/resources/img/bubble-tail.png') 0 0 no-repeat;text-indent:-9999px}

/* -- 오른쪽 채팅 -- */
.chat-right{text-align:right}
.chat-right .profile{float:right;display:inline-block;width:70px;height:70px;}
.chat-right .chat-box{display:inline-block;margin:15px 10px 0 0;}

/* 프로필 이미지 타입 */
.chat-right .profile-img-a{background:url('<%=request.getContextPath()%>/resources/img/profile-a.png') 0 0 no-repeat;}
.chat-right .profile-img-b{background:url('<%=request.getContextPath()%>/resources/img/profile-b.png') 0 0 no-repeat;}
.chat-right .profile-img-c{background:url('<%=request.getContextPath()%>/resources/img/profile-c.png') 0 0 no-repeat;}
.chat-right .profile-img-d{background:url('<%=request.getContextPath()%>/resources/img/profile-d.png') 0 0 no-repeat;}

.chat-right .bubble-me {margin-right:10px;}
.chat-right .bubble-tail {position:absolute;right:84px;top:25px;width:9px;height:10px;background: url('<%=request.getContextPath()%>/resources/img/bubble-tail-right.png') 0 0 no-repeat;text-indent:-9999px}

</style>



<div class="container">
 
<script type="text/javascript">

$(document).ready(function() {
	messages = document.getElementById("messageWindow");
	openSocket();
});


var ws; 
var messages;

function openSocket(){ 
	
	if(ws !== undefined && ws.readyState !== WebSocket.CLOSED ){
		writeResponse("WebSocket is already opened."); 
		return;
	}
	
	//웹소켓 객체 만드는 코드
	//호출명 뒤에 /websocket 해주어야 웹소켓 200에러 막을  수 있다.ㅠㅠㅠㅠ흐앙
	//해당컴에 해당하는 경로로 변경해주기!
	ws = new WebSocket("ws://localhost:9999/schline/echo.do/websocket");
	ws.onopen = function(event){ 
		if(event.data === undefined){
			return;
		}
		writeResponse(event.data);
	};
	ws.onmessage = function(event){ 
		console.log('writeResponse'); 
		console.log(event.data);
		writeResponse(event.data);
	};
	ws.onclose = function(event){
		writeResponse("대화 종료");
	}
}

//접속자 메세지 입력후 '보내기' 눌렀을때
function send(){
	var msg = document.getElementById("inputMessage").value;
	var sender = document.getElementById("info_nick").value;
	var user_img = document.getElementById("info_img").value;//내 프로필
	
	//프로필 이미지, bubble-tail 에러남★★★★★
	ws.send(sender+"|"+msg);
	var text = '';
		text += '<div class="chat chat-right">';
	    text += '   <!-- 프로필 이미지 -->';
	    msg += '   <span class="profile profile-img-a"></span>';
	    text += '   <div class="chat-box">';
	    text += '      <p class="bubble-me">'+inputMessage.value+'</p>';
	    text += '      <span class="bubble-tail"></span>';
	    text += '   </div>';
	    text += '</div>';
		
	   messageWindow.innerHTML += text;
	//서버로 메세지 전송
	//입력했던 대화내용 지워줌
	text = "";
}
function closeSocket(){
	ws.close();
} 
function writeResponse(text){
	messages.innerHTML += "<br/>"+text;
} 
function clearText(){ 
	console.log(messages.parentNode);
	messages.parentNode.removeChild(messages)
}

//키보드 눌렀을때 보내기함수 호출
function enterkey(){
   if(window.event.keyCode==13){
      send();
   }
}
</script>


	
<div id="messageWindow" class="border border-primary" style="height:300px; overflow:auto;">
<!-- 		<div style="text-align:right;">내가쓴거</div> -->
<!-- 		<div>상대가보낸거</div> -->
</div>   
<!--     <div id="logWindow" class="border border-danger" style="height:130px; overflow:auto;"></div>    -->

<table class="table table-bordered">
	<!-- 히든폼으로 사용자정보 가져오기 -->
	<input type="hidden" id="chat_id" value="${param.user_id }" style="border:1px dotted red;" />
	<input type="hidden" id="info_nick" value="${param.info_nick }" style="border:1px dotted red;" />
	<input type="hidden" id="info_img" value="${param.info_img }" style="border:1px dotted red;" />

	<tr>
		<td>
			<!-- 엔터키 입력시 전송 설정 -->
			<input type="text" id="inputMessage" class="form-control float-left mr-1" style="width:75%"
				placeholder="채팅내용을 입력하세요." onkeyup="enterkey();" />
			<input type="button" id="sendBtn" onclick="send();" value="전송" class="btn btn-info float-left" />
		</td>
	</tr>
</table>
<%-- <ul>
	<li>chat_id : <input type="hid-den" id="chat_id" value="${param.chat_id }" />  </li>
	<li>chat_room : <input type="hid-den" id="chat_room" value="${param.chat_room }" /></li>
	<li>메시지:<input type="text" id="inputMessage" /></li>
	<li>전송버튼:<input type="button" id="sendBtn" value="전송" /></li>	
</ul> --%>

</div>
