<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<%@ include file="/resources/include/top.jsp"%>




<!-- body 시작 --> 
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_userInfo.jsp"/><!-- flag구분예정 -->
	<div id="main">
 
		<div style="text-align: center;">
	      <small>수강 과목</small>
	    </div>
	    
		<c:forEach items="${lists }" var="row">		
			<div class="container">
				<div class="container">
					<div class="container">
						<h4><a href="../class/grade.do?subject_idx=${row.subject_idx }">&emsp;과목명 :${row.subject_name }</a></h4>						
						<h6>출결 현황</h6>
						<table style="font-size: 5px;">
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
										<c:forEach items="${attenlists }" var="row2">
											<td>
												${row2.rnum }번 강의	
											</td>
										</c:forEach>		
									</tr>
									<tr>
										<c:forEach items="${attenlists }" var="row2">
											<td>
												<c:if test="${row2.attendance_flag==3 }">
												O
												</c:if>
												<c:if test="${row2.attendance_flag!=3 }">
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