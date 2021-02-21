<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>협업</title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>

<!-- body 시작 -->
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_classRoom.jsp"/><!-- flag구분예정 -->
 <hr /><!-- 구분자 -->
<p style="text-align:center; font-size:1.2em">${team_num }팀 협업공간</p>
	<div class="table-wrapper">
		<table class="alt" style="text-align:center">
		<c:choose>	
			<c:when test="${empty teamlist }">
 				<tr>
 					<td colspan="6" align="center" height="100">
 						등록된 게시물이 없습니다. 
 					</td>
 				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${teamlist }" var="trow" varStatus="tloop">
					<tr>
						<td style="width:5%;">${trow.virtualNum }</td>
						<td style="text-align:left;">
						<a href="teamView.do?board_idx=${trow.board_idx }&subject_idx=${trow.subject_idx}">
						${trow.board_title }
						</a>
						</td>
						<td style="width:15%">${trow.user_name }</td>	
						<td style="width:15%">${trow.board_postdate }</td>
						<td style="width:5%">
					<c:if test="${not empty trow.board_file }">
						<a href="teamDownload.do?board_file=${trow.board_file }"><!-- 다운로드 추가 필요 -->
						<img src="../resources/images/download.png" alt="download" style="max-width:100%; height:auto;"/>
						</a>
					</c:if>	
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>	
		</c:choose>
		</table>
		<div>
			<div class="row  mr-1">
				<div class="col-10">
					<ul class='pagination justify-content-center'>
						${pagingImg }
					</ul>
				</div>
				<div class="col-2 text-right pr-3">					
					<input type="button" class="button primary"
				 onclick="location.href='teamWrite.do?subject_idx=${param.subject_idx }'" value="작성" style="min-width:0"/>
				</div>	
			</div>
		</div>
		<br /><br />
		<br /><br />
	</div>
 <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>