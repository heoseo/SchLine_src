<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 채팅 UI -->
<link rel="stylesheet" href="../resources/assets/css/chat.css" />

<!-- <div class="container"> -->
<!-- 채팅 -->
<script type="text/javascript">

$(document).ready(function() {
   messages = document.getElementById("messageWindow");
   openSocket();
   
   var info_nick = $('#info_nick').val();//닉네임
//    alert(info_nick);
});

var ws; 
var messages;

//소켓오픈
function openSocket(){
   if(ws !== undefined && ws.readyState !== WebSocket.CLOSED ){
      writeResponse("WebSocket is already opened.");
      return;
   }
   
   //웹소켓 객체 만드는 코드
   //호출명 뒤에 /websocket 해주어야 웹소켓 200에러 막을  수 있다.
   //해당컴에 해당하는 경로로 변경해주기!
   //ws = new WebSocket("ws://localhost:9999/schline/echo.do/websocket");

   //ws = new WebSocket("ws://192.168.25.47:9999/schline/EchoServer.do");//다혜
    //ws = new WebSocket("ws://192.168.219.113:9999/schline/EchoServer.do");//성준

   ws = new WebSocket("ws://192.168.219.119:8080/schline/EchoServer.do");//다은


   
   //채팅창 open
      ws.onopen = function(event){
        //사용자가 입장했을때 다른사람들에게 뿌려줌
        $('#inputMessage').val("admin|'${info_nick}'님 도서관 입장하셨습니다.<br/>");
         send();
         //메세지인풋 다시 null로 만들어줌
         $('#inputMessage').val('');
         $('#inputMessage').focus();
         
         if(event.data === undefined){
           return;
         }
         //상대가 보낸 메세지 출력
         writeResponse(event.data);
      };
   
   //상대가 메세지 보냈을때
   ws.onmessage = function(event){ 
      console.log('상대메세지'+event.data); 
      writeResponse(event.data);
   };
   //채팅 종료
   ws.onclose = function(event){
      send("admin|'${info_nick}'님이 퇴실하셨습니다.");
   };
   //에러발생
	ws.onerror = function(event) {
		wsError(event);
	};
}

function wsError(event) {
	writeResponse("에러 발생");
	writeResponse(event.data);
}


var block;//신고와 차단용 변수 생성

