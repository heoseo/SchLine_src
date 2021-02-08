<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");


//캘린더
Calendar tDay = Calendar.getInstance(); //현재날짜
int now_year = tDay.get(Calendar.YEAR); //현재년도
int now_month = tDay.get(Calendar.MONTH) + 1; //현재월
int now_week = tDay.get(Calendar.DAY_OF_WEEK);//현재요일(일1, 토7)
int now_day = tDay.get(Calendar.DATE); //현재일
int last_day = tDay.getActualMaximum(Calendar.DAY_OF_MONTH);//현재달 마지막 일

Calendar cDay = Calendar.getInstance();
cDay.set(cDay.DAY_OF_MONTH, 1);//DAY_OF_MONTH를 1로 설정(월의 첫날)
int first_week = cDay.get(Calendar.DAY_OF_WEEK);//위에서 설정한 1일의 요일
cDay.set(cDay.DAY_OF_MONTH, last_day);//DAY_OF_MONTH를 1로 설정(월의 첫날)
int last_week = cDay.get(Calendar.DAY_OF_WEEK);//마지막일의 요일
%>

<!DOCTYPE html>
<html>
<head>
<title>캘린더</title>
<!-- 캘린더CSS -->
<style>
/* .calendarTitle { */
/* 	font-weight: bold; */
/* } */

/* .Year { */
/* 	padding-left: 400px; */
/* 	font-size: 20px; */
/* } */

/* #buttonMove { */
/* 	padding-left: 50px; */
/* 	font-size: 10px; */
/* } */

/* .calendarTable { */
/* 	border: solid 2px #E8D9FF; */
/* 	text-align: right; */
/* } */

/* .calendarTr { */
/* 	padding: 50px; */
/* } */

/* .calendarTh { */
/* 	text-align: center; */
/* 	padding: 5px; */
/* 	background: #E8D9FF; */
/* 	font-weight: bold; */
/* } */

/* .calendarTd { */
/* 	text-align: left; */
/* 	color: black; */
/* 	padding-top: 0; */
/* 	padding-left: 0.5; */
/* 	padding-bottom: 60px; */
/* 	border: solid 2px #E8D9FF; */
/* 	font-size: 15px; */
/* } */

/* .Task { */
/* 	border: solid 2px #4682B4; */
/* 	border-radius: 5px; */
/* 	background: #87CEEB; */
/* 	font-size: 5px; */
/* 	font-weight: bold; */
/* 	color: #4169E1; */
/* } */
</style>
<!-- style태그끝! -->


<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>
<script>
//캘린더 아잭스
$(function() {
	//계산을 위한 변수선언
	var sum = parseInt($('#hmonth').val());
	var sum2 = parseInt($('#hyear').val());
	var mon = $('#calMon');
	var year = $('#calYear');
	
	//아잭스 시작(현재상태)
	$.ajax({
		url : "<%=request.getContextPath() %>/schedule/ajaxCalendar.do",
		type : "post",
		data :
			{
			year : $('#calYear').text(),
			month : $('#calMon').text(),
			},
		dateType : "html",
		contentType : "application/x-www-form-urlencoded;chatset:utf-8",
		success : function(Date) {
			$("#calBody").html(Date);
			},
		error : function(request,status,error) {
			//확인하기
	        alert("code:"+request.status+"\n"+"message:"+request.responseText+
	        		"\n"+"error:"+error);
			console.log("message : " + request.responseText);
		}
	});
	//이전달 클릭시 액션 및 Ajax
	$('#calBefore').bind("click", function() {
		if (sum == 1) {
			sum = 12;
			sum2--;
		}else {sum--;}
		mon.text(sum);
		year.text(sum2);
		//ajax실행
		$.ajax({
			url : "<%=request.getContextPath() %>/schedule/ajaxCalendar.do",
			type : "post",
			data :
				{
				year : $('#calYear').text(),
				month : $('#calMon').text(),
				},
			dateType : "html",
			contentType : "application/x-www-form-urlencoded;chatset:utf-8",
			success : function(Date) {
				$("#calBody").html(Date);
				},
			error : function(request,status,error) {
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+
		        		"\n"+"error:"+error);
			}
		});
	});
	//다음달 클릭시 액션 및 Ajax
	$('#calAfter').click(function() {
		if (sum == 12) {
			sum = 1;
			sum2++;
		}else {sum++;}
		mon.text(sum);
		year.text(sum2);
		//ajax실행
		$.ajax({
			url : "<%=request.getContextPath() %>/schedule/ajaxCalendar.do",
			type : "post",
			data :
				{
				year : $('#calYear').text(),
				month : $('#calMon').text(),
				},
			dateType : "html",
			contentType : "application/x-www-form-urlencoded;chatset:utf-8",
			success : function(Date) {
				$("#calBody").html(Date);
				},
			error : function(request,status,error) {
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+
		        		"\n"+"error:"+error);
			}
		});
	});
});
</script>
<!-- body 시작 -->
<body class="is-preload">

	<!-- 왼쪽메뉴 include -->
	<jsp:include page="/resources/include/leftmenu_schedule.jsp" /><!-- flag구분예정 -->

	<!-- 캘린더시작. -->
	<hr />
	
	<div id="main" class="col-lg-12 sidenav">
	
		<div>
			<span class="Year" id="calYear"><%=now_year%>년 <%=now_month%>월</span>
			<span id="buttonMove"> 
				<a href="../schedule/calendar.do?y=<%=now_year%>&m=<%=now_month-1 %>" class="button small">
					<i class='fas fa-chevron-left'></i>
				</a>
				<a href="../schedule/calendar.do?y=<%=now_year%>&m=<%=now_month+1%>" class="button small">
					<i class='fas fa-chevron-right'></i>
				</a>
			</span>
		</div>

		<div class="contents_box">
			<table border="0">
			
				<input type="hidden" id="hyear" name="hyear" value="<%=now_year%>" />
				<input type="hidden" id="hmonth" name="hmonth" value="<%=now_month%>" />
				
				<tr>
					<td>
						<button id="calBefore" style="border:0">
							<i class='fas fa-chevron-left'></i>
						</button>
					</td>
					<td>
						<span id="calYear" style="font-size: 1.4em; font-weight: bold;"><%=now_year%></span>&nbsp;&nbsp;
						<span id="calMon" style="font-size: 1.2em;"><%=now_month%></span>
						<span style="font-size: 1.2em;">월</span> 
					<td>
						<!-- 캘린더 버튼. 다음달-->
						<button id="calAfter" style="border: 0">
							<i class='fas fa-chevron-right' style="margin-top: 3px;"></i>
						</button>
					</td>
				</tr>				
			</table>
			
			<div id="calBody">
				달력Display
			</div>	
		</div><!-- contents_box끝 -->
		
	</div><!-- main div끝 <-->




<!-- #################################################################### -->

			<jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />

</html>