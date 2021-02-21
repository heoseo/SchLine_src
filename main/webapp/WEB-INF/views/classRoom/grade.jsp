<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>성적 페이지 </title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>


<!-- body 시작 -->
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_classRoom.jsp"/><!-- flag구분예정 -->
   <hr /><!-- 구분자 -->
	
	<!-- 출결 테이블 -->
	<table class="table table-bordered table-hover table-striped" style="font-size:15px;">	

		<c:choose>	
			
			<c:when test="${empty attenlists }">
		 				<tr>
		 					<td colspan="6" align="center" height="100">
		 						출결 현황이 없습니다.
		 					</td>
		 				</tr>
			</c:when>
			<c:otherwise>
						<tr>
							<td colspan="10" style="text-align:center; font-size:1.2em">출결 현황</td>
						</tr>
						<tr align="center" align="center">
							<c:forEach items="${attenlists }" var="row">
								<td class="text-center"><!-- 가상번호 -->
									${row.rnum }번 강의	
								</td>
							</c:forEach>		
						</tr>
						<tr align="center" >
							<c:forEach items="${attenlists }" var="row">
										<td class="text-center">
											<c:if test="${row.attendance_flag==2 }">
											O
											</c:if>
											<c:if test="${row.attendance_flag!=2 }">
											X
											</c:if>											
										</td>
							</c:forEach>		
						</tr>
			</c:otherwise>	
		</c:choose>
    </table>
    <!-- 과제 테이블 -->
	<table class="table table-bordered table-hover table-striped" style="font-size:15px;">	

		<c:choose>	
			
			<c:when test="${empty gradelists }">
		 				<tr>
		 					<td colspan="6" align="center" height="100">
		 						과제 현황이 없습니다.
		 					</td>
		 				</tr>
			</c:when>
			<c:otherwise>
						<tr>
							<td colspan="10" style="text-align:center; font-size:1.2em">과제 현황</td>
						</tr>
						<tr align="center" align="center">
							<c:forEach items="${gradelists }" var="row">
								<td class="text-center"><!-- 가상번호 -->
									${row.exam_name }
								</td>
							</c:forEach>		
						</tr>
						<tr align="center" >
							<c:forEach items="${gradelists }" var="row">
										<td class="text-center">
											${row.grade_exam }										
										</td>
							</c:forEach>		
						</tr>
			</c:otherwise>	
		</c:choose>
	<!-- 성적 테이블 -->
    </table>
    <table class="table  table-hover table-striped" >
	    <tr>
	    	<td>성적 : ${gradeChar }</td>
	    </tr>
    </table>
            
   <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>