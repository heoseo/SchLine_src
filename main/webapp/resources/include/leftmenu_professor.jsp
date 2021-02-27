<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
	<head>

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
<br />
<div id="main" class="container-fluid">
	<div class="row content">
	<br />
		<div class="col-sm-2 sidenav">
			<br/>
				<div class="list-group">
				
				<!-- 기존 코스★★★★★ -->
					<a style="color:#145374"  href="professorinfo.do" class="list-group-item" >
						<i class="fas fa-vector-square" id="icon">&nbsp&nbsp</i>
						<span style="text-align: center;">전체 보기</span>
					</a>
					
				</div>
	</div>
<!-- 내용입력부분. 클래스속성 건드리지말것 -->
<div class="col-lg-10">
<div class="container">
	