<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%

%>
<!DOCTYPE html>
<html>
<head>
<title>알림</title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>
<style>
#category {
}
#selectSapn {
	border: solid;
	width: 10px;
}
#searchDiv {
	border: solid;
	font-size: 0px;
}
#listDate {text-align: right;}
</style>

<script>
$(function(){	

	//셀렉트박스에 onchange 이벤트 생성.
	$('#selectBoard').change(function(){
		alert("에젝체인지");
		//셀렉트 박스 선택이 바뀔때 "셀렉트박스 요소"를 함수로 전달.
		
		
		//아잭스 셀렉트 체인지시.
		$.ajax({
			//내부 서블릿으로 요청을 전송함.
			url : "../schedule/ajaxNoticeRead.do",
			type : "post",
			data :
				{ type : $('#content option:selected').val() },
			dateType : "html",
			contentType : "application/x-www-form-urlencoded;chatset:utf-8",
			beforeSend : function(xhr){
	            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	           },
			success : function(Date) {
				$("#content").html("");
				$("#content").html(Date);
				},
			error : function(request,status,error) {
				//확인하기
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+
		        		"\n"+"error:"+error);
			}
		});
		
		
		
	});
});

</script>

</head>

<!-- 내용입력부분. 클래스속성 건드리지말것 -->
<!-- <div class="col-lg-10"> -->
<!-- <div class="container"> -->

<!-- body 시작 -->
<body class="is-preload">
	<!-- 왼쪽메뉴 include -->
	<jsp:include page="/resources/include/leftmenu_schedule.jsp" />
	
	<div id="main"><!-- mainDiv시작 -->
	<hr />
		<select name="selectBoard" id="selectBoard" class="col-sm-4">
			<option value="allBoard" >전부</option>
			<option value="notiRead">읽은 공지 알림</option>
			<option value="notiNotRead">안읽은 공지 알림</option>
			<option value="task">과제</option>
			<option value="exam">시험</option>
		</select>
		<br />

<!-- 		<div id="searchDiv" class="col-sm-4"> -->
<!-- 			<form method="get"> -->
<!-- 				<select name="searchField"> -->
<!-- 					<option value="contents">내용</option> -->
<!-- 					<option value="name">작성자</option> -->
<!-- 				</select> -->
<!-- 				<input type="text" name="searchTxt"/> -->
<!-- 				<input type="submit" value="검색" /> -->
<!-- 			</form> -->
<!-- 		</div> -->



		<div class="row" id="content">

<!-- 읽은 공지사항 리스트 출력하기 -->
<c:forEach items="${allLists }" var="row">
				
			<table style="height: 10px;">
				<tr id="listTr">
					<td id="contentTd">
						<div id="listTitle">
							글확인여부 : ${row.CHECK_FLAG }
						</div>
						<div id="listTitle">
							공지제목 : ${row.TITLE }
						</div>
						<div id="listContent">
							내용 : ${row.CONTENT }
						</div>
						<div id="listDate">
							게시일 : ${row.POSTDATE }
						</div>
					</td>
				</tr>
			</table>
				
</c:forEach>
			<!-- 방명록 반복 부분 e -->
			<ul class="pagination justify-content-center">
				${pagingImg }
			</ul>
		
		
		</div>
<!-- 읽은 공지사항 리스트 끝.-->

	

	
	
	</div><!-- mainDiv끝 -->

	<jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>