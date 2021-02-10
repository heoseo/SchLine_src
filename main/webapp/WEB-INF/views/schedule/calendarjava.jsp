
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
/*
Calendar 클래스는 추상 클래스로 생성자를 제공하지 않는다. 
따라서, 객체를 생성하기 위해 new 연산자를 사용할 수 없다.  
대신 getInstance() 메소드를 사용하여 현재 날짜와 시간의 객체를 얻어올 수 있다.
*/
Calendar tDay = Calendar.getInstance();

/* 파라미터가 없다면 현재 년/월/일 구해옴 */
int y = (request.getParameter("y")==null) ? 
		tDay.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("y"));
int m = (request.getParameter("m")==null) ? 
		tDay.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("m"));
int d = tDay.get(Calendar.DATE);



if(m == -0){
	y--;
	m=12;
}
if(m == 13){
	y++;
	m=1;
}

//날자설정을 위한 객체생성 : 현재 년/월 그리고 1일로 설정, 즉 현재월의 1일로 설정한다.
Calendar dSet = Calendar.getInstance();
dSet.set(y, m, 1);

int yo = dSet.get(Calendar.DAY_OF_WEEK);

//현재월의 마지막 날자를 구해옴(7월:31일, 9월:30일 ... )
int last_day = dSet.getActualMaximum(Calendar.DATE);


///////

Calendar gSet = Calendar.getInstance();

String Task = "안녕하세요모라하노뚱뚱아";

%>

<!DOCTYPE html>
<html>
<head>
<title>캘린더</title>
<!-- 캘린더CSS -->
<style>
.calendarTitle {
	font-weight: bold;
}

.Year {
	padding-left: 400px;
	font-size: 20px;
}

#buttonMove {
	padding-left: 50px;
	font-size: 10px;
}

.calendarTable {
	border: solid 2px #E8D9FF;
	text-align: right;
}

.calendarTr {
	padding: 50px;
}

.calendarTh {
	text-align: center;
	padding: 5px;
	background: #E8D9FF;
	font-weight: bold;
}

.calendarTd {
	text-align: left;
	color: black;
	padding-top: 0;
	padding-left: 0.5;
	padding-bottom: 60px;
	border: solid 2px #E8D9FF;
	font-size: 15px;
}

.Task {
	border: solid 2px #4682B4;
	border-radius: 5px;
	background: #87CEEB;
	font-size: 5px;
	font-weight: bold;
	color: 	#4169E1;
}
</style>
<!-- style태그끝! -->

<script type="text/javascript">

</script>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>

<!-- body 시작 -->
<body class="is-preload">



	<!-- 왼쪽메뉴 include -->
	<jsp:include page="/resources/include/leftmenu_schedule.jsp" /><!-- flag구분예정 -->

	<!-- 검색 인클루드 : 필요한분 쓰세요!!!!! -->
	<%--<%@ include file="/resources/include/search.jsp"%> --%>


	<!-- 캘린더시작. -->
	<hr />
	<div id="main" class="col-lg-12 sidenav">

		<div class="calendarTitle" id="calendartop">

			<span class="Year" id="calYear"><%=y%>년 <%=m%>월</span>
			<span id="buttonMove"> 
<%-- 				<a href="../schedule/calendar.do?y=<%=y -1%>&m=<%=m %>" class="btn"> --%>
<!-- 					<i class='fas fa-chevron-left'></i><i class='fas fa-chevron-left'></i> -->
<!-- 				</a> -->
				<a href="../schedule/calendar.do?y=<%=y%>&m=<%=m-1 %>" class="button small">
					<i class='fas fa-chevron-left'></i>
				</a>
				<a href="../schedule/calendar.do?y=<%=y%>&m=<%=m+1%>" class="button small">
					<i class='fas fa-chevron-right'></i>
				</a>
<%-- 				<a href="../schedule/calendar.do?<%=y+1%>&m=<%=m%>" class="btn"> --%>
<!-- 					<i class='fas fa-chevron-right'></i><i class='fas fa-chevron-right'></i> -->
<!-- 				</a> -->
			</span>
		</div>
		
		<hr />
		
		<table  cellpadding="0" border="1" class="calendar" style="table-layout: fixed" "> 	
			<colgroup>
				<col width="14%" />
				<col width="14%" />
				<col width="14%" />
				<col width="14%" />
				<col width="14%" />
				<col width="14%" />
				<col width="14%" />
			</colgroup>
			<tr>
	<%
	String[] a = { "월", "화", "수", "목", "금", "토", "일" };
	for (int i = 0; i < 7; i++) {
	%>
				<th style="padding: 5px 0;" class="calendarTh"><%=a[i]%></th>
	<%
	}
	%>
			</tr>
			<tr>
	<%
	for (int k = 1; k < yo; k++) {
	%>
				<td class="calendarTd">
					<div class="Task"><%=Task %></div>
				</td>
	<%
	}
	%>
	
	<%
	for (int j = 1; j <= last_day; j++) {
	%>
				<td class="calendarTd">
				<%=j%> <%if ((yo+j-1) % 7 == 0) {%>
				

				<div class="Task"><%=Task %></div>
				</td>
			</tr>
			<tr>
	<%
		}
	}
	for(int e=1;e<(7-yo);e++){
	%>
				<td>
					<div class="Task"><%=Task %></div>
				</td>
	<%
	}
	%>
	<!-- 끝날부터 토요일까지 빈칸으로 처리. -->
	<%
	for(int g = gSet.get(Calendar.DAY_OF_WEEK); g<=7; g++) out.println("<td class='calendarTd'>%nbsp;</td>"); 
			
	%> 
			</tr>
		</table>

	</div>
	<!-- main div끝 -->

	<!-- #################################################################### -->

	<jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />

</html>