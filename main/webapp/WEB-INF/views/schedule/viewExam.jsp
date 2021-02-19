<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>과제/시험</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />

			<!-- JS파일이 부트스트랩보다 위에 있어야 min.js에러가 안남 -->
			
			<!-- Scripts -->
			<script src='<c:url value="/resources/assets/js/jquery.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/jquery.scrollex.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/jquery.scrolly.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/browser.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/breakpoints.min.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/util.js"/>'></script>
			<script src='<c:url value="/resources/assets/js/main.js"/>'></script>
			
			<!-- 드롭다운용 부트 -->
			<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
			<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
						
	
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/main.css" />
		<noscript><link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/noscript.css" /></noscript>
<script>
function paging(nowPage){
	
	location.href = "../schedule/alertList.do?type="+type+"&nowPage="+nowPage;
}
</script>
<style type="text/css">
#row {
font-weight: bold;
background: white;
color: #145374;
padding: 10px;
align-content: center;
border-radius: 5px;
}
</style>
</head>

<!-- body 시작 -->
<body class="is-preload">

<!-- 읽은 공지사항 리스트 출력하기 -->
<c:forEach items="${viewList }" var="row">

<!-- 페이지제목 -->
<br />
<c:choose>
	<c:when test="${row.exam_type == 1}">
	<h2 style="text-align:center; font-weight:bold; color:black;">과제</h2>
	</c:when>
	<c:otherwise>
		<h2 style="text-align:center; font-weight:bold; color:black;">시험</h2>
 	</c:otherwise>
</c:choose>	
<br />
<!-- 게시물 -->
	<div id="row" class="col-lg-12">
		<table class="table table-bordered table-hover table-striped" style="font-weight:bold">
			<tr>
				<th class="text-center table-active align-middle">구분</th>
			<c:choose>
			  	<c:when test="${row.exam_type == 1}">
					<td>과제</td>
						</c:when>
						<c:otherwise>
		    		<td>시험</td>
			   	</c:otherwise>
			 </c:choose>	
				<th class="text-center table-active align-middle" style="color:#DC143C">마감일</th>
				<td>${row.exam_date }</td>					
			</tr>
			<tr>
				<th class="text-center table-active align-middle">작성자</th>
				<td>${row.user_name }</td>
				<th class="text-center table-active align-middle">작성일</th>
				<td>${row.exam_postdate }</td>
			</tr>
			<tr>
				<th class="text-center table-active align-middle">제목</th>
				<td>
					${row.exam_name }
				</td>
				<th class="text-center table-active align-middle">배점</th>
				<td>${row.exam_scoring }</td>
			</tr>
			<tr>
				<th class="text-center table-active align-middle">내용</th>
				<td colspan="3" class="align-middle" style="height:200px;">
					${row.exam_content }
				</td>
			</tr>
		</table>
		<div>
<c:if  test="${row.exam_type == 1}">				
			<div style="text-align:right">	
				<button type="button" class="btn" onclick="taskWrite(${row.subject_idx }, ${row.exam_idx })">
					제출하기</button>
			</div>	

</c:if>				
		</div>
	</div><!-- main끝. -->
	
<!-- 히든값으로 taskWrite()함수에 메소드에 값넘겨줌. -->
<%-- <input type="hidden" id="subject_idx">${row.subject_idx }</input> --%>
<%-- <input type="hidden" id="exam_idx">${row.exam_idx }</input> --%>
</c:forEach>
<!-- 게시물 끝.-->

<script>
function taskWrite(subject_idx, exam_idx){
	
	$.ajax({
		url : "/schline/class/examStart.do?subject_idx="+subject_idx+"&exam_idx="+exam_idx,
		type : "post",
		beforeSend : function(xhr){
            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
           },
		data : {"subject_idx" : subject_idx, "exam_type" : 1, "exam_idx" : exam_idx},
		dataType : "html",
		contentType : "application/x-www-form-urlencoded;chatset:utf-8",
		success : function(Data){
			alert(Data);
			$("#taskWrite").html(Data);
		},
		error : function(e){
			alert("실패"+e);
		}
	});	
}
</script>
</head>

<%-- Ajax로 과제 제출이 붙는 영역 학생정보와, 과제정보, --%>
	<div id="taskWrite"></div>

</body>
</html>