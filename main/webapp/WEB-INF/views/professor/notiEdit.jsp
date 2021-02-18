<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>알림</title>
<!-- 상단 인클루드 -->

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
	function checkValidate(fm){
		if(fm.board_title.value==""){
			alert("제목을 입력하세요."); 
			fm.name.focus(); 
			return false; 
		}
		if(fm.board_content.value==""){
			alert("내용을 입력하세요."); 
			fm.pass.focus(); 
			return false; 
		}
	}
</script>
</head>

<!-- 메인 로고 이미지 -->
<div align="center">
<br /> 
	<a href="/schline/"><!-- ★★이미지클릭시 home으로 가기. home요청명 적기 -->
		<img src="<%=request.getContextPath() %>/resources/images/logo3.png" width="200px" alt="스쿨라인 로고" />
	</a>
<br />
</div>

<!-- body 시작 -->
<body class="is-preload">	

	<!-- 읽은 공지사항 리스트 출력하기 -->
	<c:forEach items="${getNotiView }" var="row">
			<!-- 
				파일 업로드를 위해서는 반드시 enctype을 선언해야 한다. 해당 
				선언문장이 없으면 파일은 서버로 전송되지 않는다.
			 -->
			<form:form name="writeFrm" method="post" action="./notiEditAction.do?${_csrf.parameterName}=${_csrf.token}" 
				onsubmit="return checkValidate(this);"
				enctype="multipart/form-data">
				<input type="hid-den" name="board_idx" value="${row.board_idx}" />
			<table class="table table-bordered table-hover table-striped" style="font-weight:bold;">
				<tr>
					<th class="text-center table-active align-middle" style="color:#145374">과목명</th>
					<td>${row.subject_name }</td>
					<th class="text-center table-active align-middle">작성일</th>
					<td>${row.board_postdate }</td>
				</tr>
				<tr>
					<th class="text-center table-active align-middle">제목</th>
					<td colspan="3">
						${row.board_title }
						<input type="text" class="form-control" 
							name="board_title" />
					</td>
				</tr>
				<tr>
					<th class="text-center table-active align-middle">내용</th>
					<td colspan="3" class="align-middle" style="height:200px;">
						${row.board_content }
						<textarea rows="10" 
							class="form-control" name="board_content"></textarea>
					</td>
				</tr>
				<tr>
					<th class="text-center table-active align-middle">첨부파일</th>
					<td colspan="3">다운로드구현..ㅎ
						${row.board_file}
						<input type="file" class="form-control" 
							name="board_file" />
					</td>
				</tr>
			</table>
			<div class="row mb-3">
				<div class="col-6" style="text-align: right;"> 
					<button type="submit" class="btn btn-danger" style="font-weight:bold;">전송하기</button>
					<button type="reset" class="btn btn-dark" style="font-weight:bold;">Reset</button>
					<button type="button" class="btn btn-warning" style="font-weight:bold;"
						onclick="location.href='notiBoardList.do?nowPage=${param.nowPage }';">
						리스트보기</button>
				</div>	
				
			</div>	
			</form:form>
</c:forEach>
<!-- 읽은 공지사항 리스트 끝.-->

	<jsp:include page="/resources/include/bottom.jsp" />
</body>

<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>