<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   

<!--
2021.02.02
1) ★★★인클루드 메뉴바 링크는 각자 넣어주세요!!!★★
2) ★★★각 view페이지 smail태그 안에있는 타이틀 일단 주석처리 해주세요(깔끔하게 스타일 변경)
 -->

<!DOCTYPE html>
<html>
	<head>
		<title>스쿨라인 메인</title>

<%@ include file="/resources/include/top.jsp" %>

<!-- /////////////////////Main시작////////////////////// -->
<body class="is-preload" data-spy="scroll" data-target="#myScrollspy" data-offset="1" >
	<br />
	<div id="main">
	
		
	<!-- 1. 강의실 -->
		<section id="class" class="main special">
			<div class="spotlight">
				<div class="content">
					<header class="major">
						<h2>강의실</h2>
					</header>
					<span class="image"><img src="<%=request.getContextPath() %>/resources/images/pic01.jpg" alt="" /></span>
					<p>
					Sed lorem ipsum dolor sit amet nullam consequat feugiat consequat magna
					adipiscing magna etiam amet veroeros. Lorem ipsum dolor tempus sit cursus.
					Tempus nisl et nullam lorem ipsum dolor sit amet aliquam.</p>
					<ul class="actions">
						<li><a href="generic.html" class="button">Learn More</a></li>
					</ul>
				</div>
			</div>
		</section>
		
		<!-- 2. 출결 -->
		<section id="attend" class="main special">
			<header class="major">
				<h2>출결</h2>
			</header>
			<ul class="features">
				<li>
					<span class="icon solid major style1 fa-code"></span>
					<h3>Ipsum consequat</h3>
					<p>Sed lorem amet ipsum dolor et amet nullam consequat a feugiat consequat tempus veroeros sed consequat.</p>
				</li>
				<li>
					<span class="icon major style3 fa-copy"></span>
					<h3>Amed sed feugiat</h3>
					<p>Sed lorem amet ipsum dolor et amet nullam consequat a feugiat consequat tempus veroeros sed consequat.</p>
				</li>
				<li>
					<span class="icon major style5 fa-gem"></span>
					<h3>Dolor nullam</h3>
					<p>Sed lorem amet ipsum dolor et amet nullam consequat a feugiat consequat tempus veroeros sed consequat.</p>
				</li>
			</ul>
			<footer class="major">
				<ul class="actions special">
					<li><a href="generic.html" class="button">Learn More</a></li>
				</ul>
			</footer>
		</section>

<!-- 3.캘린더시작 -->		

		<section id="calendar" class="main special">
			<header class="major">
				<h2 style="font-weight:bold; padding-top: 0px">캘린더</h2>
			<%@ include file="../schedule/calendarMain.jsp" %>
			</header>
		</section>
		
<!-- 3.캘린더끝. -->		
		
		
		<!-- 4. 과제함 -->
		<section id="homework" class="main special">
			<header class="major">
				<h2>과제함</h2>
				<p>Donec imperdiet consequat consequat. Suspendisse feugiat congue<br />
				posuere. Nulla massa urna, fermentum eget quam aliquet.</p>
			</header>
			<footer class="major">
				<ul class="actions special">
					<li><a href="generic.html" class="button primary">Get Started</a></li>
					<li><a href="generic.html" class="button">Learn More</a></li>
				</ul>
			</footer>
		</section>
		
		<!-- 5. 공부방 -->
		<section id="studyroom" class="main special">
				<header class="major">
				<h2>공부방</h2>
				<p>Donec imperdiet consequat consequat. Suspendisse feugiat congue<br />
					posuere. Nulla massa urna, fermentum eget quam aliquet.</p>
			</header>
			<footer class="major">
				<ul class="actions special">
					<li><a href="generic.html" class="button primary">Get Started</a></li>
					<li><a href="generic.html" class="button">Learn More</a></li>
				</ul>
			</footer>
		</section>
	</div>
		
	<!-- 메인 퀵바 -->
	<%@ include file="/resources/include/quick.jsp"%>
	<!-- /////////////////////메인끝////////////////////// -->
		</body>
		
	<!-- 하단 인클루드 -->
	<jsp:include page="/resources/include/footer.jsp"/>

</html>