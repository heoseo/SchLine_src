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

<jsp:include page="/resources/include/leftmenu_professor_student.jsp"/><!-- flag구분예정 -->
<div>

   <hr /><!-- 구분자 -->
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
							<td colspan="10" align="center" style="font-size:20px;">출결 현황</td>
						</tr>
						<tr align="center" align="center">
							<c:forEach items="${attenlists }" var="row2">
								<td class="text-center"><!-- 가상번호 -->
									${row2.rnum }번 강의	
								</td>
							</c:forEach>		
						</tr>
						<form:form name="attenFrm" method="post" 
						action="./professorSetting.do?user_id=${student_id }" >
						<tr align="center" >
							<c:forEach items="${attenlists }" var="row">
										<td class="text-center">
											<c:if test="${row.attendance_flag==2 }">
												<select name="${row.rnum }">
													<option value="2" selected="selected">O</intput>
													<option value="0">X</intput>
												</select>
											</c:if>
											<c:if test="${row.attendance_flag!=2 }">
												<select name="${row.rnum }">
													<option value="2" >O</intput>
													<option value="0" selected="selected">X</intput>
												</select>
											</c:if>											
										</td>
							</c:forEach>
							<tr>
								<td colspan="10" align="center">
									<div class="actions">
										<input type="submit" value="전송하기" class="primary btn-hover" style="padding: 0px 420px 0px 420px" />
									</div>
								</td>
							</tr>		
							</tr>
<%-- 							<input type="hidden" name="user_id">${student_id }</input> --%>
						</form:form>
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
							<td colspan="10" style="text-align:center; font-size:20px">과제 현황</td>
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
</div>  
   <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>