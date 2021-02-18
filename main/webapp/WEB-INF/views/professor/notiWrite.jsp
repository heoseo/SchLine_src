<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
	<head>
		<title>공지사항</title>
<!-- 나머지 head속성은 인클루드에 있어요 -->
<!-- 상단  인클루드 : 메뉴별 페이지 이동설정 해야함★★★★★★-->
<%@ include file="/resources/include/top_professor.jsp"%>
<script>
	/* 연습문제] 글쓰기 폼에 빈값이 있는경우 서버로 전송되지
			않도록 아래 validate()함수를 완성하시오.
			모든 값이 입력되었다면 WriteProc.jsp로 
			submit되어야 한다.
	*/
	function checkValidate(fm){
		if(fm.name.value==""){
			alert("작성자의 이름을 입력하세요."); 
			fm.name.focus(); 
			return false; 
		}
		if(fm.pass.value==""){
			alert("비밀번호를 입력하세요."); 
			fm.pass.focus(); 
			return false; 
		}
		if(fm.title.value==""){
			alert("제목을 입력하세요."); 
			fm.title.focus(); 
			return false; 
		}
		if(fm.content.value==""){
			alert("내용을 입력하세요."); 
			fm.content.focus(); 
			return false;
		}
	}
</script>
<body class="is-preload" >
	<div id="main">
	<br /><br />
		<!-- 
		파일 업로드를 위해서는 반드시 enctype을 선언해야 한다. 해당 
		선언문장이 없으면 파일은 서버로 전송되지 않는다.
	 -->
	<form:form name="writeFrm" method="post" action="notiWriteAction.do?${_csrf.parameterName}=${_csrf.token}" 
		onsubmit="return checkValidate(this);"
		enctype="multipart/form-data">
		<div style="text-align:center; font-weight:bold; font-size: 30px">
		<i class="fas fa-plus" style="padding-right:5px;"></i>
		공지사항 글쓰기</div><hr />
		<!-- ### 게시판의 body 부분 start ### -->
		<div style="padding: 10px;">
				<table class="table table-bordered table-striped">	
				<colgroup>
					<col width="20%"/>
					<col width="*"/>
				</colgroup>
				<tbody>
					<tr>
					<!-- 저장된변수 getProfessor -->
					<c:forEach items="${getProfessor }" var="row"></c:forEach>
						<th class="text-center align-middle">작성자</th>
						<td>${user_id}</td>
					</tr>
					<tr>
						<th class="text-center" 
							style="vertical-align:middle;">제목</th>
						<td>
							<input type="text" class="form-control" 
								name="board_title" />
						</td>
					</tr>
					<tr>
						<th class="text-center"
							style="vertical-align:middle;">내용</th>
						<td>
							<textarea rows="10" 
								class="form-control" name="board_content"></textarea>
						</td>
					</tr>
					<tr>
						<th class="text-center"
							style="vertical-align:middle;">첨부파일</th>
						<td>
							<input type="file" class="form-control" 
								name="board_file" />
						</td>
					</tr>
				</tbody>
				
				</table>
			</div>
			<div class="col text-right">
				<button type="submit" class="btn btn-danger" style="font-weight:bold;">전송하기</button>
				<button type="reset" class="btn btn-dark" style="font-weight:bold;">Reset</button>
				<button type="button" class="btn btn-warning"  style="font-weight:bold;"
					onclick="location.href='notiBoardList.do?nowPage=${nowPage }';">
					리스트보기</button>
			</div><br />
			</form:form>
		</div>

	</div><!-- main디브끝. -->
</body>

<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>