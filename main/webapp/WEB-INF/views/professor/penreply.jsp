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
<div style="background:white;">
<br /><br />
   	<div style="text-align: center;">
      	<small style="font-size:1.2em; font-weight:bold;"><i class="fas fa-comments"></i>&nbsp;&nbsp;답변 게시판</small><!-- flag구분예정-->
   	</div>
<br />
   
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
		
	<table border=1 width=800 class="table table-bordered table-hover table-striped" style="border-radius:5px;">
	<colgroup>
		<col width="25%"/>
		<col width="*"/>
	</colgroup>
	<tr>
		<th class="text-center table-hover align-middle" style="font-size: 1em">제목</td>
		<td>		
		<input type="text" name="board_title" style="width:90%;" id="demo-name" value="${replyRow.board_title }" placeholder="제목" />
		</td>
	</tr>
	<tr>
		<th class="text-center table-hover align-middle" style="font-size: 1em">내용</td>
		<td><textarea id="board_content" name="board_content" 
				style="width:90%;" id="demo-message" placeholder="내용을 입력하세요" rows="6">${replyRow.board_content }</textarea>
		</td>
	</tr>
	<c:if test="${replyRow.board_type eq 'red'}">
	<tr>
		<td></td>
		<td class="table-hover align-middle" 
		style="font-size: 1em; color:#145374; padding-left:20px; height:5%">
		<i class="	fas fa-exclamation-triangle"></i>&nbsp;&nbsp;위 정정 내용을 모든 학생들에게 알리시겠습니까?
		<br></br>
		<div class="col-4 col-12-small" style="font-size: 0.8em;">
			<input type="radio" style="color:#145374 " id="demo-priority-low" name="yorn" value="yes" checked/>
			<label for="demo-priority-low">예</label>
		</div>
		<div class="col-4 col-12-small" style="font-size: 0.8em;">
			<input type="radio" id="demo-priority-normal" value="no" name="yorn"/>
			<label for="demo-priority-normal">아니요</label>
		</div>
		</td>
	</tr>
	</c:if>
	<tr>
		<td colspan="2" align="right" class="text-center table-hover">
		<ul class="actions">
			<li><input type="submit" value="전송하기" class="primary" style="font-size:1em; font-weight:bold" /></li>
			<li><input type="reset" value="Reset" class="light" style="font-size:1em; font-weight:bold;" /></li>
		</ul>
		</td>
	</tr>
	</table>	
	</form:form>
	<br />
</div>
</div>   

            
   	<jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>