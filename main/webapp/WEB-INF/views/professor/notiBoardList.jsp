<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<title>공지사항</title>
<!-- 나머지 head속성은 인클루드에 있어요 -->
<!-- 상단  인클루드 : 메뉴별 페이지 이동설정 해야함★★★★★★-->
<%@ include file="/resources/include/top_professor.jsp"%>

<body class="is-preload">
	<div id="main">
	<br /><br />
	<div style="text-align:center; font-weight:bold; font-size:1.2em">
		<i class="fas fa-check-circle" style="padding-right:5px;"></i>
		공지사항</div>
		<!-- ### 게시판의 body 부분 start ### -->
		<div style="padding: 10px;">
			<div class="text-right">
				<button type="button" class="btn btn-default" style="font-weight:bold; color:#145374; border: 2px solid gray; "
					onclick="location.href='notiWrite.do?nowPage=${nowPage}';">
					<i class="fas fa-plus" style="padding-right:5px;"></i>
					공지사항</button>
			</div>
			<!-- 게시판리스트부분 -->
			<table class="table table-bordered table-hover table-striped">	
				<colgroup>
					<col width="7%"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>				
				<thead>
				<tr class="text-center" style="font-size:1.1em">
					<th class="text-center">No</th>
					<th class="text-center">제목</th>
					<th class="text-center">작성자</th>
					<th class="text-center">작성일</th>
					<th class="text-center">첨부</th>
				</tr>
				</thead>				
				<tbody>	
<c:choose>	
	<c:when test="${empty notiList }">
 				<tr>
 					<td colspan="6" align="center" height="100">
 						등록된 게시물이 없습니다. 
 					</td>
 				</tr>
	</c:when>
	<c:otherwise>
		<!-- 공지사항 리스트 출력하기 -->
		<c:forEach items="${notiList }" var="row">			
				<tr>
				<td class="text-center">${row.RNUM}</td>
					<td class="text-left">
						<a style="color: #145374;" href="notiView.do?board_idx=${row.board_idx }&nowPage=${nowPage }">${row.board_title }</a>
					</td>
					<td class="text-center">${row.user_name }</td>
					<td class="text-center">${row.board_postdate }</td>
					<td class="text-center">
<c:if test="${not empty row.board_file }">
						<a href="download.do?board_file=${row.board_file }&board_idx=${row.board_idx }">
							<i class="fas fa-download" style="font-size:20px"></i>
						</a>
</c:if>
					</td>
				</tr>
		</c:forEach>		
	</c:otherwise>	
</c:choose>
				</tbody>
			</table>
		</div>
		<div class="row mt-3">
			<div class="col">
				<!-- 페이지번호 부분 -->
				<ul class='pagination justify-content-center'>
					${pagingImg }
				</ul>
			</div>								
		</div>
		
		

	</div><!-- main디브끝. -->
</body>

<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>