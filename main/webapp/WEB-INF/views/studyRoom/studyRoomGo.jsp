<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet"
   href="<%=request.getContextPath()%>/resources/assets/css/default.css" />
   

<!DOCTYPE html>
<html>
<head>
<title>스터디룸 채팅</title>
<%@ include file="/resources/include/top.jsp"%>
<script src= "timer.js"></script><!-- 타이머 -->

<style>
/* 고정된 버튼 사이즈 변경 */
button {min-width: 0;width: 30%;cursor: pointer;padding: 3px;min-height: 0;
   height: 40px;font-size: 0.7em;margin-bottom: 10px;}
#entry {width: 100%;height: 85%;padding: 10px; background-image:url('');}
#re {font-size: 0.7em;min-height: 0;min-width: 0;width: 20%;height: 30px;}
#st {font-size: 0.7em;min-height: 0;min-width: 0;width: 20%;height: 30px;}
</style>


<body class="is-preload">
   <jsp:include page="/resources/include/leftmenu_classRoom.jsp" />

<script type="text/javascript">
$(function () {
    window.onload = function () {
       $('#modal').hide();
       $('#audio').hide();
       $('#myModal').modal("show");
       	//타이머 스타트
       	setTimeout(function() { start();}, 1000);
     	//10초에 한번씩 공부시간 db에 업데이트
      	setInterval(function () {
			dbup();	}, 10000); 
    	
     	//시간대별 바뀌는 배경화면 설정
    	var dtime = new Date();//현재시간관련정보
    	var d = dtime.getHours();//현재 시
    	//(4~7):b1, (7~11)b2, (11~17)b3, (17~22)b4, (22~4):b5
    	if(d>=4 && d<7){
        	$('#entry').css('background-image', 'url("../resources/images/b1.jpg")');
//         	$('#entry').css('background-image':'url("../resources/images/b1.jpg")', 'background-repeat' : 'no-repeat', 'background-position':'center center');

    	}
    	else if(d>=7 && d<11){
        	$('#entry').css('background-image', 'url("../resources/images/b2.jpg")');
//         	$('#entry').css('background-image':'url("../resources/images/b2.jpg")', 'background-repeat' : 'no-repeat', 'background-position':'center center');

        	
    	}
    	else if(d>=11 && d<17){
        	$('#entry').css('background-image', 'url("../resources/images/b3.jpg")');
//         	$('#entry').css('background-image':'url("../resources/images/b3.jpg")', 'background-repeat' : 'no-repeat', 'background-position':'center center');

    	}
    	else if(d>=17 && d<22){
        	$('#entry').css('background-image', 'url("../resources/images/b4.jpg")');
//         	$('#entry').css('background-image':'url("../resources/images/b4.jpg")', 'background-repeat' : 'no-repeat', 'background-position':'center center');

    	}
    	else{
        	$('#entry').css('background-image', 'url("../resources/images/b5.jpg")');
//         	$('#entry').css('background-image':'url("../resources/images/b5.jpg")', 'background-repeat' : 'no-repeat', 'background-position':'center center');
    	}
    	
//     	background-image:url('../resources/images/pic07.jpg');}
//     	document.getElementById("time").src=fname;
    	
//     	var h = (d.getHours()>12 ? d.getHours()-12 : d.getHours());
//     	var m = d.getMinutes();
//     	return ampm+" "+h+":"+m;
    
    }
   
    var timeElapsed = 0;
    var myTimer = 0;
    var hour2 = "";
    var min2 = "";
    var sec2 = "";
//     var sendTime;
    //타이머 시작
    function start() {
        myTimer = setInterval(function(){
            timeElapsed += 1;
           
//             hour2 = parseInt(timeElapsed/3600);
//             min2 = parseInt(hour2/60);//몫을계산
//             sec2 = parseInt(hour2%60); //나머지 계산
//             $('#current_time').html(hour2+"시간 "+min2+"분 "+sec2+"초");//이렇게 바껴서 전송이 안된다!!!
            document.getElementById("current_time").innerText = timeElapsed;

//             document.getElementById("send_time").value = timeElapsed;
        }, 1000) ;
    }
   


//    function stop() {//타이머 종료
//        clearInterval(myTimer);
//    }
//    function reset() {//타이머 리셋
//       timeElapsed = 0;
//       clearInterval(myTimer);
//       document.getElementById("time").innerHTML = timeElapsed;
//    }
   

   //이거하니깐 위의 시간선택창 안뜬다
   //사용자가 창 닫을때 이벤트 발생
//    $(window).bind('beforeunload', function(){
//         alert("사용자가 창 닫음.");
//    }); 
//    window.onbeforeunload = function() {
//       return alert("당신의 공부시간은");
//         return "당신의 공부시간은";
//         return "당신의 공부시간은 "+resultTime+"입니다.";
//       };

    var currentSpan = document.getElementById("current_time");
    var totalSpan = document.getElementById("total_time");
    var progress = document.getElementById("progress");
   
    progress.addEventListener("timeupdate", function () {
        totalSpan.innerHTML = $('#study_time').html();
        currentSpan.innerHTML = audio.currentTime;
      //진행바에 최대값 설정 : 총재생시간 설정 : 학생지정 공부시간
      progress.max = $('#study_time').html();
      //진행바에 현재 진행상황 표시
        progress.value = audio.currentTime;
    });
});

function play() {
    audio.play();
//    progress.max = $('#study_time').html();
}
function stop() {
    audio.pause();
    clearInterval(myTimer);
}

