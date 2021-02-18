<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">	
/* a태그 디자인 */
.list-group-item-action {
	min-width:0;
	border-radius:5px;
	padding: 10px 40px 10px 40px;
	border-radius: 5px;
	background:#ADD8E6;
	style="font-weight:bold; 
	color:#145374;
}
ul{list-style:none;}
#gotop{ 
border-radius:5px; 
font-size:40px;
padding: 10px 40px 10px 40px; 
color:#145374;
}
</style>
<div id="quick" style="position:absolute; top:0px; right:10px;">

<div class="btn-group-vertical">
		<ul>
		    <li>
		    <a href="#class" class="list-group-item-action" style="font-weight:bold; color:#495464;">
		    	강의실</a>
		    </li><br />
		    <li>
		    <a href="#attend" class="list-group-item-action" style="font-weight:bold; color:#495464;">
		    	&nbsp;출&nbsp;&nbsp;&nbsp;결&nbsp;</a>
		    </li><br />
		    <li>
		    <a href="#calendar" class="list-group-item-action" style="font-weight:bold; color:#495464;">
		    	캘린더</a>
		    </li><br />
		    <li>
		    <a href="#homework" class="list-group-item-action" style="font-weight:bold; color:#495464;">
		    	과제함</a>
		    </li><br />
		    <li>
		    <a href="#studyroom" class="list-group-item-action" style="font-weight:bold; color:#495464;">
		    	공부방</a>
		    </li><br />
		    <li>
		    	<div align="center">
				   <a href="#top">
					   <img alt="top" src="resources/images/up_arrow.png" 
					   style="border-radius:5px; font-size: 200px;"/> 
				   </a>  		
		  		</div>
		    </li>
		</ul>   
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
	
	initMoving(document.getElementById("quick"), 150, 0);
	/* function initMoving(target, position, topLimit, btmLimit) */ 
</script>
