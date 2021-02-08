<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/default.css"/>
<!-- 채팅을 위한 stylesheet -->
<!-- 요기서 프로필 이미지 변경할것 !!★★ -->

<!DOCTYPE html>
<html>
<head>
<title>스터디룸 채팅</title>
<%@ include file="/resources/include/top.jsp"%>

<style>
/* 고정된 버튼 사이즈 변경 */
button{min-width :0; width: 33%; cursor: pointer; padding: 0;}
</style>
<body class="is-preload">
<jsp:include page="/resources/include/leftmenu_classRoom.jsp"/>
	<div style="text-align: center;">
<!-- 		<small>스터디룸 채팅</small> -->


	</div><hr />

		<div class="row">
		
	    	<div class="col-sm-7">
		    	<button>컨셉1</button><button>컨셉2</button><button>컨셉3</button>
		    	<!-- 오디오 -->
		    	<jsp:include page="studyRoomMusic.jsp"/>
				
	   		</div>
	   
	   		<div class="col-sm-5">
		  		<!-- 채팅 -->
		  		<jsp:include page="studyRoomChat.jsp"/>
		  			
	   		</div>
	   </div>
   </div>
	<jsp:include page="/resources/include/bottom.jsp" />
</body>







<jsp:include page="/resources/include/footer.jsp" />
</html>