<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
 <title>${name }</title>
<meta charset="UTF-8">
<meta name="robots" content="noindex,nofollow"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
<meta http-equiv="X-UA Compatible" control="IE=edge,chrome=1" />
  <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
  <link rel="stylesheet" href="video-canvas.css" />
  <script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="/schline/resources/assets/css/main.css" />
	<noscript><link rel="stylesheet" href="/schline/resources/assets/css/noscript.css" /></noscript>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.1/css/font-awesome.min.css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<style tyle="text/css">
    body{
        font-family:verdana;
    }
    #result{
        padding:10px;
        font-size: 14px;
    }
#video_contorls_bar{background: #333; padding:10px; height:25px;}
#video_contorls_bar span {color:#ffffff;}
div video{width:700px; height:450px;}
#seekslider{width:37%;}
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
    <br />
      	<div align="center">
					<a href="/schline/"><!-- ★★이미지클릭시 home으로 가기. home요청명 적기 -->
 						<img src="<%=request.getContextPath() %>/resources/images/logo.png" width="400px" alt="스쿨라인 로고" />
					</a>
				</div>
    </header>  
	<br /><!-- style="display:none" -->
	<div id='timerBox' class="timerBox" >
	<div  id="time" class="time" style="text-align: center;" >00:00:00</div>
	<div  id="at" style="text-align: center">1</div>
	</div>
    <!-- 비디오 태그 쓸꺼임-->
    <div id="playerbox" style="height:500px;width:700px;background:#333;margin:0px auto;">
	   <div id="vid_box" style="width:700px;height:450px; ">
	        <video id="my_video" >
	        <source src="../resources/video/${video_title }">
	        </video>
	   </div>
        <div id="video_contorls_bar" style="position: relative;">
            <span id="plapausebtn" >
            
			<img src="../resources/images/play.png"  alt="play" width="20px" style="margin-bottom:-5px;cursor:pointer; "  />
			</span>
             <input type="range" id="seekslider" min="0" max="100" value="0" step="1">   
            <span id="curtimetext" style="font-size:small;">0:00:00</span> / <span style="font-size:small;" id="durtimetext">0:00:00</span>
            &nbsp;
            <span id="mutebtn">
			<img src="../resources/images/unmute.png"  alt="play" width="20px" style="margin-bottom:-5px;cursor:pointer; "  />            
            </span>
            <input type="range" id="soundslider" min="0" max="100" value="0" step="1">   
            <span id="mutebtn">
			<img src="../resources/images/mic.png" onClick="startConverting();" width="20px" style="margin-bottom:-5px;cursor:pointer; "  />            
            </span>
            <span class="float-right">
            <span style="background-color: #333; border:none; color:red; cursor: pointer;" onclick="penboard('red')" id="pen1" ><i class="fas fa-pencil-alt"></i></span>
            &nbsp;
            <span style="background-color: #333; border:none; color:skyblue;cursor: pointer;" id="pen2" onclick="penboard('blue')"><i class="fas fa-pencil-alt"></i></span>
            &nbsp;
            <span  style="background-color: #333; border:none; color:yellow;cursor:pointer; " id="pen3" onclick='snap();' ><i class="fas fa-pencil-alt"></i></span>
    
            <span id="fullscreenbtn">
            &emsp;<img src="../resources/images/full.png"  alt="play" width="20px" style="margin-bottom:-5px;cursor:pointer; "  />            
            </span>
            </span>
          <div id="result" style="position: relative;  top:-65px; opacity:0.5;  color:white">
			
			</div>
        <canvas ></canvas>
        </div>
       

        
   </div>
<script>
var vid,playerbox, playbtn, seekbar,curtimetext,durtimetext,mutebtn,soundslider,fullscreenbtn,vid_box;
var time=${dto.getPlay_time()}; var attendance=${dto.getAttendance_flag()};

