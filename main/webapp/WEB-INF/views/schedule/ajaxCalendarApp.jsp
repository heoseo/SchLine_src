<%@page import="schline.ExamDTO"%> 
<%@page import="java.util.ArrayList"%>
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

Calendar cDay = Calendar.getInstance();
int first_week = tDay.get(Calendar.DAY_OF_WEEK);//위에서 설정한 1일의 요일
tDay.set(year, month-1, last_day);
int last_week = tDay.get(Calendar.DAY_OF_WEEK);//마지막일의 요일


// 일정이 있는 테이블에서 한달치 데이터를 가져온다. 
// 가져온 데이터는 ArrayList에 저장한다. 
// 예를 들어 2020년 12월 일정을 가져온다고 가정...
ArrayList<ExamDTO> lists = (ArrayList<ExamDTO>)request.getAttribute("lists");


%>
<style>
#title {
	font-weight: bold;
	text-align: center;
	padding-top: 5px;
	padding-bottom: 3px;
}
#td {
	padding-top: 0px;
	padding-bottom: 50px;
	font-size: 15px;
	font-weight: normal;
 	border: solid 1px #C0C0C0;
	text-align:left;
	padding-left:2px;
}
.Task {
	border: solid 1px #00334e;
	border-radius: 5px;
	font-size: 5px;
	font-weight: bold;
	color: 	#00334e;
}
</style>

<table id="calTable" class="calendar">
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
			<th id="title">월</th>
			<th id="title">화</th>
			<th id="title">수</th>
			<th id="title">목</th>
			<th id="title">금</th>
			<th id="title">토</th>
			<th id="title">일</th>
		</tr>
		<tr>
		<%
		//빈값을 채우기 위해 null값 반복
		for(int i=1 ; i<first_week ; i++){
		%>
			<td id="td">
			
			
			</td>
		<%}

		//요일채우기(일1, 토7)
		int day;
		for(day=1 ; day<=last_day ; day++){ 
		%>
			<td id="td"><%=day %>
				<%
				for(ExamDTO dto : lists) { 
					String yearStr = Integer.toString(year);
					String monthStr = "";
					
					if(month < 10)
						monthStr = "0" + Integer.toString(month);
					else
						monthStr = Integer.toString(month);
					
					String dayStr = Integer.toString(day);
					
					String nowDate = yearStr +"-"+ monthStr+"-" + dayStr;
							
					String exam_date = dto.getExam_date().toString();
					
					//디버깅용.
					//System.out.println("exam_date : " + exam_date);
					if(exam_date.equals(nowDate)) {
						//디버깅용
						//System.out.println("들어옴");
				
						%>
				
<!-- 			private String exam_name;	 //과제 이름 -->
<!-- 			private java.sql.Date exam_date;	//제출마감일 -->
<!-- 			private int exam_type;		//과제(1), 시험(2) -->

					<div class="Task">&nbsp;&nbsp;<i class="fas fa-thumbtack"></i>
					&nbsp;&nbsp; [ <%=dto.getExam_name() %> ] </div>
				<%	}
			  	}
				%>
			</td>
			<%
			if((first_week -1 + day) % 7 ==0) {
			%>
			</tr>
			<tr>
			<% 	
			}
		} 
		//마지막날의 요일을 활용해 빈칸 채우기
		for(int j=1 ; j<=(7-last_week) ; j++){
			%> <td id="td"></td>
			<%
		}%>
		</tr>
	</table>