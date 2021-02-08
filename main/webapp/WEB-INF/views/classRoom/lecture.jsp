<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>강의 페이지 </title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>


<!-- body 시작 -->
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_classRoom.jsp"/><!-- flag구분예정 -->
   <div style="text-align: center;">
      <small>강의</small><!-- flag구분예정-->
   </div>
   <hr /><!-- 구분자 -->

	<table class="table  table-hover table-striped">
	<c:choose>	
	<c:when test="${empty lists }">
 				<tr>
 					<td colspan="6" align="center" height="100">
 						등록된 게시물이 없습니다. 
 					</td>
 				</tr>
	</c:when>
	<c:otherwise>
		<c:forEach items="${lists }" var="row">				
				<tr>
					<td class="text-center"><!-- 가상번호 -->
						${row.rnum }.	
					</td>
					<td class="text-right">
					<img src="../resources/images/lecture_thumbnail.png" class="media-object" style="width:40px;margin-bottom:-5px">
					</td>
					<td class="text-left">
					<a href="../class/play.do?title=${row.video_title }"  target="_blank">${row.video_title }</a>
					</td>
					<td class="text-center">출석 인정일:${row.video_end }</td>
				</tr>
		</c:forEach>		
	</c:otherwise>	
</c:choose>
    </table>

            
            
   <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>