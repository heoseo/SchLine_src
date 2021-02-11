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
 <hr /><!-- 구분자 -->
	<div class="table-wrapper">
		<div style="text-align: center;">
	      <small>제출 파일</small>
	    </div>
		<table class="alt" style="text-align:center">
		<c:choose>	
			<c:when test="${empty lists }">
 				<tr>
 					<td colspan="6" align="center" height="100">
 						등록된 게시물이 없습니다. 
 					</td>
 				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${lists }" var="row">
					<tr>
						<td style="text-align:left;">
						<a href="teamView.do?board_idx=${row.board_idx }&subject_idx=${row.subject_idx}">
						${row.board_title }
						</a>
						</td>
						<td style="width:15%">${row.user_name }</td>
						<td style="width:5%">
					<c:if test="${not empty row.board_file }">
						<a href="userDownload.do?board_file=${row.board_file }"><!-- 다운로드 추가 필요 -->
						<img src="../resources/images/download.png" alt="download" style="max-width:100%; height:auto;"/>
						</a>
					</c:if>	
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>	
		</c:choose>
		</table>
		
	</div>
 <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>