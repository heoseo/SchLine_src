<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<title></title>
<!-- 나머지 head속성은 인클루드에 있어요 -->
<!-- 상단  인클루드 : 메뉴별 페이지 이동설정 해야함★★★★★★-->
<%@ include file="/resources/include/top_professor.jsp"%>
<script>
function questionCorrect(){
	var c = confirm('정답처리 하시겠습니까?');
	if(c){
		alert('배점되었습니다.');
		return true;
	}
	else{
		return false;
	}
}
function moveurl(url) { 
    location.href = url;
} 
</script>

<body class="is-preload" >
	<div id="main">
	<br /><br />
	<div style="text-align:center">
	<h2 style="text-align:center; display:inline">주관식 입력 리스트</h2>&emsp;&emsp;
	<select name="id" style="width:200px; display:inline" onchange="moveurl(this.value);">
		<option value="" selected>학생을 선택하세요</option>
	<c:forEach items="${userlist }" var="urow" varStatus="loop">
		<option value="examCheck.do?id=${urow.user_id }">${urow.user_name }</option>
	</c:forEach>
	</select>
	</div>
	<br />
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
				<c:forEach items="${teamlist }" var="row" varStatus="loop">
					<table class="alt" style="text-align:center;">
						<tr >
							<%-- 순차적으로 문제번호 부여 --%>
							<td style="width:10%; vertical-align:middle;">문제</td>
							<td style="vertical-align:middle;"> ${row.question_content }</td>
							<td style="width:15%">(작성자)<br/> ${row.user_name }</td>
							<td style="width:15%">(배점)<br/>${row.question_score }점</td>
						</tr>
						<form:form name="scoreFrm" onsubmit="return questionCorrect();" method="post" action="examScoring.do">
							<input type="hidden" name="exam_idx" id="exam_idx" value="${row.exam_idx }" />
							<input type="hidden" name="user_id" id="user_id" value="${row.user_id }"/>
							<input type="hidden" name="question_score" id="question_score" value="${row.question_score }"/>
							<tr>
							<td>입력한 답</td>
							<td colspan="2"> ${row.questionanswer_content } &nbsp;</td>
							<td rowspan="2" style="width:10%;">
							<input type="submit" id="btn${loop.count }" class="button primary"
							style="min-width:0" value="정답처리">
							</td>
							</tr>
						<%-- 정답 확인을 위한 문항별 인덱스를 히든폼에 저장 --%>
						</form:form>
					</table>
				</c:forEach>
				<br />
			</c:otherwise>	
		</c:choose>
		</table>
		<div>
			<div class="row  mr-1">
			</div>
		</div>
	</div>
	</div>
</body>

<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>