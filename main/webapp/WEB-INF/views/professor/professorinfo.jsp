<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>코스 페이지 </title>
<!-- 상단 인클루드 -->
<!-- 목록 
사용자 - 개인정보, 설정
수강 과목  - 수강친청 연결, 과목리스트, 과목당 출석여부
성적  - 과목리스트 ->과목별 성적 출력 , 전체성적
-->
<%@ include file="/resources/include/top_professor.jsp"%>


<!-- body 시작 -->
<body class="is-preload">
<!-- 왼쪽메뉴 include -->

<jsp:include page="/resources/include/leftmenu_professor.jsp"/><!-- flag구분예정 -->

<div><hr /><!-- 구분자 -->
  	<div style="text-align: center;">
      <small style="font-size:1.2em;">학생 정보</small>
    </div>
    <br />
	<table class="table table-bordered table-hover table-striped" style="font-size:15px; text-align:center;">	
    	<tr>
    		<td rowspan="2" width="10%">이름</td>
    		<td rowspan="2" width="15%">학번</td>
    		<td rowspan="2" width="10%">팀 번호</td>
    		<td colspan="${videoNum }">출결</td>
    		<td rowspan="2" width="10%">성적</td>
    	</tr>
    	<tr>
    		<c:forEach items="${lists2 }" var="row2">
    			<td>${row2.video_idx }강</td>
    		</c:forEach>
    	</tr>
    	<c:forEach items="${lists }" var="row">
	    	<tr>
	    		<td>
	    		<a href="../professor/studentinfo.do?user_id=${row.user_id }">
	    		${row.user_name }
	    		</a>
	    		</td>
	    		<td>
	    		<a href="../professor/studentinfo.do?user_id=${row.user_id }">
	    		${row.user_id }
	    		</a>
	    		</td>
	    		<td>${row.team_idx }</td>
	    		
	    		<c:forEach items="${lists3 }" var="row3">
	    			<c:choose>
	    				<c:when test="${row3.user_id == row.user_id }">
		    				<td>
								<c:if test="${row3.attendance_flag==2 }">
								O
								</c:if>
								<c:if test="${row3.attendance_flag!=2 }">
								X
								</c:if>											
							</td>
	    				</c:when>
	    				<c:otherwise>
	    				</c:otherwise>
	    			</c:choose>
	    		</c:forEach>
	    		
	    		<td>${row.grade_sub }</td>
	    	</tr>
    	</c:forEach>
    </table>
</div>
   <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>