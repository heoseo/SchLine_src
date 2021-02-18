<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>알림</title>
<!-- 상단 인클루드 -->

		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />

			<!-- JS파일이 부트스트랩보다 위에 있어야 min.js에러가 안남 -->
			
			<!-- Scripts -->
			<script src='<c:url value="/resources/assets/js/jquery.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/jquery.scrollex.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/jquery.scrolly.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/browser.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/breakpoints.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/util.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/main.js"/>'></script>
			
			<!-- 드롭다운용 부트 -->
			<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
			<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
						
	
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/main.css" />
		<noscript><link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/noscript.css" /></noscript>

</head>
<style type="text/css">
#row {font-weight: bold;}
</style>
<!-- body 시작 -->
<body class="is-preload">	
<!-- 페이지 제목 -->
<br />
	<h3 style="text-align:center; font-weight:bold;">공지사항</h3>
<!-- 게시물 -->
	<div id="row" class="col-lg-12">
<!-- 읽은 공지사항 리스트 출력하기 -->
<c:forEach items="${getNotiView }" var="row">
				<table>
					<tr>
						<th class="text-center table-active align-middle">작성자</th>
						<td>${row.user_name }</td>
						<th class="text-center table-active align-middle">작성일</th>
						<td>${row.board_postdate }</td>
					</tr>
					<tr>
						<th class="text-center table-active align-middle">제목</th>
						<td colspan="3">
							${row.board_title }
						</td>
					</tr>
					<tr>
						<th class="text-center table-active align-middle">내용</th>
						<td colspan="3" class="align-middle" style="height:200px;">
							${row.board_content }
						</td>
					</tr>
<c:if test="${not empty row.board_file }">
					<tr>
						<th class="text-center table-active align-middle">첨부파일</th>
						<td colspan="3">
							<span>파일명 : </span>${row.board_file }
							<a href="download.do?board_file=${row.board_file }&board_idx=${row.board_idx}">
								&nbsp&nbsp<i class="fas fa-download" style="font-size:30px">&nbsp[다운로드]</i>
							</a>		
						</td>
					</tr>
</c:if>		
				</table>
				<div class="row mb-3">
					<div class="col-6"> 
						<button type="button" class="btn btn-secondary" style="font-weight:bold;"
							onclick="location.href='./notiEdit.do?board_idx=${param.board_idx}&nowPage=${param.nowPage }';">
							수정하기</button>
						<button type="button" class="btn btn-success" style="font-weight:bold;"
							onclick="location.href='./notiDelete.do?&board_idx=${param.board_idx}&nowPage=${param.nowPage }';">
							삭제하기</button> 
					</div>
					<div class="col-6 text-right pr-5">					
						<button type="button" class="btn btn-warning" style="font-weight:bold;"
							onclick="location.href='./notiBoardList.do?nowPage=${param.nowPage }';">
							리스트보기</button>
					</div>	
				</div>	
</c:forEach>
	</div><!-- 리스트끝 -->

</body>
</html>