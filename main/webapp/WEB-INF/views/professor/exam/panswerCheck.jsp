<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<title></title>
<!-- 나머지 head속성은 인클루드에 있어요 -->
<!-- 상단  인클루드 : 메뉴별 페이지 이동설정 해야함★★★★★★-->
<%@ include file="/resources/include/top.jsp"%>
<script>
function answerscoring(){
	
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
 						등록된 답안이 없습니다. 
 					</td>
 				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${examlist }" var="row" varStatus="loop">
					<table>
						<tr>
							<%-- 순차적으로 문제번호 부여 --%>
							<td><b>문제 ${loop.count }</b> : ${row.question_content } &nbsp;
							<%-- 문제별 난이도 부여(추후 난이도별로 추출할 예정) --%>
							<span style="font-size:0.7em;">(난이도 : ${row.question_score })</span>
							</td>
						</tr>
						<td >정답입력 : <input type="text" name="choice" style="width:300px; height:30px; display:inline;"></td>
						
						<%-- 정답 확인을 위한 문항별 인덱스를 히든폼에 저장 --%>
					<input type="hidden" name="questionNum" value="${row.question_idx }"/>
					</table>
				</c:forEach>
					<input type="hidden" name="subject_idx" value="${param.subject_idx }"/>
					<input type="hidden" name="exam_type" value="${param.exam_type }"/>
				<span> <input type="button" id="examBtn" value="제출" style="float:right;"/> </span>
				<br />
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
				 onclick="location.href='teamWrite.do?subject_idx=${param.subject_idx}&team_num=${param.team_num }'" value="작성" style="min-width:0"/>
				</div>	
			</div>
		</div>
	</div>
	</div>
</body>

<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>