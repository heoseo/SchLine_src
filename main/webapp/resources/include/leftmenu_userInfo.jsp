<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		
<!-- 		<!-- 추가한 부트부분 -->
<!-- 		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
		
<!-- 		  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
		  
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/main.css" />
		<noscript><link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/noscript.css" /></noscript>
	</head>
<!-- 강의실 왼쪽메뉴 선택바 -->
<style>
#icon {
	font-size: 20px;
	text-align: left;
	padding-left: 5px;
}
#hover {
	color: black;
	background: #F7F7F7; 
	text-decoration: underline;
}
</style>
<div id="main" class="container-fluid">
	<br/>
	<div class="row content">
	<br />
		<div class="col-sm-2 sidenav">
				<div class="list-group">
				
				<!-- 기존 코스★★★★★ -->
					<a href="userinfo.do" class="list-group-item">
						<i class="	fas fa-user-alt" id="icon">&nbsp&nbsp</i>
						<span style="text-align: center;">사용자</span>
					</a>
					
					<a href="SubjectAtten.do" class="list-group-item">
						<i class="fas fa-list-alt" id="icon">&nbsp&nbsp</i>
						<span style="text-align: center;">수강 목록</span>
					</a>
					
					<a href="SubjectGrade.do" class="list-group-item">
						<i class="fas fa-star" id="icon">&nbsp&nbsp</i>
						<span style="text-align: center;">성적 조회</span>
					</a>
					
					<a href="SubjectFile.do" class="list-group-item">
						<i class="fas fa-folder" id="icon">&nbsp&nbsp</i>
						<span style="text-align: center;">제출 파일</span>
					</a>
				</div>
				<br />
	</div>
	<br/>
<!-- 내용입력부분. 클래스속성 건드리지말것 -->
<div class="col-lg-10">
<div class="container">
	