<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>출결 현황</title>
<!-- 상단 인클루드 -->
<!-- 목록 
사용자 - 개인정보, 설정
수강 과목  - 수강친청 연결, 과목리스트, 과목당 출석여부
성적  - 과목리스트 ->과목별 성적 출력 , 전체성적
-->
<%@ include file="/resources/include/top.jsp"%>




<!-- body 시작 --> 
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_userInfo.jsp"/><!-- flag구분예정 -->
	<div id="main">
 
		<div style="text-align: center;">
	      <small style="font-size:1.2em">
	      <i class="fas fa-book-reader" id="icon">&nbsp&nbsp</i>
	      출결 현황</small>
	    </div>
	    <hr />
		<c:forEach items="${lists }" var="row">		
			<div class="container">
				<div class="container">
					<div class="container">
						<h5><a href="../class/grade.do?subject_idx=${row.subject_idx }">
						<i class="fas fa-check-square"></i>&emsp;과목명 :${row.subject_name }</a></<h5>
						<h6>출결 현황</h6>
						<table class="table table-bordered table-hover table-striped" style="font-size:5px; text-align:center;">
								<c:choose>	
									<c:when test="${row.rnum==1 }">
						 				<tr>
											<c:forEach items="${atten1 }" var="row2">
												<td>
													${row2.rnum }번 강의	
												</td>
											</c:forEach>		
										</tr>
										<tr>
											<c:forEach items="${atten1 }" var="row2">
												<td>
													<c:if test="${row2.attendance_flag==2 }">
													O
													</c:if>
													<c:if test="${row2.attendance_flag!=2 }">
													X
													</c:if>											
												</td>
											</c:forEach>		
										</tr>
									</c:when>
									<c:when test="${row.rnum==2 }">
						 				<tr>
											<c:forEach items="${atten2 }" var="row3">
												<td>
													${row3.rnum }번 강의	
												</td>
											</c:forEach>		
										</tr>
										<tr>
											<c:forEach items="${atten2 }" var="row3">
												<td>
													<c:if test="${row3.attendance_flag==2 }">
													O
													</c:if>
													<c:if test="${row3.attendance_flag!=2 }">
													X
													</c:if>											
												</td>
											</c:forEach>		
										</tr>
									</c:when>
									<c:when test="${row.rnum==3 }">
						 				<tr>
											<c:forEach items="${atten3 }" var="row4">
												<td>
													${row4.rnum }번 강의	
												</td>
											</c:forEach>		
										</tr>
										<tr>
											<c:forEach items="${atten3 }" var="row4">
												<td>
													<c:if test="${row4.attendance_flag==2 }">
													O
													</c:if>
													<c:if test="${row4.attendance_flag!=2 }">
													X
													</c:if>											
												</td>
											</c:forEach>		
										</tr>
									</c:when>
									<c:when test="${row.rnum==4 }">
						 				<tr>
											<c:forEach items="${atten4 }" var="row5">
												<td>
													${row5.rnum }번 강의	
												</td>
											</c:forEach>		
										</tr>
										<tr>
											<c:forEach items="${atten4 }" var="row5">
												<td>
													<c:if test="${row5.attendance_flag==2 }">
													O
													</c:if>
													<c:if test="${row5.attendance_flag!=2 }">
													X
													</c:if>											
												</td>
											</c:forEach>		
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<c:forEach items="${atten5 }" var="row6">
												<td>
													${row6.rnum }번 강의	
												</td>
											</c:forEach>		
										</tr>
										<tr>
											<c:forEach items="${atten5 }" var="row6">
												<td>
													<c:if test="${row6.attendance_flag==2 }">
													O
													</c:if>
													<c:if test="${row6.attendance_flag!=2 }">
													X
													</c:if>											
												</td>
											</c:forEach>		
										</tr>
									</c:otherwise>
								</c:choose>
							
						</table>
					</div>
				</div>
			</div>
		</c:forEach>
		
		
   </div>
   <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>