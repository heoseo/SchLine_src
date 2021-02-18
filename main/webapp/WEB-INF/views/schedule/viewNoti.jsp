<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>공지사항</title>
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

<script>
function paging(nowPage){
	
	location.href = "../schedule/alertList.do?type="+type+"&nowPage="+nowPage;	
}
</script>
<style type="text/css">
#row {font-weight: bold; padding: 20px;}
</style>
</head>

<!-- body 시작 -->
<body class="is-preload">	

	<!-- 읽은 공지사항 리스트 출력하기 -->
	<c:forEach items="${viewList }" var="row">
	
	<!-- 페이지제목 -->
	<br />
	<h3 style="text-align:center; font-weight:bold;">공지사항</h3>
	<!-- 게시물 -->
	<div id="row" class="col-lg-12">
		<table class="table table-bordered table-hover table-striped" style="font-weight:bold; color:black">
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
	</div><!-- main끝. -->
		
</c:forEach>
<!-- 읽은 공지사항 리스트 끝.-->

</body>
</html>