<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>알림</title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>
<style>
#list {
	border-radius: 10px;
	border: solid 1px #A091B7;
	background: #F7F7F7;
}
#lista {
	font-size: 20px;
	font-weight: bold;
	margin-left: 10px;
}

#iconAlert {
	text-align: left;
	margin-left: 30px;
}
/* #badge { */
/* 	border-radius: 20px; */
/* 	background: #87CEEB; */
/* 	margin-left: 10px; */
/* 	padding-left: 5px; */
/* 	padding-right: 5px; */

/* } */
</style>
</head>
<!-- body 시작 -->
<body class="is-preload">
	<!-- 왼쪽메뉴 include -->
	<jsp:include page="/resources/include/leftmenu_schedule.jsp" />

	<hr />
	<div class="col-lg-12" id="list" style="font-size: 5px;">
	<br />

		<script>

			/* 
			    open() : 광고나 공지사항을 게시할 팝업창을 열고싶을때
			        주로 사용하는 함수.
			        형식] window.open(창의경로, 창의이름, 창의속성(모양, 크기, 위치 등));
			        -창의이름을 지정하지 않으면 동일한 창이 여러개 띄워질수도 있다.
			        -창의이름이 동일하면 여러개의 창이 하나의 창에 띄워질수도 있다.
			*/ 
	        function noticeRead(){
	            /*
	            screen객체를 통해 사용하는 모니터의 해상도를 얻어올수있다.
	           	 해상도와 팝업창의 크기를 이용하여 가운데로 위치를 지정한다.
	            */
	            var s_width = window.screen.width;
	            var s_height = window.screen.height;
	            
	            var leftVar = s_width/2 - 300/2;
	            var topVar = s_height/2 - 300/2;
	            window.open("<%=request.getContextPath() %>/schedule/alertNoticeRead.do", "popup", 
	                "width=800,height=800,left="+leftVar+",top="+ topVar);
	        }
	        function alertNoticeNotRead(){
	            /*
	            screen객체를 통해 사용하는 모니터의 해상도를 얻어올수있다.
	           	 해상도와 팝업창의 크기를 이용하여 가운데로 위치를 지정한다.
	            */
	            var s_width = window.screen.width;
	            var s_height = window.screen.height;
	            
	            var leftVar = s_width/2 - 300/2;
	            var topVar = s_height/2 - 300/2;
	            window.open("<%=request.getContextPath() %>/schedule/alertNoticeNotRead.do", "popup", 
	                "width=800,height=800,left="+leftVar+",top="+ topVar);
	        }
	        function correction(){
	            /*
	            screen객체를 통해 사용하는 모니터의 해상도를 얻어올수있다.
	           	 해상도와 팝업창의 크기를 이용하여 가운데로 위치를 지정한다.
	            */
	            var s_width = window.screen.width;
	            var s_height = window.screen.height;
	            
	            var leftVar = s_width/2 - 300/2;
	            var topVar = s_height/2 - 300/2;
	            window.open("<%=request.getContextPath() %>/schedule/correction.do", "popup", 
	                "width=800,height=800,left="+leftVar+",top="+ topVar);
	        }
	        function deadLine(){
	            /*
	            screen객체를 통해 사용하는 모니터의 해상도를 얻어올수있다.
	           	 해상도와 팝업창의 크기를 이용하여 가운데로 위치를 지정한다.
	            */
	            var s_width = window.screen.width;
	            var s_height = window.screen.height;
	            
	            var leftVar = s_width/2 - 300/2;
	            var topVar = s_height/2 - 300/2;
	            window.open("<%=request.getContextPath() %>/schedule/deadLine.do", "popup", 
	                "width=800,height=800,left="+leftVar+",top="+ topVar);
	        }
	    </script>
	    
	    <div style="font-weight:bold; text-align:center; font-size: 30px;">알림</div>
	    <div>&nbsp</div>

		<a class="list-group-item" onclick="noticeRead();" id="lista">
			<i class="fas fa-envelope-open-text" id="iconAlert" style="font-size: 40px">&nbsp&nbsp</i>
			<span style="text-align: center;">과제공지 읽음</span>
			<span class="badge badge-pill badge-danger" id="badge">7</span>
		</a>

		
		<a class="list-group-item" onclick="alertNoticeNotRead();" id="lista"> 
			<i class="fas fa-envelope-square" id="iconAlert" style="font-size: 40px">&nbsp&nbsp</i> 
			<span style="text-align: center;">과제공지 안 읽음</span>
			<span class="badge badge-pill badge-danger" id="badge">7</span>
		</a>

		<a class="list-group-item" onclick="correction();" id="lista"> 
			<i class="fas fa-edit" id="iconAlert" style="font-size: 40px">&nbsp&nbsp</i> 
			<span style="text-align: center;">다변수미적분-정정</span>
			<span class="badge badge-pill badge-danger" id="badge">7</span>
		</a>
 
		<a class="list-group-item" onclick="deadLine();" id="lista"> 
			<i class="fas fa-exclamation-triangle" id="iconAlert" style="font-size: 40px">&nbsp&nbsp</i>
			<span style="text-align: center;">화학2주차 과제 마감 3시간 전!!!</span>
			<span class="badge badge-pill badge-danger" id="badge">7</span>
		</a>
		<br />


	</div>
	<!-- list끝 -->


	<jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>