<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
#quick {
	height: 100vh;
	border-radius: 8px; 
}
#guick_ul {
    list-style: none;
    padding-left: 0px;  

}
#guick_ul li {
	padding-left: 50px;
	padding-right: 50px;
	text-align: center;
	color: black;
	font-weight: bold;
	padding-left: 30px;
	padding-right: 30px;
	
}
.btn-group-vertical {
	color: black;
	font-weight: bold;
}
</style>
<div id="quick" style="position: absolute; top: 0px; right: 2px;">
<!-- 	<ul id="guick_ul" class="list-group"> -->
<!-- 		<li><a href="#class" class="list-group-item list-group-item-action">강의실</a></li> -->
<!-- 		<li><a href="#attend" class="list-group-item list-group-item-action">출결</a></li> -->
<!-- 		<li><a href="#calendar" class="list-group-item list-group-item-action">캘린더</a></li> -->
<!-- 		<li><a href="#homework" class="list-group-item list-group-item-action">과제함</a></li> -->
<!-- 		<li><a href="#studyroom" class="list-group-item list-group-item-action">공부방</a></li> -->
<!-- 	</ul> -->
		<div class="btn-group-vertical">
		    <button type="button" class="btn"><a href="#class" class="list-group-item list-group-item-action">강의실</a></button><br />
		    <button type="button" class="btn"><a href="#attend" class="list-group-item list-group-item-action">출결</a></button><br />
		    <button type="button" class="btn"><a href="#calendar" class="list-group-item list-group-item-action">캘린더</a></button><br />
		    <button type="button" class="btn"><a href="#homework" class="list-group-item list-group-item-action">과제함</a></button><br />
		    <button type="button" class="btn"><a href="#studyroom" class="list-group-item list-group-item-action">공부방</a></button><br />
		   
  		</div>
  		<div align="center">
		   <a href="#top"><img alt="top" src="resources/images/top_btn.gif" /></a>  		
  		</div>
</div>



<script type="text/javascript" language="javascript">
function initMoving(target, position, topLimit, btmLimit) {
	if (!target)
	return false;
	
	var obj = target;
	obj.initTop = position;
	obj.topLimit = topLimit;
	obj.bottomLimit = document.documentElement.scrollHeight - btmLimit;
	
	 obj.style.position = "absolute";
	 obj.top = obj.initTop;
	 obj.left = obj.initLeft;
	
	 if (typeof(window.pageYOffset) == "number") {
	 obj.getTop = function() {
	 return window.pageYOffset;
	 }
	 } else if (typeof(document.documentElement.scrollTop) == "number") {
	 obj.getTop = function() {
	 return document.documentElement.scrollTop;
	 }
	 } else {
	 obj.getTop = function() {
	 return 0;
	 }
	 }
	
	 if (self.innerHeight) {
	 obj.getHeight = function() {
	 return self.innerHeight;
	 }
	 } else if(document.documentElement.clientHeight) {
	 obj.getHeight = function() {
	 return document.documentElement.clientHeight;
	 }
	 } else {
	 obj.getHeight = function() {
	 return 500;
	 }
	 }
	
	 obj.move = setInterval(function() {
	 if (obj.initTop > 0) {
	 pos = obj.getTop() + obj.initTop;
	 } else {
	 pos = obj.getTop() + obj.getHeight() + obj.initTop;
	 //pos = obj.getTop() + obj.getHeight() / 2 - 15;
	 }
	
	 if (pos > obj.bottomLimit)
	 pos = obj.bottomLimit;
	 if (pos < obj.topLimit)
	 pos = obj.topLimit;
	
	 interval = obj.top - pos;
	 obj.top = obj.top - interval / 3;
	 obj.style.top = obj.top + "px";
	 }, 30)
	}
	
	initMoving(document.getElementById("quick"), 203, 0);
	/* function initMoving(target, position, topLimit, btmLimit) */ 
</script>
