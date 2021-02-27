<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>성적 조회</title>
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
    
    <div>
 		
 		<div style="text-align: center;">
	      <small style="font-size:1.2em">
	      <i class="fas fa-lightbulb" id="icon">&nbsp&nbsp</i>
	      학기 성적</small>
	    </div>
	    <hr />
		<table class="table table-bordered table-hover table-striped" 
		style="font-size:5px; margin-top:0px; padding-top: 0px">
	    <c:choose>	
			<c:when test="${empty lists }">
		 				<tr>
		 					<td colspan="6" align="center" height="100">
		 						성적 정보가 없습니다.
		 					</td>
		 				</tr>
			</c:when>
			<c:otherwise>
						<tr align="center" align="center">
							<c:forEach items="${lists }" var="row">
								<td class="text-center">
									${row.subject_name }						
								</td>
							</c:forEach>		
						</tr>
						<br />
						<tr align="center" >
							<c:forEach items="${listgrade2 }" var="row">
								<td class="text-center">
									${row }						
								</td>
							</c:forEach>		
						</tr>
			</c:otherwise>	
		</c:choose>

		</table>
		
		<c:if test="${gradeChar!=null }">
			<c:if test="${gradeNum!=0.0 }">
				<table class="table table-hover table-striped" style="font-size:1.2em">
				<tr>
				<td colspan="5" style="font-size:0.9em; text-align:left; padding-left: 20px;
				background:d3e0ea;"><i class="fas fa-graduation-cap" id="icon">&nbsp&nbsp</i>
							평균 성적 : ${gradeChar } (${gradeNum })</td>
				</tr>
				</table>
			</c:if>
		</c:if> 		
 		
		<div style="text-align: center;">
	      <small style="font-size:1.2em">
	      <i class="fas fa-lightbulb" id="icon">&nbsp&nbsp</i>
	      과목별 성적표</small>
	    </div>
	    
		<c:forEach items="${lists }" var="row">		
			<div class="container">
				<div class="container">
					<div class="container">
						<h4><a href="../class/grade.do?subject_idx=${row.subject_idx }">
						<i class="fas fa-check-square"></i>&emsp;과목명 :${row.subject_name }</a></h4>						
							<table class="table table-bordered table-hover table-striped" style="font-size:5px">
				 				<tr>
									<td colspan="10">과제 점수</td>
								</tr>
							<c:choose>	
								<c:when test="${row.rnum==1 }">
									<tr align="center" align="center">
										<c:forEach items="${gradelists1 }" var="row1">
											<td class="text-center"><!-- 가상번호 -->
												${row1.exam_name }
											</td>
										</c:forEach>		
									</tr>
									<tr align="center" >
										<c:forEach items="${gradelists1 }" var="row1">
											<td class="text-center">
												${row1.grade_exam }										
											</td>
										</c:forEach>		
									</tr>
									<tr>
										<c:choose>
									    	<c:when test="${empty gradeChar1 }">
											
									    	</c:when>
									    	<c:otherwise>
								   				<td>성적 : ${gradeChar1 }</td>
									    	</c:otherwise>
							    		</c:choose>
								    </tr>
								</c:when>
								<c:when test="${row.rnum==2 }">
					 				<tr align="center" align="center">
										<c:forEach items="${gradelists2 }" var="row2">
											<td class="text-center"><!-- 가상번호 -->
												${row2.exam_name }
											</td>
										</c:forEach>		
									</tr>
									<tr align="center" >
										<c:forEach items="${gradelists2 }" var="row2">
													<td class="text-center">
														${row2.grade_exam }										
													</td>
										</c:forEach>		
									</tr>
									<tr>
									    <c:choose>
									    	<c:when test="${empty gradeChar2 }">
											
									    	</c:when>
									    	<c:otherwise>
								   				<td>성적 : ${gradeChar2 }</td>
									    	</c:otherwise>
							    		</c:choose>
								    </tr>
								</c:when>
								<c:when test="${row.rnum==3 }">
					 				<tr align="center" align="center">
										<c:forEach items="${gradelists3 }" var="row3">
											<td class="text-center"><!-- 가상번호 -->
												${row3.exam_name }
											</td>
										</c:forEach>		
									</tr>
									<tr align="center" >
										<c:forEach items="${gradelists3 }" var="row3">
													<td class="text-center">
														${row3.grade_exam }										
													</td>
										</c:forEach>		
									</tr>
									<tr>
									    <c:choose>
									    	<c:when test="${empty gradeChar3 }">
											
									    	</c:when>
									    	<c:otherwise>
								   				<td>성적 : ${gradeChar3 }</td>
									    	</c:otherwise>
							    		</c:choose>
								    </tr>
								</c:when>
								<c:when test="${row.rnum==4 }">
					 				<tr align="center" align="center">
										<c:forEach items="${gradelists4 }" var="row4">
											<td class="text-center"><!-- 가상번호 -->
												${row4.exam_name }
											</td>
										</c:forEach>		
									</tr>
									<tr align="center" >
										<c:forEach items="${gradelists4 }" var="row4">
													<td class="text-center">
														${row4.grade_exam }										
													</td>
										</c:forEach>		
									</tr>
									<tr>
									    <c:choose>
									    	<c:when test="${empty gradeChar4 }">
											
									    	</c:when>
									    	<c:otherwise>
								   				<td>성적 : ${gradeChar4 }</td>
									    	</c:otherwise>
							    		</c:choose>
								    </tr>
								</c:when>
								<c:otherwise>
									<tr align="center" align="center">
										<c:forEach items="${gradelists5 }" var="row5">
											<td class="text-center"><!-- 가상번호 -->
												${row5.exam_name }
											</td>
										</c:forEach>		
									</tr>
									<tr align="center" >
										<c:forEach items="${gradelists5 }" var="row5">
													<td class="text-center">
														${row5.grade_exam }										
													</td>
										</c:forEach>		
									</tr>
									<tr>
									    <c:choose>
									    	<c:when test="${empty gradeChar5 }">
											
									    	</c:when>
									    	<c:otherwise>
								   				<td>성적 : ${gradeChar5 }</td>
									    	</c:otherwise>
							    		</c:choose>
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