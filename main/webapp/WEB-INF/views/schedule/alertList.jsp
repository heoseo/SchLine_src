<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>알림</title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>
<script>
// $(function(){	

// 	셀렉트박스에 onchange 이벤트 생성.
// 	$('#selectBoard').change(function(){
// 		//alert("에젝체인지");
// 		//셀렉트 박스 선택이 바뀔때 "셀렉트박스 요소"를 함수로 전달.
		
		
// 		//아잭스 셀렉트 체인지시.
// 		$.ajax({
// 			//내부 서블릿으로 요청을 전송함.
// 			url : "../schedule/ajaxAlertList.do?",
// 			type : "post",
// 			data :
// 				{ type : $('#selectBoard option:selected').val() },
// 			dateType : "html",
// 			contentType : "application/x-www-form-urlencoded;chatset:utf-8",
// 			beforeSend : function(xhr){
// 	            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
// 	           },
// 			success : function(Date) {
// 				$("#content").html("");
// 				$("#content").html(Date);
// 				},
// 			error : function(request,status,error) {
// 				//확인하기
// 		        alert("code:"+request.status+"\n"+"message:"+request.responseText+
// 		        		"\n"+"error:"+error);
// 				console.log("code:"+request.status+"\n"+"message:"+request.responseText+
// 		        		"\n"+"error:"+error);
// 			}
// 		});
// 	});
// });

function paging(pageNum){
	
	$.ajax({
		//내부 서블릿으로 요청을 전송함.
		url : "../schedule/ajaxAlertList.do",
		type : "post",
		data :
			{ 
				type : $('#selectBoard option:selected').val() , 
				nowPage : pageNum
			},
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
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+
	        		"\n"+"error:"+error);
		}
	});
	
}
</script>
<style type="text/css">
.main {
	font-weight: bold;
}
#listDate {
	text-align: right;
}
</style>
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
		
		<section>
			<div class="row" id="content">
			<input type="hid-den">파람.타입확인하기-->>>>>>>  ${param.type }</input>
			<select name="selectBoard" id="selectBoard" onchange="paging(1);" class="col-sm-4" style="font-weight: bold;">
				<option value="allBoard" ${param.type eq 'allBoard' ? 'selected' : '' }>전부</option>
				<option value="allNoti" ${param.type eq 'allNoti' ? 'selected' : '' }>공지</option>
				<option value="taskAndExam" ${param.type eq 'taskAndExam' ? 'selected' : '' }>과제/시험</option>
				<option value="notiRead" ${param.type eq 'notiRead' ? 'selected' : '' }>읽은 공지</option>
				<option value="notiNotRead" ${param.type eq 'notiNotRead' ? 'selected' : '' }>읽지않은 공지</option>
			</select>
			<br />얼러트리스트
			

	<!-- 읽은 공지사항 리스트 출력하기 -->
	<c:forEach items="${alertList }" var="row">
				<table>
					<tr>
						<td>${row.noti_or_exam}</td>
						<td id="checkFlagIcon">
							<c:choose>
								<c:when test="${row.CHECK_FLAG == 1 }">
									<i class="far fa-envelope-open fa-lg" style="color:#808080"></i>
								</c:when>
								<c:otherwise>
									<i class="fas fa-envelope-square fa-2x" style="color:#4682B4"></i>
								</c:otherwise>
							</c:choose>
						</td>
						<td id="listTitle">
							<a href="viewList.do?IDX=${row.IDX}&noti_or_exam=${row.noti_or_exam}" target="_blank">
								제목 : ${row.TITLE } 
							</a>
						</td>
						<td id="listDate" rowspan="3">작성일 : ${row.POSTDATE }</td>
					</tr>
				</table>
					
	</c:forEach>
				<!-- 방명록 반복 부분 e -->
				<ul class="pagination justify-content-center">
					${pagingImg }
				</ul>
			</div>
		</section>
<!-- 읽은 공지사항 리스트 끝.-->

	
	
	</div><!-- mainDiv끝 -->

	<jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>