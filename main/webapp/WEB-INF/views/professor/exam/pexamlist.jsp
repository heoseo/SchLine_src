<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top_professor.jsp"%>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />

<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" />

<script>
$(function () {
	$('#datetimepicker1').datetimepicker({
		format: 'L'}); 
		$('#datetimepicker2').datetimepicker({
			format: 'L', useCurrent: false
	}); 
	$("#datetimepicker1").on("change.datetimepicker", 
		function (e) {
			$('#datetimepicker2').datetimepicker('minDate', e.date);
	}); 
	$("#datetimepicker2").on("change.datetimepicker", 
		function (e) {
			$('#datetimepicker1').datetimepicker('maxDate', e.date);
	});
});
function makequestion(){
	var exam_name = document.getElementById("exam_name").value;
	var exam_date = document.getElementById("exam_date").value;
	var exam_scoring = document.getElementById("exam_scoring").value;
	if(exam_name==""){
		alert("시험명을 입력하세요");
		return false;
	}
	else if(exam_date==""){
		alert("마감일을 입력하세요");
		return false;
	}
	else if(exam_scoring==""){
		alert("배점을 입력하세요");
		return false;
	}
	else{
	window.open('pexamwrite.do?exam_name='+exam_name+'&exam_date='+exam_date+
			'&exam_scoring='+exam_scoring
			,'makequestion','width=420, height=500, toolbars=no, menubar=no, scrollbars=no');
	}
}
function maketask(){
	var task_name = document.getElementById("task_name").value;
	var task_date = document.getElementById("task_date").value;
	var task_scoring = document.getElementById("task_scoring").value;
	var task_content = document.getElementById("task_content").value;
	if(task_name==""){
		alert("과제명을 입력하세요");
		return false;
	}
	if(task_date==""){
		alert("마감일을 선택하세요");
		return false;
	}
	if(task_scoring==""){
		alert("배점을 입력하세요");
		return false;
	}
	if(task_content==""){
		alert("내용을 입력하세요");
		return false;
	}
	var c = confirm("과제작성을 완료하시겠습니까?");
	if(c){
		var f = document.ptaskWriteFrm;
		f.method = 'post';
		f.action = 'ptaskWriteAction.do';
		f.submit();
	}
}

function onDelete(idx, type){
	var exam_idx = idx;
	if(type == 1){
		var c = confirm("과제를 삭제하시겠습니까?");
		if(c){
			location.href='ptaskDelete.do?exam_idx='+exam_idx+'&exam_type='+type;		
		}
	}
	else{
		var c = confirm("문제를 삭제하시겠습니까?");
		if(c){
			alert(exam_idx);	
			location.href='ptaskDelete.do?question_idx='+exam_idx+'&exam_type='+type;			
		}
	}
}
</script>
<style>
textarea { height : 200px; }
</style>
<!-- body 시작 -->
<body class="is-preload">
<div id="main">	
<br />
<div class="container">
 <hr /><!-- 구분자 -->
 <c:if test="${exam_type eq 2 }">
 <div id="setquestion">
 	<form:form>
 	<div>
 	<table class="alt text-center">
 	<tr>
 	<td rowspan="2" style="vertical-align:middle; width:10%;">시험<br />등록</td>
 	<td>시험명</td>
 	<td style="width:20%">종료일</td>
 	<td style="width:15%">총 배점</td>
 	<td rowspan="2" style="vertical-align:middle; width:10%"><button class="btn btn-primary" 
 	onclick="makequestion();" style="min-width:0;">문제 등록</button></td></tr>
 	<tr>
 	<td><input type="text" name="exam_name" id="exam_name"/></td>
 	<td>
 	
 	<div class="input-group date" id="datetimepicker1" data-target-input="nearest">
 	<input type="text" id="exam_date" class="form-control datetimepicker-input" data-target="#datetimepicker1">
 	<div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker"> 
 	<div class="input-group-text"><i class="fa fa-calendar"></i></div> </div> </div>
 	
 	</td>
 	<td style="width:10%"><input type="number" name="exam_scoring" id="exam_scoring" style="width:100%"/></td>
 	</tr>
 	</table>
 	</div>
 	</form:form>
 </div>
 <div class="text-center"><h3>시험 문제 리스트</h3></div>
 <br />
