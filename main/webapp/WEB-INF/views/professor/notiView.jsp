<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>상세보기</title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top_professor.jsp"%>

</head>
<style type="text/css">
#row {font-weight: bold;}
</style>
<!-- body 시작 -->
<body class="is-preload">	
<br />
<div style="background:white;">
<!-- 페이지 제목 -->
<br />
	<h3 style="text-align:center; font-weight:bold; font-size:1.2em">
	<i class="fas fa-check-circle" style="padding-right:5px;"></i>
	공지사항</h3>
	<br />
<!-- 게시물 -->
	<div id="row" class="col-lg-12">
<!-- 읽은 공지사항 리스트 출력하기 -->
<c:forEach items="${getNotiView }" var="row">
				<table class="table table-bordered table-hover table-striped">	
					<tr>
						<th class="text-center table-hover align-middle">작성자</th>
						<td>${row.user_name }</td>
						<th class="text-center table-hover align-middle">작성일</th>
						<td>${row.board_postdate }</td>
					</tr>
					<tr>
						<th class="text-center table-hover align-middle">제목</th>
						<td colspan="3">
							${row.board_title }
						</td>
					</tr>
					<tr>
						<th class="text-center table-hover align-middle">내용</th>
						<td colspan="3" class="align-middle" style="height:200px;">
							${row.board_content }
						</td>
					</tr>
<c:if test="${not empty row.board_file }">
					<tr>
						<th class="text-center table-hover align-middle">첨부파일</th>
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
						<button type="button" class="btn btn-light" style="font-weight:bold;"
							onclick="location.href='./notiEdit.do?board_idx=${param.board_idx}&nowPage=${param.nowPage }';">
							수정하기</button>
						<button type="button" class="btn btn-light" style="font-weight:bold;"
							onclick="location.href='./notiDelete.do?&board_idx=${param.board_idx}&nowPage=${param.nowPage }';">
							삭제하기</button> 
					</div>
					<div class="col-6 text-right pr-5">					
						<button type="button" class="btn btn-light" style="font-weight:bold;"
							onclick="location.href='./notiBoardList.do?nowPage=${param.nowPage }';">
							리스트보기</button>
					</div>	
				</div>	
</c:forEach>
<br />
	</div><!-- 리스트끝 -->
</div>
</body>
</html>