<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>코스 페이지 </title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>


<!-- body 시작 --> 
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_classRoomMain.jsp"/><!-- flag구분예정 -->
   <div style="text-align: center;">
<!--       <small>코스</small>flag구분예정 -->
   </div>
   <hr /><!-- 구분자 -->
   
    <c:forEach items="${lists }" var="row">		
		<div class="border mt-2 mb-2">
			<div class="media">
				<div class="media-body">
					<h6>과목번호:${row.subject_idx }</h6>					
					<h4><a href="../class/time.do?subject_idx=${row.subject_idx }">&emsp;${row.subject_name }</a></h4>
					<h6 style="text-align:right ">${row.user_name }&emsp;</h6>
				</div>
				
				
			</div>
		</div>
	</c:forEach>

   
   
            
            
   <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>