<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<title>협업 </title>
<script>
function isDelete(){
	var c = confirm("삭제하시겠습니까?")
	if(c){
		var f = document.teamDelFrm;
		f.method = "post";
		f.action = "teamDelete.do"
		f.submit();
	}
}
</script>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>

<!-- body 시작 -->
<body class="is-preload">
	<div id="main">
<!-- 왼쪽메뉴 include -->
 <div style="text-align: center;">
 </div>
 <hr /><!-- 구분자 -->

		<!-- ### 게시판의 body 부분 start ### -->
		<br />
<p style="text-align:center; font-size:1.2em">상세보기</p>
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
						<th class="text-center table-active align-middle">작성자</th>
						<td>${user_name }</td>
						<th class="text-center table-active align-middle">작성일</th>
						<td>${board_postdate }</td>
					</tr>
					<tr>
						<th class="text-center table-active align-middle">제목</th>
						<td colspan="3">
							${board_title }
						</td>
					</tr>
					<tr>
						<th class="text-center table-active align-middle">내용</th>
						<td colspan="3" class="align-middle" style="height:200px;">
							${board_content }
						</td>
					</tr>
					<tr>
						<th class="text-center table-active align-middle">첨부파일</th>
						<td colspan="3">
<c:if test="${not empty board_file}">
	<a href="teamDownload.do?board_file=${board_file }&board_idx=${board_idx}">
	[다운로드] ${board_file }
	</a>		
</c:if>
						</td>
					</tr>
				</tbody>
				</table>
			</div>
		<div class="row mb-3">
			<div class="col-6"> 
			<sec:authentication property="principal.username" var="user" />
		<c:if test="${user eq user_id }">
			<button type="button" class="btn btn-secondary"
				onclick="location.href='pteamEdit.do?board_idx=${board_idx }&subject_idx=${param.subject_idx}&team_num=${param.team_num }';">
				수정하기</button>
		<form:form name="teamDelFrm" style="display:inline">
			<input type="hidden" name="subject_idx" value="${param.subject_idx }" />
			<input type="hidden" name="board_idx" value="${board_idx }" />
			<input type="hidden" name="board_file" value="${board_file }" />
			<input type="hidden" name="team_num" value="${param.team_num} }" />
			<button type="button" class="btn btn-danger"
				onclick="isDelete();">
				삭제하기</button> 
		</form:form >
		</c:if>
			</div>
			<div class="col-6 text-right pr-5">					
			<button type="button" class="btn btn-success" 
				onclick="location.href='teamList.do?subject_idx=${param.subject_idx }&team_num=${team_num }';">
				리스트보기</button>
			</div>	
		</div>
		<!-- ### 게시판의 body 부분 end ### -->
    
    <br />
    
 	</div>
	</div>
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>