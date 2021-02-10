
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
//////////////////////////////////////////////////////
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
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>



<!-- 캘린더style -->
<style>

/* ############################### */

#calendar {
	border-radius: 5px;
	font-weight: bold;
	height: 50%;
    border:3px solid #E6E6FA;
    padding: 50px;
    padding-top: 0px;
}
table {
    text-align:left;
    width:100%;
}
label {
    font-weight: bold;
}
tr {
	border:1px solid #BDBDBD;
}
td {
	border:1px solid #BDBDBD;
	font-weight: bold;
	padding-bottom: 50px;
}
</style>
<!-- style태그끝! -->

	<!-- 왼쪽메뉴 include -->
	<jsp:include page="/resources/include/leftmenu_schedule.jsp" /><!-- flag구분예정 -->

	<!-- 검색 인클루드 : 필요한분 쓰세요!!!!! -->
	<%--<%@ include file="/resources/include/search.jsp"%> --%>



	<script>
    var today = new Date(); // 오늘 날짜
    var date = new Date();
 
    function beforem() //이전 달을 today에 값을 저장
    { 
        today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
        build(); //만들기
    }
    
    function nextm()  //다음 달을 today에 저장
    {
        today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
        build();
    }
    
    function build()
    {
        var nMonth = new Date(today.getFullYear(), today.getMonth(), 1); //현재달의 첫째 날
        var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0); //현재 달의 마지막 날
        var tbcal = document.getElementById("calendar"); // 테이블 달력을 만들 테이블
        var yearmonth = document.getElementById("yearmonth"); //  년도와 월 출력할곳
        yearmonth.innerHTML = today.getFullYear() + "년 "+ (today.getMonth() + 1) + "월"; //년도와 월 출력
        
        if(today.getMonth()+1==12) //  눌렀을 때 월이 넘어가는 곳
        {
            before.innerHTML=(today.getMonth())+"월";
            next.innerHTML="1월";
        }
        else if(today.getMonth()+1==1) //  1월 일 때
        {
        before.innerHTML="12월";
        next.innerHTML=(today.getMonth()+2)+"월";
        }
        else //   12월 일 때
        {
            before.innerHTML=(today.getMonth())+"월";
            next.innerHTML=(today.getMonth()+2)+"월";
        }
        
       
        // 남은 테이블 줄 삭제
        while (tbcal.rows.length > 2) 
        {
            tbcal.deleteRow(tbcal.rows.length - 1);
        }
        var row = null;
        row = tbcal.insertRow();
        var cnt = 0;
 
        // 1일 시작칸 찾기
        for (i = 0; i < nMonth.getDay(); i++) 
        {
            cell = row.insertCell();
            cnt = cnt + 1;
        }
 
        // 달력 출력
        for (i = 1; i <= lastDate.getDate(); i++) // 1일부터 마지막 일까지
        { 
            cell = row.insertCell();
            cell.innerHTML = i;
            cnt = cnt + 1;
            if (cnt % 7 == 1) {//일요일 계산
                cell.innerHTML = "<font color=#FF9090>" + i//일요일에 색
            }
            if (cnt % 7 == 0) { // 1주일이 7일 이므로 토요일 계산
                cell.innerHTML = "<font color=#7ED5E4>" + i//토요일에 색
                row = calendar.insertRow();// 줄 추가
            }
            if(today.getFullYear()==date.getFullYear()&&today.getMonth()==date.getMonth()&&i==date.getDate()) 
            {
                cell.bgColor = "#DDA0DD"; //오늘날짜배경색
            }
        }
 
    }
    
</script>


	<!-- body 시작 -->
	<body class="is-preload" onload="build();">
	<hr />
	<div class="col-lg-12 sidenav" style="text-align: center;">캘린더</div>
	
	
	
	<!-- 캘린더시작. -->
	<hr />
	
	
	<div id="calendarDiv" ">
	    <table align="center" id="calendar">
	    
	    	<!-- 년월부분. -->
	        <tr>
	            <td align="center"><label onclick="beforem()" id="before"></label></td>
	            <td colspan="5" align="center" id="yearmonth"></td>
	            <td align="center"><label onclick="nextm()" id="next"></label></td>
	        </tr>
	        <!-- 요일제목부분. -->
	        <tr>
	            <td align="center"><font color="#FF9090">일</font></td>
	            <td align="center">월</td>
	            <td align="center">화</td>
	            <td align="center">수</td>
	            <td align="center">목</td>
	            <td align="center">금</td>
	            <td align="center"><font color=#7ED5E4>토</font></td>
	        </tr>

	    </table>
	</div>
	<!-- #################################################################### -->

	<jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />

</html>