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
<style type="text/css">
	body{
	/* 	background: #074684; */
	/* 	background: #b1bed5; */
	 	background: #bee5d3;
	
	}
	nav{
		color: white;
	}

</style>
</head>
<!-- 강의실 왼쪽메뉴 선택바 -->
<style>
#icon {
	font-size: 20px;
	text-align: left;
}
#hover {
	color: black;
	background: #F7F7F7; 
	text-decoration: underline;
}



.list-group-item.active {
    z-index: 2;
    color: #fff;
    background-color: #a7c3ca;
    border-color: #a7c3ca;
}


</style>
<div id="main" class="container-fluid">
	<br/>
	<div class="row content">
	<br />
		<div class="col-sm-2 sidenav">
			<br/>
				<div class="list-group">
				
				<!-- 기존 코스★★★★★ -->
					<a href="professorinfo.do" class="list-group-item" >
						<i class="fas fa-arrow-alt-circle-left" id="icon">&nbsp&nbsp</i>
						<span style="text-align: center;">뒤로 가기</span>
					</a>
					
				</div>
				<br />
	</div>
	<br/><br/>
<!-- 내용입력부분. 클래스속성 건드리지말것 -->
<div class="col-lg-10">
<div class="container">
	