<div class="table-wrapper">
	<table class="alt text-center">
			<tr>
				<td style="width:25%">시험명</td>
				<td>문제내용</td>
				<td>정답</td>
				<td style="width:8%">배점</td>
				<td style="width:8%">삭제</td>
			</tr>
		<c:forEach items="${pexamlist}" var="exam" varStatus="eloop">
			<tr>
				<td>${exam.exam_name }</td>
				<td>${exam.question_content }</td>
				<td>${exam.answer }</td>
				<td>${exam.question_score }</td>
				<td>
				<button type="button" class="btn btn-danger" onclick="onDelete(${exam.question_idx}, 2)" 
					style="min-width:0; font-size:0.7em">
					삭제</button>
				</td>
			</tr>
			<%-- 객관식 문제일 경우.... --%>
			<c:if test="${exam.question_type eq 1 }">
			<tr>
			<td style="vertical-align:middle">문항</td>
			<td class="text-left" colspan="4">
			<%-- 문항을 추출한다 --%>
			<c:forEach items="${questionlist }" var="question" varStatus="qloop">
			<c:if test="${exam.question_idx eq question.question_idx }">
				&emsp;${question.questionlist_num }번 문항 : ${question.questionlist_content }
				<br />
			</c:if>
			</c:forEach>
			</td>
			</tr>
			</c:if>
		</c:forEach>
	</table>
</c:if>

<c:if test="${exam_type eq '1' }">
<div id="setquestion">
 	<form:form name="ptaskWriteFrm">
 	<div>
 	<table class="alt text-center">
 	<tr>
 	<td rowspan="2" style="vertical-align:middle; width:10%;">과제<br />등록</td>
 	<td>과제명</td>
 	<td style="width:20%">종료일</td>
 	<td style="width:15%">과제배점</td>
 	<td rowspan="3" style="vertical-align:middle; width:10%"><button class="btn btn-primary" 
 	onclick="maketask();" style="min-width:0; height:50%;">과제<br/>등록</button></td></tr>
 	<tr>
 	<td><input type="text" name="exam_name" id="task_name"/></td>
 	<td>
 	<div class="input-group date" id="datetimepicker1" data-target-input="nearest">
 	<input type="text" name="exam_date" id="task_date" class="form-control datetimepicker-input" data-target="#datetimepicker1">
 	<div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker"> 
 	<div class="input-group-text"><i class="fa fa-calendar"></i></div> </div> </div>
 	
 	</td>
 	<td style="width:10%"><input type="number" name="exam_scoring" id="task_scoring" style="width:100%"/></td>
 	</tr>
 	<tr>
 	<td style="vertical-align:middle;">과제<br/>내용</td>
 	<td colspan="3"><textarea name="exam_content" id="task_content" style="height:200px;"></textarea></td>
 	</tr>
 	</table>
 	</div>
 	</form:form>
 </div>
  </div>
 <div class="text-center"><h3>과제 리스트</h3></div>
 <br />
<div class="table-wrapper">
	<table class="alt text-center" style="vertical-align:middel">
			<tr>
				<td style="width:5%">No</td>
				<td style="width:20%">과제명</td>
				<td>과제내용</td>
				<td style="width:15%">등록일</td>
				<td style="width:15%">마감일</td>
				<td style="width:8%">배점</td>
				<td style="width:10%">수정/삭제</td>
			</tr>
		<c:forEach items="${pexamlist}" var="exam" varStatus="eloop">
			<tr>
				<td>${eloop.count }</td>
				<td>${exam.exam_name }</td>
				<td>${exam.exam_content }</td>
				<td>${exam.exam_postdate }</td>
				<td>${exam.exam_date }</td>
				<td>${exam.exam_scoring }</td>
				<td>
				<button type="button" class="btn btn-success" 
					style="min-width:0; font-size:0.7em" 
						onclick="
						window.open('ptaskEdit.do?exam_idx=${exam.exam_idx}'
						,'edittask','width=950, height=580, toolbars=no, menubar=no, scrollbars=no');"
						>
					수정</button>
				<button type="button" class="btn btn-danger" onclick="onDelete(${exam.exam_idx}, 1)" 
					style="min-width:0; font-size:0.7em">
					삭제</button>
				</td>
			</tr>
		</c:forEach>
	</table>
 </c:if>
</div>
    
 <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>