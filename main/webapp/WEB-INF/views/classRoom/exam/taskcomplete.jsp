<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>empty페이지 </title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>


<!-- body 시작 -->
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_classRoom.jsp"/><!-- flag구분예정 -->
 <div style="text-align: center;">
  <small>타이틀</small><!-- flag구분예정-->
 </div>
 <hr /><!-- 구분자 -->
 
 <!-- 검색 인클루드 : 필요한분 쓰세요!!!!! -->
 <%@ include file="/resources/include/search.jsp"%>
 
  	<h2>파일 업로드 결과보기</h2>
	
	<!-- model객체에 저장된 갯수만큼 반복 출력함 -->
	<c:forEach begin="0" end="${returnObj.files.size()-1 }" var="i">
	<ul>
		<%-- <li>제목${i+1 } :
			${returnObj.files[i].title }</li>
		<li>원본파일명${i+1 } :
			${returnObj.files[i].originalName }</li>  --%>
		<li>저장된파일명${i+1 } :
			${returnObj.files[i].saveFileName }</li>
		<li>전체경로${i+1 } :
			${returnObj.files[i].serverFullName }</li>
		<li><img src="../resources/uploadsFile/${returnObj.files[i].saveFileName }" width="200"></li>
	</ul>
	</c:forEach>
    
    
    
 <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>