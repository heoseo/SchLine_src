<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<title>님,강의 수정페이지</title>
<!-- 나머지 head속성은 인클루드에 있어요 -->
<!-- 상단  인클루드 : 메뉴별 페이지 이동설정 해야함★★★★★★-->
<%@ include file="/resources/include/top_professor.jsp"%>
<script>
function deleteRow(idx,  saved){
	if(confirm("정말 삭제하겠습니까?")){
		location.href="../professor/deletevid.do?idx="+idx+"&saved="+saved;
	}
}

</script>

<body class="is-preload" >
	<div id="main">	
	<br />
	<div class="container">
	<div style="padding:50px" align="right">
	<button type="reset" class="btn" onclick="location.href='../professor/videowrite.do?subject_idx=${subject_idx}'">강의업로드</button>	
	</div>		
	<table class="table  table-hover table-striped" >
	


	<c:choose>	
	<c:when test="${empty fileMap }">
 				<tr>
 					<td align="center" height="100">
 						강의영상을 업로드 하지 않았습니다.
 					</td>
 				</tr>
	</c:when>
	<c:otherwise>
	<c:forEach items="${fileMap }" var="vs" >   	 
  		<tr>
  		<td>
   		 강의명:${vs.video_title }  &emsp; 게시일:${vs.video_postdate }
   	 	~ 출석인정일:${vs.video_end } &emsp; 
   	 	</td>
   	 	<td>
   	 	<button class="btn btn-primary" onclick="location.href='../professor/vidmodify.do?idx=${vs.video_idx}';">수정</button>
		<button class="btn btn-danger" onclick="javascript:deleteRow(${vs.video_idx},'${vs.server_saved}');">삭제</button>	   	 	
   	 	</td>
  		</tr>
    </c:forEach>     
	</c:otherwise>	
</c:choose>
    </table>	
	</div>
	</div>
</body>

<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>