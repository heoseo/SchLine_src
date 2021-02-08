<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ajaxCalendar.jsp -->
<%
int year, month;

Calendar tDay = Calendar.getInstance(); //현재날짜

year = (request.getParameter("year") == null) ? tDay.get(Calendar.YEAR)
		: Integer.parseInt(request.getParameter("year"));

month = (request.getParameter("month") == null) ? tDay.get(Calendar.MONTH) + 1
		: Integer.parseInt(request.getParameter("month"));

//month-1 해주기!!!★★
tDay.set(year, month-1, 1);
int last_day = tDay.getActualMaximum(Calendar.DAY_OF_MONTH);//체크된달의 마지막일

System.out.println(year);
System.out.println(month);
System.out.println(last_day);

Calendar cDay = Calendar.getInstance();
int first_week = tDay.get(Calendar.DAY_OF_WEEK);//위에서 설정한 1일의 요일
tDay.set(year, month-1, last_day);
int last_week = tDay.get(Calendar.DAY_OF_WEEK);//마지막일의 요일
%>
<!-- 요일 이미지 가운데 정렬 -->
<style>
	#calTable tr th img{display: block; margin: 0px auto;}
</style>
<table id="calTable" cellpadding="0" cellspacing="0" border="0"
	class="calendar" style="text-align: center;">
		<colgroup>
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="14%" />
			<col width="*" />
		</colgroup>
		<tr>
			<th><img src="../images/day01.gif" alt="S" />월</th>
			<th><img src="../images/day02.gif" alt="M" />화</th>
			<th><img src="../images/day03.gif" alt="T" />수</th>
			<th><img src="../images/day04.gif" alt="W" />목</th>
			<th><img src="../images/day05.gif" alt="T" />금</th>
			<th><img src="../images/day06.gif" alt="F" />토</th>
			<th><img src="../images/day07.gif" alt="S" />일</th>
		</tr>
		<tr>
		<%
		//빈값을 채우기 위해 null값 반복
		for(int i=1 ; i<first_week ; i++){
		%>
			<td></td>
		<%}
			//요일채우기(일1, 토7)
		for(int i=1 ; i<=last_day ; i++){ %>
			<td>
<%-- 				<a href="../space/cal_view.jsp?menu=space&flag=02&year=<%=year%>&month=<%=month%>&day=<%=i%>"> --%>

				<%=i %>
			</td>
		<%
			if((first_week -1 + i) % 7 ==0) {
		%>
			</tr>
			<tr>
		<%}
		//마지막날의 요일을 활용해 빈칸 채우기
		}for(int j=1 ; j<=(7-last_week) ; j++){
			%> <td></td>
			<%
		}%>
		</tr>
	</table>