//모달 버튼 클릭시
//시간은 초단위로 설정한다.
function btn1() {//30분
	time=1800;
	$('#study_time').html('1800');
// 	time=60;
// 	$('#study_time').html('60');
	$('#myModal').modal("hide");
}
function btn2() {//1시간
    time=3600;
// 	$('#study_time').html('3600');
	$('#myModal').modal("hide");
}
function btn3() {//2시간
  	time=7200;
// 	$('#study_time').html('7200');         
	//      $('#myModal').hide();//안됨
	$('#myModal').modal("hide");
}
function btn4() {//3시간
    time = 10800;
// 	$('#study_time').html('10800');         
	$('#myModal').modal("hide");
}
function btn5() {//6시간
    time = 21600;
// 	$('#study_time').html('21600');         
    $('#myModal').modal("hide");
}
function btn6() {//12시간
    time = 43200;
// 	$('#study_time').html('43200');
	$('#myModal').modal("hide");
}

//목표시간
var time;
// var time = $("#study_time").html();
var hour = "";//시간
var min = "";//분
var sec = "";//초

//setInterval(함수, 시간) : 주기적인 실행
var interval = setInterval(function() {
   //parseInt : 정수를 반환
   hour = parseInt(time/3600);
   min = parseInt(hour/60); //몫을계산
   sec = parseInt(hour%60); //나머지 계산
   //값이 왜 이상하게 나오지 ???????
   $('#study_time').html("[목표] "+hour+"시간 "+min+"분 "+sec+"초");
}, 1000);

//프로그레스바 타이머 설정
var currentSpan = document.getElementById("current_time");
var totalSpan = document.getElementById("total_time");
var progress = document.getElementById("progress");

$('#progress').addEventListener("timeupdate", function () {
    totalSpan.innerHTML = time;
    currentSpan.innerHTML = timeElapsed;
  progress.max = $('#study_time').val();
    progress.value = audio.currentTime;
});


//디비에 정보 업데이트 시키기   
function dbup() {
	var sendTime = document.getElementById("current_time").innerText;
	var sendTime2 = String(sendTime);
    $('#send_time').val(sendTime2);
	
// 	var frm = document.timeFrm;
// 	$("#timeFrm").attr("action", "../class/studyTimeSet.do");
// 	frm.submit();
// 	$("#timeFrm").submit();
	

	$.ajax({
		url : "../class/studyTimeSet.do",
		type : "post",
		data : {send_time : sendTime},
		dataType : "json", //반환받는 데이터타입 map은 json(키,벨유)
		contentType : "application/x-www-form-urlencoded;charset:utf-8", //post방식
		success : function(d) {
// 			alert("성공");
			$('#save_time').val(d.setTime);//d.키값 => 벨유값 들어옴
		},
		error : function(e) {
			alert("오류" + e.status + ":" + e.statusText);
		}
	});
}



//우클릭 사용금지
document.oncontextmenu = function() {
   alert("마우스의 우클릭은 사용할 수 없습니다.")
   return false;
}
</script>

   <!-- Button to Open the Modal -->
   <button type="button" id="modal" class="btn btn-primary"
      data-toggle="modal" data-target="#myModal"
      style="background-color: white; border: 0;"></button>

   <!-- 타임값 넘어가나 확인 -->
   <!-- <input type="hid-den" id="study_time" value="" /> -->

   <!-- The Modal -->
   <div class="modal" id="myModal">
      <div class="modal-dialog modal-sm">
         <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
               <h4 class="modal-title">목표 공부시간은?</h4>
               <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <!-- Modal body -->
            <div class="modal-body">
               <table>
                  <tr style="text-align: center;">
                     <td>
                        <button onclick="btn1();">30분</button>
                        <button onclick="btn2();">1시간</button>
                        <button onclick="btn3();">2시간</button>
                        <button onclick="btn4();">3시간</button>
                        <button onclick="btn5();">6시간</button>
                        <button onclick="btn6();">12시간</button>
                     </td>
                  </tr>
               </table>
            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
               <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>
         </div>
      </div>
   </div>
   
   <br /><hr />
   <div style="text-align: center;">
      <!--       <small>스터디룸 채팅</small> -->
   </div>

   <div class="container">
      <div class="row">

         <div class="col-sm-6">         
<!--             <button>시간별</button> -->
<!--             <button>해리포터</button> -->
<!--             <button>코딩</button> -->
            
       
            
            <audio id="audio"
               src="<%=request.getContextPath()%>/resources/music/audio.mp3"
               autoplay controls>
               audio태그를 지원하지 않는 브라우저입니다.
               <a href="<%=request.getContextPath()%>/resources/music/audio.mp3">여기</a>를
               	클릭해서 다운받으세요
            </audio>
 			
 			<div style="text-align: center;">
 				<span id="current_time" style="font-size: 0.7em;"></span> /
                <span id="study_time" style="font-size: 0.7em;"></span>
            </div>
            <!-- 배경이미지 -->
            <div id="entry" class="image" style="text-align: center;">
            	
            	<div style="vertical-align: middle; text-align: center;">
               <progress value="0" id="progress"></progress>
               <!--       <div> -->
               <button id="re" onclick="play()">RESTART</button>
               <button id="st" onclick="stop()">STOP</button>
               <!--       <input type="button" value="PLAY" onclick="play()"/> -->
               <!--       <input type="button" value="STOP" onclick="stop()"/> -->
               <br /> 
               <!--       </div> -->
            </div>
                 <form:form id="timeFrm" action="" >
               <input type="hidden" id="send_time" name="send_time" value="" />
               <input type="hidden" id="save_time" name="save_time" value="" />
            </form:form>
            
            </div>
         </div>

         <div class="col-sm-6">
            <!-- 채팅 -->
            <jsp:include page="studyRoomChat.jsp" />

         </div>
      </div>
   </div>

   <jsp:include page="/resources/include/bottom.jsp" />
</body>

<jsp:include page="/resources/include/footer.jsp" />
</html>