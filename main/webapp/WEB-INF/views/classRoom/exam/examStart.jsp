<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script>
function examstart(subject_idx, exam_type, exam_idx){
	var c = confirm('시험을 시작하시겠습니까? 시작하면 시험을 다시 치룰 수 없습니다.');
	if(c){
		location.href="../class/examList.do?subject_idx="+subject_idx+
				"&exam_type="+exam_type+"&exam_idx="+exam_idx;
	}
}
</script>
<title>시험 </title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>

<!-- body 시작 -->
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_classRoom.jsp"/><!-- flag구분예정 -->
 <div style="text-align: center;">
  <!-- <small>타이틀</small>flag구분예정? -->
 </div>
 <hr /><!-- 구분자 -->
 
 <!-- 검색 인클루드 : 필요한분 쓰세요!!!!! -->
<%--  <%@ include file="/resources/include/search.jsp"%> --%>
 
 <div style="text-align:center">


    <h2><b style="color:#145374; font-size: 0.8em">과목 : ${map.subject_name }</b></h2>
    <!-- 과목 및 시험 인덱스 -->
    
 <table class="alt">
 <tr>
 	<td>No</td>
 	<td>시험명</td>
 	<td>마감일</td>
 	<td>시작</td>
 </tr>
<c:forEach items="${getexamlist }" var="row" varStatus="loop">
 <tr>
 <td>${loop.count }</td>
 <td>${row.exam_name }</td>
 <td>${row.exam_date }</td>
 <td>
 	<button class="button primary" onclick="examstart(${row.subject_idx }, ${row.exam_type}, ${row.exam_idx})">
 	시험시작
 	</button>
</td>
</tr>
</c:forEach>
</table>
    <br />

</div>
 <jsp:include page="/resources/include/bottom.jsp" />
</body>
<br /><br />
<br /><br />

<!-- 하단 인클루드 -->
<%-- <jsp:include page="/resources/include/footer.jsp" /> --%>
</html>