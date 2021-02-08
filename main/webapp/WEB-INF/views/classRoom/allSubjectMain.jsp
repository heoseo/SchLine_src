<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>코스메인</title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>

<style>
blockquote {
	
}

</style>
<!-- body 시작 -->
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_classRoomMain.jsp"/><!-- flag구분예정 -->

	<hr />
   	<div style="text-align: center;">
      	<small>코스</small><!-- flag구분예정-->
   	</div>
   	<hr /><!-- 구분자 -->
   
   	<!-- 검색 인클루드 : 필요한분 쓰세요!!!!! -->
   	<%@ include file="/resources/include/search.jsp"%>
   		<h3>Blockquote</h3>
   		<div>

			<blockquote>
				호로로롤로ㅗㄹ롤로로롤
			</blockquote>
			
			
			<h3>Preformatted</h3>
			<pre><code>i = 0;
   		
   		
   		</div>
            
            
            
   	<jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>