//접속자 메세지 입력후 '보내기' 눌렀을때
function send(){
//    $('#messageWindow').css("color", "black");

    var msg = document.getElementById("inputMessage").value;
    var sender = document.getElementById("info_nick").value;
    var user_img = document.getElementById("info_img").value; //내 프로필
    var time = nowTime();
    var ww;
   
      //사용자 닉네임을 통해 프로필 이미지 불러오기
//    $('.profile profile-img-a').attr("background", "url('"+user_img+") 0 0 no-repeat'");
   
      //메세지가 없다면 작동하지 않음
      if(msg==""){
         return false;
      }
      //관리자가보낸 메세지일때는 서버로 전송만 해주고 창에는 띄워주지 않는다
      if(msg.startsWith("admin")==true){
         ws.send(sender+'|'+ msg +'|'+user_img);
         return false;
      }
      //상대방 프로필보기
      else if(msg.startsWith("@")==true){
         var other = msg.split('@');
         var other_nick = other[1];
//     ajax로 닉네임체크 후 프로필창 띄워주기
         ajaxPro(2, other_nick);
       $('#inputMessage').val('');
         return false;
    }
      //신고할때
      else if(msg.startsWith("#")==true){
         var a = msg.split("#");
         var b = a[1];//닉네임
         $('#messageWindow').css("text-align", "center");
         //닉네임 체크 및 신고
         ajaxPro("1", b);//1은 신고, 0은 차단, 2는 프로필확인
         messages.scrollTop = messages.scrollHeight;
         $('#inputMessage').val("");
         return false;
      }

       
       
    //서버로 메세지 전송
    ws.send(sender+'|'+ msg + '|' + user_img);

    //귓속말할때
    if(msg.startsWith("/")==true){
      var x = msg.split("/");
      var z = x[1];//보내는사람
      var y = x[2];
//       alert(y);
      if(msg.startsWith("/"+z+"/")==true){
          ajaxPro("3", z);//1은 신고, 0은 차단, 2는 프로필확인, 3은 회원여부 확인
          temp = msg.replace("/"+z+"/","["+z+"에게 귓속말]");
          //메세지 내용을 바꿔준다
          msg = temp;
         }
      else{
        alert("명령어를 잘못 입력하셨습니다.");
         $('#inputMessage').val("");
        return false;
      }
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
   $.ajax({
      url : "../class/chatSave.do",
      type : "post",
      data : {chat_content : msg},
      dataType : "json",
      beforeSend : function(xhr){
          xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
         },
      contentType : "application/x-www-form-urlencoded;charset:utf-8",
      success : function(d) {
//          alert("채팅내용 세이브");
      },
      error : function(e) {
         alert("채팅저장 오류" + e.status + ":" + e.statusText);
      }
   });
}//send끝




//닉네임 확인(닉네임확인, 프로필보기, 신고, 차단 동시진행)
function ajaxPro(d, ot_nick) {
   $.ajax({
      url : "../class/checkUSer.do",
      dataType : "json",
      type : "post",
      contentType : "application/x-www-form-urlencoded;charset:utf-8",
      beforeSend : function(xhr){
            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
           },
       data : {
          flag : d,
          ot_nick : ot_nick
          },
       success : function(r){
//           alert("아이디확인"+r);
         if(r.result==1){//반환 성공값이 1일때
             if(d==2){//프로필보기용
               window.open("../class/openProfile.do?ot_nick="+ot_nick+"&user_id=${user_id}", "_blank", "width=500px, height=500px");
             }//프로필보기가 아닐경우 아무일도 하지않는다.
             else if(r.check==1){//신고하기 성공시
                  messages.innerHTML += "[알림]'"+ot_nick+"'를 신고했습니다.<br/>";
                  messages.scrollTop = messages.scrollHeight;
                 $('#inputMessage').val("");
             }
             else if(r.check==0){//차단하기 성공시
                  messages.innerHTML += "[알림]'"+ot_nick+"차단 완료<br/>";
                  messages.scrollTop = messages.scrollHeight;
                 $('#inputMessage').val("");
             }
         }
         else{//나머지
            alert("존재하지않는 사용자입니다.");
            $('#inputMessage').val("");
         }
      },
      error : function(e){
         alert("존재하지않는 사용자입니다.");
      }
   });
}


//채팅종료
function closeSocket(){
	send("admin|'${info_nick}'님이 퇴실하셨습니다.");
   	ws.close();
}


// function bl_check(num) {
//    return num;
// }


function blockPeople() {
   
}



//상대응답
function writeResponse(text){

    var msgAll = text.split('|');
    var sender = msgAll[0];
    var con = msgAll[1];
    var img = msgAll[2];
    var msg;
    var bl_check;
    
    //다른 기기로 진입하더라도 보낸사람이 나일때는 전송되지 않게처리
    if(sender.match("${info_nick}")){
       return;
    }
    
   //내가 차단한 상대일 경우 대화창을 띄우지 않는다.
   blockPeople(sender);
   
   $.ajax({
      url : "../class/studyBlock.do",
      dataType : "json",
      type : "post",
      contentType : "application/x-www-form-urlencoded;charset:utf-8",
      async: false, //동기방식으로 변경
       data : {ot_nick : sender},
       beforeSend : function(xhr){
            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
           },
       success : function(r){
          if(r.check==1){//차단한 상대일때
             bl_check = 1;
             return false;//적용안됨
          }//차단유저가 아닐경우 그냥 진행
      },
      error : function(e){
         alert("메세지받아오기 차단부분 에러"+e);
      }
   });
   
   //여기서 차단여부 구분해서 처리해줌
   if(bl_check==1){//차단한상대일때 밖으로 나감
      return false;
   }
   
   var tmep;
      //관리자가 보낸 메세지일때
      if(con.startsWith("admin")==true){
         $('#messageWindow').css("text-align", "center");
           messages.innerHTML += "<br/>"+img;//3번째영역이 대화내용이므로
          messages.scrollTop = messages.scrollHeight;
           return false;
      }
       if(con.startsWith("/")){
         if(con.startsWith("/${info_nick}/")==true){
            var x = con.split("/");
            var y = con[2];
             temp = con.replace("/${info_nick}/","[귓속말]");
             //메세지 UI적용
             msg = makeBalloon(sender, temp, img);
             messages.innerHTML += msg;
          }
         else return;
      }
      else{
          //명령어가 아닐시 모두에게 디스플레이
         msg = makeBalloon(sender, con, img);
         messages.innerHTML += "<br/>"+msg;
      }
    //스크롤바 항상 아래로
   messages.scrollTop = messages.scrollHeight;
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

//프로필 이미지 눌렀을때
$('.profile-img').on('click', function () {
   alert('이미지클릭');
   window.onload('');
   //form값을 넘겨줘야함
   //상대방 이미지가 들어가야함
   $('#other_img').val();
});
</script>

<!-- 채팅 출력창 -->
<div id="messageWindow" class="border"
   style="height: 500px; overflow: auto; padding: 20px; 
   border-radius: 5px; border: solid 2px #145374;">
</div>

<table class="table table-hover table-striped"
   style="min-width: 0; width: 100%; max-height: 100%;">
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
            style="min-width: 0; width: 20%; min-height: 0; height: 45px; font-size: 0.7em; background:#ADD8E6">
            <i class="fas fa-paper-plane" style="font-size: 2em"></i>
         </button>
         <!--          <input type="button" id="sendBtn" onclick="send();" value="전송" class="btn btn-info float-left" /> -->
      </td>
   </tr>
</table>