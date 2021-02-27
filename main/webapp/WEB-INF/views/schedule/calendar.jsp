<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");


//캘린더
Calendar tDay = Calendar.getInstance(); //현재날짜 오늘날짜
int now_year = tDay.get(Calendar.YEAR); //현재년도
int now_month = tDay.get(Calendar.MONTH) + 1; //현재월
int now_week = tDay.get(Calendar.DAY_OF_WEEK);//현재요일(일1, 토7)
int now_day = tDay.get(Calendar.DATE); //현재일
int last_day = tDay.getActualMaximum(Calendar.DAY_OF_MONTH);//현재달 마지막 일

Calendar cDay = Calendar.getInstance();
cDay.set(cDay.DAY_OF_MONTH, 1);//DAY_OF_MONTH를 1로 설정(월의 첫날) 2월 1일
int first_week = cDay.get(Calendar.DAY_OF_WEEK);//위에서 설정한 1일의 요일

cDay.set(cDay.DAY_OF_MONTH, last_day);//DAY_OF_MONTH를 1로 설정(월의 첫날) 2월 28일
int last_week = cDay.get(Calendar.DAY_OF_WEEK);//마지막일의 요일
%>

<!DOCTYPE html>
<html>
<head>
<title>캘린더</title>
<!-- 캘린더CSS -->
<style>
.calendarTitle {
	text-align:right;
	font-size: 1.2em;
}
#button {
	font-size: 10px;
	border: none;
	text-align: right;
	padding-left: 300px;
}
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
	
	//에이잭스 시작(현재상태)
	$.ajax({
		url : "<%=request.getContextPath() %>/schedule/ajaxCalendar.do",
		type : "post",
		data :
			{
			year : $('#calYear').text(),
			month : $('#calMon').text(),
			},
		dateType : "html",
		beforeSend : function(xhr){
            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
           },
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
			beforeSend : function(xhr){
	            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	           },
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
			beforeSend : function(xhr){
	            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	           },
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

		<div class="contents_box">
		
			<table class="table table-bordered table-hover table-striped">
				<input type="hidden" id="hyear" name="hyear" value="<%=now_year%>" />
				<input type="hidden" id="hmonth" name="hmonth" value="<%=now_month%>" />
				
				<tr>
					<td>

						<!-- 캘린더 년도,월 출력. -->
						<div class="calendarTitle">
							<span class="calYear" id="calYear"><%=now_year%></span><span>년</span> 
							<span class="calMon" id="calMon"><%=now_month%></span><span>월</span>
						
							&nbsp;&nbsp;
							<span id="button">
								<!-- 캘린더 버튼. 이전달달 -->
								<button id="calBefore" class="button small" style="border: 2px solid gray;">
									<i class='fas fa-chevron-left'></i>
								</button>
								<!-- 캘린더 버튼. 다음달 -->				
								<button id="calAfter" class="button small" style="margin-right: 0px; border: 2px solid gray;">
									<i class='fas fa-chevron-right'></i>
								</button>
							</span>
						</div> 
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