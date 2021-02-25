<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet"
   href="<%=request.getContextPath()%>/resources/assets/css/default.css" />
   

<!DOCTYPE html>
<html>
<head>
<title>공부방 입장</title>
<%@ include file="/resources/include/top.jsp"%>
<script src= "timer.js"></script><!-- 타이머 -->

<style>
/* 고정된 버튼 사이즈 변경 */
button {min-width: 0;width: 30%;cursor: pointer;padding: 3px;min-height: 0;
   height: 40px;font-size: 0.7em;margin-bottom: 10px;}
#entry {width: 100%;height: 85%;padding: 10px; background-image:url('');}
#re {font-size: 0.7em;min-height: 0;min-width: 0;width: 10%;height: 30px; vertical-align: middle; border: none; outline: none; text-decoration: none;}
#st {font-size: 0.7em;min-height: 0;min-width: 0;width: 10%;height: 30px;vertical-align: middle;border: none;outline: none; text-decoration: none;}
#order {font-size: 0.7em;min-height: 0;min-width: 0;width: 20%;height: 30px;vertical-align: middle;border: none; }
</style>


<body class="is-preload">
<%--    <jsp:include page="/resources/include/leftmenu_classRoom.jsp" /> --%>
<div id="main" class="container-fluid" style="text-align: center;"> 
<!-- <div class="container"> -->

