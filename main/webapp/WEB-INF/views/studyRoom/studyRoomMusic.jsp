<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!-- 시간대별로 바뀌는 배경 ★★★★★★ -->
<style>
#entry{width: 100%; height: 85%; background-image: url('<%=request.getContextPath() %>/resources/images/pic07.jpg');
		padding: 40px;}
</style>
<div id="entry" class="image" style="text-align: center;">

	<audio src="<%=request.getContextPath()%>/resources/music/audio.mp3" autoplay controls>
		audio태그를 지원하지 않는 브라우저입니다.
		<a href="<%=request.getContextPath()%>/resources/music/audio.mp3">여기</a>를
		클릭해서 다운받으세요
	</audio>
</div>

<script type="text/javascript">
//Audio객체생성
//음악 안끊기도록 반복재생 설정하기★★★★
var audio = new Audio("<%=request.getContextPath()%>/resources/music/audio.mp3");
window.onload = function () {
    var currentSpan = document.getElementById("current_time");
    var totalSpan = document.getElementById("total_time");
    var progress = document.getElementById("progress");
	
    audio.addEventListener("timeupdate", function () {
        totalSpan.innerHTML = audio.duration;
        currentSpan.innerHTML = audio.currentTime;
		//진행바에 최대값 설정 : 총재생시간 설정
		//★학생 지정 공부시간으로 변경
		progress.max = audio.duration;
		//진행바에 현재 진행상황 표시
        progress.value = audio.currentTime;
    });
}
function play() {
    audio.play();
}
function stop() {
    audio.pause();
}
</script>   


<div>
	<progress value="0" id="progress"></progress>
	</div>
	<div>
	<input type="button" value="PLAY" onclick="play()"/>
	<input type="button" value="STOP" onclick="stop()"/><br/>
	<span id="current_time"></span>
	/
	<span id="total_time"></span>
</div>

