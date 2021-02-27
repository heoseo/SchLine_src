<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html>
<head>
<title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/default.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/chat.css" />
</head>

<!-- 시간저장은 안드에서? -->

<%-- <%@ include file="/resources/include/top.jsp"%> --%>
<style>


</style>


<body class="is-preload" >
<div id="main">
<div class="container">
<!-- 채팅 -->


<script type="text/javascript">

$(document).ready(function() {
	
	//출석증가
	var dtime = new Date();//현재시간관련정보
    //시간대별 바뀌는 배경화면 설정
   	var d = dtime.getHours();//현재 시
   	//(4~7):b1, (7~11)b2, (11~17)b3, (17~22)b4, (22~4):b5
   	if(d>=4 && d<7) $('#messageWindow').css('background-image', 'url("../resources/images/b1.jpg")');
   	else if(d>=7 && d<11) $('#messageWindow').css('background-image', 'url("../resources/images/b2.jpg")');
   	else if(d>=11 && d<17) $('#messageWindow').css('background-image', 'url("../resources/images/b3.jpg")');
   	else if(d>=17 && d<22) $('#messageWindow').css('background-image', 'url("../resources/images/b4.jpg")');
   	else $('#messageWindow').css('background-image', 'url("../resources/images/b5.jpg")');
	    
	
	var today = String(dtime.getFullYear())+String((dtime.getMonth()+1))+String(dtime.getDay());
	attenPlus(today);
	
   	//타이머 스타트
   	setTimeout(function() { start();}, 1000);
   	//10초에 한번씩 db업데이트
   	//setInterval(function () { dbup();}, 10000);


   	messages = document.getElementById("messageWindow");
   	openSocket();
});

//안드로이드로 변경
//디비에 정보 업데이트 시키기   
function dbup() {
   $.ajax({
      url : "../studyTimeSet.do",
      type : "post",
      data : {send_time :  $('#send_time').val()},
      dataType : "json", //반환받는 데이터타입 map은 json(키,벨유)
      contentType : "application/x-www-form-urlencoded;charset:utf-8", //post방식
      success : function(d) {
         $('#save_time').val(d.setTime);//d.키값 => 벨유값 들어옴
      },
      error : function(e) {
         alert("오류" + e.status + ":" + e.statusText);
      }
   });
}

//시간저장
var timeElapsed = 0;
function start() {
	myTimer = setInterval(function(){
	    timeElapsed += 1;//시간증가
	    $('#send_time').val(timeElapsed);//컨트롤러 전송용
	}, 1000);
}


 //출석증가
 function attenPlus(today) {
	$.ajax({
	    url : "../attenPlus.do",
	    type : "post",
	    data : {today : today},
	    dataType : "json",
	    contentType : "application/x-www-form-urlencoded;charset:utf-8",
	    success : function(d) {
	    	if(d.reslut==1){
	    		//alert("출석증가");
	    	}
	    	else if(d.reslut==0){
	    		//alert("이미출석 증가x");
	    	}
	    	else{
	    		//alert(d+"출석예외");
	    	}
	    },
	    error : function(e) {
	       alert("출석증가 오류" + e.status + ":" + e.statusText);
	    }
	});
}


var ws; 
var messages;

function openSocket(){
   if(ws !== undefined && ws.readyState !== WebSocket.CLOSED ){
      writeResponse("WebSocket is already opened.");
      return;
   }
   
   //웹소켓 객체 만드는 코드
   //호출명 뒤에 /websocket 해주어야 웹소켓 200에러 막을  수 있다.
   	//ws = new WebSocket("ws://localhost:9999/schline/echo.do/websocket");

    //ws = new WebSocket("ws://192.168.25.47:9999/schline/EchoServer.do");//다혜집
    //ws = new WebSocket("ws://192.168.219.113:9999/schline/EchoServer.do");//성준

    ws = new WebSocket("ws://192.168.219.119:8080/schline/EchoServer.do");//다은


   //채팅창 open
      ws.onopen = function(event){
        //사용자가 입장했을때 다른사람들에게 뿌려줌
        $('#inputMessage').val("admin|'${info_nick}'님 도서관 입장하셨습니다.");
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
      console.log('writeResponse'); 
      console.log(event.data);
      writeResponse(event.data);
   };
   //채팅 종료
   ws.onclose = function(event){
   };
}

var block;//신고와 차단용 변수 생성

