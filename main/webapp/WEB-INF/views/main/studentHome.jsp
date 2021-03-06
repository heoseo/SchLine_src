<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   

<!--
2021.02.02
1) ★★★인클루드 메뉴바 링크는 각자 넣어주세요!!!★★
2) ★★★각 view페이지 smail태그 안에있는 타이틀 일단 주석처리 해주세요(깔끔하게 스타일 변경)
 -->

<!DOCTYPE html>
<html>
	<head>
		<title>스쿨라인 메인</title>

<!-- /////////////////////Main시작////////////////////// -->
<body class="is-preload" data-spy="scroll" data-target="#myScrollspy" data-offset="1" >
<%@ include file="/resources/include/top.jsp" %>
<!-- 메인에 코스 리스트를 위한 style임-->
<%@ include file="/resources/include/HomeClasslist.jsp" %>
	<div id="main">
	
		
	<!-- 1. 강의실 -->
		<section id="class" class="main special">
			<div class="spotlight">
				<div class="content">
					<header class="major">
						<h2>코스</h2>
					</header>
					
<div id="pattern" class="pattern">

    <ul class="list img-list">
      <c:forEach items="${course }" var="row">	
       <li>	
		<a href="./class/time.do?subject_idx=${row.subject_idx }"  class="inner">					
			<div class="li-img">
			 <c:set var="ran"><%= java.lang.Math.round(java.lang.Math.random() *10)%>${row.subject_idx}</c:set>
         	 <img src="https://picsum.photos/200/150/?image=${ran}" alt="sample image">
            </div>
             <div class="li-text">
                <h4 class="li-head">${row.subject_name }</h4>
                <p class="li-sub">${row.user_name }&emsp;</p>		
			</div>
     	</a>
     	 </li>
	</c:forEach>
  
    </ul>
</div>
				</div>
			</div>
		</section>
		
		<!-- 2. 출결 -->
		<section id="attend" class="main special">
			<header class="major">
				<h2>출결</h2>
				<%@ include file="../userInfo/infoMain.jsp" %>
			</header>
			
		</section>
		<span style="clear:both;"></span>

<!-- 3.캘린더시작 -->		

		<section id="calendar" class="main special">
			<header class="major">
				<h2 style="padding-top: 0px">캘린더</h2>
			<%@ include file="../schedule/calendarMain.jsp" %>
			</header>
		</section>
		<span style="clear:both;"></span>
<!-- 3.캘린더끝. -->		
		
		
		<!-- 4. 과제함 -->
		<section id="homework" class="main special">
			<header class="major">
				<h2 style="font-weight:bold; padding-top: 0px">과제함</h2>
			</header>
		<div class="table-wrapper" style="height:400px; overflow:auto;">
			<table class="alt" style="text-align:center">
				<tr>
					<td style="width:18%;">과제명</td>
					<td>과제 내용</td>	
					<td style="width:12%">마감일</td>
					<td style="width:12%">제출여부</td>
					<td style="width:10%">과제함이동</td>
				</tr>
			<c:forEach items="${examlist }" var="trow" varStatus="tloop">
				<tr>
					<td style="width:18%;" >${trow.exam_name }</td>
					<td style="text-align:left; overflow:hidden;">${trow.exam_content }</td>	
					<td style="width:12%">${trow.exam_date }</td>
					<td style="width:12%">
					<c:choose>
					<c:when test="${trow.check_flag eq 0 }">미제출</c:when>
					<c:otherwise>제출완료</c:otherwise>
					</c:choose>					
					</td>
					<td style="width:10%">
					<a href="/schline/class/taskList.do?subject_idx=${trow.subject_idx}&exam_type=1" class="button primary">
					이동하기
					</td>
				</tr>
				
			</c:forEach>
			</table>
		</div>
			</footer>
		</section>
		
		<!-- 5. 공부방 -->
		<section id="studyroom" class="main special">
			<div class="spotlight">
				<div class="content">
					<header class="major">
						<h2>공부방</h2>
					대학친구들과 함께 공부하는 온라인 도서관
						
					</header>
					<footer class="major">
					
	<!-- 					<input type="image" src="" alt="" /> -->
						<span class="image">
							<a href="./studyRoom/studyRoom.do">
								<img src="<%=request.getContextPath() %>/resources/images/study3.jpg" alt="공부방 이동"
<%-- 								<img src="<%=request.getContextPath() %>/resources/images/harry2.JPG" alt="공부방 이동" --%>
<%-- 								<img src="<%=request.getContextPath() %>/resources/images/harry.png" alt="공부방 이동" --%>
								style="min-height:0; min-width:0; width: 400px; height: 400px;" />							</a>
						</span>
					<ul class="actions">
<!-- 						<li><a href="generic.html" class="button">입장하기</a></li> -->
					</ul>
				</footer>
			</div>
		</div>
		</section>
	</div>
		
	<!-- 메인 퀵바 -->
	<%@ include file="/resources/include/quick.jsp"%>
	<!-- /////////////////////메인끝////////////////////// -->
		</body>
		
	<!-- 하단 인클루드 -->
	<jsp:include page="/resources/include/footer.jsp"/>

</html>