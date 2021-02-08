<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 채팅 UI -->
<link rel="stylesheet" href="../resources/assets/css/chat.css" />

<!--
할거 
1. 차단
2. 신고
3. 상대프로필 보기
4. 귓속말오면 알림창 띄우기
 -->

<div class="container">
	<!-- 채팅 -->
	<script type="text/javascript">

$(document).ready(function() {
   messages = document.getElementById("messageWindow");
   openSocket();
});

var ws; 
var messages;
var info_nick = $('#info_nick').val();//닉네임

function openSocket(){ 
   
   if(ws !== undefined && ws.readyState !== WebSocket.CLOSED ){
      writeResponse("WebSocket is already opened.");
      return;
   }
   
   //웹소켓 객체 만드는 코드
   //호출명 뒤에 /websocket 해주어야 웹소켓 200에러 막을  수 있다.ㅠㅠㅠㅠ흐앙
   //해당컴에 해당하는 경로로 변경해주기!
   ws = new WebSocket("ws://localhost:9999/schline/echo.do/websocket");
   //채팅창 open
   ws.onopen = function(event){
	   //이거 접속자가 접속했을때 뿌려주게하기...
	   
//        $("#messageWindow").html("<p class='chat_content'>"+info_nick+"님이 채팅에 참여하였습니다.</p>");
      if(event.data === undefined){
         return;
      }
      //상대가 보낸 메세지 출력
      writeResponse(event.data);
   };
   
   //상대가 메세지 보냈을때
   ws.onmessage = function(event){ 
      console.log('writeResponse'); 
      console.log(event.data);
      writeResponse(event.data);
   };
   //채팅 종료
   ws.onclose = function(event){
      writeResponse("대화 종료");
   };
}

//접속자 메세지 입력후 '보내기' 눌렀을때
function send(){
	
    var msg = document.getElementById("inputMessage").value;
    var sender = document.getElementById("info_nick").value;
    var user_img = document.getElementById("info_img").value; //내 프로필
	var time = nowTime();
   
   //메세지가 없다면 작동하지 않음
   if(msg==""){
      return false;
   }
   if(msg=="@")

   //서버로 메세지 전송
   ws.send(sender+'|'+ msg + '|' + user_img);
   
   var text = '';
      text += '<div class="chat chat-right">';
       text += '   <!-- 내 프로필 이미지 -->';
       text += '   <span class="profile profile-img" style="background:url('+user_img+') 0 0 no-repeat; background-size: 100% 100%; background-position: center;"></span>';
       text += '   <div class="chat-box">';
       text += '      <p style="font-weight: bold; font-size: 0.7em; margin-bottom: 5px;">'+sender+'</p>';
       text += '      <p class="bubble-me">'+msg+'</p>';
       text += '      <span class="bubble-tail"></span>';
       text += '   </div>'+
				"<div class=\"time\" style='font-size:0.7em;'>\n"+
				time+"\n"+
				"</div>\n";
       text += '</div>';
      
       messages.innerHTML += text;

   //입력했던 대화내용 지워줌
   $('#inputMessage').val("");
   //스크롤 아래로
   messages.scrollTop = messages.scrollHeight;
}
//채팅종료
function closeSocket(){
   ws.close();
}

//상대응답
function writeResponse(text){
   
    var msgAll = text.split('|');
    var sender = msgAll[0];
    var con = msgAll[1];
    var img = msgAll[2];
   
    var msg;
    
    if(con==""){//내용이없을땐 아무일 안일어남
    }
    else{
        if(con.match("@")){
          if(con.match("@"+sender)){
             var temp = con.replace("@"+sender,"[귓속말]"+con);
             //메세지 UI적용
             msg = makeBalloon(sender, temp, img);
          }
       }
//         else if(con.match("/")){
//            if(con.match("/"+info_nick)){
//               var temp = con.replace(("/"+info_nick), "[신고] 닉네임 '"+ info_nick +"'를 신고했습니다.");
              
//              msg = makeBalloon(sender, temp, img);
//            }
//         }
        else{
           //명령어가 아닐시 모두에게 디스플레이
         msg = makeBalloon(sender, con, img);
         messages.innerHTML += "<br/>"+msg;
        }
   }
    //스크롤바 항상 아래로
   messages.scrollTop = messages.scrollHeight;
//     var result = makeBalloon(sender, con);
//    messages.innerHTML += "<br/>"+result;
} 


//상대방이 보낸 메세지를 출력하기위한 부분
function makeBalloon(id, cont, img){
	
	var time = nowTime();
	
   var msg = '';
   msg += '<div class="chat chat-left">';
   msg += '   <!-- 다른사람 프로필 이미지 -->';
   msg += '   <span class="profile profile-img" style="background:url('+img+') 0 0 no-repeat; background-size: 100% 100%; background-position: center;"></span>';
   msg += '   <div class="chat-box">';
   msg += '      <p style="font-weight: bold; font-size: 0.7em; margin-bottom: 5px;">'+id+'</p>';
   msg += '      <p class="bubble">'+cont+'</p>';
   msg += '      <span class="bubble-tail"></span>';
   msg += '   </div>'+
			"<div class=\"time\" style='font-size:0.7em;'>\n"+
			time+"\n"+
			"</div>\n";
   msg += '</div>';
   return msg;
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



//내 프로필 이미지 적용
// $(document).ready(function () {
//    //닉네임에 맞는 프로필 정보 가지고 와서 사진 변경해주기 
//    $('.profile profile-img-a').attr("background", "url('/schline/"+user_img+") 0 0 no-repeat'");
   
// });

//현재시간 불러오기
function nowTime(){
	var d = new Date();
	var ampm = (d.getHours()>=12 ?  "PM" : "AM");
	var h = (d.getHours()>12 ? d.getHours()-12 : d.getHours());
	var m = d.getMinutes();
	
	return ampm+" "+h+":"+m;
}
</script>
	<!-- 채팅 출력창 -->
	<div id="messageWindow" class="border border-primary"
		style="height: 300px; overflow: auto;">
	</div>

	<table class="table table-bordered"
		style="min-width: 0; width: 100%; max-height: 100%">
		<!-- 히든폼으로 사용자정보 가져오기 -->
		<input type="hidden" id="chat_id" value="${user_id }"/>
		<input type="hidden" id="info_nick" value="${info_nick }" />
		<input type="hidden" id="info_img" name="info_img" value="<c:url value='/resources/profile_image/${info_img}'/>" />

		<tr>
			<td>
				<!-- 엔터키 입력시 전송 설정 --> <input type="text" id="inputMessage"
				class="form-control float-left mr-1" placeholder="채팅내용을 입력하세요."
				onkeyup="enterkey();" style="min-width: 0; width: 78%;" />
				<button id="sendBtn" onclick="return send();"
					style="min-width: 0; width: 20%; min-height: 0; height: 45px; font-size: 0.7em;">send</button>
				<!--          <input type="button" id="sendBtn" onclick="send();" value="전송" class="btn btn-info float-left" /> -->
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