<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>


<script>
var time = 0;
var starFlag = true;
$(document).ready(function(){
  buttonEvt();
});

function init(){
  document.getElementById("time").innerHTML = "00:00:00";
}

function buttonEvt(){
  var hour = 0;
  var min = 0;
  var sec = 0;
  var timer;

  // start btn
	$("#startbtn").click(function(){

    if(starFlag){
      $(".fa").css("color","#FAED7D")
      this.style.color = "#4C4C4C";
      starFlag = false;

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
    }
	});

  // pause btn
  $("#pausebtn").click(function(){
    if(time != 0){
        $(".fa").css("color","#FAED7D")
        this.style.color = "#4C4C4C";
        clearInterval(timer);
        starFlag = true;
    }
  });

  // stop btn
  $("#stopbtn").click(function(){
    if(time != 0){
      $(".fa").css("color","#FAED7D")
      this.style.color = "#4C4C4C";
      clearInterval(timer);
      starFlag = true;
      time = 0;
      init();
    }

  });
}
</script>


<style>
	*{
		margin: 0px;
		padding: 0px;
	}
  body{
    height: 100vh;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
  }
  .box{
    width: 200px;
    height: 200px;
  }
	.timerBox{
		width: 200px;
		outline: 2px solid black;
	}
  .timerBox .time{
    font-size: 30pt;
		color: #4C4C4C;
    text-align: center;
    font-family: sans-serif;
  }
  .btnBox{
    margin: 20px auto;
    text-align: center;
  }
  .btnBox .fa{
    margin: 0px 5px;
    font-size: 30pt;
    color: #FAED7D;
    cursor: pointer;
  }
</style>
<!-- <meta charset="UTF-8"> -->
<!-- <title>StopWatch</title> -->
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript" src="stopwatch.js"></script>
<!-- </head> -->
<!-- <body> -->
	<div id='box' class="box">
    <div id='timerBox' class="timerBox">
      <div id="time" class="time">00:00:00</div>
    </div>
    <div class="btnBox">
      <i id="startbtn" class="fa fa-play" aria-hidden="true"></i>
      <i id="pausebtn" class="fa fa-pause" aria-hidden="true"></i>
      <i id="stopbtn" class="fa fa-stop" aria-hidden="true"></i>
    </div>
  </div>




</body>
</html>