<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 채팅 UI -->
<!-- <link rel="stylesheet" href="../resources/assets/css/chat.css" /> -->
<style>

/* reset */

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

#chat-wrapper{margin:0px; padding:5px; max-height: auto; width:580px;border-radius:10px 10px 0 0;background:#edecea;}
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
.chat-left .profile{float:left;display:inline-block;width:50px;height:50px; border-radius: 70%; overflow: hidden;}
.chat-left .chat-box{display:inline-block;margin:15px 0 0 10px;}

/* -- 프로필 이미지 타입 -- */
/* .chat-left .profile-img-{ */
/* 	float: left; */
/* 	width: 100%; */
/* 	height: 100%; */
/* 	object-fit: cover; */
/* } */

.chat-left .bubble{margin-left:10px;}
.chat-left .bubble .bubble-tail{position:absolute;left:84px;top:25px;width:9px;height:10px;background: url('../resources/img/bubble-tail.png') 0 0 no-repeat;text-indent:-9999px}

/* -- 오른쪽 채팅 -- */
.chat-right{text-align:right;}
.chat-right .profile{float:right;display:inline-block;width:50px;height:50px;border-radius: 70%; overflow: hidden;}
.chat-right .chat-box{display:inline-block;margin:15px 10px 0 0;}

/* 프로필 이미지 타입 */
/* .chat-right .profile-img-{ */
/* 	float: right; */
/* 	width: 100%; */
/* 	height: 100%; */
/* 	object-fit: cover; */
/* } */

.chat-right .bubble-me {margin-right:10px;}
.chat-right .bubble-tail {position:absolute;right:84px;top:25px;width:9px;height:10px;background: url('../resources/img/param.info_img }') 0 0 no-repeat;text-indent:-9999px}

#messageWindow{max-height: auto;}

</style>
<!--
할거 
1. 차단
2. 신고
3. 상대프로필 보기
4. 귓속말오면 알림창 띄우기
 -->

<!-- <div class="container"> -->
	<!-- 채팅 -->
	<script type="text/javascript">

$(document).ready(function() {
   messages = document.getElementById("messageWindow");
   openSocket();
   
   var info_nick = $('#info_nick').val();//닉네임
//    alert(info_nick);

   	document.getElementById('inputMessage').focus();
//	$('#inputMessage').css("color", "black");

});

var ws; 
var messages;

function openSocket(){
   if(ws !== undefined && ws.readyState !== WebSocket.CLOSED ){
      writeResponse("WebSocket is already opened.");
      return;
   }
   
   //웹소켓 객체 만드는 코드
   //호출명 뒤에 /websocket 해주어야 웹소켓 200에러 막을  수 있다.
   //해당컴에 해당하는 경로로 변경해주기!
   ws = new WebSocket("ws://localhost:8080/schline/echo.do/websocket");
//    ws = new WebSocket("ws://localhost:9999/schline/echo.do/websocket");

   //채팅창 open
   ws.onopen = function(event){
   		var u_nick = $('#info_nick').val();//닉네임
	   //사용자가 입장했을때 다른사람들에게 뿌려줌
		send("admin|"+u_nick+"님이 입장하셨습니다.");
   		
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
// 	$('#messageWindow').css("color", "black");

    var msg = document.getElementById("inputMessage").value;
    var sender = document.getElementById("info_nick").value;
    var user_img = document.getElementById("info_img").value; //내 프로필
	var time = nowTime();
   
   //사용자 닉네임을 통해 프로필 이미지 불러오기
//    $('.profile profile-img-a').attr("background", "url('"+user_img+") 0 0 no-repeat'");
   
// 	$('#inputMessage').css("color", "black");
   //메세지가 없다면 작동하지 않음
   
   //if구분전 서버로 메세지 우선 전송
   ws.send(sender+'|'+ msg +'|'+user_img);
   
	if(msg==""){
	   return false;
	}
	//귓속말할때
	if(msg.match="@"){
	 //색깔 파란색으로 바꿔주기
// 	$('#inputMessage').css("color", "blue");
	messages.scrollTop = messages.scrollHeight;
	}
	//상대방 프로필보기
	else if(msg.match="#"){
		//학생리스트를 전체 가지고와서 프로필보기 눌러야할듯
	}
	else if(msg.match("/")){
		//색깔 빨간색으로 바꿔주기
		var a = msg.split("/");
		var b = a[1];
		$('#messageWindow').css("text-align", "center");
		  //$('#messageWindow').css("color", "red");//전체가 빨간색으로 변경됨..
	    messages.innerHTML += "[알림]'"+b+"'를 신고했습니다.";
	    messages.scrollTop = messages.scrollHeight;
	    return;
	}
   
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
      
    //db에 서버전송내용 저장. 페이지이동되지 않도록 ajax로 전송
	$.ajax({
		url : "../class/chatSave.do",
		type : "post",
		data : {chat_content : msg},
		dataType : "json",
		contentType : "application/x-www-form-urlencoded;charset:utf-8",
		success : function(d) {
// 			alert("채팅내용 세이브");
		},
		error : function(e) {
			alert("채팅저장 오류" + e.status + ":" + e.statusText);
		}
	});
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
    
    //다른 기기로 진입하더라도 보낸사람이 나일때는 전송되지 않게처리
    //로그인 연결이후 풀자!!
//     if(sender.match(info_nick)){
//     	return;
//     }
    
	//관리자가 보낸 메세지일때
	if(con.match("admin")){
		$('#messageWindow').css("text-align", "center");
        messages.innerHTML += "<br/>"+img;
        return;
	}
    
    //나에게보낸 귓속말일 경우
	if(con.match("@")){
	   if(con.match("@"+info_nick)){
	      var temp = con.replace("@"+info_nick,"[귓속말]"+con);
	      //메세지 UI적용
	      msg = makeBalloon(sender, temp, img);
	   }
	}
	else{
	    //명령어가 아닐시 모두에게 디스플레이
		msg = makeBalloon(sender, con, img);
		messages.innerHTML += "<br/>"+msg;
	}
    //스크롤바 항상 아래로
   messages.scrollTop = messages.scrollHeight;
//     var result = makeBalloon(sender, con);
//    messages.innerHTML += "<br/>"+result;
} 


//상대방이 보낸 메세지를 출력하기위한 부분
function makeBalloon(id, cont, img){
	//현재시각 불러오기
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
		<form:form id="peopleFrm">
			<input type="hidden" id="chat_id" value="${user_id }"/>
			<input type="hidden" id="info_nick" value="${info_nick }" />
			<input type="hidden" id="other_img" name="other_img" value="" />
			<input type="hidden" id="info_img" name="info_img" value="<c:url value='/resources/profile_image/${info_img}'/>" />
		</form:form>
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

<!-- </div> -->