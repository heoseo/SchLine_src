<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>협업</title>
<script>
function checkValidate(){
	//폼의 빈값 체크
	var f = document.teamFrm;
	if(f.board_title.value==""){
		alert("제목을 입력하세요");
		f.board_title.focus();
		return false;
	}
	if(f.board_content.value==""){
		alert("내용을 입력하세요");
		f.board_content.focus(); 
		return false;
	}
}
</script>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>

<!-- body 시작 -->
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_classRoom.jsp"/><!-- flag구분예정 -->
 <div style="text-align: center;">
 </div>
 <hr /><!-- 구분자 -->
	<!-- ### 게시판의 body 부분 start ### -->
<p style="text-align:center; font-size:1.2em">협업</p>
		<form:form action="teamEditAction.do?${_csrf.parameterName }=${_csrf.token }"
		 name="teamFrm" onsubmit="return checkValidate();"
		 method="post" enctype="multipart/form-data">
		<div class="row ml-1 mr-4">
			<table class="table table-bordered">
			<colgroup>
				<col width="20%"/>
				<col width="30%"/>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th class="text-center table-active align-middle">제목</th>
					<td colspan="3">
					<input type="text" name="board_title" value="${board_title }"/>
					</td>
				</tr>
				<tr>
					<th class="text-center table-active align-middle">내용</th>
					<td colspan="3" class="align-middle" style="height:200px;">
					<textarea name="board_content" style="height:100%;">${board_content }</textarea>
					</td>
				</tr>
				<tr>
					<th class="text-center table-active align-middle">첨부파일</th>
					<td colspan="3">
					<input type="file" name="file1" id="userfile1"/>
				<c:if test="${not empty board_file}">
					<br />기존파일 : ${board_file }
				</c:if>
					</td>
				</tr>
			</tbody>
			</table>
			</div>
		<div class="row mb-3">
			<div class="col-6"> 
			<button type="button" class="btn btn-success" 
				onclick="location.href='teamTask.do?subject_idx=${param.subject_idx }&team_num=${team_num }';">
				리스트보기</button>
			</div>
			<div class="col-6 text-right pr-5">					
			<button type="submit" class="btn btn-secondary">수정</button>
			</div>	
		</div>
		<input type="hidden" name="board_idx" value="${board_idx }" />
		<input type="hidden" name="subject_idx" value="${param.subject_idx }" />
		<input type="hidden" name="board_file" value="${board_file }" />
		</form:form>

		<!-- ### 게시판의 body 부분 end ### -->

 <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>