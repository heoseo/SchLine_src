<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>과제/시험</title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>
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
			<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.0/jquery-ui.min.js"></script>
			
	
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
#taskWrite{
border-radius: 5px;
margin: 50px;
padding-top: 20px;
}
</style>
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
			$("#taskWrite").html(Data);
		},
		error : function(e){
			alert("실패"+e);
		}
	});	
}
jQuery(document).ready(function($) {

	$(".scroll").click(function(event){            

	event.preventDefault();

	$('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);

	});

});
</script>
</head>

<!-- body 시작 -->
<body class="is-preload">
	<!-- 왼쪽메뉴 include -->
	<jsp:include page="/resources/include/leftmenu_schedule.jsp" />
	<hr />
<!-- 읽은 공지사항 리스트 출력하기 -->
<c:forEach items="${viewList }" var="row">

<!-- 페이지제목 -->
	<div id="row" class="col-lg-12">

<c:choose>
	<c:when test="${row.exam_type == 1}">
	<h2 style="text-align:center; font-weight:bold;">
	<i class="fas fa-thumbtack" id="icon">&nbsp&nbsp</i>과제</h2>
	</c:when>
	<c:otherwise>
		<i class="fas fa-thumbtack" id="icon">&nbsp&nbsp</i>
		<h2 style="text-align:center; font-weight:bold; color:black;">시험</h2>
 	</c:otherwise>
</c:choose>	
<!-- 게시물 -->

		<table class="table table-bordered table-hover table-striped">
		<colgroup>
			<col width="20%"/>
			<col width="20%"/>
			<col width="20%"/>
			<col width="20%"/>
			<col width="20%"/>
			<col width="20%"/>
		</colgroup>
		<tr>
			<tr>
				<th class="text-center table-hover align-middle">구분</th>
			<c:choose>
			  	<c:when test="${row.exam_type == 1}">
					<td class="text-center table-hover align-middle">과제</td>
						</c:when>
						<c:otherwise>
		    		<td class="text-center table-hover align-middle">시험</td>
			   	</c:otherwise>
			 </c:choose>	
				<th class="text-center table-hover align-middle" style="color:#DC143C">마감일</th>
				<td class="text-center table-hover align-middle">${row.exam_date }</td>					
			</tr>
			<tr>
				<th class="text-center table-hover align-middle">작성자</th>
				<td class="text-center table-hover align-middle">${row.user_name }</td>
				<th class="text-center table-hover align-middle">작성일</th>
				<td class="text-center table-hover align-middle">${row.exam_postdate }</td>
			</tr>
			<tr>
				<th class="text-center table-hover align-middle">제목</th>
				<td class="text-center table-hover align-middle">
					${row.exam_name }
				</td>
				<th class="text-center table-hover align-middle">배점</th>
				<td class="text-center table-hover align-middle">${row.exam_scoring }</td>
			</tr>
			<tr>
				<th class="text-center table-hover align-middle">내용</th>
				<td colspan="3" class="text-center table-hover align-middle" style="height:200px;">
					${row.exam_content }
				</td>
			</tr>
		</table>
		<div>
<c:if  test="${row.exam_type == 1}">				
			<div style="text-align:right; padding-right:30px">	
				<a href="#target1" class="scroll">
				<button type="button" style="font-size:1em; font-weight:bold" class="btn btn-light"
				 onclick="taskWrite(${row.subject_idx }, ${row.exam_idx })">
					제출하기</button></a>
			</div>	
</c:if>				
<%-- Ajax로 과제 제출이 붙는 영역 학생정보와, 과제정보, --%>
			<div id="target1">
				<div id="taskWrite" class="table table-hover table-striped" 
				style="border-color:#145374; width:90%; padding:30px;">
				</div>
			</div>
		</div>
			</div><!-- main끝. -->
<!-- 게시물 끝.-->
</c:forEach>

</body>
</html>