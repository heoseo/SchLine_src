<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 상단 인클루드 -->

		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />

			<!-- JS파일이 부트스트랩보다 위에 있어야 min.js에러가 안남 -->
			
			<!-- Scripts -->
			<script src='<c:url value="/resources/assets/js/jquery.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/jquery.scrollex.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/jquery.scrolly.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/browser.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/breakpoints.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/util.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/main.js"/>'></script>
			
			<!-- 드롭다운용 부트 -->
			<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
			<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
						
	
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/main.css" />
		<noscript><link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/noscript.css" /></noscript>
	</head>
	
	<!-- 기존 바디 위치 -->


	<!-- Wrapper -->
		<div id="wrapper">
		<!-- 상단영역 줄이기 위해 헤더속성 제거 -->
			<!-- Header -->
			<!-- he -->

<%

if(session.getAttribute("user_id") != null){
	
	if(!request.getRequestURI().contains("accessDenied")){
	
%>
					<!-- 글 안적을거같으니 일단 주석처리 -->
<!-- 					<p>Just another free, fully responsive site template<br /> -->
<!-- 						built by <a href="https://twitter.com/ajlkn">@ajlkn</a> for <a href="https://html5up.net">HTML5 UP</a>.</p> -->
<!-- 					</header> -->

<!-- 네비바 드롭다운 hover 적용 -->
<style>
/* 	nav ul li.dropdown:hover > ul.dropdown-menu {display:block; margin:0;} */
	nav ul li.dropdown:hover > div.dropdown-menu {display:block; margin:0;}
</style>

		<!-- Nav -->
			<nav id="nav" style="background-color: #ADD8E6; color:#145374; font-weight:bold;">
				<ul>
    				<li class="nav-item">
						<a href="/schline/"><!-- ★★이미지클릭시 home으로 가기. home요청명 적기 -->
 							<img src="<%=request.getContextPath() %>/resources/images/logo.png" width="200px" alt="스쿨라인 로고" />
 						</a>
					</li>
    				<li class="nav-item">
						<a href="/schline/professor/video.do">
						강의
						</a>
					</li>
					
	 				<li class="nav-item">
						<a href="/schline/professor/select.do" >
						과제</a>
					</li>
				
					<li><a href="/schline/professor/pexamlist.do">시험</a></li>
					<li>
						<div class="dropdown nav-item" >
							<div class="nav-item dropdown-toggle" data-toggle="dropdown" style="font-weight:bold;">
							<span style="text-align: center;" id="name">게시판</span>
							</div> 
							<div class="dropdown-menu nav-item">
								<a class="dropdown-item" href="/schline/professor/notiBoardList.do?"><i class="fas fa-question-circle"></i>&nbsp&nbsp공지사항</a> 
								<a class="dropdown-item" href="/schline/professor/penlist.do?board_type=red"><i class="fas fa-edit"></i>&nbsp&nbsp정정게시판</a> 
								<a class="dropdown-item" href="/schline/professor/penlist.do?board_type=blue"><i class="fas fa-question-circle"></i>&nbsp&nbsp질문게시판</a> 
							</div>
						</div>
					</li>
					<li><a href="/schline/professor/">출석</a></li>
					<li><a href="/schline/professor/">성적</a></li>
					<li><a href="/schline/professor/professorinfo.do"><i class="fas fa-user-circle" style="font-size:25px;">&nbsp;</i>계정</a></li>
					<li><a href="javascript:document.logout.submit()">
					<i class="fas fa-sign-out-alt">&nbsp;</i>로그아웃</a></li>
				</ul>
			</nav>
			
			<form:form method="post"
					action="${pageContext.request.contextPath }/member/logout" name="logout">
			</form:form>
				</ul>
			</nav>
			<br />
<%
	}
}
%>		