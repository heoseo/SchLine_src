<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
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
 <table><tr><td>
    <h2><b style="color:#145374">과목 : ${map.subject_name }</b></h2>
    <!-- 과목 및 시험 인덱스 -->
    <a href="../class/examList.do?subject_idx=${param.subject_idx }&exam_type=${param.exam_type}">
    	<img src="<%=request.getContextPath() %>/resources/images/examimage.jpg" alt="시험" />
    </a>
</td></tr></table>
    <br />

</div>
</td></tr></table>
 <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>