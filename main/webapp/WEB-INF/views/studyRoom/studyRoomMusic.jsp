<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<style>
#entry{width: 100%; height: 85%; background-image: url('<%=request.getContextPath() %>/resources/images/pic07.jpg');
		padding:10px;}
#re {
font-size:0.7em;
min-height: 0; min-width: 0; width: 20%; height: 30px; vertical-align: middle;
}
#st{
font-size:0.7em;
min-height: 0; min-width: 0; width: 20%; height: 30px; vertical-align: middle;
}
</style>

<script type="text/javascript">
//Audio객체생성
//음악 안끊기도록 반복재생 설정하기★★★★
<%-- var audio = new Audio("<%=request.getContextPath()%>/resources/music/audio.mp3"); --%>
// window.onload = function () {
//     var currentSpan = document.getElementById("current_time");
//     var totalSpan = document.getElementById("total_time");
//     var progress = document.getElementById("progress");
	
//     progress.addEventListener("timeupdate", function () {
//         totalSpan.innerHTML = $('#study_time').html();
//         currentSpan.innerHTML = audio.currentTime;
// 		진행바에 최대값 설정 : 총재생시간 설정
// 		//★학생 지정 공부시간으로 변경
// 		progress.max = $('#study_time').html();
// 		//진행바에 현재 진행상황 표시
//         progress.value = audio.currentTime;
//     });
// }
function play() {
    audio.play();
// 	progress.max = $('#study_time').html();
}
function stop() {
    audio.pause();
}


//시간은 초단위로 설정한다.
	function btn1() {//30분
//     setTimeout(function() { $('#myModal').hide();}, 1000);
	$('#study_time').html('1800');
	$('#myModal').modal("hide");
}
	function btn2() {//1시간
	$('#study_time').html('3600');
	$('#myModal').modal("hide");
}
	function btn3() {//2시간
	$('#study_time').html('7200');			
//		$('#myModal').hide();//안됨
	$('#myModal').modal("hide");
}
	function btn4() {//3시간
	$('#study_time').html('10800');			
	$('#myModal').modal("hide");
}
	function btn5() {//6시간
	$('#study_time').html('21600');			
		$('#myModal').modal("hide");
}
	function btn6() {//12시간
	$('#study_time').html('43200');
	$('#myModal').modal("hide");
}

</script>   


<div id="entry" class="image" style="text-align: center;">

	<audio id="audio" src="<%=request.getContextPath()%>/resources/music/audio.mp3" autoplay controls>
		audio태그를 지원하지 않는 브라우저입니다.
		<a href="<%=request.getContextPath()%>/resources/music/audio.mp3">여기</a>를
		클릭해서 다운받으세요
	</audio>
	
	<div>
		<progress value="0" id="progress"></progress>
<!-- 		<div> -->
		<button id="re" onclick="play()" >RESTART</button>
		<button id="st" onclick="stop()">STOP</button>
<!-- 		<input type="button" value="PLAY" onclick="play()"/> -->
<!-- 		<input type="button" value="STOP" onclick="stop()"/> -->
		<br/>
		<span id="current_time" style="font-size: 0.7em;"></span> /
		<span id="study_time" style="font-size: 0.7em;"></span>
<!-- 		</div> -->
	</div>
</div>




