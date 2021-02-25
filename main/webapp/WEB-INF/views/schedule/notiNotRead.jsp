<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>알림</title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>
<script>
function paging(nowPage){
	var numSelect = document.getElementById("selectBoard");
	var value = numSelect.options[numSelect.selectedIndex].value;
	
	location.href="./alertList.do?type="+value+"&nowPage="+nowPage;
}
</script>
<style type="text/css">
#selectBoard{
	margin-bottom: 15px;
}
</style>
</head>

<!-- body 시작 -->
<body class="is-preload">
	<!-- 왼쪽메뉴 include -->
	<jsp:include page="/resources/include/leftmenu_schedule.jsp" />
	
	<div><!-- mainDiv시작 -->
		<hr />
		<div style="text-align:center; font-size:1.2em">
		<i class="fas fa-clock" style="padding-right:5px; text-align:center;"></i>
		알림</div>
		<div id="content"> 
			<select name="selectBoard" id="selectBoard" onchange="paging(1);" class="col-sm-3" style="font-weight:bold;">
				<option value="allBoard" ${param.type eq 'allBoard' ? 'selected' : '' }>전부</option>
				<option value="allNoti" ${param.type eq 'allNoti' ? 'selected' : '' }>공지</option>
				<option value="taskAndExam" ${param.type eq 'taskAndExam' ? 'selected' : '' }>과제/시험</option>
				<option value="notiRead" ${param.type eq 'notiRead' ? 'selected' : '' }>읽은 공지</option>
				<option value="notiNotRead" ${param.type eq 'notiNotRead' ? 'selected' : '' }>읽지않은 공지</option>
			</select>
			<table class="table table-bordered table-hover table-striped">
			<colgroup>
				<col width="40px"/>
				<col width="40px"/>
				<col width="300px"/>
				<col width="100px"/>
			</colgroup>	
			<thead>
				<tr>
					<th class="text-center" style="font-weight:bold;">No</th>
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
						<a href="viewPop.do?IDX=${row.IDX}&noti_or_exam=${row.noti_or_exam}">
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
				<div style="text-align:center;">
					<!-- 방명록 반복 부분 e -->
					<ul class="pagination justify-content-center">
						${pagingImg }
					</ul>
				</div>
		</div>
		<!-- 공지사항 리스트 끝.-->

	
	
	</div><!-- mainDiv끝 -->

	<jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>