<script type="text/javascript">
$(function () {
    window.onload = function () {
       $('#modal').hide();
       $('#audio').hide();
       $('#myModal').modal("show");
       
       	//타이머 스타트
       	setTimeout(function() { start();}, 1000);
     	//10초에 한번씩 공부시간 db에 업데이트
      	setInterval(function () { dbup();}, 10000); 
    	
     	//시간대별 바뀌는 배경화면 설정
    	var dtime = new Date();//현재시간관련정보
    	var d = dtime.getHours();//현재 시
    	//(4~7):b1, (7~11)b2, (11~17)b3, (17~22)b4, (22~4):b5
    	if(d>=4 && d<7) $('#entry').css('background-image', 'url("../resources/images/b1.jpg")');
    	else if(d>=7 && d<11) $('#entry').css('background-image', 'url("../resources/images/b2.jpg")');
    	else if(d>=11 && d<17) $('#entry').css('background-image', 'url("../resources/images/b3.jpg")');
    	else if(d>=17 && d<22) $('#entry').css('background-image', 'url("../resources/images/b4.jpg")');
    	else $('#entry').css('background-image', 'url("../resources/images/b5.jpg")');

		//나가기이벤트 : 크롬에서는 작동안함.
//     	$(window).bind("beforeunload", function (e){
//     		return "창을 닫으실래요?";
//     	});
    	
    	//출석증가
    	var today = String(dtime.getFullYear())+String((dtime.getMonth()+1))+String(dtime.getDay());
    	//ajax호출
    	attenPlus(today);
    }
    
    //출석증가
    function attenPlus(today) {
		$.ajax({
		    url : "../class/attenPlus.do",
		    type : "post",
		    data : {today : today},
		    dataType : "json",
		    beforeSend : function(xhr){
		        xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
		    },
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
   
    var timeElapsed = 0;
    var myTimer = 0;
    //타이머 시작
    function start() {
        myTimer = setInterval(function(){
	        timeElapsed += 1;//시간증가
	        var hour2 = parseInt(timeElapsed/3600);
	        var min2 = parseInt((timeElapsed%3600)/60);
	        var sec2 = parseInt(((timeElapsed%3600)%60)%60);
	        
	        if(hour2==0 && min2==0){
		        $('#cutm').html(sec2+"초");
	        }else if(hour2==0){
		        $('#cutm').html(min2+"분 "+sec2+"초");
	        }
	        else{
		        $('#cutm').html(hour2+"시간 "+min2+"분 "+sec2+"초");
	        }
	        $('#send_time').val(timeElapsed);//컨트롤러 전송용
        }, 1000);
    }
    
// 	$('#progress').addEventListener("timeupdate", function () {
// 		alert("이벤트리스너발생");
// 	  	progress.max = time;
// 	    progress.value = Integer($('#current_time').text());
// 	});
    
//    function stop() {//타이머 종료
//        clearInterval(myTimer);
//    }
//    function reset() {//타이머 리셋
//       timeElapsed = 0;
//       clearInterval(myTimer);
//       document.getElementById("time").innerHTML = timeElapsed;
//    }

});

//오디오
function play() {
    audio.play();
}
function stop() {
    audio.pause();
    clearInterval(myTimer);
}

//모달 버튼 클릭시
//시간은 초단위로 설정한다.
function btn1() {//30분
	time=1800;
	$('#myModal').modal("hide");
}
function btn2() {//1시간
    time=3600;
	$('#myModal').modal("hide");
}
function btn3() {//2시간
  	time=7200;
	$('#myModal').modal("hide");
}
function btn4() {//3시간
    time = 10800;
	$('#myModal').modal("hide");
}
function btn5() {//6시간
    time = 21600;
    $('#myModal').modal("hide");
}
function btn6() {//12시간
    time = 43200;
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
   min = parseInt(time%3600)/60; //몫을계산
//    sec = parseInt((time%3600)%60)/60); //나머지 계산
   
	if(min==0){
   		$('#study_time').text("[목표] "+hour+"시간 ");
	}
	else{
   		$('#study_time').text("[목표] "+min+"분 ");
	}
}, 1000);



var progress = document.getElementById("progress");
//프로그레스바 타이머 설정
function progressStart() {
		alert("이벤트리스너발생2");
	$('#progress').addEventListener("timeupdate", function () {
		alert("이벤트리스너발생2");
	  	progress.max = time;
	    progress.value = Integer($('#send_time').val());
	});
}



//디비에 정보 업데이트 시키기   
function dbup() {
	$.ajax({
		url : "../class/studyTimeSet.do",
		type : "post",
		data : {send_time :  $('#send_time').val()},
		dataType : "json", //반환받는 데이터타입 map은 json(키,벨유)
		contentType : "application/x-www-form-urlencoded;charset:utf-8", //post방식
		beforeSend : function(xhr){
            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
           },
		success : function(d) {
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

//사용자가 창 닫을때 이벤트 발생 //크롬은 작동x
// $(window).bind('beforeunload', function(){
//    return alert("당신의 공부시간은");
// }); 
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
            
 			<table style="background-color: white;  margin: 0;color: black; font-size: 0.7em;">
 				<tr style="text-align: right; min-height:0; height:5px;">
 					<td>
		 				<span id="current_time" ></span>
		 				<span id="cutm" ></span> / <span id="study_time" ></span>
		 				&nbsp;&nbsp;
		               <button id="re" onclick="play()"><img src="../resources/images/mplay.png" alt="" /></button><!-- 재시작 -->
		               <button id="st" onclick="stop()"><img src="../resources/images/mpause.png" alt="" /></button><!-- 정지 -->
<!--  					</td> -->
<!--  					<td> -->
		 				&nbsp;&nbsp;
					  <button id="order" data-toggle="popover" data-placement="top"
					   title="" data-content="/닉네임/: 귓속말  , @닉네임: 프로필보기   #닉네임 : 신고"
						   style="text-align:center;">명령어</button>
						<script>
						$(document).ready(function(){
						  $('[data-toggle="popover"]').popover();   
						});
						</script>
 					</td>
 				</tr>
 			</table>
<!--  			<div style="text-align: center;"> -->

<!--             </div> -->
            <!-- 배경이미지 -->
            <div id="entry" class="image" style="text-align: center;">
            	
            	<div style="vertical-align: middle; text-align: center;">
<!--                <progress value="" id="progress"></progress> -->
               <!--       <div> -->
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
      <br />
   </div>
   </div>
   </div>
   </div>

   <jsp:include page="/resources/include/bottom.jsp" />
</body>

<br /><br />
<br /><br />
</html>