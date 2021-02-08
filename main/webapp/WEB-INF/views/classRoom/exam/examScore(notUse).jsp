<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>시험결과</title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>


<!-- body 시작 -->
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_classRoom.jsp"/><!-- flag구분예정 -->
 <div style="text-align: center;">
 <!--  <small>타이틀</small>flag구분예정 -->
 </div>
 <hr /><!-- 구분자 -->
 
 <!-- 검색 인클루드 : 필요한분 쓰세요!!!!! -->
 <%-- <%@ include file="/resources/include/search.jsp"%> --%>
 
 
 	<!-- 배점을..Grade 테이블에 저장하는 기능 필요..추후 교수가 주관식 및 과제점수를 추가하여 합산필요 -->
 	<!-- 이 표시는 모달창으로 처리하는것이 더 이쁠것 같기는 함...redirect로 돌려주고..고민해봅시다 -->
    <h2>시험이 종료 되었습니다.</h2>
    <br />
    <h3>${score }점 입니다.</h3>
    <br />
    <h2>주관식 답안의 점수는 채점 후 반영됩니다.</h2>
    
    
 <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>