function intializePlayer(){
var hour=0 , min=0 , sec =0;
var timer,timedb;


    vid  = document.getElementById("my_video");
    playbtn  = document.getElementById("plapausebtn");
    playerbox  = document.getElementById("playerbox");
    seekbar  = document.getElementById("seekslider");
    curtimetext  = document.getElementById("curtimetext");
    durtimetext  = document.getElementById("durtimetext");
    mutebtn  = document.getElementById("mutebtn");
    soundslider  = document.getElementById("soundslider");
    fullscreenbtn  = document.getElementById("fullscreenbtn");
    vid_box  = document.getElementById("vid_box");
    setTimeout(function() {
    	updateData(); }, 3000); 
 
    vid.currentTime=${dto.getCurrenttime()};

    playbtn.addEventListener("click",playPause,false);
    seekbar.addEventListener("change",vidSeek,false);
    vid.addEventListener("timeupdate",seektimeUpdate,false);
    mutebtn.addEventListener("click",vidmute,false);
    soundslider.addEventListener("change",setvolume,false);
    fullscreenbtn.addEventListener("click",togglefullscreen,false);

    
    

}
window.onload = intializePlayer;
function init(){
	  document.getElementById("time").innerHTML = "00:00:00";
	}

function playPause(){
    if(vid.paused){
        vid.play();
        playbtn.innerHTML = '<img src="../resources/images/stop.png"  alt="play" width="20px" style="margin-bottom:-5px;cursor:pointer;"  />';
        if(time == 0){
            init();
          }
        timer = setInterval(function(){
            time++;

            min = Math.floor(time/60);
            hour = Math.floor(min/60);
            sec = time%60;
            min = min%60;

            var th = hour;
            var tm = min;
            var ts = sec;
            if(th<10){
            th = "0" + hour;
            }
            if(tm < 10){
            tm = "0" + min;
            }
            if(ts < 10){
            ts = "0" + sec;
            }

            document.getElementById("time").innerHTML = th + ":" + tm + ":" + ts;
          }, 1000);

    }else{
        vid.pause();
        playbtn.innerHTML = '<img src="../resources/images/play.png"  alt="play" width="20px" style="margin-bottom:-5px;cursor:pointer;"  />';
        if(time != 0){
            clearInterval(timer);
          }
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
    //0.8로 바꿔야하는데 테스트할떄 40%만 들어도 출석으로 해놈
    if(vid.duration *0.4 <= time){
    	attendance=2;   
    	document.getElementById("at").innerHTML = attendance ;
        }
    else{
    	attendance=1;   
    }
}
function vidmute(){
    if(vid.muted){
        vid.muted = false;
        mutebtn.innerHTML='<img src="../resources/images/unmute.png"  alt="play" width="20px" style="margin-bottom:-5px;cursor:pointer; "  />';
    }else{
        vid.muted= true;
        mutebtn.innerHTML='<img src="../resources/images/mute.png"  alt="play" width="20px" style="margin-bottom:-5px;cursor:pointer; "  />';
    }
}
function togglefullscreen(){
    if(playerbox.requestFullScreen){
        playerbox.requestFullScreen();
    }else if(playerbox.webkitRequestFullScreen){
        playerbox.webkitRequestFullScreen();
    }else if(playerbox.mozRequestFullScreen) {
        playerbox.mozRequestFullScreen();
    }
    
    vid.style.width='100vw';
    vid.style.height='90vh';
    vid_box.style.width='100vw';
    vid_box.style.height='90vh';
}
document.addEventListener("webkitfullscreenchange", function(){
    if(!document.webkitIsFullScreen){
    	playerbox.style.width = "700px";
        playerbox.style.height = "500px";        
        vid_box.style.width = "700px";
        vid_box.style.height = "450px";            
        vid.style.width = "700px";
        vid.style.height = "450px";      

    }
});
document.addEventListener("mozfullscreenchange", function(){
    if(!document.mozIsFullScreen){
    	playerbox.style.width = "700px";
        playerbox.style.height = "500px";        
        vid_box.style.width = "700px";
        vid_box.style.height = "450px";            
        vid.style.width = "700px";
        vid.style.height = "450px";     
    }
});
document.addEventListener("MSFullscreenChange", function(){
    if(!document.msFullscreenElement){
    	playerbox.style.width = "700px";
        playerbox.style.height = "500px";        
        vid_box.style.width = "700px";
        vid_box.style.height = "450px";            
        vid.style.width = "700px";
        vid.style.height = "450px";     
    }
});
// 비디오 캔버스에 그리기
var video = document.querySelector('video');
var canvas = document.querySelector('canvas');
// Get a handle on the 2d context of the canvas element
var context = canvas.getContext('2d');
// Define some vars required later
var w, h, ratio;

// Add a listener to wait for the 'loadedmetadata' state so the video's dimensions can be read
video.addEventListener('loadedmetadata', function() {
	// Calculate the ratio of the video's width to height
	ratio = video.videoWidth / video.videoHeight;
	// Define the required width as 100 pixels smaller than the actual video's width
	w = video.videoWidth - 100;
	// Calculate the height based on the video's width and the ratio
	h = parseInt(w / ratio, 10);
	// Set the canvas width and height to the values just calculated
	canvas.width = w;
	canvas.height = h;			
}, false);

// Takes a snapshot of the video
function snap() {
	// Define the size of the rectangle that will be filled (basically the entire element)
	context.fillRect(0, 0, w, h);
	// Grab the image from the video
	context.drawImage(video, 0, 0, w, h);
	canvas.style.display="none";
	sreenShot();
}
//캔버스 이미지로 변환후 에이젝스로 데이터 보내기
function sreenShot() {
	
	  var $canvas = document.createElement('canvas');
	   var myImg = $canvas.toDataURL('image/png');
			var myImg = canvas.toDataURL("image/png");
			myImg = myImg.replace("data:image/png;base64,", "");

			$.ajax({
				type : "POST",
				data : {
					"imgSrc" : myImg,
					"title" : "${name }"
				},
				dataType : "text",
				url : "../yellow/ImgSave.do",
				beforeSend : function(xhr){
		            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
		           },
				success : function(data) {
					console.log(data);
				},
				error : function(a, b, c) {	
					alert("error");
				}
			});
}

//디비 30초 업데이트
 function updateData(){
    $.ajax({
      url: "../class/atupdate.do",
      type:"post",
      data : {
    	  	idx : "${idx}",
			play : time,
			flag : attendance,
			current : vid.currentTime			
		}
     , beforeSend : function(xhr){
         xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
     },
      cache : false,
      success: function(data){ 
    	  console.log(data);
      }
    });
    timedb = setTimeout("updateData()", 10000); // 테스트 용으로 10초마다 보냄 >30초가 맞음
} 

//음성인식 자막
var r=document.getElementById('result');
 
function startConverting ()
{
        if('webkitSpeechRecognition'in window){
            //Web speech API Function
            var speechRecognizer = new webkitSpeechRecognition();
            //continuous : you will catch mic only one time or not
            speechRecognizer.continuous = true;
            //interimResults : during capturing the mic you will send results or not
            speechRecognizer.interimResults = true;
            //lang : language (ko-KR : Korean, en-IN : englist)
            speechRecognizer.lang="ko-KR"||"en-IN";
            //start!
            speechRecognizer.start();
 
            var finalTranscripts = '';
 
            //if the voice catched onresult function will start
            speechRecognizer.onresult=function(event){
                var interimTranscripts='';
                for(var i=event.resultIndex; i < event.results.length; i++)
                {
                    var transcript=event.results[i][0].transcript;
                    transcript.replace("\n","<br>");
 
                    //isFinal : if speech recognition is finished, isFinal = true
                    if(event.results[i].isFinal){
                        finalTranscripts+=transcript;
                    }
                    else{
                        interimTranscripts+=transcript;
                    }
                }
                r.innerHTML='<span style="background:#333;">'+'&emsp;&emsp;&emsp;&emsp;'+interimTranscripts+'</span>';
            };
            speechRecognizer.onerror = function(event){
            };
        }
        else{
            r.innerHTML ="크롬에서만 이용가능합니다.";
        }
    }
//빨간펜 파란펜
function penboard(target){
	 var url = "../penboard/write.do?flag="+target+"&time="+$('#curtimetext').text()+"&vid_title="+"${name }&sub_idx="+${sub_idx};
	 var win = window.open(url, "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,top=500,left=500,width=600,height=600");

	 
}
</script>
 <jsp:include page="/resources/include/bottom.jsp" />
</body>
<jsp:include page="/resources/include/footer.jsp" />
</html>