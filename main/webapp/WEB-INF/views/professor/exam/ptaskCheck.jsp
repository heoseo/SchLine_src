<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<title>제출 리스트</title>
<!-- 나머지 head속성은 인클루드에 있어요 -->
<!-- 상단  인클루드 : 메뉴별 페이지 이동설정 해야함★★★★★★-->
<%@ include file="/resources/include/top_professor.jsp"%>
<script>
function taskscoring(){
	var c = confirm('배점 하시겠습니까?');
	if(c){
		alert('배점되었습니다.');
		return true;
	}
	else{
		return false;
	}
}
</script>

<body class="is-preload" >
	<div id="main">
	<br /><br />
	<h2 style="text-align:center">제출 과제 리스트</h2>
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
						<td rowspan="2" style="width:5%; vertical-align:middle;">${trow.virtualNum }</td>
						<td style="width:10%">제목</td>
						<td style="text-align:left;">${trow.board_title }</td>
						<td style="width:15%">(작성자)<br/>${trow.user_name }</td>	
						<td style="width:15%">(제출일)<br/>${trow.board_postdate }</td>
						<td style="width:5%">
					<c:if test="${not empty trow.board_file }">
						<a href="teamDownload.do?board_file=${trow.board_file }&downParam=task">
						<img src="../resources/images/download.png" alt="download" style="max-width:100%; height:auto;"/>
						</a>
					</c:if>	
						</td>
					</tr>
					<tr>
						<td style="width:10%">내용</td>
						<td colspan="4">
						${trow.board_content }
						</td>
					</tr>
					<tr>
						<form:form method="post" action="taskScoring.do" onsubmit="return taskscoring();">
							<td colspan="6" style="width:10%">[${trow.user_name }] 학생의 과제점수 &ensp;:&ensp; 
								<input type="number" name="score" style="width:100px;"/>&ensp;
								<input type="submit" class="button small primary" style="margin-top:5px; font-size:0.8em" value="배점">
								<input type="hidden" name="user_id" value="${trow.user_id }" />
								<input type="hidden" name="exam_idx" value="${trow.exam_idx }" />
							</td>
						</form:form>
					</tr>
					<tr><td colspan="6"></td></tr>
				</c:forEach>
			</c:otherwise>	
		</c:choose>
		</table>
		<div>
			<div class="col-12">
					<ul class='pagination justify-content-center'>
						${pagingImg }
					</ul>
				</div>	
		</div>
	</div>
	</div>
</body>

<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>