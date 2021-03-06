<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>과제/시험</title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top_professor.jsp"%>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />

<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" />
<style type="text/css">
/* input[type=number]{opacity: 1} */
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: initial !important;
}
</style>
<script>
$(function () {
	$('#datetimepicker1').datetimepicker({
		dateFormat: 'yy-mm-dd'}); 
		$('#datetimepicker2').datetimepicker({
			dateFormat: 'yy-mm-dd', useCurrent: false
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
	var exam_content = document.getElementById("exam_content").value;
	var exam_date = document.getElementById("exam_date").value;
	var exam_scoring = document.getElementById("exam_scoring").value;
	if(exam_content==""){
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
	window.open('pexamwrite.do?exam_idx='+exam_name+'&exam_content='+exam_content+'&exam_date='+exam_date+
			'&exam_scoring='+exam_scoring
			,'makequestion','width=420, height=500, toolbars=no, menubar=no, scrollbars=no');
	}
};
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
};

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
			location.href='ptaskDelete.do?question_idx='+exam_idx+'&exam_type='+type;			
		}
	}
};
function moveurl(url) { 
    location.href = url;
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
 <h3 style="text-align:center; font-size: 1.2em">시험 등록하기</h3>
 <div id="setquestion">
 	<form:form id="examlistFrm">
 	<div>
	<table class="table table-bordered table-hover table-striped" style="text-align: center; font-size: 0.8em">
 	<tr>
 	<td rowspan="2" style="vertical-align:middle; width:8%;">시험<br />등록</td>
 	<td>시험명</td>
 	<td>시험내용</td>
 	<td style="width:20%">종료일</td>
 	<td style="width:10%; vertical-align:middle;">총 배점</td>
 	<td rowspan="2" style="margin: 0px; vertical-align:middle;">
	 	<button class="button primary" onclick="makequestion();" 
	 	style="min-width:0;font-size: 1.2em; padding-bottom: 60px; padding-top: 10px">
	 	문제 등록<br />
	 	</button>
 	</td>
 	</tr>
 	<tr>
 	<td>
 	<select name="exam_idx" id="exam_name" style="font-size: 15px">
 	<!-- 추후에 과목별 인덱스와 시험제목을 파라미터로 받아야함 -->
 	<c:forEach items="${pexamlist }" var="erow" varStatus="eloop">
 		<option value="${erow.exam_idx }">${erow.exam_name }</option>
 	</c:forEach>
 	</select>
 	</td>
 	<td><input type="text" name="exam_content" id="exam_content"  style="font-size: 15px"/></td>
 	<td>
 	
 	<div class="input-group date" id="datetimepicker1" data-target-input="nearest">
 	<input type="text" id="exam_date" class="form-control datetimepicker-input" data-target="#datetimepicker1"  style="font-size: 15px">
 	<div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker"> 
 	<div class="input-group-text"><i class="fa fa-calendar"></i></div> </div> </div>
 	
 	</td>
 	<td style="width:10%; text-decoration: none"><input type="number" name="exam_scoring" id="exam_scoring" style="width:100%; 
 	border: solid 1px #cdd0cb; border-radius: 5px;"/></td>
 	</tr>

 	</table>
 	</div>
 	</form:form>
 </div>
 <div class="text-center"><h3 style="display:inline; margin-left:150px; font-size: 1.2em">시험 문제 리스트</h3>
 <input type="button" class="button primary small" value="주관식 채점" style="float:right" onclick="location.href='examCheck.do';"/></div>
 <br />
 <select name="id" style="width:200px; display:inline; font-size: 15px" onchange="moveurl(this.value);">
		<option value="" selected>시험을 선택하세요</option>
	<c:forEach items="${pexamlist }" var="urow" varStatus="loop">
		<option value="pexamlist.do?exam_idx=${urow.exam_idx }">${urow.exam_name }</option>
	</c:forEach>
</select>

<div class="table-wrapper mt-1">
	<table class="table table-bordered table-hover table-striped" 
	style="text-align: center; font-size: 0.8em">
		<colgroup>
			<col width="20%"/>
			<col width="15%"/>
			<col width="15%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="10%"/>
		</colgroup>	
		<thead>
		<tr>
			<td>시험명</td>
			<td>시험내용</td>
			<td>문제내용</td>
			<td>정답</td>
			<td>배점</td>
			<td>삭제</td>
		</tr>
		</thead>
		<tbody>
	<c:choose>
	<c:when test="${empty param.exam_idx }">
		<tr><td colspan="6">시험을 선택하세요</td></tr>
	</c:when>
	<c:otherwise>
		<c:forEach items="${pinexamList}" var="exam" varStatus="eloop">
		<c:if test="${exam.exam_idx eq param.exam_idx }">
			<tr>
				<td style=" vertical-align:middle">${exam.exam_name }</td>
				<td style=" vertical-align:middle">${exam.exam_content }</td>
				<td style=" vertical-align:middle">${exam.question_content }</td>
				<td style=" vertical-align:middle">${exam.answer }</td>
				<td style=" vertical-align:middle">${exam.question_score }</td>
				<td style=" vertical-align:middle;">
				<button type="button" class="btn btn-light" onclick="onDelete(${exam.question_idx}, 2)" 
					style="min-width:0; font-size: 14px;  border: solid 1px #B90000;">
					삭제</button>
				</td>
			</tr>
			<%-- 객관식 문제일 경우.... --%>
			<c:if test="${exam.question_type eq 1 }">
			<tr>
			<td colspan="2" style="vertical-align:middle">문항<br />(객관식)</td>
			<td class="text-left" colspan="5">
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
		</c:if>
		</c:forEach>
		</c:otherwise>
		</c:choose>
		</tbody>
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
 	<td style="width:10%; border: 1px solid gray;"><input type="number" name="exam_scoring" id="task_scoring" style="width:100%; border: 1px solid gray;"/></td>
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
 <br />
</div>
    
 <jsp:include page="/resources/include/bottom.jsp" />
 <br /><br />
</body>
</html>