
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	Calendar cal = Calendar.getInstance();
int year = request.getParameter("y") == null ? cal.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("y"));
int month = request.getParameter("m") == null
		? cal.get(Calendar.MONTH)
		: (Integer.parseInt(request.getParameter("m")) - 1);

// 시작요일 확인
// - Calendar MONTH는 0-11까지임
cal.set(year, month, 1);
int bgnWeek = cal.get(Calendar.DAY_OF_WEEK);

// 다음/이전월 계산
// - MONTH 계산시 표기월로 계산하기 때문에 +1을 한 상태에서 계산함
int prevYear = year;
int prevMonth = (month + 1) - 1;
int nextYear = year;
int nextMonth = (month + 1) + 1;

// 1월인 경우 이전년 12월로 지정
if (prevMonth < 1) {
	prevYear--;
	prevMonth = 12;
}

// 12월인 경우 다음년 1월로 지정
if (nextMonth > 12) {
	nextYear++;
	nextMonth = 1;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>캘린더</title>
<!-- 캘린더CSS -->
<style>
.calendarTitle {
	padding-left: 10px;
	padding-right: 10px;
	font-weight: bold;
}

.Year {
	font-size: 20px;
}

#buttonMove {
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
	color: #4169E1;
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

<!-- 		<div class="calendarTitle" id="calendartop"> -->

<%-- 			<span class="Year" id="calYear"><%=y%>년 <%=m%>월</span>  --%>
<!-- 			<span id="buttonMove"> 				 -->
<%-- 				<a href="../schedule/calendar.do?y=<%=y -1%>&m=<%=m %>" class="btn"> --%>
<!-- 				<i class='fas fa-chevron-left'></i><i class='fas fa-chevron-left'></i> -->
<!-- 				</a> -->
<%-- 				<a href="../schedule/calendar.do?y=<%=y%>&m=<%=month - 1%>" class="button small">  --%>
<!-- 				<i class='fas fa-chevron-left'></i> -->
<!-- 				</a>  -->
<%-- 				<a href="../schedule/calendar.do?y=<%=y%>&m=<%=m + 1%>" class="button small">  --%>
<!-- 				<i class='fas fa-chevron-right'></i> -->
<!-- 			</a> -->
<!-- 			</span> -->
<!-- 		</div> -->


		<table border="0" cellpadding="0" cellspacing="0" class="calendarTable">
		
			<tr>
				<td align="center" class="calendarTitle">
					<a href="./calendar.do?y=<%=prevYear%>&m=<%=prevMonth%>" class="button small" id="#buttonMove">
						<i class='fas fa-chevron-left'></i>
					</a> 
					<span style="padding-right: 10px; padding-left: 10px;"><%=year%>년<%=month + 1%>월</span>

					<a href="./calendar.do?y=<%=nextYear%>&m=<%=nextMonth%>" class="button small" id="#buttonMove">
						<i class='fas fa-chevron-right'></i>
					</a>
				</td>
			</tr>
			<tr>
				<td>

					<table border="1">
						<tr>
							<td>일</td>
							<td>월</td>
							<td>화</td>
							<td>수</td>
							<td>목</td>
							<td>금</td>
							<td>토</td>
						</tr>
						<tr>
							<%
								// 시작요일까지 이동
							for (int i = 1; i < bgnWeek; i++)
								out.println("<td>&nbsp;</td>");

							// 첫날~마지막날까지 처리
							// - 날짜를 하루씩 이동하여 월이 바뀔때까지 그린다
							while (cal.get(Calendar.MONTH) == month) {
								out.println("<td>" + cal.get(Calendar.DATE) + "</td>");

								// 토요일인 경우 다음줄로 생성
								if (cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY)
									out.println("</tr><tr>");

								// 날짜 증가시키지
								cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE) + 1);
							}

							// 끝날부터 토요일까지 빈칸으로 처리
							for (int i = cal.get(Calendar.DAY_OF_WEEK); i <= 7; i++)
								out.println("<td>&nbsp;</td>");
							%>
						</tr>
					</table>

				</td>
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