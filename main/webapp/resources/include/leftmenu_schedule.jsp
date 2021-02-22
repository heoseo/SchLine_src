<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<style>
#icon {
	font-size: 25px;
	text-align: left;
	padding-left: 5px;
}
</style>
<!-- 강의실 왼쪽메뉴 선택바 -->
<div id="main" class="container-fluid">

	<div class="row content">
		<br />
		<div class="col-sm-2 sidenav" style="font-weight: bold;">
			<br />
			<div class="list-group">
				<!-- fas fa-clock, fas fa-bell -->
				<a href="<%=request.getContextPath() %>/schedule/alertList.do?type=allBoard" class="list-group-item">
					<i class="fas fa-clock" id="icon">&nbsp&nbsp</i>
					<span>알림</span>
				</a>
				<a href="<%=request.getContextPath() %>/schedule/calendar.do" class="list-group-item">
					<i class="far fa-calendar-alt" id="icon">&nbsp&nbsp</i>
					<span style="text-align: center;">캘린더</span>
				</a>
			</div>
			<br />
		</div>
<!-- 내용입력부분. 클래스속성 건드리지말것 -->
<div class="col-lg-10">
<div class="container">
	