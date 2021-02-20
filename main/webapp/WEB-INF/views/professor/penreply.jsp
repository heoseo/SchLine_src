<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>교수용 펜게시판 답변</title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top_professor.jsp"%>


<!-- body 시작 -->
<body class="is-preload">

	<hr />
   	<div style="text-align: center;">
      	<small>답변 게시판</small><!-- flag구분예정-->
   	</div>
   	<hr /><!-- 구분자 -->
   
<script type="text/javascript">
	function checkValidate(f){
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
<div class="container">
	
	<form:form name="writeFrm" method="post" 
		action="./replyAction.do" 
		onsubmit="return checkValidate(this);">
		
		<input type="hidden" name="stu_id" value="${replyRow.user_id }" />
		<input type="hidden" name="board_type" value="${replyRow.board_type }" />
		<input type="hidden" name="pen_idx" value="${replyRow.pen_idx }" />
		<input type="hidden" name="subject_idx" value="${replyRow.subject_idx }" />
		<input type="hidden" name="nowPage" value="${nowPage }" />
		<input type="hidden" name="bgroup" value="${replyRow.bgroup }" />
		<input type="hidden" name="bstep" value="${replyRow.bstep }" />
		<input type="hidden" name="bindent" value="${replyRow.bindent }" />
		
	<table border=1 width=800>
	<colgroup>
		<col width="25%"/>
		<col width="*"/>
	</colgroup>
	<tr>
		<td>제목</td>
		<td>		
		<input type="text" name="board_title" style="width:90%;" id="demo-name" value="${replyRow.board_title }" placeholder="제목" />
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea id="board_content" name="board_content" 
				style="width:90%;" id="demo-message" placeholder="내용을 입력하세요" rows="6">${replyRow.board_content }</textarea>
		</td>
	</tr>
	<c:if test="${replyRow.board_type eq 'red'}">
	<tr>
		<td colspan="2">위 내용을 정정 하시겠습니까?
		<div class="col-4 col-12-small">
			<input type="radio" id="demo-priority-low" name="yorn" value="yes" checked/>
			<label for="demo-priority-low">예</label>
		</div>
		<div class="col-4 col-12-small">
			<input type="radio" id="demo-priority-normal" value="no" name="yorn"/>
			<label for="demo-priority-normal">아니요</label>
		</div>
		</td>
	</tr>
	</c:if>
	<tr>
		<td colspan="2" align="center">
		<ul class="actions">
			<li><input type="submit" value="전송하기" class="primary" /></li>
			<li><input type="reset" value="Reset" /></li>
		</ul>
		</td>
	</tr>
	</table>	
	</form:form>
</div>
   
   
            
   	<jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>