//접속자 메세지 입력후 '보내기' 눌렀을때
function send(){
//    $('#messageWindow').css("color", "black");

    var msg = document.getElementById("inputMessage").value;
    var sender = document.getElementById("info_nick").value;
    var user_img = document.getElementById("info_img").value; //내 프로필
   var time = nowTime();
   
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
//    ajax로 닉네임체크 후 프로필창 띄워주기
      ajaxPro(2, other_nick);
      return false;
    }
   

   
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
   //신고할때
   else if(msg.startsWith("#")==true){
      var a = msg.split("#");
      var b = a[1];//닉네임
      $('#messageWindow').css("text-align", "center");
      
      //닉네임 체크 및 신고
      ajaxPro("1", b);//1은 신고, 0은 차단, 2는 프로필확인
      messages.scrollTop = messages.scrollHeight;
       return false;
   }
    //차단할때
   else if(msg.startsWith("&")==true){
	      var a = msg.split("&");
	      var b = a[1];//닉네임
	      $('#messageWindow').css("text-align", "center");
	      //닉네임 체크 및 차단
	      ajaxPro("0", b);//1은 신고, 0은 차단, 2는 프로필확인
	      return false;
   }
    
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
   $.ajax({
      url : "../chatSave.do",
      type : "post",
      data : {chat_content : msg},
      dataType : "json",
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
      url : "../checkUSer.do",
      dataType : "json",
      type : "post",
      contentType : "application/x-www-form-urlencoded;charset:utf-8",
       data : {
          flag : d,
          ot_nick : ot_nick
          },
       success : function(r){
//           alert("아이디확인"+r);
         if(r.result==1){//반환 성공값이 1일때
             if(d==2){//프로필보기용
               window.open("../openProfile.do?ot_nick="+ot_nick+"&user_id=${user_id}", "_blank", "width=600px, height=600px");
             }//프로필보기가 아닐경우 아무일도 하지않는다.
             else if(r.check==1){//신고하기 성공시
                  messages.innerHTML += "[알림]'"+ot_nick+"'를 신고했습니다.<br/>";
                  messages.scrollTop = messages.scrollHeight;
                 $('#inputMessage').val("");
             }

         }
         else if(d==0){
            if(r.check==0){//차단하기 성공시
                 messages.innerHTML += "[알림]'"+ot_nick+"차단 완료";
                 messages.scrollTop = messages.scrollHeight;
                $('#inputMessage').val("");
            }
            else{
                messages.innerHTML += "[알림]'"+ot_nick+"차단 해제";
                messages.scrollTop = messages.scrollHeight;
                $('#inputMessage').val("");
            } 
         }
         else{//나머지
            alert("존재하지않는 사용자입니다.");
         }
      },
      error : function(e){
         alert("존재하지않는 사용자입니다.");
      }
   });
}


//채팅종료
function closeSocket(){
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
      url : "../studyBlock.do",
      dataType : "json",
      type : "post",
      async: false, //동기방식으로 변경
      contentType : "application/x-www-form-urlencoded;charset:utf-8",
       data : {ot_nick : sender},
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
</script>

<!-- 채팅 출력창 -->
<div id="messageWindow" class="border border-primary"
   style="height: 500px; width:auto; overflow: auto; 
   background-image: url('../resources/images/pic07.jpg'); font-size: 2em;">
</div>
<!--  style="min-width: 0; width: 100%; max-height: 100%" -->
<table class="table table-bordered">
   <!-- 히든폼으로 사용자정보 가져오기 -->
   <form id="peopleFrm">
      <input type="hidden" id="chat_id" value="${user_id }"/>
      <input type="hidden" id="info_nick" value="${info_nick }" />
      <input type="hidden" id="send_time" value="" />
      <input type="hidden" id="other_img" name="other_img" value="" />
      <input type="hidden" id="info_img" name="info_img" value="<c:url value='/resources/profile_image/${info_img}'/>" />
   </form>
   <tr>
      <td style="text-align: center;">
         <!-- 엔터키 입력시 전송 설정 --> 
         <input type="text" id="inputMessage"
         class="form-control float-left mr-1" placeholder="채팅내용을 입력하세요."
         onkeyup="enterkey();" style="min-width: 0; width: 75%;" />
         <button id="sendBtn" onclick="return send();"
            style="min-width: 0; width: 20%; min-height: 0; height: 40px;">send</button>
         <!--          <input type="button" id="sendBtn" onclick="send();" value="전송" class="btn btn-info float-left" /> -->
      </td>
   </tr>
</table>
</div>
</div>
</body>
</html>