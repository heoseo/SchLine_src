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

#icon {
	text-align: left;
	padding-left: 30px;
}
</style>
</head>
<!-- body 시작 -->
<body class="is-preload">
	<!-- 왼쪽메뉴 include -->
	<jsp:include page="/resources/include/leftmenu_schedule.jsp" />

	<hr />
	<div class="col-lg-12" id="list" style="font-size: 20px;">
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
	            window.open("<%=request.getContextPath() %>/schedule/alertNoticeRead.do", "popup", 
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
	            window.open("<%=request.getContextPath() %>/schedule/alertNoticeRead.do", "popup", 
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
	            window.open("<%=request.getContextPath() %>/schedule/alertNoticeRead.do", "popup", 
	                "width=800,height=800,left="+leftVar+",top="+ topVar);
	        }
	    </script>
	    
	    <div style="font-weight:bold; text-align:center; font-size: 30px;">알림</div>
	    <div>&nbsp</div>
	    
		<a class="list-group-item" onclick="noticeRead();">
			<i class="fas fa-envelope-open-text fa-10x" id="icon">&nbsp&nbsp</i>
			<span style="text-align: center;">과제공지 읽음</span>
		</a>
		
		<a class="list-group-item" onclick="alertNoticeNotRead();"> 
			<i class="fas fa-envelope-square fa-10x" id="icon">&nbsp&nbsp</i> 
			<span style="text-align: center;">과제공지 안 읽음</span>
		</a>

		<a class="list-group-item" onclick="correction();"> 
			<i class="fas fa-edit fa-10x" id="icon">&nbsp&nbsp</i> 
			<span style="text-align: center;">다변수미적분-정정</span>
		</a>
 
		<a class="list-group-item" onclick="deadLine();"> 
			<i class="fas fa-exclamation-triangle fa-10x" id="icon">&nbsp&nbsp</i>
			<span style="text-align: center;">화학2주차 과제 마감 3시간 전!!!</span>
		</a>
		<br />


	</div>
	<!-- list끝 -->


	<jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>