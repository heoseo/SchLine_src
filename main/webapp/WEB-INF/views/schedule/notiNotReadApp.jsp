<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>알림</title>

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
	var numSelect = document.getElementById("selectBoard");
	var value = numSelect.options[numSelect.selectedIndex].value;
	
	location.href="./alertList.do?type="+value+"&nowPage="+nowPage;
}
</script>
<style type="text/css">
body {
	margin: 0 auto;
	padding-left: 10px;
	padding-right: 10px;
  	height: 51em
}
#selectBoard{
	margin-bottom: 15px;
}
</style>
</head>

<!-- body 시작 -->
<body class="is-preload">
	
	<div><!-- mainDiv시작 -->
		<br />
		<div style="text-align:center; font-size:1.2em; font-weight:bold;">
		<i class="fas fa-clock" style="padding-right:5px; text-align:center; 
		font-size:1.2em; font-weight: bold;"></i>
		알림</div>
		<div id="content"> 
			<select name="selectBoard" id="selectBoard" onchange="paging(1);" class="col-sm-3" style="font-weight:bold;">
				<option value="allBoardApp" ${param.type eq 'allBoardApp' ? 'selected' : '' }>전부</option>
				<option value="allNotiApp" ${param.type eq 'allNotiApp' ? 'selected' : '' }>공지</option>
				<option value="taskAndExamApp" ${param.type eq 'taskAndExamApp' ? 'selected' : '' }>과제/시험</option>
				<option value="notiReadApp" ${param.type eq 'notiReadApp' ? 'selected' : '' }>읽은 공지</option>
				<option value="notiNotReadApp" ${param.type eq 'notiNotReadApp' ? 'selected' : '' }>읽지않은 공지</option>
			</select>
			<table class="table table-bordered table-hover table-striped">
			<colgroup>
				<col width="10%"/>
				<col width="10%"/>
				<col width="30%"/>
				<col width="20%"/>
			</colgroup>	
			<thead>
				<tr>
					<th class="text-center" style="font-weight:bold;">번호</th>
					<th class="text-center" style="font-weight:bold;">확인</th>
					<th style="font-weight:bold;">제목</th>
					<th class="text-center" style="font-weight:bold;">작성일</th>
				</tr>
			</thead>
			<tbody>
<c:choose>	
	<c:when test="${empty List }">
 				<tr>
 					<td colspan="6" align="center" height="100">
 						등록된 게시물이 없습니다. 
 					</td>
 				</tr>
	</c:when>
	<c:otherwise>
		<!-- 읽은 공지사항 리스트 출력하기 -->
		<c:forEach items="${List }" var="row">
				<tr>
					<td class="text-center" >${row.RNUM}</td>
					<td class="text-center" >
					<c:choose>
						<c:when test="${row.CHECK_FLAG == 1 }">
							<i class="far fa-envelope-open fa-lg" style="color:#808080"></i>
						</c:when>
						<c:otherwise>
							<i class="fas fa-envelope-square fa-2x" style="color:#4682B4"></i>
						</c:otherwise>
					</c:choose>
					</td>
					<td>
						<a href="viewPop.do?IDX=${row.IDX}&noti_or_exam=${row.noti_or_exam}&subject_idx=${row.SUB_IDX}&nowPage=${nowPage}&type=notiNotReadApp&user_id=${user_id}">
							제목 : ${row.TITLE } 
						</a>
					</td>
					<td class="text-center" >${row.POSTDATE }</td>
				</tr>
		</c:forEach>
	</c:otherwise>	
</c:choose>
				</tbody>
				</table>
			<div style="text-align:center; font-size: 2em; font-weight:bold;">
					<!-- 방명록 반복 부분 e -->
					<ul class="pagination justify-content-center">
						${pagingImg }
					</ul>
				</div>
		</div>
		<!-- 공지사항 리스트 끝.-->

	
	
	</div><!-- mainDiv끝 -->
</body>
</html>