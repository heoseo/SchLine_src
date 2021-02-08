<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
 <title>${video_title }</title>
<meta charset="UTF-8">
  <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/main.css" />
	<noscript><link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/noscript.css" /></noscript>
<style>
#video_contorls_bar{background: #333; padding:10px; margin-top:-5px;}
#video_contorls_bar span {color:#ffffff;}
div video{width:700px; height:450px;}
#seekslider{width:40%;}
#soundslider{width: 5%;}
input[type='range']{
    -webkit-appearance: none !important;
    background: #000; border: rgb(150, 133, 133) 1px;
    height: 4px;
}
input[type='range']::-webkit-slider-thumb{
    -webkit-appearance: none !important;
    background: #fff;height: 15px; width: 15px;
    border-radius:100%; cursor: pointer;
}
</style>
</head>
<body>
    <header>
      	<div align="center">
					<a href="#"><!-- ★★이미지클릭시 home으로 가기. home요청명 적기 -->
						<img src="<%=request.getContextPath() %>/resources/images/schooline_logo.png" width="600px" alt="스쿨라인 로고" />
					</a>
				</div>
    </header>  
	<br />
    <!-- 비디오 태그 쓸꺼임-->
    <div id="playerbox" style="height:500px;width:700px;background:#333;margin:0px auto;">
        <video id="my_video" >
        <source src="<%=request.getContextPath() %>/resources/video/${video_title }">
        </video>
        <div id="video_contorls_bar">
            <button id="plapausebtn">Play</button>
             <input type="range" id="seekslider" min="0" max="100" value="0" step="1">   
            <span id="curtimetext">0:00:00</span> / <span id="durtimetext">0:00:00</span>
            <button id="mutebtn">Mute</button>
            <input type="range" id="soundslider" min="0" max="100" value="0" step="1">   
            <button id="fullscreenbtn">[&nbsp;]</button>
            <span style="background-color: #333; border:none; color:red;" id="pen1" ><i class="fas fa-pencil-alt"></i></span>
            <span style="background-color: #333; border:none; color:skyblue;" id="pen2" ><i class="fas fa-pencil-alt"></i></span>
            <span style="background-color: #333; border:none; color:yellow;" id="pen3" ><i class="fas fa-pencil-alt"></i></span>
          

        </div>
   </div>
<script>
var vid,playerbox, playbtn, seekbar,curtimetext,durtimetext,mutebtn,soundslider,fullscreenbtn;
function intializePlayer(){

    vid  = document.getElementById("my_video");
    playbtn  = document.getElementById("plapausebtn");
    playerbox  = document.getElementById("playerbox");
    seekbar  = document.getElementById("seekslider");
    curtimetext  = document.getElementById("curtimetext");
    durtimetext  = document.getElementById("durtimetext");
    mutebtn  = document.getElementById("mutebtn");
    soundslider  = document.getElementById("soundslider");
    fullscreenbtn  = document.getElementById("fullscreenbtn");
  


    playbtn.addEventListener("click",playPause,false);
    seekbar.addEventListener("change",vidSeek,false);
    vid.addEventListener("timeupdate",seektimeUpdate,false);
    mutebtn.addEventListener("click",vidmute,false);
    soundslider.addEventListener("change",setvolume,false);
    fullscreenbtn.addEventListener("click",togglefullscreen,false);

    
    

}
window.onload = intializePlayer;

function playPause(){
    if(vid.paused){
        vid.play();
        playbtn.innerHTML = "Pause";
    }else{
        vid.pause();
        playbtn.innerHTML = "Play";
    }
}
function vidSeek(){
    var seekto = vid.duration * (seekbar.value/100);
    vid.currentTime = seekto;
}
function setvolume(){
   vid.volume = soundslider.value /100
}
function seektimeUpdate(){
    var nt = vid.currentTime *(100/vid.duration);
    seekbar.value = nt;
    var curhours = Math.floor(vid.currentTime / 3600);
    var curmins = Math.floor((vid.currentTime % 3600)/60);
    var cursecs = Math.floor(vid.currentTime - curmins*60);
    var durhours = Math.floor(vid.duration / 3600);
    var durmins = Math.floor((vid.duration % 3600)/60);
    var dursecs = Math.floor(vid.duration - durmins*60);
    
    if(cursecs<10){ cursecs = "0"+cursecs;}
    if(dursecs<10){dursecs = "0"+dursecs;}
    if(durmins<10){ durmins = "0"+durmins;}
    if(curmins<10){curmins = "0"+curmins;}
    curtimetext.innerHTML = curhours+":"+ curmins+":"+cursecs;
    durtimetext.innerHTML = durhours+":"+ durmins+":"+dursecs;
}
function vidmute(){
    if(vid.muted){
        vid.muted = false;
        mutebtn.innerHTML="Mute";
    }else{
        vid.muted= true;
        mutebtn.innerHTML="Unmute"
    }
}
function togglefullscreen(){
    if(playerbox.requestFullScreen){
        playerbox.requestFullScreen();
    }else if(playerbox.webkitRequestFullScreen){
        playerbox.webkitRequestFullScreen();
    }else if(playerbox.mozRequestFullScreen){
        playerbox.mozRequestFullScreen();
    }
    playerbox.style.display="block";
    playerbox.style.width="100vw"; 
    playerbox.style.heigth="100vh";
    
    vid.style.width='100vw';
    vid.style.height='90vh';
}
document.addEventListener("webkitfullscreenchange", function(){
    if(!document.webkitIsFullScreen){
    	playerbox.style.width = "700px";
        playerbox.style.height = "500px";        
        vid.style.width = "700px";
        vid.style.height = "450px";      

    }
});
document.addEventListener("mozfullscreenchange", function(){
    if(!document.mozIsFullScreen){
    	playerbox.style.width = "700px";
        playerbox.style.height = "500px";        
        vid.style.width = "700px";
        vid.style.height = "450px";           
 
    }
});
document.addEventListener("MSFullscreenChange", function(){
    if(!document.msFullscreenElement){
    	 playerbox.style.width = "700px";
         playerbox.style.height = "500px";        
         vid.style.width = "700px";
         vid.style.height = "450px";      

    }
});

</script>
 <jsp:include page="/resources/include/bottom.jsp" />
</body>
<jsp:include page="/resources/include/footer.jsp" />
</html>