<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>시험</title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>


<!-- body 시작 -->
<body class="is-preload">
<!-- 타입이 시험(2)일때 -->
<c:if test="${examlist[0].exam_type eq '2' }">
<!-- 왼쪽메뉴 include 시험일땐 왼쪽 바를 없앤다..상단바는 어쩌지.. -->
<%-- <jsp:include page="/resources/include/leftmenu_classRoom.jsp"/><!-- flag구분예정 --> --%>

<!-- 아래 부분은 leftmenu 주석처리로 인해 필요한 부분을 직접 페이지로 가져왔다. -->
<div id="main" class="container-fluid">
<div class="row content">
<br />	
<div class="container">
<!-- ============= 여기까지 leftmenu에서 가져온 부분 ============== -->
 <div style="text-align: center;">
 </div>
 <hr /><!-- 구분자 -->
 
 <!-- 시험명 -->
<p style="text-align:center;">${examlist[0].exam_name }</p>

<!-- 정답 체크를 위한 폼 -->
<form action="examComplete.do" method="post">
<!-- 시험문제 반복 -->
<c:forEach items="${examlist }" var="row" varStatus="loop">
<table>
	<tr>
		<!-- 순차적으로 문제번호 부여 -->
		<td><b>문제 ${loop.count }</b> : ${row.question_content } &nbsp;
		<!-- 문제별 난이도 부여(추후 난이도별로 추출할 예정) -->
		<span style="font-size:0.7em;">(난이도 : ${row.question_score })</span>
		</td>
	</tr>
	
	<!-- 객관식 문제일 경우.... -->
	<c:if test="${row.question_type eq 1 }">
	<!-- 문항을 추출한다 -->
	<c:forEach items="${questionlist }" var="qrow" varStatus="qloop">
	<!-- 추출한 문항중에 현재 문제번호와 동일한 인덱스를 가진 문항리스트를 선택 -->
	<c:if test="${row.question_idx eq qrow.question_idx }">
	<tr>
		<!-- 문항 출력 -->
		<td style="padding-left:50px;">
		${qrow.questionlist_num} : ${qrow.questionlist_content }
		</td>
	</tr>
	</c:if>
	</c:forEach>
	<!-- select 태그를 통해 객관식의 정답을 선택하게 한다... -->
	<tr><td>정답선택 : 
		<select name="choice" id="demo-category" style="width:100px; height:30px; display:inline;">
			<option value="정답1" selected>1</option>
			<option value="정답2">2</option>
			<option value="정답3">3</option>
			<option value="정답4">4</option>
			<option value="정답5">5</option>
		</select>
	</td></tr>
	</c:if>
	<!-- 객관식이 아닐경우 정답을 입력할 수 있는 인풋(텍스트)태그를 부여 -->
	<c:if test="${row.question_type ne 1 }">
	<td >정답입력 : <input type="text" name="choice" style="width:300px; height:30px; display:inline;"></td>
	</c:if>
	<!-- 정답 확인을 위한 문항별 인덱스를 히든폼에 저장 -->
	<input type="hidden" name="questionNum" value="${row.question_idx }"/>
</table>

</c:forEach>
<span> <input type="submit" value="제출" style="float:right;"/> </span>
<br />
</form>    
</c:if> <!-- 시험문제 리스트 출력 끝 -->

<!-- 타입이 과제(1)이라면... -->    
<c:if test="${examlist[0].exam_type eq '1' }">

<jsp:include page="/resources/include/leftmenu_classRoom.jsp"/>

 <div style="text-align: center;">
  <!-- <small>타이틀</small>flag구분예정 -->
 </div>
 <hr /><!-- 구분자 -->

<h1>과제리스트 출력을 위한 페이지....</h1>
<div class="table-wrapper">
<table class="alt" style="text-align:center">
<c:forEach items="${examlist }" var="trow" varStatus="tloop">
	<tr>
		<td style="width:20px"><b>${tloop.count }</b></td>
		<td style="width:16%; overflow:hidden;">${trow.exam_name }</td>
		<td style="text-align:left;"><a href="">${trow.exam_content }</a></td>	
		<td style="width:15%">${trow.exam_postdate }</td>
		<td style="width:10%"><input type="button" value="제출" style="min-width:0"/></td>
	</tr>
</c:forEach>
</table>
</div>

</c:if>    
 <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>